<#
.SYNOPSIS
    Azure Key Vault abstraction layer for IntelIntent orchestration.

.DESCRIPTION
    Provides unified interface for secure secrets management with certificate-based
    authentication, managed identity support, and RBAC authorization.

.NOTES
    Module:         SecureSecretsManager.psm1
    Author:         IntelIntent Orchestration Team
    Created:        2025-11-29
    Phase:          Phase 4 - Production Hardening
    Dependencies:   Azure CLI, Azure PowerShell (optional)

.EXAMPLE
    Import-Module .\IntelIntent_Seeding\SecureSecretsManager.psm1
    New-SecretVault -VaultName "IntelIntentSecrets" -ResourceGroup "Phase4RG"
    Set-SecretValue -SecretName "GraphClientSecret" -SecretValue $secret
    $token = Get-SecretValue -SecretName "GraphClientSecret"
#>

# === Module State ===
$script:VaultContext = @{
    VaultName = $null
    TenantId = $null
    SubscriptionId = $null
    ManagedIdentityClientId = $null
    LastOperation = $null
    SessionID = (New-Guid).ToString()
}

# === Core Functions ===

function New-SecretVault {
    <#
    .SYNOPSIS
        Creates Azure Key Vault with RBAC authorization.

    .DESCRIPTION
        Provisions new Azure Key Vault with:
        - RBAC-based access control (no access policies)
        - Soft delete enabled (90-day retention)
        - Purge protection enabled
        - Network ACLs configurable

    .PARAMETER VaultName
        Unique Key Vault name (3-24 alphanumeric chars + hyphens).

    .PARAMETER ResourceGroup
        Azure resource group name. Must exist.

    .PARAMETER Location
        Azure region (default: centralus).

    .PARAMETER EnableRBAC
        Enable Azure RBAC authorization (default: $true).
        If false, uses legacy access policies.

    .PARAMETER EnablePurgeProtection
        Enable purge protection (cannot be disabled once set).

    .PARAMETER NetworkRuleAction
        Default network rule: Allow or Deny (default: Allow).

    .EXAMPLE
        New-SecretVault -VaultName "IntelIntentSecrets" -ResourceGroup "Phase4RG"

    .EXAMPLE
        New-SecretVault -VaultName "DevVault" -ResourceGroup "TestRG" -EnablePurgeProtection $false
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [ValidatePattern('^[a-zA-Z0-9-]{3,24}$')]
        [string]$VaultName,

        [Parameter(Mandatory=$true)]
        [string]$ResourceGroup,

        [string]$Location = "centralus",

        [bool]$EnableRBAC = $true,

        [bool]$EnablePurgeProtection = $true,

        [ValidateSet("Allow", "Deny")]
        [string]$NetworkRuleAction = "Allow"
    )

    try {
        Write-Host "🔐 Creating Key Vault: $VaultName" -ForegroundColor Cyan

        # Verify resource group exists
        $rgExists = az group show --name $ResourceGroup --query "id" -o tsv 2>$null
        if (-not $rgExists) {
            throw "Resource group '$ResourceGroup' not found. Create it first with: az group create"
        }

        # Build Azure CLI command
        $azCmd = @(
            "az keyvault create",
            "--name `"$VaultName`"",
            "--resource-group `"$ResourceGroup`"",
            "--location `"$Location`""
        )

        if ($EnableRBAC) {
            $azCmd += "--enable-rbac-authorization true"
        }

        if ($EnablePurgeProtection) {
            $azCmd += "--enable-purge-protection true"
        }

        $azCmd += "--default-action $NetworkRuleAction"
        $azCmd += "--output json"

        # Execute creation
        $cmdString = $azCmd -join " "
        $result = Invoke-Expression $cmdString | ConvertFrom-Json

        # Update module context
        $script:VaultContext.VaultName = $VaultName
        $script:VaultContext.LastOperation = "Create"

        Write-Host "  ✅ Vault URI: $($result.properties.vaultUri)" -ForegroundColor Green

        return @{
            Status = "Success"
            VaultUri = $result.properties.vaultUri
            VaultId = $result.id
            VaultName = $VaultName
            ResourceGroup = $ResourceGroup
            Location = $result.location
            EnableRBAC = $EnableRBAC
        }
    }
    catch {
        Write-Error "❌ Failed to create Key Vault: $_"
        return @{
            Status = "Failed"
            Error = $_.Exception.Message
        }
    }
}

function Set-SecretValue {
    <#
    .SYNOPSIS
        Stores secret in Azure Key Vault.

    .DESCRIPTION
        Securely stores secret value with optional expiration and tags.
        Supports both plain text and SecureString inputs.

    .PARAMETER SecretName
        Name of secret (alphanumeric, hyphens only).

    .PARAMETER SecretValue
        Secret value (plain text or SecureString).

    .PARAMETER VaultName
        Key Vault name (uses module context if not specified).

    .PARAMETER ExpiresOn
        Optional expiration date (ISO 8601 format or DateTime).

    .PARAMETER Tags
        Optional hashtable of metadata tags.

    .PARAMETER ContentType
        Optional content type descriptor (e.g., "application/x-json").

    .EXAMPLE
        Set-SecretValue -SecretName "GraphClientSecret" -SecretValue $secret

    .EXAMPLE
        Set-SecretValue -SecretName "ApiKey" -SecretValue $key -ExpiresOn (Get-Date).AddYears(1)
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [ValidatePattern('^[a-zA-Z0-9-]+$')]
        [string]$SecretName,

        [Parameter(Mandatory=$true)]
        $SecretValue,

        [string]$VaultName = $script:VaultContext.VaultName,

        [datetime]$ExpiresOn,

        [hashtable]$Tags,

        [string]$ContentType
    )

    if (-not $VaultName) {
        throw "VaultName not set. Call New-SecretVault or Set-VaultContext first."
    }

    try {
        Write-Verbose "Setting secret: $SecretName in vault: $VaultName"

        # Convert SecureString if needed
        if ($SecretValue -is [System.Security.SecureString]) {
            $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecretValue)
            $SecretValue = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
            [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
        }

        # Build command
        $azCmd = @(
            "az keyvault secret set",
            "--vault-name `"$VaultName`"",
            "--name `"$SecretName`"",
            "--value `"$SecretValue`""
        )

        if ($ExpiresOn) {
            $expiryISO = $ExpiresOn.ToString("yyyy-MM-ddTHH:mm:ssZ")
            $azCmd += "--expires `"$expiryISO`""
        }

        if ($Tags) {
            $tagString = ($Tags.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join " "
            $azCmd += "--tags $tagString"
        }

        if ($ContentType) {
            $azCmd += "--content-type `"$ContentType`""
        }

        $azCmd += "--output json"

        # Execute
        $cmdString = $azCmd -join " "
        $result = Invoke-Expression $cmdString | ConvertFrom-Json

        $script:VaultContext.LastOperation = "SetSecret"

        Write-Verbose "Secret stored successfully: $($result.id)"

        return @{
            Status = "Success"
            SecretName = $SecretName
            SecretId = $result.id
            Version = $result.id.Split('/')[-1]
        }
    }
    catch {
        Write-Error "❌ Failed to set secret: $_"
        return @{
            Status = "Failed"
            Error = $_.Exception.Message
        }
    }
}

function Get-SecretValue {
    <#
    .SYNOPSIS
        Retrieves secret from Azure Key Vault.

    .DESCRIPTION
        Fetches secret value with optional version specification.
        Can return as SecureString for enhanced security.

    .PARAMETER SecretName
        Name of secret to retrieve.

    .PARAMETER VaultName
        Key Vault name (uses module context if not specified).

    .PARAMETER Version
        Optional secret version ID. Latest version if omitted.

    .PARAMETER AsSecureString
        Return as SecureString instead of plain text.

    .EXAMPLE
        $secret = Get-SecretValue -SecretName "GraphClientSecret"

    .EXAMPLE
        $secureSecret = Get-SecretValue -SecretName "ApiKey" -AsSecureString
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$SecretName,

        [string]$VaultName = $script:VaultContext.VaultName,

        [string]$Version,

        [switch]$AsSecureString
    )

    if (-not $VaultName) {
        throw "VaultName not set. Call New-SecretVault or Set-VaultContext first."
    }

    try {
        Write-Verbose "Retrieving secret: $SecretName from vault: $VaultName"

        # Build command
        $azCmd = "az keyvault secret show --vault-name `"$VaultName`" --name `"$SecretName`""

        if ($Version) {
            $azCmd += " --version `"$Version`""
        }

        $azCmd += " --query `"value`" --output tsv"

        # Execute
        $secretValue = Invoke-Expression $azCmd

        if (-not $secretValue) {
            throw "Secret not found or access denied"
        }

        $script:VaultContext.LastOperation = "GetSecret"

        if ($AsSecureString) {
            return ConvertTo-SecureString -String $secretValue -AsPlainText -Force
        }

        return $secretValue
    }
    catch {
        Write-Error "❌ Failed to retrieve secret: $_"
        return $null
    }
}

function Grant-VaultAccess {
    <#
    .SYNOPSIS
        Grants RBAC role to user/service principal for Key Vault.

    .DESCRIPTION
        Assigns Azure RBAC role for Key Vault operations.
        Common roles: Key Vault Secrets Officer, Key Vault Secrets User.

    .PARAMETER PrincipalId
        Object ID of user/service principal/managed identity.

    .PARAMETER RoleName
        RBAC role name (default: "Key Vault Secrets Officer").

    .PARAMETER VaultName
        Key Vault name (uses module context if not specified).

    .PARAMETER Scope
        Optional custom scope (defaults to vault resource ID).

    .EXAMPLE
        Grant-VaultAccess -PrincipalId $managedIdentityId -RoleName "Key Vault Secrets User"

    .EXAMPLE
        Grant-VaultAccess -PrincipalId $userId -RoleName "Key Vault Secrets Officer"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$PrincipalId,

        [string]$RoleName = "Key Vault Secrets Officer",

        [string]$VaultName = $script:VaultContext.VaultName,

        [string]$Scope
    )

    if (-not $VaultName) {
        throw "VaultName not set."
    }

    try {
        Write-Host "🔐 Granting '$RoleName' to principal: $PrincipalId" -ForegroundColor Cyan

        # Get vault resource ID if scope not specified
        if (-not $Scope) {
            $vaultId = az keyvault show --name $VaultName --query id --output tsv
            $Scope = $vaultId
        }

        # Create role assignment
        az role assignment create `
            --assignee $PrincipalId `
            --role $RoleName `
            --scope $Scope `
            --output none

        $script:VaultContext.LastOperation = "GrantAccess"

        Write-Host "  ✅ Access granted successfully" -ForegroundColor Green

        return @{
            Status = "Success"
            Role = $RoleName
            Principal = $PrincipalId
            Scope = $Scope
        }
    }
    catch {
        Write-Error "❌ Failed to grant access: $_"
        return @{
            Status = "Failed"
            Error = $_.Exception.Message
        }
    }
}

function Remove-SecretValue {
    <#
    .SYNOPSIS
        Deletes secret from Azure Key Vault (soft delete).

    .DESCRIPTION
        Soft deletes secret (recoverable for 90 days by default).
        Use Restore-SecretValue to recover, or purge permanently.

    .PARAMETER SecretName
        Name of secret to delete.

    .PARAMETER VaultName
        Key Vault name (uses module context if not specified).

    .PARAMETER Purge
        Permanently delete (cannot be recovered).

    .EXAMPLE
        Remove-SecretValue -SecretName "OldApiKey"

    .EXAMPLE
        Remove-SecretValue -SecretName "TempSecret" -Purge
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
    param(
        [Parameter(Mandatory=$true)]
        [string]$SecretName,

        [string]$VaultName = $script:VaultContext.VaultName,

        [switch]$Purge
    )

    if (-not $VaultName) {
        throw "VaultName not set."
    }

    try {
        if ($PSCmdlet.ShouldProcess($SecretName, "Delete secret")) {
            if ($Purge) {
                Write-Warning "⚠️ Purging secret permanently (cannot be recovered)"
                az keyvault secret purge --vault-name $VaultName --name $SecretName
            } else {
                Write-Verbose "Soft deleting secret: $SecretName"
                az keyvault secret delete --vault-name $VaultName --name $SecretName --output none
            }

            $script:VaultContext.LastOperation = if ($Purge) { "PurgeSecret" } else { "DeleteSecret" }

            return @{ Status = "Success"; SecretName = $SecretName; Purged = $Purge }
        }
    }
    catch {
        Write-Error "❌ Failed to delete secret: $_"
        return @{ Status = "Failed"; Error = $_.Exception.Message }
    }
}

function Set-VaultContext {
    <#
    .SYNOPSIS
        Sets module-level vault context for subsequent operations.

    .DESCRIPTION
        Configures default Key Vault for all module operations.
        Reduces need to specify -VaultName parameter repeatedly.

    .PARAMETER VaultName
        Azure Key Vault name.

    .PARAMETER TenantId
        Optional Azure AD tenant ID.

    .PARAMETER SubscriptionId
        Optional Azure subscription ID.

    .EXAMPLE
        Set-VaultContext -VaultName "IntelIntentSecrets"

    .EXAMPLE
        Set-VaultContext -VaultName "ProdVault" -TenantId $tenantId
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$VaultName,

        [string]$TenantId,

        [string]$SubscriptionId
    )

    $script:VaultContext.VaultName = $VaultName

    if ($TenantId) {
        $script:VaultContext.TenantId = $TenantId
    }

    if ($SubscriptionId) {
        $script:VaultContext.SubscriptionId = $SubscriptionId
    }

    Write-Verbose "Vault context set: $VaultName"
}

function Get-VaultContext {
    <#
    .SYNOPSIS
        Returns current vault context.

    .DESCRIPTION
        Shows active vault configuration and session metadata.

    .EXAMPLE
        Get-VaultContext
    #>
    [CmdletBinding()]
    param()

    return $script:VaultContext
}

function Test-VaultConnection {
    <#
    .SYNOPSIS
        Tests connectivity to Azure Key Vault.

    .DESCRIPTION
        Validates Azure CLI authentication and vault accessibility.

    .PARAMETER VaultName
        Key Vault name to test (uses context if not specified).

    .EXAMPLE
        Test-VaultConnection

    .EXAMPLE
        Test-VaultConnection -VaultName "TestVault"
    #>
    [CmdletBinding()]
    param(
        [string]$VaultName = $script:VaultContext.VaultName
    )

    if (-not $VaultName) {
        throw "VaultName not set."
    }

    try {
        Write-Host "🔍 Testing vault connection: $VaultName" -ForegroundColor Cyan

        # Test Azure CLI authentication
        $account = az account show 2>$null | ConvertFrom-Json
        if (-not $account) {
            throw "Not authenticated to Azure. Run: az login"
        }
        Write-Host "  ✅ Azure CLI authenticated: $($account.user.name)" -ForegroundColor Green

        # Test vault access
        $vault = az keyvault show --name $VaultName --query "name" -o tsv 2>$null
        if (-not $vault) {
            throw "Vault not found or access denied"
        }
        Write-Host "  ✅ Vault accessible: $vault" -ForegroundColor Green

        return @{
            Status = "Success"
            VaultName = $vault
            Authenticated = $true
            User = $account.user.name
        }
    }
    catch {
        Write-Error "❌ Connection test failed: $_"
        return @{
            Status = "Failed"
            Error = $_.Exception.Message
        }
    }
}

# Export module members
Export-ModuleMember -Function @(
    'New-SecretVault',
    'Set-SecretValue',
    'Get-SecretValue',
    'Grant-VaultAccess',
    'Remove-SecretValue',
    'Set-VaultContext',
    'Get-VaultContext',
    'Test-VaultConnection'
)

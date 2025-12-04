<#
.SYNOPSIS
    Finance data storage helper functions for local JSON persistence.

.DESCRIPTION
    Provides CRUD operations for portfolio data without Azure dependencies.
    Uses local JSON files in Data/Finance/ directory.
#>

# === Data File Paths ===
$script:DataRoot = Join-Path $PSScriptRoot '..' 'Data' 'Finance'
$script:PortfolioFile = Join-Path $script:DataRoot 'portfolios.json'
$script:AlertsFile = Join-Path $script:DataRoot 'market_alerts.json'

# === Portfolio Operations ===

function Get-PortfolioData {
    <#
    .SYNOPSIS
        Loads portfolio data from JSON file.

    .PARAMETER UserID
        Investor user ID (default: investor1).

    .EXAMPLE
        $portfolio = Get-PortfolioData -UserID "investor1"
    #>
    param(
        [string]$UserID = 'investor1'
    )

    if (-not (Test-Path $script:PortfolioFile)) {
        Write-Warning "Portfolio file not found: $script:PortfolioFile"
        return $null
    }

    try {
        $allData = Get-Content $script:PortfolioFile -Raw | ConvertFrom-Json
        return $allData.investors.$UserID
    } catch {
        Write-Error "Failed to load portfolio data: $_"
        return $null
    }
}

function Set-PortfolioData {
    <#
    .SYNOPSIS
        Saves portfolio data to JSON file.

    .PARAMETER UserID
        Investor user ID.

    .PARAMETER PortfolioData
        Portfolio object to save.

    .EXAMPLE
        Set-PortfolioData -UserID "investor1" -PortfolioData $updatedPortfolio
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$UserID,

        [Parameter(Mandatory = $true)]
        $PortfolioData
    )

    try {
        $allData = if (Test-Path $script:PortfolioFile) {
            Get-Content $script:PortfolioFile -Raw | ConvertFrom-Json
        } else {
            @{ investors = @{} }
        }

        $allData.investors.$UserID = $PortfolioData
        $allData | ConvertTo-Json -Depth 10 | Set-Content $script:PortfolioFile -Force

        Write-Verbose "Portfolio saved for user: $UserID"
        return $true
    } catch {
        Write-Error "Failed to save portfolio data: $_"
        return $false
    }
}

function Get-PortfolioSummary {
    <#
    .SYNOPSIS
        Calculates portfolio performance metrics.

    .PARAMETER UserID
        Investor user ID.

    .EXAMPLE
        $summary = Get-PortfolioSummary -UserID "investor1"
    #>
    param(
        [string]$UserID = 'investor1'
    )

    $portfolio = Get-PortfolioData -UserID $UserID

    if (-not $portfolio) {
        return $null
    }

    $totalCost = 0
    $totalValue = 0
    $holdingSummary = @()

    foreach ($holding in $portfolio.holdings) {
        $costBasis = $holding.shares * $holding.costBasis
        $currentValue = $holding.shares * $holding.currentPrice
        $gain = $currentValue - $costBasis
        $gainPercent = if ($costBasis -gt 0) { ($gain / $costBasis) * 100 } else { 0 }

        $totalCost += $costBasis
        $totalValue += $currentValue

        $holdingSummary += @{
            Symbol       = $holding.symbol
            Name         = $holding.name
            Shares       = $holding.shares
            CostBasis    = $costBasis
            CurrentValue = $currentValue
            Gain         = $gain
            GainPercent  = [Math]::Round($gainPercent, 2)
        }
    }

    $portfolioGain = $totalValue - $totalCost
    $portfolioGainPercent = if ($totalCost -gt 0) { ($portfolioGain / $totalCost) * 100 } else { 0 }

    return @{
        UserID      = $UserID
        Name        = $portfolio.name
        TotalCost   = [Math]::Round($totalCost, 2)
        TotalValue  = [Math]::Round($totalValue, 2)
        CashBalance = $portfolio.cashBalance
        NetWorth    = [Math]::Round($totalValue + $portfolio.cashBalance, 2)
        Gain        = [Math]::Round($portfolioGain, 2)
        GainPercent = [Math]::Round($portfolioGainPercent, 2)
        Holdings    = $holdingSummary
        LastUpdated = $portfolio.lastUpdated
    }
}

function Add-PortfolioHolding {
    <#
    .SYNOPSIS
        Adds or updates a holding in the portfolio.

    .PARAMETER UserID
        Investor user ID.

    .PARAMETER Symbol
        Stock/crypto symbol.

    .PARAMETER Shares
        Number of shares to add.

    .PARAMETER Price
        Purchase price per share.

    .EXAMPLE
        Add-PortfolioHolding -UserID "investor1" -Symbol "NVDA" -Shares 10 -Price 495.00
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$UserID,

        [Parameter(Mandatory = $true)]
        [string]$Symbol,

        [Parameter(Mandatory = $true)]
        [double]$Shares,

        [Parameter(Mandatory = $true)]
        [double]$Price
    )

    $portfolio = Get-PortfolioData -UserID $UserID

    if (-not $portfolio) {
        Write-Error "Portfolio not found for user: $UserID"
        return $false
    }

    $existingHolding = $portfolio.holdings | Where-Object { $_.symbol -eq $Symbol }

    if ($existingHolding) {
        # Update existing holding (average cost basis)
        $totalShares = $existingHolding.shares + $Shares
        $totalCost = ($existingHolding.shares * $existingHolding.costBasis) + ($Shares * $Price)
        $existingHolding.shares = $totalShares
        $existingHolding.costBasis = $totalCost / $totalShares
    } else {
        # Add new holding
        $newHolding = @{
            symbol       = $Symbol
            name         = $Symbol  # TODO: Fetch company name from API
            shares       = $Shares
            costBasis    = $Price
            currentPrice = $Price  # Will be updated by market data sync
            purchaseDate = (Get-Date).ToString('yyyy-MM-dd')
        }

        $portfolio.holdings += $newHolding
    }

    $portfolio.lastUpdated = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')

    return Set-PortfolioData -UserID $UserID -PortfolioData $portfolio
}

# === Market Alert Operations ===

function Get-MarketAlerts {
    <#
    .SYNOPSIS
        Retrieves active market alerts.

    .EXAMPLE
        $alerts = Get-MarketAlerts
    #>
    if (-not (Test-Path $script:AlertsFile)) {
        return @()
    }

    try {
        $data = Get-Content $script:AlertsFile -Raw | ConvertFrom-Json
        return $data.alerts
    } catch {
        Write-Error "Failed to load alerts: $_"
        return @()
    }
}

function Add-MarketAlert {
    <#
    .SYNOPSIS
        Creates a new market alert.

    .PARAMETER Symbol
        Stock/crypto symbol.

    .PARAMETER Type
        Alert type: PriceTarget, PercentChange, VolumeSpike.

    .PARAMETER Condition
        Condition: above, below.

    .PARAMETER Value
        Target value (price or percent).

    .EXAMPLE
        Add-MarketAlert -Symbol "TSLA" -Type "PriceTarget" -Condition "above" -Value 250.00
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$Symbol,

        [Parameter(Mandatory = $true)]
        [ValidateSet('PriceTarget', 'PercentChange', 'VolumeSpike')]
        [string]$Type,

        [Parameter(Mandatory = $true)]
        [ValidateSet('above', 'below')]
        [string]$Condition,

        [Parameter(Mandatory = $true)]
        [double]$Value
    )

    try {
        $data = if (Test-Path $script:AlertsFile) {
            Get-Content $script:AlertsFile -Raw | ConvertFrom-Json
        } else {
            @{ alerts = @() }
        }

        $alertId = "alert-$(Get-Random -Minimum 100 -Maximum 999)"

        $newAlert = @{
            id          = $alertId
            symbol      = $Symbol
            type        = $Type
            condition   = $Condition
            status      = 'active'
            createdDate = (Get-Date).ToString('yyyy-MM-dd')
        }

        if ($Type -eq 'PriceTarget') {
            $newAlert.targetPrice = $Value
        } elseif ($Type -eq 'PercentChange') {
            $newAlert.targetPercent = $Value
        }

        $data.alerts += $newAlert
        $data | ConvertTo-Json -Depth 10 | Set-Content $script:AlertsFile -Force

        return $newAlert
    } catch {
        Write-Error "Failed to create alert: $_"
        return $null
    }
}

# === Portfolio Optimization ===

function Get-RebalanceSuggestions {
    <#
    .SYNOPSIS
        Analyzes portfolio and suggests rebalancing actions.

    .PARAMETER UserID
        Investor user ID.

    .PARAMETER TargetAllocation
        Target allocation percentages (hashtable).

    .EXAMPLE
        $suggestions = Get-RebalanceSuggestions -UserID "investor1" -TargetAllocation @{
            Stocks = 60; Bonds = 30; Crypto = 10
        }
    #>
    param(
        [string]$UserID = 'investor1',

        [hashtable]$TargetAllocation = @{
            Stocks = 70
            Crypto = 20
            Cash   = 10
        }
    )

    $summary = Get-PortfolioSummary -UserID $UserID

    if (-not $summary) {
        return $null
    }

    $totalValue = $summary.NetWorth
    $suggestions = @()

    # Categorize holdings
    $stockValue = ($summary.Holdings | Where-Object { $_.Symbol -notmatch '-USD$' } |
            Measure-Object -Property CurrentValue -Sum).Sum ?? 0

    $cryptoValue = ($summary.Holdings | Where-Object { $_.Symbol -match '-USD$' } |
            Measure-Object -Property CurrentValue -Sum).Sum ?? 0

    $cashValue = $summary.CashBalance

    # Calculate current allocation
    $currentAllocation = @{
        Stocks = if ($totalValue -gt 0) { ($stockValue / $totalValue) * 100 } else { 0 }
        Crypto = if ($totalValue -gt 0) { ($cryptoValue / $totalValue) * 100 } else { 0 }
        Cash   = if ($totalValue -gt 0) { ($cashValue / $totalValue) * 100 } else { 0 }
    }

    # Compare to target and generate suggestions
    foreach ($category in $TargetAllocation.Keys) {
        $current = [Math]::Round($currentAllocation[$category], 2)
        $target = $TargetAllocation[$category]
        $diff = $target - $current

        if ([Math]::Abs($diff) -gt 5) {
            # 5% threshold
            $action = if ($diff -gt 0) { 'Increase' } else { 'Decrease' }
            $amount = [Math]::Abs($diff) * $totalValue / 100

            $suggestions += @{
                Category          = $category
                Action            = $action
                CurrentPercent    = $current
                TargetPercent     = $target
                DifferencePercent = [Math]::Round($diff, 2)
                SuggestedAmount   = [Math]::Round($amount, 2)
            }
        }
    }

    return @{
        UserID            = $UserID
        TotalValue        = $totalValue
        CurrentAllocation = $currentAllocation
        TargetAllocation  = $TargetAllocation
        Suggestions       = $suggestions
        AnalysisDate      = (Get-Date).ToString('yyyy-MM-dd')
    }
}

# Export module functions
Export-ModuleMember -Function @(
    'Get-PortfolioData',
    'Set-PortfolioData',
    'Get-PortfolioSummary',
    'Add-PortfolioHolding',
    'Get-MarketAlerts',
    'Add-MarketAlert',
    'Get-RebalanceSuggestions'
)

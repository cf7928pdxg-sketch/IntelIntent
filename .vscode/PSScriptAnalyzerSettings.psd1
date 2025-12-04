@{
    # PSScriptAnalyzer Settings for IntelIntent Project
    # Enforces best practices and IntelIntent-specific conventions

    # Severity Levels: Error, Warning, Information
    Severity     = @('Error', 'Warning')

    # Exclude specific rules
    ExcludeRules = @(
        'PSAvoidUsingWriteHost',  # We use Write-Host for colored output intentionally
        'PSUseShouldProcessForStateChangingFunctions',  # Not all state-changing functions need -WhatIf
        'PSAvoidUsingPositionalParameters'  # Allow positional for common cmdlets
    )

    # Include specific rules
    IncludeRules = @(
        'PSUseApprovedVerbs',
        'PSAvoidUsingCmdletAliases',
        'PSUseDeclaredVarsMoreThanAssignments',
        'PSAvoidDefaultValueSwitchParameter',
        'PSUseCmdletCorrectly',
        'PSAvoidGlobalVars',
        'PSUsePSCredentialType',
        'PSAvoidUsingPlainTextForPassword',
        'PSAvoidUsingComputerNameHardcoded',
        'PSAvoidUsingUsernameAndPasswordParams',
        'PSUseSingularNouns',
        'PSAvoidUsingInvokeExpression',
        'PSReservedCmdletChar',
        'PSReservedParams',
        'PSMissingModuleManifestField',
        'PSUseToExportFieldsInManifest',
        'PSShouldProcess',
        'PSProvideCommentHelp',
        'PSAvoidTrailingWhitespace',
        'PSAlignAssignmentStatement'
    )

    # Rule-specific configurations
    Rules        = @{
        PSProvideCommentHelp                      = @{
            Enable                  = $true
            ExportedOnly            = $false
            BlockComment            = $true
            VSCodeSnippetCorrection = $true
            Placement               = 'begin'
        }

        PSPlaceOpenBrace                          = @{
            Enable             = $true
            OnSameLine         = $true
            NewLineAfter       = $true
            IgnoreOneLineBlock = $true
        }

        PSPlaceCloseBrace                         = @{
            Enable             = $true
            NewLineAfter       = $true
            IgnoreOneLineBlock = $true
            NoEmptyLineBefore  = $false
        }

        PSUseConsistentIndentation                = @{
            Enable              = $true
            Kind                = 'space'
            IndentationSize     = 4
            PipelineIndentation = 'IncreaseIndentationForFirstPipeline'
        }

        PSUseConsistentWhitespace                 = @{
            Enable                          = $true
            CheckInnerBrace                 = $true
            CheckOpenBrace                  = $true
            CheckOpenParen                  = $true
            CheckOperator                   = $true
            CheckPipe                       = $true
            CheckPipeForRedundantWhitespace = $true
            CheckSeparator                  = $true
            CheckParameter                  = $false
        }

        PSAlignAssignmentStatement                = @{
            Enable         = $true
            CheckHashtable = $true
        }

        PSUseCorrectCasing                        = @{
            Enable = $true
        }

        PSAvoidUsingDoubleQuotesForConstantString = @{
            Enable = $false  # Allow double quotes for consistency
        }
    }
}

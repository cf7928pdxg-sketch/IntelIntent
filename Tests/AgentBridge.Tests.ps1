<#
.SYNOPSIS
    Pester unit tests for AgentBridge.psm1

.DESCRIPTION
    Tests agent orchestration, routing logic, and lifecycle management.
    Uses mocks to isolate agent logic from data layer.
#>

BeforeAll {
    # Import module under test
    Import-Module "$PSScriptRoot\..\IntelIntent_Seeding\AgentBridge.psm1" -Force
}

Describe "AgentBridge Module" {

    Context "Module Import" {
        It "Should export orchestrator agent" {
            Get-Command Invoke-OrchestratorAgent -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
        }

        It "Should export Finance agent" {
            Get-Command Invoke-FinanceAgent -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
        }

        It "Should export Boopas agent" {
            Get-Command Invoke-BoopasAgent -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
        }

        It "Should export Identity agent" {
            Get-Command Invoke-IdentityAgent -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
        }

        It "Should export Deployment agent" {
            Get-Command Invoke-DeploymentAgent -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
        }

        It "Should export Modality agent" {
            Get-Command Invoke-ModalityAgent -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
        }

        It "Should export lifecycle functions" {
            Get-Command Get-AgentContext -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
            Get-Command Clear-AgentContext -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
            Get-Command Export-AgentLogs -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
        }
    }
}

Describe "Invoke-OrchestratorAgent" {

    Context "Intent Routing" {
        It "Should route finance intent to FinanceAgent" {
            $result = Invoke-OrchestratorAgent -Intent "Show me my investment portfolio"

            $result.Status | Should -Be "Success"
            $result.Agent | Should -Be "FinanceAgent"
        }

        It "Should route commerce intent to BoopasAgent" {
            $result = Invoke-OrchestratorAgent -Intent "Process a sale at the register"

            $result.Status | Should -Be "Success"
            $result.Agent | Should -Be "BoopasAgent"
        }

        It "Should return error for empty intent" {
            $result = Invoke-OrchestratorAgent -Intent ""

            $result.Status | Should -Be "Error"
        }
    }

    Context "Return Structure" {
        It "Should return Status property" {
            $result = Invoke-OrchestratorAgent -Intent "test"

            $result.Status | Should -BeIn @("Success", "Error")
        }

        It "Should return Agent property on success" {
            $result = Invoke-OrchestratorAgent -Intent "portfolio"

            if ($result.Status -eq "Success") {
                $result.Agent | Should -Not -BeNullOrEmpty
            }
        }
    }
}

Describe "Invoke-FinanceAgent" {

    BeforeAll {
        # Mock data helper functions
        Import-Module "$PSScriptRoot\..\IntelIntent_Seeding\FinanceDataHelper.psm1" -Force
    }

    Context "Dashboard Operation" {
        It "Should return portfolio summary" {
            $result = Invoke-FinanceAgent -Operation "Dashboard" -Data @{ UserID = "investor1" }

            $result.Status | Should -Be "Success"
            $result.Agent | Should -Be "FinanceAgent"
            $result.Operation | Should -Be "Dashboard"
        }
    }

    Context "Portfolio Operation" {
        It "Should get holdings" {
            $result = Invoke-FinanceAgent -Operation "Portfolio" -Data @{
                Action = "GetHoldings"
                UserID = "investor1"
            }

            $result.Status | Should -Be "Success"
            $result.Result | Should -Not -BeNullOrEmpty
        }

        It "Should add holding" {
            $result = Invoke-FinanceAgent -Operation "Portfolio" -Data @{
                Action = "AddHolding"
                UserID = "investor1"
                Symbol = "TSLA"
                Quantity = 5
                CostBasis = 200
                CurrentPrice = 250
            }

            $result.Status | Should -Be "Success"
        }
    }

    Context "MarketEvent Operation" {
        It "Should get alerts" {
            $result = Invoke-FinanceAgent -Operation "MarketEvent" -Data @{
                Action = "GetAlerts"
                UserID = "investor1"
            }

            $result.Status | Should -Be "Success"
        }

        It "Should create alert" {
            $result = Invoke-FinanceAgent -Operation "MarketEvent" -Data @{
                Action = "CreateAlert"
                UserID = "investor1"
                Type = "price_alert"
                Message = "Test alert"
                Symbol = "MSFT"
            }

            $result.Status | Should -Be "Success"
        }
    }

    Context "Optimization Operation" {
        It "Should provide rebalancing suggestions" {
            $result = Invoke-FinanceAgent -Operation "Optimization" -Data @{
                UserID = "investor1"
            }

            $result.Status | Should -Be "Success"
            $result.Result.Suggestions | Should -Not -BeNullOrEmpty
        }
    }

    Context "Error Handling" {
        It "Should return error for invalid operation" {
            $result = Invoke-FinanceAgent -Operation "InvalidOp" -Data @{}

            $result.Status | Should -Be "Error"
        }

        It "Should return error for missing UserID" {
            $result = Invoke-FinanceAgent -Operation "Dashboard" -Data @{}

            $result.Status | Should -Be "Error"
        }
    }
}

Describe "Invoke-BoopasAgent" {

    BeforeAll {
        # Mock data helper functions
        Import-Module "$PSScriptRoot\..\IntelIntent_Seeding\BoopasDataHelper.psm1" -Force
    }

    Context "Transaction Operation" {
        It "Should process sale" {
            $result = Invoke-BoopasAgent -Operation "Transaction" -Data @{
                Action = "ProcessSale"
                Items = @(@{ sku = "BAGEL-001"; quantity = 1; unitPrice = 2.50 })
                PaymentMethod = "cash"
            }

            $result.Status | Should -Be "Success"
            $result.Result.id | Should -Match "^TXN-"
        }

        It "Should get sales summary" {
            $result = Invoke-BoopasAgent -Operation "Transaction" -Data @{
                Action = "GetSales"
                StartDate = (Get-Date).ToString("yyyy-MM-dd")
                EndDate = (Get-Date).ToString("yyyy-MM-dd")
            }

            $result.Status | Should -Be "Success"
            $result.Result.TotalSales | Should -BeGreaterOrEqual 0
        }
    }

    Context "Inventory Operation" {
        It "Should get inventory" {
            $result = Invoke-BoopasAgent -Operation "Inventory" -Data @{
                Action = "GetInventory"
            }

            $result.Status | Should -Be "Success"
            $result.Result.Products | Should -Not -BeNullOrEmpty
        }

        It "Should get low stock items" {
            $result = Invoke-BoopasAgent -Operation "Inventory" -Data @{
                Action = "GetLowStock"
            }

            $result.Status | Should -Be "Success"
        }

        It "Should get inventory value" {
            $result = Invoke-BoopasAgent -Operation "Inventory" -Data @{
                Action = "GetValue"
            }

            $result.Status | Should -Be "Success"
            $result.Result.TotalRetailValue | Should -BeGreaterThan 0
        }
    }

    Context "Vendor Operation" {
        It "Should get vendors" {
            $result = Invoke-BoopasAgent -Operation "Vendor" -Data @{
                Action = "GetVendors"
            }

            $result.Status | Should -Be "Success"
            $result.Result.Vendors | Should -Not -BeNullOrEmpty
        }

        It "Should update vendor balance" {
            $result = Invoke-BoopasAgent -Operation "Vendor" -Data @{
                Action = "UpdateBalance"
                VendorID = "VEN-001"
                AmountChange = -50
            }

            $result.Status | Should -Be "Success"
        }
    }

    Context "Reconciliation Operation" {
        It "Should generate vendor summary" {
            $result = Invoke-BoopasAgent -Operation "Reconciliation" -Data @{}

            $result.Status | Should -Be "Success"
            $result.Result.TotalVendors | Should -BeGreaterThan 0
        }
    }
}

Describe "Get-AgentContext" {

    Context "Session Management" {
        It "Should return context object" {
            $context = Get-AgentContext

            $context | Should -Not -BeNullOrEmpty
        }

        It "Should include SessionID" {
            $context = Get-AgentContext

            $context.SessionID | Should -Not -BeNullOrEmpty
        }

        It "Should include CallHistory array" {
            $context = Get-AgentContext

            $context.CallHistory | Should -BeOfType [Array]
        }

        It "Should track agent calls" {
            Clear-AgentContext
            Invoke-FinanceAgent -Operation "Dashboard" -Data @{ UserID = "investor1" }

            $context = Get-AgentContext
            $context.CallHistory.Count | Should -BeGreaterThan 0
        }
    }
}

Describe "Clear-AgentContext" {

    Context "Context Reset" {
        It "Should generate new SessionID" {
            $oldContext = Get-AgentContext
            $oldSessionID = $oldContext.SessionID

            Clear-AgentContext

            $newContext = Get-AgentContext
            $newContext.SessionID | Should -Not -Be $oldSessionID
        }

        It "Should clear call history" {
            Invoke-FinanceAgent -Operation "Dashboard" -Data @{ UserID = "investor1" }
            Clear-AgentContext

            $context = Get-AgentContext
            $context.CallHistory.Count | Should -Be 0
        }
    }
}

Describe "Export-AgentLogs" {

    BeforeEach {
        $script:TestLogFile = "$PSScriptRoot\test-agent-logs.json"
    }

    AfterEach {
        if (Test-Path $script:TestLogFile) {
            Remove-Item $script:TestLogFile -Force
        }
    }

    Context "Log Export" {
        It "Should create log file" {
            Clear-AgentContext
            Invoke-FinanceAgent -Operation "Dashboard" -Data @{ UserID = "investor1" }

            Export-AgentLogs -OutputPath $script:TestLogFile

            Test-Path $script:TestLogFile | Should -Be $true
        }

        It "Should export valid JSON" {
            Clear-AgentContext
            Invoke-BoopasAgent -Operation "Inventory" -Data @{ Action = "GetInventory" }

            Export-AgentLogs -OutputPath $script:TestLogFile

            { Get-Content $script:TestLogFile | ConvertFrom-Json } | Should -Not -Throw
        }

        It "Should include call history" {
            Clear-AgentContext
            Invoke-FinanceAgent -Operation "Dashboard" -Data @{ UserID = "investor1" }
            Invoke-BoopasAgent -Operation "Inventory" -Data @{ Action = "GetInventory" }

            Export-AgentLogs -OutputPath $script:TestLogFile

            $logs = Get-Content $script:TestLogFile | ConvertFrom-Json
            $logs.CallHistory.Count | Should -Be 2
        }
    }
}

AfterAll {
    # Cleanup
    Remove-Module AgentBridge -Force -ErrorAction SilentlyContinue
    Remove-Module FinanceDataHelper -Force -ErrorAction SilentlyContinue
    Remove-Module BoopasDataHelper -Force -ErrorAction SilentlyContinue
}

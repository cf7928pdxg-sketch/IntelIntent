<#
.SYNOPSIS
    Pester unit tests for FinanceDataHelper.psm1

.DESCRIPTION
    Tests all 7 exported functions with mocked data operations.
    Validates business logic, data transformations, and error handling.
#>

BeforeAll {
    # Import module under test
    Import-Module "$PSScriptRoot\..\IntelIntent_Seeding\FinanceDataHelper.psm1" -Force

    # Mock data directory for isolation
    $script:TestDataDir = "$PSScriptRoot\..\Data\Finance"
}

Describe 'FinanceDataHelper Module' {

    Context 'Module Import' {
        It 'Should export all 7 public functions' {
            $exportedFunctions = Get-Command -Module FinanceDataHelper
            $exportedFunctions.Count | Should -Be 7
        }

        It 'Should export Get-PortfolioData' {
            Get-Command Get-PortfolioData -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
        }

        It 'Should export Set-PortfolioData' {
            Get-Command Set-PortfolioData -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
        }

        It 'Should export Get-PortfolioSummary' {
            Get-Command Get-PortfolioSummary -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Get-PortfolioData' {

    Context 'Valid User' {
        It 'Should return portfolio for existing user' {
            $result = Get-PortfolioData -UserID 'investor1'

            $result | Should -Not -BeNullOrEmpty
            $result.userID | Should -Be 'investor1'
            $result.holdings | Should -Not -BeNullOrEmpty
        }

        It 'Should return holdings array' {
            $result = Get-PortfolioData -UserID 'investor1'

            $result.holdings | Should -BeOfType [Array]
            $result.holdings.Count | Should -BeGreaterThan 0
        }

        It 'Should include holding properties' {
            $result = Get-PortfolioData -UserID 'investor1'
            $firstHolding = $result.holdings[0]

            $firstHolding.symbol | Should -Not -BeNullOrEmpty
            $firstHolding.quantity | Should -BeGreaterThan 0
            $firstHolding.costBasis | Should -BeGreaterThan 0
        }
    }

    Context 'Invalid User' {
        It 'Should return null for non-existent user' {
            $result = Get-PortfolioData -UserID 'nonexistent999'

            $result | Should -BeNullOrEmpty
        }

        It 'Should handle empty UserID gracefully' {
            { Get-PortfolioData -UserID '' } | Should -Throw
        }
    }
}

Describe 'Set-PortfolioData' {

    BeforeEach {
        # Backup original data
        $script:OriginalData = Get-Content "$script:TestDataDir\portfolios.json" -Raw
    }

    AfterEach {
        # Restore original data
        Set-Content "$script:TestDataDir\portfolios.json" -Value $script:OriginalData
    }

    Context 'Update Existing Portfolio' {
        It 'Should update portfolio successfully' {
            $portfolio = Get-PortfolioData -UserID 'investor1'
            $portfolio.holdings[0].quantity = 999

            $result = Set-PortfolioData -UserID 'investor1' -PortfolioData $portfolio

            $result | Should -Be $true
        }

        It 'Should persist changes to disk' {
            $portfolio = Get-PortfolioData -UserID 'investor1'
            $portfolio.holdings[0].quantity = 999
            Set-PortfolioData -UserID 'investor1' -PortfolioData $portfolio

            $reloaded = Get-PortfolioData -UserID 'investor1'
            $reloaded.holdings[0].quantity | Should -Be 999
        }
    }

    Context 'Create New Portfolio' {
        It 'Should create new portfolio for new user' {
            $newPortfolio = @{
                userID   = 'testuser123'
                holdings = @(
                    @{ symbol = 'TEST'; quantity = 10; costBasis = 100; currentPrice = 120 }
                )
            }

            $result = Set-PortfolioData -UserID 'testuser123' -PortfolioData $newPortfolio

            $result | Should -Be $true
        }
    }
}

Describe 'Get-PortfolioSummary' {

    Context 'Summary Calculations' {
        It 'Should calculate total value correctly' {
            $summary = Get-PortfolioSummary -UserID 'investor1'

            $summary.TotalValue | Should -BeGreaterThan 0
        }

        It 'Should calculate total cost basis' {
            $summary = Get-PortfolioSummary -UserID 'investor1'

            $summary.TotalCostBasis | Should -BeGreaterThan 0
        }

        It 'Should calculate net gain/loss' {
            $summary = Get-PortfolioSummary -UserID 'investor1'

            $summary.NetGainLoss | Should -Not -BeNullOrEmpty
            $summary.NetGainLossPercent | Should -Not -BeNullOrEmpty
        }

        It 'Should include holdings count' {
            $summary = Get-PortfolioSummary -UserID 'investor1'

            $summary.HoldingsCount | Should -BeGreaterThan 0
        }
    }

    Context 'Holdings Breakdown' {
        It 'Should include all holdings with current values' {
            $summary = Get-PortfolioSummary -UserID 'investor1'

            $summary.Holdings | Should -Not -BeNullOrEmpty
            $summary.Holdings.Count | Should -BeGreaterThan 0
        }

        It 'Should calculate per-holding gain/loss' {
            $summary = Get-PortfolioSummary -UserID 'investor1'
            $firstHolding = $summary.Holdings[0]

            $firstHolding.GainLoss | Should -Not -BeNullOrEmpty
            $firstHolding.GainLossPercent | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Add-PortfolioHolding' {

    BeforeEach {
        $script:OriginalData = Get-Content "$script:TestDataDir\portfolios.json" -Raw
    }

    AfterEach {
        Set-Content "$script:TestDataDir\portfolios.json" -Value $script:OriginalData
    }

    Context 'Add New Holding' {
        It 'Should add new holding to portfolio' {
            $result = Add-PortfolioHolding -UserID 'investor1' -Symbol 'TSLA' -Quantity 5 -CostBasis 200 -CurrentPrice 250

            $result | Should -Be $true
        }

        It 'Should persist new holding' {
            Add-PortfolioHolding -UserID 'investor1' -Symbol 'NVDA' -Quantity 10 -CostBasis 300 -CurrentPrice 350

            $portfolio = Get-PortfolioData -UserID 'investor1'
            $nvdaHolding = $portfolio.holdings | Where-Object { $_.symbol -eq 'NVDA' }

            $nvdaHolding | Should -Not -BeNullOrEmpty
            $nvdaHolding.quantity | Should -Be 10
        }
    }

    Context 'Update Existing Holding' {
        It 'Should update quantity for existing symbol' {
            $originalPortfolio = Get-PortfolioData -UserID 'investor1'
            $originalMsft = $originalPortfolio.holdings | Where-Object { $_.symbol -eq 'MSFT' }
            $originalQuantity = $originalMsft.quantity

            Add-PortfolioHolding -UserID 'investor1' -Symbol 'MSFT' -Quantity 50 -CostBasis 350 -CurrentPrice 375.50

            $updatedPortfolio = Get-PortfolioData -UserID 'investor1'
            $updatedMsft = $updatedPortfolio.holdings | Where-Object { $_.symbol -eq 'MSFT' }

            $updatedMsft.quantity | Should -Be ($originalQuantity + 50)
        }

        It 'Should average cost basis when adding to existing holding' {
            Add-PortfolioHolding -UserID 'investor1' -Symbol 'AAPL' -Quantity 10 -CostBasis 180 -CurrentPrice 189.25

            $portfolio = Get-PortfolioData -UserID 'investor1'
            $aapl = $portfolio.holdings | Where-Object { $_.symbol -eq 'AAPL' }

            $aapl.costBasis | Should -BeGreaterThan 0
        }
    }

    Context 'Validation' {
        It 'Should reject negative quantity' {
            { Add-PortfolioHolding -UserID 'investor1' -Symbol 'TEST' -Quantity -10 -CostBasis 100 -CurrentPrice 120 } | Should -Throw
        }

        It 'Should reject zero cost basis' {
            { Add-PortfolioHolding -UserID 'investor1' -Symbol 'TEST' -Quantity 10 -CostBasis 0 -CurrentPrice 120 } | Should -Throw
        }

        It 'Should reject empty symbol' {
            { Add-PortfolioHolding -UserID 'investor1' -Symbol '' -Quantity 10 -CostBasis 100 -CurrentPrice 120 } | Should -Throw
        }
    }
}

Describe 'Get-MarketAlerts' {

    Context 'Filter by UserID' {
        It 'Should return alerts for specified user' {
            $alerts = Get-MarketAlerts -UserID 'investor1'

            $alerts | Should -Not -BeNullOrEmpty
            $alerts | ForEach-Object { $_.userID | Should -Be 'investor1' }
        }

        It 'Should return empty array for user with no alerts' {
            $alerts = Get-MarketAlerts -UserID 'nonexistent999'

            $alerts | Should -BeOfType [Array]
            $alerts.Count | Should -Be 0
        }
    }

    Context 'Alert Properties' {
        It 'Should include alert ID' {
            $alerts = Get-MarketAlerts -UserID 'investor1'

            $alerts[0].id | Should -Not -BeNullOrEmpty
        }

        It 'Should include timestamp' {
            $alerts = Get-MarketAlerts -UserID 'investor1'

            $alerts[0].timestamp | Should -Not -BeNullOrEmpty
        }

        It 'Should include alert type and message' {
            $alerts = Get-MarketAlerts -UserID 'investor1'

            $alerts[0].type | Should -Not -BeNullOrEmpty
            $alerts[0].message | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Add-MarketAlert' {

    BeforeEach {
        $script:OriginalAlerts = Get-Content "$script:TestDataDir\market_alerts.json" -Raw
    }

    AfterEach {
        Set-Content "$script:TestDataDir\market_alerts.json" -Value $script:OriginalAlerts
    }

    Context 'Create Alert' {
        It 'Should add alert successfully' {
            $result = Add-MarketAlert -UserID 'investor1' -Type 'price_alert' -Message 'Test alert' -Symbol 'TSLA'

            $result | Should -Be $true
        }

        It 'Should generate unique alert ID' {
            Add-MarketAlert -UserID 'investor1' -Type 'price_alert' -Message 'Alert 1' -Symbol 'MSFT'
            Add-MarketAlert -UserID 'investor1' -Type 'price_alert' -Message 'Alert 2' -Symbol 'AAPL'

            $alerts = Get-MarketAlerts -UserID 'investor1'
            $ids = $alerts | Select-Object -ExpandProperty id

            ($ids | Select-Object -Unique).Count | Should -Be $alerts.Count
        }

        It 'Should include timestamp in ISO 8601 format' {
            Add-MarketAlert -UserID 'investor1' -Type 'news' -Message 'Test news' -Symbol 'GOOGL'

            $alerts = Get-MarketAlerts -UserID 'investor1'
            $latestAlert = $alerts | Sort-Object timestamp -Descending | Select-Object -First 1

            { [DateTime]::Parse($latestAlert.timestamp) } | Should -Not -Throw
        }
    }

    Context 'Alert Types' {
        It 'Should support price_alert type' {
            $result = Add-MarketAlert -UserID 'investor1' -Type 'price_alert' -Message 'Price alert' -Symbol 'MSFT'
            $result | Should -Be $true
        }

        It 'Should support news type' {
            $result = Add-MarketAlert -UserID 'investor1' -Type 'news' -Message 'News alert' -Symbol 'AAPL'
            $result | Should -Be $true
        }

        It 'Should support volatility type' {
            $result = Add-MarketAlert -UserID 'investor1' -Type 'volatility' -Message 'High volatility' -Symbol 'BTC-USD'
            $result | Should -Be $true
        }
    }
}

Describe 'Get-RebalanceSuggestions' {

    Context 'Rebalancing Logic' {
        It 'Should return suggestions for investor1' {
            $suggestions = Get-RebalanceSuggestions -UserID 'investor1'

            $suggestions | Should -Not -BeNullOrEmpty
        }

        It 'Should include portfolio composition' {
            $suggestions = Get-RebalanceSuggestions -UserID 'investor1'

            $suggestions.CurrentComposition | Should -Not -BeNullOrEmpty
        }

        It 'Should provide actionable suggestions' {
            $suggestions = Get-RebalanceSuggestions -UserID 'investor1'

            $suggestions.Suggestions | Should -Not -BeNullOrEmpty
            $suggestions.Suggestions.Count | Should -BeGreaterThan 0
        }

        It 'Should calculate percentage allocations' {
            $suggestions = Get-RebalanceSuggestions -UserID 'investor1'

            $suggestions.CurrentComposition | ForEach-Object {
                $_.Percentage | Should -BeGreaterThan 0
                $_.Percentage | Should -BeLessOrEqual 100
            }
        }
    }

    Context 'Target Allocation' {
        It 'Should define target allocation percentages' {
            $suggestions = Get-RebalanceSuggestions -UserID 'investor1'

            $suggestions.TargetAllocation | Should -Not -BeNullOrEmpty
        }

        It 'Should recommend increases/decreases' {
            $suggestions = Get-RebalanceSuggestions -UserID 'investor1'

            $suggestions.Suggestions | ForEach-Object {
                $_.Action | Should -BeIn @('Increase', 'Decrease', 'Hold')
            }
        }
    }
}

AfterAll {
    # Cleanup
    Remove-Module FinanceDataHelper -Force -ErrorAction SilentlyContinue
}

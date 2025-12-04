<#
.SYNOPSIS
    Pester unit tests for BoopasDataHelper.psm1

.DESCRIPTION
    Tests all 10 exported functions with mocked commerce data.
    Validates POS transactions, inventory management, and vendor operations.
#>

BeforeAll {
    # Import module under test
    Import-Module "$PSScriptRoot\..\IntelIntent_Seeding\BoopasDataHelper.psm1" -Force

    # Test data directory
    $script:TestDataDir = "$PSScriptRoot\..\Data\Boopas"
}

Describe "BoopasDataHelper Module" {

    Context "Module Import" {
        It "Should export all 10 public functions" {
            $exportedFunctions = Get-Command -Module BoopasDataHelper
            $exportedFunctions.Count | Should -Be 10
        }

        It "Should export transaction functions" {
            Get-Command Get-TransactionData -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
            Get-Command Add-Transaction -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
            Get-Command Get-SalesSummary -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
        }

        It "Should export inventory functions" {
            Get-Command Get-InventoryData -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
            Get-Command Update-InventoryQuantity -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
        }

        It "Should export vendor functions" {
            Get-Command Get-VendorData -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
            Get-Command Update-VendorBalance -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
        }
    }
}

Describe "Get-TransactionData" {

    Context "Retrieve Transactions" {
        It "Should return all transactions" {
            $transactions = Get-TransactionData

            $transactions | Should -Not -BeNullOrEmpty
            $transactions | Should -BeOfType [Array]
        }

        It "Should include transaction properties" {
            $transactions = Get-TransactionData
            $firstTxn = $transactions[0]

            $firstTxn.id | Should -Not -BeNullOrEmpty
            $firstTxn.timestamp | Should -Not -BeNullOrEmpty
            $firstTxn.total | Should -BeGreaterThan 0
        }
    }
}

Describe "Add-Transaction" {

    BeforeEach {
        $script:OriginalTransactions = Get-Content "$script:TestDataDir\transactions.json" -Raw
        $script:OriginalInventory = Get-Content "$script:TestDataDir\inventory.json" -Raw
    }

    AfterEach {
        Set-Content "$script:TestDataDir\transactions.json" -Value $script:OriginalTransactions
        Set-Content "$script:TestDataDir\inventory.json" -Value $script:OriginalInventory
    }

    Context "Transaction Creation" {
        It "Should create transaction successfully" {
            $items = @(
                @{ sku = "BAGEL-001"; quantity = 2; unitPrice = 2.50 }
            )

            $result = Add-Transaction -Items $items -PaymentMethod "cash"

            $result | Should -Not -BeNullOrEmpty
            $result.id | Should -Match "^TXN-\d{8}-\d{3}$"
        }

        It "Should generate unique transaction IDs" {
            $items = @(@{ sku = "COFFEE-001"; quantity = 1; unitPrice = 3.00 })

            $txn1 = Add-Transaction -Items $items -PaymentMethod "cash"
            $txn2 = Add-Transaction -Items $items -PaymentMethod "credit_card"

            $txn1.id | Should -Not -Be $txn2.id
        }

        It "Should calculate subtotal correctly" {
            $items = @(
                @{ sku = "BAGEL-001"; quantity = 3; unitPrice = 2.50 }
                @{ sku = "COFFEE-002"; quantity = 2; unitPrice = 4.50 }
            )

            $result = Add-Transaction -Items $items -PaymentMethod "cash"

            $result.subtotal | Should -Be 16.50
        }

        It "Should calculate 8% tax correctly" {
            $items = @(
                @{ sku = "BAGEL-001"; quantity = 2; unitPrice = 2.50 }
            )

            $result = Add-Transaction -Items $items -PaymentMethod "cash"

            $expectedTax = [Math]::Round(5.00 * 0.08, 2)
            $result.tax | Should -Be $expectedTax
        }

        It "Should calculate total correctly" {
            $items = @(
                @{ sku = "BAGEL-001"; quantity = 2; unitPrice = 2.50 }
            )

            $result = Add-Transaction -Items $items -PaymentMethod "cash"

            $result.total | Should -Be ($result.subtotal + $result.tax)
        }
    }

    Context "Inventory Deduction" {
        It "Should auto-deduct from inventory" {
            $originalInventory = Get-InventoryData
            $bagel = $originalInventory | Where-Object { $_.sku -eq "BAGEL-001" }
            $originalQuantity = $bagel.quantityOnHand

            $items = @(@{ sku = "BAGEL-001"; quantity = 5; unitPrice = 2.50 })
            Add-Transaction -Items $items -PaymentMethod "cash"

            $updatedInventory = Get-InventoryData
            $updatedBagel = $updatedInventory | Where-Object { $_.sku -eq "BAGEL-001" }

            $updatedBagel.quantityOnHand | Should -Be ($originalQuantity - 5)
        }
    }

    Context "Payment Methods" {
        It "Should support cash payment" {
            $items = @(@{ sku = "COFFEE-001"; quantity = 1; unitPrice = 3.00 })
            $result = Add-Transaction -Items $items -PaymentMethod "cash"

            $result.paymentMethod | Should -Be "cash"
        }

        It "Should support credit card payment" {
            $items = @(@{ sku = "COFFEE-001"; quantity = 1; unitPrice = 3.00 })
            $result = Add-Transaction -Items $items -PaymentMethod "credit_card"

            $result.paymentMethod | Should -Be "credit_card"
        }

        It "Should support mobile payment" {
            $items = @(@{ sku = "COFFEE-001"; quantity = 1; unitPrice = 3.00 })
            $result = Add-Transaction -Items $items -PaymentMethod "mobile_payment"

            $result.paymentMethod | Should -Be "mobile_payment"
        }
    }
}

Describe "Get-SalesSummary" {

    Context "Summary Calculations" {
        It "Should calculate total sales" {
            $today = (Get-Date).ToString("yyyy-MM-dd")
            $summary = Get-SalesSummary -StartDate $today -EndDate $today

            $summary.TotalSales | Should -BeGreaterOrEqual 0
        }

        It "Should count transactions" {
            $today = (Get-Date).ToString("yyyy-MM-dd")
            $summary = Get-SalesSummary -StartDate $today -EndDate $today

            $summary.TotalTransactions | Should -BeGreaterOrEqual 0
        }

        It "Should calculate average transaction value" {
            $today = (Get-Date).ToString("yyyy-MM-dd")
            $summary = Get-SalesSummary -StartDate $today -EndDate $today

            if ($summary.TotalTransactions -gt 0) {
                $summary.AverageTransaction | Should -Be ($summary.TotalSales / $summary.TotalTransactions)
            }
        }

        It "Should calculate total tax collected" {
            $today = (Get-Date).ToString("yyyy-MM-dd")
            $summary = Get-SalesSummary -StartDate $today -EndDate $today

            $summary.TotalTax | Should -BeGreaterOrEqual 0
        }
    }

    Context "Payment Breakdown" {
        It "Should group by payment method" {
            $today = (Get-Date).ToString("yyyy-MM-dd")
            $summary = Get-SalesSummary -StartDate $today -EndDate $today

            $summary.PaymentBreakdown | Should -Not -BeNullOrEmpty
        }

        It "Should include payment counts" {
            $today = (Get-Date).ToString("yyyy-MM-dd")
            $summary = Get-SalesSummary -StartDate $today -EndDate $today

            $summary.PaymentBreakdown | ForEach-Object {
                $_.Count | Should -BeGreaterOrEqual 0
            }
        }
    }

    Context "Top Selling Items" {
        It "Should identify top sellers" {
            $today = (Get-Date).ToString("yyyy-MM-dd")
            $summary = Get-SalesSummary -StartDate $today -EndDate $today

            $summary.TopSellingItems | Should -Not -BeNullOrEmpty
        }

        It "Should limit to top 5 items" {
            $today = (Get-Date).ToString("yyyy-MM-dd")
            $summary = Get-SalesSummary -StartDate $today -EndDate $today

            $summary.TopSellingItems.Count | Should -BeLessOrEqual 5
        }
    }
}

Describe "Get-InventoryData" {

    Context "Retrieve Inventory" {
        It "Should return all products" {
            $inventory = Get-InventoryData

            $inventory | Should -Not -BeNullOrEmpty
            $inventory.Count | Should -BeGreaterThan 0
        }

        It "Should include product properties" {
            $inventory = Get-InventoryData
            $product = $inventory[0]

            $product.sku | Should -Not -BeNullOrEmpty
            $product.name | Should -Not -BeNullOrEmpty
            $product.category | Should -Not -BeNullOrEmpty
            $product.unitCost | Should -BeGreaterThan 0
            $product.unitPrice | Should -BeGreaterThan 0
        }
    }

    Context "Category Filtering" {
        It "Should filter by category" {
            $bagels = Get-InventoryData -Category "Bagels"

            $bagels | ForEach-Object {
                $_.category | Should -Be "Bagels"
            }
        }

        It "Should return empty array for non-existent category" {
            $result = Get-InventoryData -Category "NonExistent"

            $result | Should -BeOfType [Array]
            $result.Count | Should -Be 0
        }
    }
}

Describe "Update-InventoryQuantity" {

    BeforeEach {
        $script:OriginalInventory = Get-Content "$script:TestDataDir\inventory.json" -Raw
    }

    AfterEach {
        Set-Content "$script:TestDataDir\inventory.json" -Value $script:OriginalInventory
    }

    Context "Quantity Adjustments" {
        It "Should increase quantity" {
            $originalInventory = Get-InventoryData
            $product = $originalInventory | Where-Object { $_.sku -eq "BAGEL-001" }
            $originalQuantity = $product.quantityOnHand

            Update-InventoryQuantity -SKU "BAGEL-001" -QuantityChange 50

            $updatedInventory = Get-InventoryData
            $updatedProduct = $updatedInventory | Where-Object { $_.sku -eq "BAGEL-001" }

            $updatedProduct.quantityOnHand | Should -Be ($originalQuantity + 50)
        }

        It "Should decrease quantity" {
            $originalInventory = Get-InventoryData
            $product = $originalInventory | Where-Object { $_.sku -eq "COFFEE-001" }
            $originalQuantity = $product.quantityOnHand

            Update-InventoryQuantity -SKU "COFFEE-001" -QuantityChange -10

            $updatedInventory = Get-InventoryData
            $updatedProduct = $updatedInventory | Where-Object { $_.sku -eq "COFFEE-001" }

            $updatedProduct.quantityOnHand | Should -Be ($originalQuantity - 10)
        }
    }
}

Describe "Get-LowStockItems" {

    Context "Low Stock Detection" {
        It "Should return array" {
            $lowStock = Get-LowStockItems

            $lowStock | Should -BeOfType [Array]
        }

        It "Should identify items at or below reorder point" {
            $lowStock = Get-LowStockItems

            $lowStock | ForEach-Object {
                $_.QuantityOnHand | Should -BeLessOrEqual $_.ReorderPoint
            }
        }

        It "Should calculate shortfall quantity" {
            $lowStock = Get-LowStockItems

            $lowStock | ForEach-Object {
                $_.ShortfallQuantity | Should -Be ($_.ReorderPoint - $_.QuantityOnHand)
            }
        }
    }
}

Describe "Get-InventoryValue" {

    Context "Valuation Calculations" {
        It "Should calculate total cost value" {
            $value = Get-InventoryValue

            $value.TotalCostValue | Should -BeGreaterThan 0
        }

        It "Should calculate total retail value" {
            $value = Get-InventoryValue

            $value.TotalRetailValue | Should -BeGreaterThan 0
        }

        It "Should calculate potential profit" {
            $value = Get-InventoryValue

            $value.PotentialProfit | Should -Be ($value.TotalRetailValue - $value.TotalCostValue)
        }

        It "Should count total items" {
            $value = Get-InventoryValue

            $value.TotalItems | Should -BeGreaterThan 0
        }

        It "Should count total units" {
            $value = Get-InventoryValue

            $value.TotalUnits | Should -BeGreaterThan 0
        }
    }
}

Describe "Get-VendorData" {

    Context "Retrieve Vendors" {
        It "Should return all vendors" {
            $vendors = Get-VendorData

            $vendors | Should -Not -BeNullOrEmpty
            $vendors.Count | Should -BeGreaterThan 0
        }

        It "Should include vendor properties" {
            $vendors = Get-VendorData
            $vendor = $vendors[0]

            $vendor.id | Should -Not -BeNullOrEmpty
            $vendor.name | Should -Not -BeNullOrEmpty
            $vendor.category | Should -Not -BeNullOrEmpty
            $vendor.contact | Should -Not -BeNullOrEmpty
        }
    }
}

Describe "Get-VendorSummary" {

    Context "Summary Metrics" {
        It "Should calculate total outstanding balance" {
            $summary = Get-VendorSummary

            $summary.TotalOutstandingBalance | Should -BeGreaterOrEqual 0
        }

        It "Should count vendors" {
            $summary = Get-VendorSummary

            $summary.TotalVendors | Should -BeGreaterThan 0
            $summary.ActiveVendors | Should -BeGreaterThan 0
        }

        It "Should identify overdue vendors" {
            $summary = Get-VendorSummary

            $summary.OverdueVendors | Should -BeGreaterOrEqual 0
        }
    }
}

Describe "Update-VendorBalance" {

    BeforeEach {
        $script:OriginalVendors = Get-Content "$script:TestDataDir\vendors.json" -Raw
    }

    AfterEach {
        Set-Content "$script:TestDataDir\vendors.json" -Value $script:OriginalVendors
    }

    Context "Balance Updates" {
        It "Should process payment (negative amount)" {
            $vendors = Get-VendorData
            $vendor = $vendors | Where-Object { $_.id -eq "VEN-001" }
            $originalBalance = $vendor.outstandingBalance

            Update-VendorBalance -VendorID "VEN-001" -AmountChange -100

            $updatedVendors = Get-VendorData
            $updatedVendor = $updatedVendors | Where-Object { $_.id -eq "VEN-001" }

            $updatedVendor.outstandingBalance | Should -Be ($originalBalance - 100)
        }

        It "Should add invoice (positive amount)" {
            $vendors = Get-VendorData
            $vendor = $vendors | Where-Object { $_.id -eq "VEN-002" }
            $originalBalance = $vendor.outstandingBalance

            Update-VendorBalance -VendorID "VEN-002" -AmountChange 250

            $updatedVendors = Get-VendorData
            $updatedVendor = $updatedVendors | Where-Object { $_.id -eq "VEN-002" }

            $updatedVendor.outstandingBalance | Should -Be ($originalBalance + 250)
        }
    }
}

AfterAll {
    # Cleanup
    Remove-Module BoopasDataHelper -Force -ErrorAction SilentlyContinue
}

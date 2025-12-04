<#
.SYNOPSIS
    Boopas commerce data storage helper functions for local JSON persistence.

.DESCRIPTION
    Provides CRUD operations for POS transactions, inventory, and vendor management
    without Azure dependencies. Uses local JSON files in Data/Boopas/ directory.
#>

# === Data File Paths ===
$script:DataRoot = Join-Path $PSScriptRoot ".." "Data" "Boopas"
$script:TransactionsFile = Join-Path $script:DataRoot "transactions.json"
$script:InventoryFile = Join-Path $script:DataRoot "inventory.json"
$script:VendorsFile = Join-Path $script:DataRoot "vendors.json"

# === Transaction Operations ===

function Get-TransactionData {
    <#
    .SYNOPSIS
        Loads all transactions from JSON file.

    .PARAMETER DateFilter
        Optional date to filter transactions (format: yyyy-MM-dd).

    .EXAMPLE
        $transactions = Get-TransactionData
        $todayTxn = Get-TransactionData -DateFilter "2025-11-30"
    #>
    param(
        [string]$DateFilter
    )

    if (-not (Test-Path $script:TransactionsFile)) {
        Write-Warning "Transactions file not found: $script:TransactionsFile"
        return @()
    }

    try {
        $data = Get-Content $script:TransactionsFile -Raw | ConvertFrom-Json
        $transactions = $data.transactions

        if ($DateFilter) {
            $transactions = $transactions | Where-Object {
                $_.timestamp -match "^$DateFilter"
            }
        }

        return $transactions
    }
    catch {
        Write-Error "Failed to load transactions: $_"
        return @()
    }
}

function Add-Transaction {
    <#
    .SYNOPSIS
        Records a new POS transaction.

    .PARAMETER Items
        Array of items with sku, quantity, unitPrice.

    .PARAMETER PaymentMethod
        Payment method: credit_card, cash, debit_card, mobile.

    .EXAMPLE
        $items = @(
            @{ sku = "BAGEL-001"; quantity = 2; unitPrice = 2.50 }
            @{ sku = "COFFEE-001"; quantity = 1; unitPrice = 3.00 }
        )
        Add-Transaction -Items $items -PaymentMethod "credit_card"
    #>
    param(
        [Parameter(Mandatory=$true)]
        [array]$Items,

        [Parameter(Mandatory=$true)]
        [ValidateSet("credit_card", "cash", "debit_card", "mobile")]
        [string]$PaymentMethod
    )

    try {
        # Load existing transactions
        $data = if (Test-Path $script:TransactionsFile) {
            Get-Content $script:TransactionsFile -Raw | ConvertFrom-Json
        } else {
            @{ transactions = @(); lastUpdated = "" }
        }

        # Load inventory for product names
        $inventory = Get-InventoryData

        # Calculate transaction details
        $subtotal = 0
        $transactionItems = @()

        foreach ($item in $Items) {
            $product = $inventory | Where-Object { $_.sku -eq $item.sku } | Select-Object -First 1
            $itemTotal = $item.quantity * $item.unitPrice
            $subtotal += $itemTotal

            $transactionItems += @{
                sku = $item.sku
                name = $product.name ?? $item.sku
                quantity = $item.quantity
                unitPrice = $item.unitPrice
                total = [Math]::Round($itemTotal, 2)
            }

            # Update inventory
            if ($product) {
                Update-InventoryQuantity -SKU $item.sku -QuantityChange (-$item.quantity)
            }
        }

        $tax = [Math]::Round($subtotal * 0.08, 2)  # 8% sales tax
        $total = [Math]::Round($subtotal + $tax, 2)

        # Generate transaction ID
        $datePrefix = (Get-Date).ToString("yyyyMMdd")
        $existingToday = $data.transactions | Where-Object { $_.id -match "^TXN-$datePrefix" }
        $nextNum = ($existingToday.Count + 1).ToString("000")
        $txnId = "TXN-$datePrefix-$nextNum"

        # Create transaction
        $transaction = @{
            id = $txnId
            timestamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
            items = $transactionItems
            subtotal = $subtotal
            tax = $tax
            total = $total
            paymentMethod = $PaymentMethod
            status = "completed"
        }

        $data.transactions += $transaction
        $data.lastUpdated = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

        # Save
        $data | ConvertTo-Json -Depth 10 | Set-Content $script:TransactionsFile -Force

        return $transaction
    }
    catch {
        Write-Error "Failed to add transaction: $_"
        return $null
    }
}

function Get-SalesSummary {
    <#
    .SYNOPSIS
        Calculates sales metrics for a date range.

    .PARAMETER StartDate
        Start date (format: yyyy-MM-dd). Defaults to today.

    .PARAMETER EndDate
        End date (format: yyyy-MM-dd). Defaults to today.

    .EXAMPLE
        $summary = Get-SalesSummary -StartDate "2025-11-01" -EndDate "2025-11-30"
    #>
    param(
        [string]$StartDate = (Get-Date).ToString("yyyy-MM-dd"),
        [string]$EndDate = (Get-Date).ToString("yyyy-MM-dd")
    )

    $transactions = Get-TransactionData

    # Filter by date range
    $filtered = $transactions | Where-Object {
        $txnDate = ([datetime]$_.timestamp).ToString("yyyy-MM-dd")
        $txnDate -ge $StartDate -and $txnDate -le $EndDate
    }

    $totalSales = ($filtered | Measure-Object -Property total -Sum).Sum ?? 0
    $totalTransactions = $filtered.Count
    $totalTax = ($filtered | Measure-Object -Property tax -Sum).Sum ?? 0
    $avgTransaction = if ($totalTransactions -gt 0) { $totalSales / $totalTransactions } else { 0 }

    # Payment method breakdown
    $paymentBreakdown = $filtered | Group-Object -Property paymentMethod | ForEach-Object {
        @{
            Method = $_.Name
            Count = $_.Count
            Total = ($_.Group | Measure-Object -Property total -Sum).Sum
        }
    }

    # Top selling items
    $allItems = $filtered | ForEach-Object { $_.items } | ForEach-Object { $_ }
    $topItems = $allItems | Group-Object -Property sku | ForEach-Object {
        @{
            SKU = $_.Name
            Name = $_.Group[0].name
            UnitsSold = ($_.Group | Measure-Object -Property quantity -Sum).Sum
            Revenue = ($_.Group | Measure-Object -Property total -Sum).Sum
        }
    } | Sort-Object -Property Revenue -Descending | Select-Object -First 5

    return @{
        StartDate = $StartDate
        EndDate = $EndDate
        TotalSales = [Math]::Round($totalSales, 2)
        TotalTransactions = $totalTransactions
        TotalTax = [Math]::Round($totalTax, 2)
        AverageTransaction = [Math]::Round($avgTransaction, 2)
        PaymentBreakdown = $paymentBreakdown
        TopSellingItems = $topItems
    }
}

# === Inventory Operations ===

function Get-InventoryData {
    <#
    .SYNOPSIS
        Loads inventory from JSON file.

    .PARAMETER Category
        Optional category filter.

    .EXAMPLE
        $inventory = Get-InventoryData
        $bagels = Get-InventoryData -Category "Bagels"
    #>
    param(
        [string]$Category
    )

    if (-not (Test-Path $script:InventoryFile)) {
        Write-Warning "Inventory file not found: $script:InventoryFile"
        return @()
    }

    try {
        $data = Get-Content $script:InventoryFile -Raw | ConvertFrom-Json
        $products = $data.products

        if ($Category) {
            $products = $products | Where-Object { $_.category -eq $Category }
        }

        return $products
    }
    catch {
        Write-Error "Failed to load inventory: $_"
        return @()
    }
}

function Update-InventoryQuantity {
    <#
    .SYNOPSIS
        Updates product quantity in inventory.

    .PARAMETER SKU
        Product SKU.

    .PARAMETER QuantityChange
        Change in quantity (positive for restock, negative for sale).

    .EXAMPLE
        Update-InventoryQuantity -SKU "BAGEL-001" -QuantityChange -5  # Sold 5
        Update-InventoryQuantity -SKU "BAGEL-001" -QuantityChange 100 # Restocked 100
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$SKU,

        [Parameter(Mandatory=$true)]
        [int]$QuantityChange
    )

    try {
        $data = Get-Content $script:InventoryFile -Raw | ConvertFrom-Json

        $product = $data.products | Where-Object { $_.sku -eq $SKU } | Select-Object -First 1

        if ($product) {
            $product.quantityOnHand += $QuantityChange

            if ($product.quantityOnHand -lt 0) {
                Write-Warning "Inventory for $SKU is now negative: $($product.quantityOnHand)"
            }

            $data.lastUpdated = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
            $data | ConvertTo-Json -Depth 10 | Set-Content $script:InventoryFile -Force

            return $true
        }
        else {
            Write-Warning "Product not found: $SKU"
            return $false
        }
    }
    catch {
        Write-Error "Failed to update inventory: $_"
        return $false
    }
}

function Get-LowStockItems {
    <#
    .SYNOPSIS
        Retrieves products below reorder point.

    .EXAMPLE
        $lowStock = Get-LowStockItems
    #>
    $inventory = Get-InventoryData

    $lowStock = $inventory | Where-Object {
        $_.quantityOnHand -le $_.reorderPoint
    } | ForEach-Object {
        @{
            SKU = $_.sku
            Name = $_.name
            Category = $_.category
            QuantityOnHand = $_.quantityOnHand
            ReorderPoint = $_.reorderPoint
            ReorderQuantity = $_.reorderQuantity
            Supplier = $_.supplier
            ShortfallQuantity = $_.reorderPoint - $_.quantityOnHand + 1
        }
    }

    return $lowStock
}

function Get-InventoryValue {
    <#
    .SYNOPSIS
        Calculates total inventory value.

    .EXAMPLE
        $value = Get-InventoryValue
    #>
    $inventory = Get-InventoryData

    $costValue = 0
    $retailValue = 0

    foreach ($product in $inventory) {
        $costValue += $product.quantityOnHand * $product.unitCost
        $retailValue += $product.quantityOnHand * $product.unitPrice
    }

    return @{
        TotalCostValue = [Math]::Round($costValue, 2)
        TotalRetailValue = [Math]::Round($retailValue, 2)
        PotentialProfit = [Math]::Round($retailValue - $costValue, 2)
        TotalItems = $inventory.Count
        TotalUnits = ($inventory | Measure-Object -Property quantityOnHand -Sum).Sum
    }
}

# === Vendor Operations ===

function Get-VendorData {
    <#
    .SYNOPSIS
        Loads vendor data from JSON file.

    .PARAMETER VendorID
        Optional vendor ID filter.

    .EXAMPLE
        $vendors = Get-VendorData
        $vendor = Get-VendorData -VendorID "VEN-001"
    #>
    param(
        [string]$VendorID
    )

    if (-not (Test-Path $script:VendorsFile)) {
        Write-Warning "Vendors file not found: $script:VendorsFile"
        return @()
    }

    try {
        $data = Get-Content $script:VendorsFile -Raw | ConvertFrom-Json
        $vendors = $data.vendors

        if ($VendorID) {
            $vendors = $vendors | Where-Object { $_.id -eq $VendorID }
        }

        return $vendors
    }
    catch {
        Write-Error "Failed to load vendors: $_"
        return @()
    }
}

function Get-VendorSummary {
    <#
    .SYNOPSIS
        Generates vendor reconciliation summary.

    .EXAMPLE
        $summary = Get-VendorSummary
    #>
    $vendors = Get-VendorData

    $totalOutstanding = ($vendors | Measure-Object -Property outstandingBalance -Sum).Sum ?? 0

    $vendorSummary = $vendors | ForEach-Object {
        @{
            ID = $_.id
            Name = $_.name
            Category = $_.category
            OutstandingBalance = $_.outstandingBalance
            PaymentTerms = $_.paymentTerms
            LastOrderDate = $_.lastOrderDate
            LastPaymentDate = $_.lastPaymentDate
            Status = $_.status
            ContactEmail = $_.contact.email
        }
    }

    # Vendors with overdue payments (>30 days since last payment)
    $overdueVendors = $vendors | Where-Object {
        $daysSincePayment = ((Get-Date) - [datetime]$_.lastPaymentDate).Days
        $daysSincePayment -gt 30 -and $_.outstandingBalance -gt 0
    }

    return @{
        TotalVendors = $vendors.Count
        TotalOutstandingBalance = [Math]::Round($totalOutstanding, 2)
        ActiveVendors = ($vendors | Where-Object { $_.status -eq "active" }).Count
        OverdueVendors = $overdueVendors.Count
        Vendors = $vendorSummary
    }
}

function Update-VendorBalance {
    <#
    .SYNOPSIS
        Updates vendor outstanding balance.

    .PARAMETER VendorID
        Vendor ID.

    .PARAMETER AmountChange
        Change in balance (positive for new order, negative for payment).

    .EXAMPLE
        Update-VendorBalance -VendorID "VEN-001" -AmountChange -200.00  # Payment
        Update-VendorBalance -VendorID "VEN-001" -AmountChange 350.00   # New order
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$VendorID,

        [Parameter(Mandatory=$true)]
        [double]$AmountChange
    )

    try {
        $data = Get-Content $script:VendorsFile -Raw | ConvertFrom-Json

        $vendor = $data.vendors | Where-Object { $_.id -eq $VendorID } | Select-Object -First 1

        if ($vendor) {
            $vendor.outstandingBalance += $AmountChange

            if ($AmountChange -lt 0) {
                # Payment made
                $vendor.lastPaymentDate = (Get-Date).ToString("yyyy-MM-dd")
            }
            elseif ($AmountChange -gt 0) {
                # New order
                $vendor.lastOrderDate = (Get-Date).ToString("yyyy-MM-dd")
            }

            $data.lastUpdated = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
            $data | ConvertTo-Json -Depth 10 | Set-Content $script:VendorsFile -Force

            return $true
        }
        else {
            Write-Warning "Vendor not found: $VendorID"
            return $false
        }
    }
    catch {
        Write-Error "Failed to update vendor balance: $_"
        return $false
    }
}

# Export module functions
Export-ModuleMember -Function @(
    'Get-TransactionData',
    'Add-Transaction',
    'Get-SalesSummary',
    'Get-InventoryData',
    'Update-InventoryQuantity',
    'Get-LowStockItems',
    'Get-InventoryValue',
    'Get-VendorData',
    'Get-VendorSummary',
    'Update-VendorBalance'
)

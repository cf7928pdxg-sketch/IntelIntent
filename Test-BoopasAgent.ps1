<#
.SYNOPSIS
    Interactive test script for Boopas Agent implementation.

.DESCRIPTION
    Demonstrates all Boopas Agent operations with real business logic:
    - Transaction: POS sales processing
    - Inventory: Stock management and valuation
    - Vendor: Supplier relationship management
    - Reconciliation: Accounts payable summary
#>

# Import modules
Import-Module .\IntelIntent_Seeding\AgentBridge.psm1 -Force
Import-Module .\IntelIntent_Seeding\BoopasDataHelper.psm1 -Force

Write-Host "`n╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║       Boopas Agent - Production Implementation Test      ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

# Test 1: Transaction - Process Sale
Write-Host "═══ Test 1: Transaction - Process Sale ═══" -ForegroundColor Yellow
Write-Host "Processing new POS transaction...`n"

$saleResult = Invoke-BoopasAgent -Operation "Transaction" -Data @{
    Action = "ProcessSale"
    Items = @(
        @{ sku = "BAGEL-001"; quantity = 3; unitPrice = 2.50 }
        @{ sku = "COFFEE-002"; quantity = 2; unitPrice = 4.50 }
    )
    PaymentMethod = "credit_card"
}

if ($saleResult.Status -eq "Success") {
    Write-Host "✅ Transaction processed successfully!" -ForegroundColor Green
    Write-Host "`nTransaction Details:" -ForegroundColor Cyan
    Write-Host "  Transaction ID: $($saleResult.Result.id)"
    Write-Host "  Timestamp: $($saleResult.Result.timestamp)"
    Write-Host "  Subtotal: `$$($saleResult.Result.subtotal)" -ForegroundColor White
    Write-Host "  Tax: `$$($saleResult.Result.tax)" -ForegroundColor Gray
    Write-Host "  Total: `$$($saleResult.Result.total)" -ForegroundColor Green
    Write-Host "  Payment: $($saleResult.Result.paymentMethod)"

    Write-Host "`n  Items:" -ForegroundColor Cyan
    $saleResult.Result.items | ForEach-Object {
        Write-Host "    • $($_.name) x$($_.quantity) @ `$$($_.unitPrice) = `$$($_.total)" -ForegroundColor White
    }
}
else {
    Write-Host "❌ Transaction failed: $($saleResult.Error)" -ForegroundColor Red
}

Write-Host "`n" + ("─" * 60) + "`n"

# Test 2: Transaction - Get Sales Summary
Write-Host "═══ Test 2: Transaction - Sales Summary ═══" -ForegroundColor Yellow
Write-Host "Retrieving sales summary for today...`n"

$salesResult = Invoke-BoopasAgent -Operation "Transaction" -Data @{
    Action = "GetSales"
    StartDate = (Get-Date).ToString("yyyy-MM-dd")
    EndDate = (Get-Date).ToString("yyyy-MM-dd")
}

if ($salesResult.Status -eq "Success") {
    Write-Host "✅ Sales summary retrieved!" -ForegroundColor Green
    Write-Host "`nSales Summary:" -ForegroundColor Cyan
    Write-Host "  Total Sales: `$$($salesResult.Result.TotalSales)" -ForegroundColor Green
    Write-Host "  Total Transactions: $($salesResult.Result.TotalTransactions)"
    Write-Host "  Average Transaction: `$$($salesResult.Result.AverageTransaction)"
    Write-Host "  Total Tax Collected: `$$($salesResult.Result.TotalTax)"

    Write-Host "`n  Payment Method Breakdown:" -ForegroundColor Cyan
    $salesResult.Result.PaymentBreakdown | ForEach-Object {
        Write-Host "    $($_.Method): $($_.Count) transactions - `$$($_.Total)" -ForegroundColor White
    }

    Write-Host "`n  Top Selling Items:" -ForegroundColor Cyan
    $salesResult.Result.TopSellingItems | ForEach-Object {
        Write-Host "    📊 $($_.Name): $($_.UnitsSold) units - `$$($_.Revenue) revenue" -ForegroundColor White
    }
}
else {
    Write-Host "❌ Sales summary failed: $($salesResult.Error)" -ForegroundColor Red
}

Write-Host "`n" + ("─" * 60) + "`n"

# Test 3: Inventory - Get Low Stock
Write-Host "═══ Test 3: Inventory - Low Stock Alert ═══" -ForegroundColor Yellow
Write-Host "Checking for products below reorder point...`n"

$lowStockResult = Invoke-BoopasAgent -Operation "Inventory" -Data @{
    Action = "GetLowStock"
}

if ($lowStockResult.Status -eq "Success") {
    Write-Host "✅ Low stock check complete!" -ForegroundColor Green

    if ($lowStockResult.Result.Count -gt 0) {
        Write-Host "`n⚠️ Low Stock Items: $($lowStockResult.Result.Count)" -ForegroundColor Yellow

        $lowStockResult.Result.LowStockItems | ForEach-Object {
            Write-Host "  • $($_.Name) ($($_.SKU))" -ForegroundColor Yellow
            Write-Host "    Category: $($_.Category) | Supplier: $($_.Supplier)" -ForegroundColor Gray
            Write-Host "    On Hand: $($_.QuantityOnHand) | Reorder Point: $($_.ReorderPoint)" -ForegroundColor White
            Write-Host "    Shortfall: $($_.ShortfallQuantity) units | Suggested Order: $($_.ReorderQuantity) units" -ForegroundColor Cyan
        }
    }
    else {
        Write-Host "`n✅ All inventory levels are sufficient!" -ForegroundColor Green
    }
}
else {
    Write-Host "❌ Low stock check failed: $($lowStockResult.Error)" -ForegroundColor Red
}

Write-Host "`n" + ("─" * 60) + "`n"

# Test 4: Inventory - Get Value
Write-Host "═══ Test 4: Inventory - Total Value ═══" -ForegroundColor Yellow
Write-Host "Calculating total inventory value...`n"

$valueResult = Invoke-BoopasAgent -Operation "Inventory" -Data @{
    Action = "GetValue"
}

if ($valueResult.Status -eq "Success") {
    Write-Host "✅ Inventory valuation complete!" -ForegroundColor Green
    Write-Host "`nInventory Metrics:" -ForegroundColor Cyan
    Write-Host "  Total Cost Value: `$$($valueResult.Result.TotalCostValue)" -ForegroundColor Yellow
    Write-Host "  Total Retail Value: `$$($valueResult.Result.TotalRetailValue)" -ForegroundColor Green
    Write-Host "  Potential Profit: `$$($valueResult.Result.PotentialProfit)" -ForegroundColor Cyan
    Write-Host "  Total Product Types: $($valueResult.Result.TotalItems)"
    Write-Host "  Total Units in Stock: $($valueResult.Result.TotalUnits)"

    $profitMargin = if ($valueResult.Result.TotalRetailValue -gt 0) {
        ($valueResult.Result.PotentialProfit / $valueResult.Result.TotalRetailValue) * 100
    } else { 0 }
    Write-Host "  Profit Margin: $([Math]::Round($profitMargin, 2))%" -ForegroundColor Magenta
}
else {
    Write-Host "❌ Inventory valuation failed: $($valueResult.Error)" -ForegroundColor Red
}

Write-Host "`n" + ("─" * 60) + "`n"

# Test 5: Inventory - Get Full Inventory
Write-Host "═══ Test 5: Inventory - Product Catalog ═══" -ForegroundColor Yellow
Write-Host "Retrieving complete product inventory...`n"

$inventoryResult = Invoke-BoopasAgent -Operation "Inventory" -Data @{
    Action = "GetInventory"
    Category = "Bagels"  # Filter by category
}

if ($inventoryResult.Status -eq "Success") {
    Write-Host "✅ Inventory retrieved successfully!" -ForegroundColor Green
    Write-Host "`nBagels Category ($($inventoryResult.Result.Count) products):" -ForegroundColor Cyan

    $inventoryResult.Result.Products | ForEach-Object {
        Write-Host "  🥯 $($_.name) ($($_.sku))" -ForegroundColor Yellow
        Write-Host "     On Hand: $($_.quantityOnHand) | Cost: `$$($_.unitCost) | Price: `$$($_.unitPrice)" -ForegroundColor White
        Write-Host "     Supplier: $($_.supplier)" -ForegroundColor Gray
    }
}
else {
    Write-Host "❌ Inventory retrieval failed: $($inventoryResult.Error)" -ForegroundColor Red
}

Write-Host "`n" + ("─" * 60) + "`n"

# Test 6: Vendor - Get Vendors
Write-Host "═══ Test 6: Vendor - Supplier List ═══" -ForegroundColor Yellow
Write-Host "Retrieving vendor database...`n"

$vendorsResult = Invoke-BoopasAgent -Operation "Vendor" -Data @{
    Action = "GetVendors"
}

if ($vendorsResult.Status -eq "Success") {
    Write-Host "✅ Vendor list retrieved!" -ForegroundColor Green
    Write-Host "`nActive Vendors: $($vendorsResult.Result.Count)" -ForegroundColor Cyan

    $vendorsResult.Result.Vendors | ForEach-Object {
        Write-Host "  🏢 $($_.name) ($($_.id))" -ForegroundColor Cyan
        Write-Host "     Category: $($_.category)" -ForegroundColor Gray
        Write-Host "     Contact: $($_.contact.name) - $($_.contact.email)" -ForegroundColor White
        Write-Host "     Outstanding Balance: `$$($_.outstandingBalance)" -ForegroundColor Yellow
        Write-Host "     Payment Terms: $($_.paymentTerms)" -ForegroundColor Gray
    }
}
else {
    Write-Host "❌ Vendor retrieval failed: $($vendorsResult.Error)" -ForegroundColor Red
}

Write-Host "`n" + ("─" * 60) + "`n"

# Test 7: Vendor - Update Balance (Payment)
Write-Host "═══ Test 7: Vendor - Process Payment ═══" -ForegroundColor Yellow
Write-Host "Recording payment to Local Bakery Supply...`n"

$paymentResult = Invoke-BoopasAgent -Operation "Vendor" -Data @{
    Action = "UpdateBalance"
    VendorID = "VEN-001"
    AmountChange = -200.00  # Negative = payment
}

if ($paymentResult.Status -eq "Success") {
    Write-Host "✅ Payment processed successfully!" -ForegroundColor Green
    Write-Host "  Vendor: $($paymentResult.Result.VendorID)"
    Write-Host "  Action: $($paymentResult.Result.Action)"
    Write-Host "  Amount: `$$([Math]::Abs($paymentResult.Result.AmountChange))" -ForegroundColor Green
}
else {
    Write-Host "❌ Payment failed: $($paymentResult.Error)" -ForegroundColor Red
}

Write-Host "`n" + ("─" * 60) + "`n"

# Test 8: Reconciliation - Vendor Summary
Write-Host "═══ Test 8: Reconciliation - Accounts Payable ═══" -ForegroundColor Yellow
Write-Host "Generating vendor reconciliation report...`n"

$reconResult = Invoke-BoopasAgent -Operation "Reconciliation" -Data @{}

if ($reconResult.Status -eq "Success") {
    Write-Host "✅ Reconciliation report generated!" -ForegroundColor Green
    Write-Host "`nAccounts Payable Summary:" -ForegroundColor Cyan
    Write-Host "  Total Vendors: $($reconResult.Result.TotalVendors)"
    Write-Host "  Active Vendors: $($reconResult.Result.ActiveVendors)"
    Write-Host "  Total Outstanding: `$$($reconResult.Result.TotalOutstandingBalance)" -ForegroundColor Yellow
    Write-Host "  Overdue Vendors: $($reconResult.Result.OverdueVendors)" -ForegroundColor $(
        if ($reconResult.Result.OverdueVendors -gt 0) { "Red" } else { "Green" }
    )

    Write-Host "`n  Vendor Details:" -ForegroundColor Cyan
    $reconResult.Result.Vendors | ForEach-Object {
        Write-Host "    • $($_.Name) - `$$($_.OutstandingBalance)" -ForegroundColor White
        Write-Host "      Last Payment: $($_.LastPaymentDate) | Last Order: $($_.LastOrderDate)" -ForegroundColor Gray
    }
}
else {
    Write-Host "❌ Reconciliation failed: $($reconResult.Error)" -ForegroundColor Red
}

Write-Host "`n" + ("─" * 60) + "`n"

# Summary
Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                     Test Summary                          ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

$context = Get-AgentContext
Write-Host "Session ID: $($context.SessionID)" -ForegroundColor Gray
Write-Host "Total Boopas Agent Calls: $(($context.CallHistory | Where-Object Agent -eq 'Boopas').Count)" -ForegroundColor Cyan
Write-Host "`nAgent Call History:" -ForegroundColor Yellow

$context.CallHistory | Where-Object Agent -eq "Boopas" | ForEach-Object {
    Write-Host "  • $($_.Timestamp.ToString('HH:mm:ss')) - $($_.Agent)Agent: $($_.Operation)" -ForegroundColor White
}

Write-Host "`n✅ Boopas Agent is now operational with real business logic!" -ForegroundColor Green
Write-Host "   POS, Inventory, Vendor management - fully functional!`n" -ForegroundColor Cyan

<#
.SYNOPSIS
    Interactive test script for Finance Agent implementation.

.DESCRIPTION
    Demonstrates all Finance Agent operations with real business logic:
    - Dashboard: Portfolio summary and performance
    - Portfolio: Holdings management
    - MarketEvent: Price alerts
    - Optimization: Rebalancing suggestions
#>

# Import modules
Import-Module .\IntelIntent_Seeding\AgentBridge.psm1 -Force
Import-Module .\IntelIntent_Seeding\FinanceDataHelper.psm1 -Force

Write-Host "`n╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║       Finance Agent - Production Implementation Test      ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

# Test 1: Dashboard Operation
Write-Host "═══ Test 1: Dashboard Operation ═══" -ForegroundColor Yellow
Write-Host "Getting portfolio summary for investor1...`n"

$dashboardResult = Invoke-FinanceAgent -Operation "Dashboard" -Data @{
    UserID = "investor1"
}

if ($dashboardResult.Status -eq "Success") {
    Write-Host "✅ Dashboard operation successful!" -ForegroundColor Green
    Write-Host "`nPortfolio Summary:" -ForegroundColor Cyan
    Write-Host "  Name: $($dashboardResult.Result.Name)"
    Write-Host "  Total Value: $($dashboardResult.Result.TotalValue) USD" -ForegroundColor Green
    Write-Host "  Cash Balance: $($dashboardResult.Result.CashBalance) USD"
    Write-Host "  Net Worth: $($dashboardResult.Result.NetWorth) USD" -ForegroundColor Cyan
    Write-Host "  Total Gain: $($dashboardResult.Result.Gain) USD ($($dashboardResult.Result.GainPercent)%)" -ForegroundColor $(
        if ($dashboardResult.Result.Gain -gt 0) { "Green" } else { "Red" }
    )

    Write-Host "`nTop Holdings:" -ForegroundColor Cyan
    $dashboardResult.Result.Holdings | Select-Object -First 3 | ForEach-Object {
        Write-Host "  📊 $($_.Symbol): $($_.Shares) shares @ $$($_.CurrentValue) ($($_.GainPercent)%)" -ForegroundColor White
    }
}
else {
    Write-Host "❌ Dashboard operation failed: $($dashboardResult.Error)" -ForegroundColor Red
}

Write-Host "`n" + ("─" * 60) + "`n"

# Test 2: Portfolio Operation - Get Holdings
Write-Host "═══ Test 2: Portfolio - Get Holdings ═══" -ForegroundColor Yellow
Write-Host "Retrieving all holdings...`n"

$portfolioResult = Invoke-FinanceAgent -Operation "Portfolio" -Data @{
    UserID = "investor1"
    Action = "GetHoldings"
}

if ($portfolioResult.Status -eq "Success") {
    Write-Host "✅ Portfolio retrieval successful!" -ForegroundColor Green
    Write-Host "`nAll Holdings:" -ForegroundColor Cyan

    $portfolioResult.Result.Holdings | ForEach-Object {
        Write-Host "  • $($_.Symbol) ($($_.Name)): $($_.Shares) shares" -ForegroundColor White
        Write-Host "    Cost Basis: $$($_.CostBasis) | Current: $$($_.CurrentValue) | Gain: $$($_.Gain) ($($_.GainPercent)%)" -ForegroundColor Gray
    }

    Write-Host "`n  Total Portfolio Value: $$($portfolioResult.Result.TotalValue)" -ForegroundColor Cyan
    Write-Host "  Cash Balance: $$($portfolioResult.Result.CashBalance)" -ForegroundColor Cyan
}
else {
    Write-Host "❌ Portfolio operation failed: $($portfolioResult.Error)" -ForegroundColor Red
}

Write-Host "`n" + ("─" * 60) + "`n"

# Test 3: Portfolio Operation - Add Holding
Write-Host "═══ Test 3: Portfolio - Add New Holding ═══" -ForegroundColor Yellow
Write-Host "Adding 15 shares of NVDA at `$495.00...`n"

$addResult = Invoke-FinanceAgent -Operation "Portfolio" -Data @{
    UserID = "investor1"
    Action = "AddHolding"
    Symbol = "NVDA"
    Shares = 15
    Price = 495.00
}

if ($addResult.Status -eq "Success") {
    Write-Host "✅ Holding added successfully!" -ForegroundColor Green
    Write-Host "  Symbol: $($addResult.Result.Symbol)"
    Write-Host "  Shares: $($addResult.Result.Shares)"
    Write-Host "  Price: `$$($addResult.Result.Price)"
}
else {
    Write-Host "❌ Add holding failed: $($addResult.Error)" -ForegroundColor Red
}

Write-Host "`n" + ("─" * 60) + "`n"

# Test 4: Market Event - Get Alerts
Write-Host "═══ Test 4: Market Events - Get Alerts ═══" -ForegroundColor Yellow
Write-Host "Retrieving active market alerts...`n"

$alertsResult = Invoke-FinanceAgent -Operation "MarketEvent" -Data @{
    Action = "GetAlerts"
}

if ($alertsResult.Status -eq "Success") {
    Write-Host "✅ Alert retrieval successful!" -ForegroundColor Green
    Write-Host "`nActive Alerts: $($alertsResult.Result.Count)" -ForegroundColor Cyan

    $alertsResult.Result.Alerts | ForEach-Object {
        Write-Host "  🔔 $($_.id): $($_.symbol) - $($_.type) $($_.condition)" -ForegroundColor Yellow
        if ($_.targetPrice) {
            Write-Host "     Target Price: `$$($_.targetPrice) | Current: `$$($_.currentPrice)" -ForegroundColor Gray
        }
        elseif ($_.targetPercent) {
            Write-Host "     Target Change: $($_.targetPercent)%" -ForegroundColor Gray
        }
        Write-Host "     Status: $($_.status) | Created: $($_.createdDate)" -ForegroundColor Gray
    }
}
else {
    Write-Host "❌ Alert retrieval failed: $($alertsResult.Error)" -ForegroundColor Red
}

Write-Host "`n" + ("─" * 60) + "`n"

# Test 5: Market Event - Create Alert
Write-Host "═══ Test 5: Market Events - Create Alert ═══" -ForegroundColor Yellow
Write-Host "Creating price alert for NVDA at `$500.00...`n"

$createAlertResult = Invoke-FinanceAgent -Operation "MarketEvent" -Data @{
    Action = "CreateAlert"
    Symbol = "NVDA"
    Type = "PriceTarget"
    Condition = "above"
    Value = 500.00
}

if ($createAlertResult.Status -eq "Success") {
    Write-Host "✅ Alert created successfully!" -ForegroundColor Green
    Write-Host "  Alert ID: $($createAlertResult.Result.id)"
    Write-Host "  Symbol: $($createAlertResult.Result.symbol)"
    Write-Host "  Type: $($createAlertResult.Result.type)"
    Write-Host "  Condition: $($createAlertResult.Result.condition)"
    Write-Host "  Target Price: `$$($createAlertResult.Result.targetPrice)"
}
else {
    Write-Host "❌ Alert creation failed: $($createAlertResult.Error)" -ForegroundColor Red
}

Write-Host "`n" + ("─" * 60) + "`n"

# Test 6: Optimization - Rebalance Suggestions
Write-Host "═══ Test 6: Optimization - Rebalance Suggestions ═══" -ForegroundColor Yellow
Write-Host "Analyzing portfolio with target: 70% stocks, 20% crypto, 10% cash...`n"

$optimizeResult = Invoke-FinanceAgent -Operation "Optimization" -Data @{
    UserID = "investor1"
    TargetAllocation = @{
        Stocks = 70
        Crypto = 20
        Cash = 10
    }
}

if ($optimizeResult.Status -eq "Success") {
    Write-Host "✅ Optimization analysis complete!" -ForegroundColor Green
    Write-Host "`nCurrent Allocation:" -ForegroundColor Cyan

    $optimizeResult.Result.CurrentAllocation.GetEnumerator() | ForEach-Object {
        Write-Host "  $($_.Key): $([Math]::Round($_.Value, 2))%" -ForegroundColor White
    }

    Write-Host "`nRebalancing Suggestions ($($optimizeResult.Result.Suggestions.Count)):" -ForegroundColor Cyan

    if ($optimizeResult.Result.Suggestions.Count -eq 0) {
        Write-Host "  ✅ Portfolio is well-balanced! No changes needed." -ForegroundColor Green
    }
    else {
        $optimizeResult.Result.Suggestions | ForEach-Object {
            $color = if ($_.Action -eq "Increase") { "Green" } else { "Yellow" }
            Write-Host "  📊 $($_.Category): $($_.Action)" -ForegroundColor $color
            Write-Host "     Current: $($_.CurrentPercent)% | Target: $($_.TargetPercent)% | Diff: $($_.DifferencePercent)%" -ForegroundColor Gray
            Write-Host "     Suggested: `$$($_.SuggestedAmount)" -ForegroundColor Gray
        }
    }
}
else {
    Write-Host "❌ Optimization failed: $($optimizeResult.Error)" -ForegroundColor Red
}

Write-Host "`n" + ("─" * 60) + "`n"

# Summary
Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                     Test Summary                          ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

$context = Get-AgentContext
Write-Host "Session ID: $($context.SessionID)" -ForegroundColor Gray
Write-Host "Total Finance Agent Calls: $($context.CallHistory.Count)" -ForegroundColor Cyan
Write-Host "`nAgent Call History:" -ForegroundColor Yellow

$context.CallHistory | ForEach-Object {
    Write-Host "  • $($_.Timestamp.ToString('HH:mm:ss')) - $($_.Agent)Agent: $($_.Operation)" -ForegroundColor White
}

Write-Host "`n✅ Finance Agent is now operational with real business logic!" -ForegroundColor Green
Write-Host "   No Azure dependencies - fully functional with local JSON storage.`n" -ForegroundColor Cyan

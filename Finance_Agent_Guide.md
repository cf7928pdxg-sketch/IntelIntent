# Finance Agent - Quick Reference Guide

## Overview
The Finance Agent provides portfolio management, market alerts, and optimization recommendations using local JSON storage (no Azure dependencies).

## Operations

### 1. Dashboard - Portfolio Summary
Get complete portfolio overview with performance metrics.

```powershell
$result = Invoke-FinanceAgent -Operation "Dashboard" -Data @{
    UserID = "investor1"  # Optional, defaults to "investor1"
}

# Returns:
# - TotalValue: Sum of all holdings
# - CashBalance: Available cash
# - NetWorth: Total value + cash
# - Gain/GainPercent: Overall performance
# - Holdings: Array of positions with individual gains
```

**Example Output:**
```
Portfolio Summary:
  Name: Demo Investor
  Total Value: 81831.25 USD
  Net Worth: 86831.25 USD
  Total Gain: 12081.25 USD (17.32%)
```

---

### 2. Portfolio - Holdings Management

#### Get Holdings
```powershell
$result = Invoke-FinanceAgent -Operation "Portfolio" -Data @{
    UserID = "investor1"
    Action = "GetHoldings"
}

# Returns all holdings with:
# - Symbol, Name, Shares
# - CostBasis, CurrentValue
# - Gain, GainPercent
```

#### Add Holding
```powershell
$result = Invoke-FinanceAgent -Operation "Portfolio" -Data @{
    UserID = "investor1"
    Action = "AddHolding"
    Symbol = "NVDA"
    Shares = 15
    Price = 495.00
}

# Adds new position or updates existing (averages cost basis)
```

---

### 3. MarketEvent - Price Alerts

#### Get Active Alerts
```powershell
$result = Invoke-FinanceAgent -Operation "MarketEvent" -Data @{
    Action = "GetAlerts"
}

# Returns array of alerts with:
# - id, symbol, type, condition
# - targetPrice/targetPercent
# - status, createdDate
```

#### Create Alert
```powershell
# Price target alert
$result = Invoke-FinanceAgent -Operation "MarketEvent" -Data @{
    Action = "CreateAlert"
    Symbol = "NVDA"
    Type = "PriceTarget"         # PriceTarget | PercentChange | VolumeSpike
    Condition = "above"          # above | below
    Value = 500.00
}

# Percent change alert
$result = Invoke-FinanceAgent -Operation "MarketEvent" -Data @{
    Action = "CreateAlert"
    Symbol = "AAPL"
    Type = "PercentChange"
    Condition = "above"
    Value = 5.0  # 5% change
}
```

---

### 4. Optimization - Rebalancing

```powershell
$result = Invoke-FinanceAgent -Operation "Optimization" -Data @{
    UserID = "investor1"
    TargetAllocation = @{
        Stocks = 70   # Target 70% in stocks
        Crypto = 20   # Target 20% in crypto
        Cash = 10     # Target 10% in cash
    }
}

# Returns:
# - CurrentAllocation: Actual percentages
# - TargetAllocation: Desired percentages
# - Suggestions: Array of rebalancing actions
#   - Category, Action (Increase/Decrease)
#   - CurrentPercent, TargetPercent
#   - DifferencePercent, SuggestedAmount
```

**Example Output:**
```
Rebalancing Suggestions:
  📊 Crypto: Decrease
     Current: 32.89% | Target: 20% | Diff: -12.89%
     Suggested: $12149.63
  
  📊 Stocks: Increase
     Current: 61.81% | Target: 70% | Diff: 8.19%
     Suggested: $7719.59
```

---

## Data Storage

### Portfolio Data
**File:** `Data/Finance/portfolios.json`

```json
{
  "investors": {
    "investor1": {
      "name": "Demo Investor",
      "holdings": [
        {
          "symbol": "MSFT",
          "name": "Microsoft Corporation",
          "shares": 100,
          "costBasis": 350.00,
          "currentPrice": 375.50,
          "purchaseDate": "2024-01-15"
        }
      ],
      "cashBalance": 5000.00,
      "lastUpdated": "2025-11-30T10:00:00Z"
    }
  }
}
```

### Market Alerts
**File:** `Data/Finance/market_alerts.json`

```json
{
  "alerts": [
    {
      "id": "alert-001",
      "symbol": "MSFT",
      "type": "PriceTarget",
      "condition": "above",
      "targetPrice": 380.00,
      "status": "active",
      "createdDate": "2025-11-15"
    }
  ]
}
```

---

## Helper Functions (FinanceDataHelper.psm1)

### Direct Data Access
```powershell
Import-Module .\IntelIntent_Seeding\FinanceDataHelper.psm1

# Get portfolio object
$portfolio = Get-PortfolioData -UserID "investor1"

# Save portfolio
Set-PortfolioData -UserID "investor1" -PortfolioData $updatedPortfolio

# Calculate summary
$summary = Get-PortfolioSummary -UserID "investor1"

# Add holding
Add-PortfolioHolding -UserID "investor1" -Symbol "TSLA" -Shares 20 -Price 250.00

# Get alerts
$alerts = Get-MarketAlerts

# Create alert
$alert = Add-MarketAlert -Symbol "TSLA" -Type "PriceTarget" -Condition "above" -Value 275.00

# Get rebalance suggestions
$suggestions = Get-RebalanceSuggestions -UserID "investor1" -TargetAllocation @{
    Stocks = 70; Crypto = 20; Cash = 10
}
```

---

## Testing

### Interactive Test Script
```powershell
# Run comprehensive test suite
.\Test-FinanceAgent.ps1

# Tests all 4 operations:
# 1. Dashboard - Portfolio summary
# 2. Portfolio - Get holdings + Add holding
# 3. MarketEvent - Get alerts + Create alert
# 4. Optimization - Rebalancing suggestions
```

### Unit Tests (Pester)
```powershell
# Run Pester tests (when implemented)
Invoke-Pester -Path .\Tests\FinanceAgent.Tests.ps1
```

---

## Error Handling

All operations return consistent structure:

**Success:**
```powershell
@{
    Status = "Success"
    Agent = "Finance"
    Operation = "Dashboard"
    Result = @{ /* operation-specific data */ }
}
```

**Error:**
```powershell
@{
    Status = "Error"
    Agent = "Finance"
    Operation = "Dashboard"
    Error = "Portfolio not found for user: investor2"
}
```

---

## Common Use Cases

### 1. Daily Portfolio Check
```powershell
Import-Module .\IntelIntent_Seeding\AgentBridge.psm1

$dashboard = Invoke-FinanceAgent -Operation "Dashboard" -Data @{ UserID = "investor1" }

Write-Host "Net Worth: $($dashboard.Result.NetWorth) USD"
Write-Host "Gain: $($dashboard.Result.Gain) USD ($($dashboard.Result.GainPercent)%)"
```

### 2. Add Purchase
```powershell
# Buy 10 shares of TSLA at $250
Invoke-FinanceAgent -Operation "Portfolio" -Data @{
    Action = "AddHolding"
    Symbol = "TSLA"
    Shares = 10
    Price = 250.00
}
```

### 3. Set Price Alert
```powershell
# Alert when NVDA goes above $500
Invoke-FinanceAgent -Operation "MarketEvent" -Data @{
    Action = "CreateAlert"
    Symbol = "NVDA"
    Type = "PriceTarget"
    Condition = "above"
    Value = 500.00
}
```

### 4. Monthly Rebalancing
```powershell
$rebalance = Invoke-FinanceAgent -Operation "Optimization" -Data @{
    TargetAllocation = @{ Stocks = 70; Crypto = 20; Cash = 10 }
}

# Review suggestions
$rebalance.Result.Suggestions | ForEach-Object {
    Write-Host "$($_.Category): $($_.Action) $($_.SuggestedAmount) USD"
}
```

---

## Next Steps

- **Phase 3:** Integrate real-time price feeds (Alpha Vantage, Yahoo Finance API)
- **Phase 4:** Add transaction history tracking
- **Phase 5:** Implement tax loss harvesting calculations
- **Phase 6:** Power BI dashboard for portfolio visualization

---

## Files Created

| File | Purpose | Lines |
|------|---------|-------|
| `IntelIntent_Seeding/FinanceDataHelper.psm1` | Data storage layer | 450+ |
| `Data/Finance/portfolios.json` | Portfolio holdings | Sample data |
| `Data/Finance/market_alerts.json` | Price alerts | Sample data |
| `Test-FinanceAgent.ps1` | Interactive test suite | 280+ |

**Status:** ✅ **Production Ready** (No Azure dependencies)

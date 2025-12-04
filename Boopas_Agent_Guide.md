# 🏪 Boopas Agent - Commerce & POS Operations Guide

## Overview

**Boopas Agent** provides commerce and point-of-sale (POS) workflow automation with local JSON persistence. No Azure dependencies required.

**Version:** 1.0.0  
**Status:** ✅ Production Ready  
**Module:** `IntelIntent_Seeding/AgentBridge.psm1`

---

## 🎯 Core Capabilities

### 1. Transaction Processing

- Process POS sales with automatic tax calculation (8%)
- Auto-inventory deduction when items are sold
- Support for multiple payment methods (cash, credit card, mobile payment)
- Transaction history with timestamps and line-item detail

### 2. Inventory Management

- Product catalog with cost/price tracking
- Low stock alerts with reorder suggestions
- Inventory valuation (cost basis + retail value)
- Category-based filtering

### 3. Vendor Management

- Supplier database with contact information
- Outstanding balance tracking
- Payment processing and reconciliation
- Payment terms management (Net 15, Net 30)

### 4. Reconciliation

- Accounts payable summary
- Overdue vendor identification (>30 days)
- Total outstanding balance calculation

---

## 📋 Operations Reference

### Operation: Transaction

#### Sub-Action: ProcessSale

**Purpose:** Ring up a sale at the point of sale with automatic tax and inventory updates.

**Parameters:**

```powershell
$data = @{
    Action = "ProcessSale"
    Items = @(
        @{ sku = "BAGEL-001"; quantity = 2; unitPrice = 2.50 }
        @{ sku = "COFFEE-001"; quantity = 1; unitPrice = 3.00 }
    )
    PaymentMethod = "credit_card"  # Options: cash, credit_card, mobile_payment
}
```

**Example:**

```powershell
$result = Invoke-BoopasAgent -Operation "Transaction" -Data @{
    Action = "ProcessSale"
    Items = @(
        @{ sku = "BAGEL-002"; quantity = 3; unitPrice = 2.00 }
    )
    PaymentMethod = "cash"
}

# Output:
# {
#   Status: "Success"
#   Result: {
#     id: "TXN-20251201-005"
#     timestamp: "2025-12-01T03:30:00Z"
#     subtotal: 6.00
#     tax: 0.48
#     total: 6.48
#     paymentMethod: "cash"
#     items: [ ... ]
#   }
# }
```

**Business Logic:**

- Auto-generates transaction ID: `TXN-YYYYMMDD-NNN`
- Applies 8% sales tax
- Deducts sold quantities from inventory
- Persists to `Data/Boopas/transactions.json`

---

#### Sub-Action: GetSales

**Purpose:** Retrieve sales summary for date range with payment breakdown and top sellers.

**Parameters:**

```powershell
$data = @{
    Action = "GetSales"
    StartDate = "2025-12-01"
    EndDate = "2025-12-01"
}
```

**Example:**

```powershell
$result = Invoke-BoopasAgent -Operation "Transaction" -Data @{
    Action = "GetSales"
    StartDate = (Get-Date).ToString("yyyy-MM-dd")
    EndDate = (Get-Date).ToString("yyyy-MM-dd")
}

# Output:
# {
#   Status: "Success"
#   Result: {
#     TotalSales: 32.40
#     TotalTransactions: 3
#     AverageTransaction: 10.80
#     TotalTax: 2.40
#     PaymentBreakdown: [
#       { Method: "cash", Count: 1, Total: 16.20 }
#       { Method: "credit_card", Count: 2, Total: 16.20 }
#     ]
#     TopSellingItems: [ ... ]
#   }
# }
```

**Metrics Provided:**

- Total sales revenue
- Number of transactions
- Average transaction value
- Total tax collected
- Payment method breakdown
- Top 5 selling items by revenue

---

#### Sub-Action: GetTransactions

**Purpose:** Retrieve all transactions (unfiltered).

**Parameters:**

```powershell
$data = @{
    Action = "GetTransactions"
}
```

**Example:**

```powershell
$result = Invoke-BoopasAgent -Operation "Transaction" -Data @{
    Action = "GetTransactions"
}

# Returns all transactions with full detail
```

---

### Operation: Inventory

#### Sub-Action: GetInventory

**Purpose:** Retrieve product catalog with optional category filtering.

**Parameters:**

```powershell
$data = @{
    Action = "GetInventory"
    Category = "Bagels"  # Optional filter
}
```

**Example:**

```powershell
# Get all products
$result = Invoke-BoopasAgent -Operation "Inventory" -Data @{
    Action = "GetInventory"
}

# Get only coffee products
$result = Invoke-BoopasAgent -Operation "Inventory" -Data @{
    Action = "GetInventory"
    Category = "Coffee"
}

# Output:
# {
#   Status: "Success"
#   Result: {
#     Count: 2
#     Products: [
#       {
#         sku: "COFFEE-001"
#         name: "Regular Coffee"
#         category: "Coffee"
#         unitCost: 0.90
#         unitPrice: 3.00
#         quantityOnHand: 150
#         reorderPoint: 50
#         reorderQuantity: 100
#         supplier: "Coffee Distributors Inc"
#       }
#       ...
#     ]
#   }
# }
```

---

#### Sub-Action: GetLowStock

**Purpose:** Identify products at or below reorder point with order suggestions.

**Parameters:**

```powershell
$data = @{
    Action = "GetLowStock"
}
```

**Example:**

```powershell
$result = Invoke-BoopasAgent -Operation "Inventory" -Data @{
    Action = "GetLowStock"
}

# Output:
# {
#   Status: "Success"
#   Result: {
#     Count: 2
#     LowStockItems: [
#       {
#         SKU: "BAGEL-002"
#         Name: "Plain Bagel"
#         Category: "Bagels"
#         QuantityOnHand: 36
#         ReorderPoint: 50
#         ShortfallQuantity: 14
#         ReorderQuantity: 100
#         Supplier: "Local Bakery Supply"
#       }
#       ...
#     ]
#   }
# }
```

**Business Logic:**

- Shortfall = ReorderPoint - QuantityOnHand (if below threshold)
- Suggested order = ReorderQuantity (from product definition)

---

#### Sub-Action: GetValue

**Purpose:** Calculate total inventory value at cost and retail prices.

**Parameters:**

```powershell
$data = @{
    Action = "GetValue"
}
```

**Example:**

```powershell
$result = Invoke-BoopasAgent -Operation "Inventory" -Data @{
    Action = "GetValue"
}

# Output:
# {
#   Status: "Success"
#   Result: {
#     TotalCostValue: 398.25     # Sum of (unitCost * quantityOnHand)
#     TotalRetailValue: 1593.00  # Sum of (unitPrice * quantityOnHand)
#     PotentialProfit: 1194.75   # Retail - Cost
#     TotalItems: 7              # Product types
#     TotalUnits: 501            # Total units in stock
#   }
# }
```

**Use Cases:**

- Balance sheet reporting
- Profit margin analysis
- Insurance coverage calculation

---

#### Sub-Action: UpdateQuantity

**Purpose:** Manually adjust inventory quantities (receiving shipments, damaged goods, etc.).

**Parameters:**

```powershell
$data = @{
    Action = "UpdateQuantity"
    SKU = "BAGEL-001"
    QuantityChange = 100  # Positive = addition, Negative = removal
}
```

**Example:**

```powershell
# Receive shipment
$result = Invoke-BoopasAgent -Operation "Inventory" -Data @{
    Action = "UpdateQuantity"
    SKU = "COFFEE-002"
    QuantityChange = 50  # Add 50 units
}

# Remove damaged goods
$result = Invoke-BoopasAgent -Operation "Inventory" -Data @{
    Action = "UpdateQuantity"
    SKU = "CREAM-001"
    QuantityChange = -5  # Remove 5 units
}
```

**Note:** Sales automatically deduct inventory via `ProcessSale`. Manual updates are for receiving/adjustments.

---

### Operation: Vendor

#### Sub-Action: GetVendors

**Purpose:** Retrieve supplier database with contact information and balances.

**Parameters:**

```powershell
$data = @{
    Action = "GetVendors"
}
```

**Example:**

```powershell
$result = Invoke-BoopasAgent -Operation "Vendor" -Data @{
    Action = "GetVendors"
}

# Output:
# {
#   Status: "Success"
#   Result: {
#     Count: 3
#     Vendors: [
#       {
#         id: "VEN-001"
#         name: "Local Bakery Supply"
#         category: "Bakery Ingredients"
#         contact: {
#           name: "Maria Santos"
#           email: "maria@localbakery.com"
#           phone: "555-0101"
#         }
#         paymentTerms: "Net 30"
#         outstandingBalance: 850.00
#         lastPaymentDate: "2025-11-15"
#         lastOrderDate: "2025-11-25"
#       }
#       ...
#     ]
#   }
# }
```

---

#### Sub-Action: UpdateBalance

**Purpose:** Process vendor payments or record new invoices.

**Parameters:**

```powershell
$data = @{
    Action = "UpdateBalance"
    VendorID = "VEN-001"
    AmountChange = -200.00  # Negative = payment, Positive = new invoice
}
```

**Example:**

```powershell
# Make payment to vendor
$result = Invoke-BoopasAgent -Operation "Vendor" -Data @{
    Action = "UpdateBalance"
    VendorID = "VEN-002"
    AmountChange = -150.00  # Pay $150
}

# Record new invoice
$result = Invoke-BoopasAgent -Operation "Vendor" -Data @{
    Action = "UpdateBalance"
    VendorID = "VEN-003"
    AmountChange = 425.00  # New $425 invoice
}

# Output:
# {
#   Status: "Success"
#   Result: {
#     VendorID: "VEN-002"
#     Action: "Payment"  # or "Invoice"
#     AmountChange: 150.00
#   }
# }
```

---

### Operation: Reconciliation

#### Sub-Action: (Default)

**Purpose:** Generate accounts payable summary with overdue vendor identification.

**Parameters:**

```powershell
$data = @{}  # No parameters required
```

**Example:**

```powershell
$result = Invoke-BoopasAgent -Operation "Reconciliation" -Data @{}

# Output:
# {
#   Status: "Success"
#   Result: {
#     TotalVendors: 3
#     ActiveVendors: 3
#     TotalOutstandingBalance: 1375.00
#     OverdueVendors: 1  # Count of vendors with >30 day overdue payments
#     Vendors: [
#       {
#         VendorID: "VEN-001"
#         Name: "Local Bakery Supply"
#         OutstandingBalance: 650.00
#         LastPaymentDate: "2025-11-30"
#         LastOrderDate: "2025-11-25"
#         IsOverdue: false
#       }
#       ...
#     ]
#   }
# }
```

**Overdue Logic:**

- Compares `lastPaymentDate` to current date
- Vendor is overdue if difference > 30 days

---

## 📂 Data Structures

### Transactions (`Data/Boopas/transactions.json`)

```json
[
  {
    "id": "TXN-20251201-001",
    "timestamp": "2025-12-01T08:30:00Z",
    "items": [
      {
        "sku": "BAGEL-001",
        "name": "Everything Bagel",
        "quantity": 2,
        "unitPrice": 2.50,
        "total": 5.00
      }
    ],
    "subtotal": 5.00,
    "tax": 0.40,
    "total": 5.40,
    "paymentMethod": "credit_card"
  }
]
```

### Inventory (`Data/Boopas/inventory.json`)

```json
[
  {
    "sku": "BAGEL-001",
    "name": "Everything Bagel",
    "category": "Bagels",
    "unitCost": 0.75,
    "unitPrice": 2.50,
    "quantityOnHand": 48,
    "reorderPoint": 50,
    "reorderQuantity": 100,
    "supplier": "Local Bakery Supply"
  }
]
```

### Vendors (`Data/Boopas/vendors.json`)

```json
[
  {
    "id": "VEN-001",
    "name": "Local Bakery Supply",
    "category": "Bakery Ingredients",
    "contact": {
      "name": "Maria Santos",
      "email": "maria@localbakery.com",
      "phone": "555-0101"
    },
    "paymentTerms": "Net 30",
    "outstandingBalance": 850.00,
    "lastPaymentDate": "2025-11-15",
    "lastOrderDate": "2025-11-25"
  }
]
```

---

## 🧪 Testing

### Interactive Test Suite

**File:** `Test-BoopasAgent.ps1`

**Run All Tests:**

```powershell
.\Test-BoopasAgent.ps1
```

**Test Coverage:**

1. ✅ Transaction - Process Sale (with auto-inventory deduction)
2. ✅ Transaction - Sales Summary (payment breakdown, top sellers)
3. ✅ Inventory - Low Stock Alert (reorder suggestions)
4. ✅ Inventory - Total Value (cost/retail/profit)
5. ✅ Inventory - Product Catalog (category filtering)
6. ✅ Vendor - Supplier List (contact info, balances)
7. ✅ Vendor - Process Payment (update outstanding balances)
8. ✅ Reconciliation - Accounts Payable (overdue vendor tracking)

**Expected Output:**

```
✅ Boopas Agent is now operational with real business logic!
   POS, Inventory, Vendor management - fully functional!
```

---

## 🎨 Visual Menu Integration

### IntelIntent Launcher (Option 11)

```powershell
.\IntelIntent_Launcher.ps1

# Menu displays:
# ────────── 🤖 Agent Testing ──────────
# 10. Test Finance Agent
# 11. Test Boopas Agent (POS/Commerce)  ← Runs Test-BoopasAgent.ps1
# 12. Test Modality Agent (coming soon)
```

---

## 💡 Common Use Cases

### Daily Sales Report

```powershell
$todaySales = Invoke-BoopasAgent -Operation "Transaction" -Data @{
    Action = "GetSales"
    StartDate = (Get-Date).ToString("yyyy-MM-dd")
    EndDate = (Get-Date).ToString("yyyy-MM-dd")
}

Write-Host "Today's Revenue: `$$($todaySales.Result.TotalSales)"
Write-Host "Transactions: $($todaySales.Result.TotalTransactions)"
```

### Weekly Inventory Check

```powershell
$lowStock = Invoke-BoopasAgent -Operation "Inventory" -Data @{
    Action = "GetLowStock"
}

if ($lowStock.Result.Count -gt 0) {
    Write-Host "⚠️ $($lowStock.Result.Count) products need reordering!"
    $lowStock.Result.LowStockItems | ForEach-Object {
        Write-Host "  → Order $($_.ReorderQuantity) units of $($_.Name)"
    }
}
```

### End-of-Month Vendor Reconciliation

```powershell
$recon = Invoke-BoopasAgent -Operation "Reconciliation" -Data @{}

Write-Host "Total Payables: `$$($recon.Result.TotalOutstandingBalance)"

if ($recon.Result.OverdueVendors -gt 0) {
    Write-Host "⚠️ $($recon.Result.OverdueVendors) vendors are overdue!"
}
```

### Inventory Valuation for Insurance

```powershell
$value = Invoke-BoopasAgent -Operation "Inventory" -Data @{
    Action = "GetValue"
}

$profitMargin = ($value.Result.PotentialProfit / $value.Result.TotalRetailValue) * 100
Write-Host "Inventory Value: `$$($value.Result.TotalRetailValue)"
Write-Host "Profit Margin: $([Math]::Round($profitMargin, 2))%"
```

---

## 🔧 Troubleshooting

### Issue: "Transaction ID already exists"

**Cause:** System clock went backward or duplicate transaction processing.

**Solution:**

```powershell
# Transactions use timestamp-based IDs: TXN-YYYYMMDD-NNN
# Manual edit of Data/Boopas/transactions.json may be required
```

---

### Issue: "SKU not found in inventory"

**Cause:** Attempting to sell/update a product not in catalog.

**Solution:**

```powershell
# Add product to Data/Boopas/inventory.json first
{
    "sku": "NEW-001",
    "name": "New Product",
    "category": "Category",
    "unitCost": 1.00,
    "unitPrice": 2.00,
    "quantityOnHand": 100,
    "reorderPoint": 25,
    "reorderQuantity": 50,
    "supplier": "Vendor Name"
}
```

---

### Issue: "Vendor not found"

**Cause:** Invalid VendorID in UpdateBalance operation.

**Solution:**

```powershell
# List all vendors first
$vendors = Invoke-BoopasAgent -Operation "Vendor" -Data @{
    Action = "GetVendors"
}

$vendors.Result.Vendors | ForEach-Object {
    Write-Host "$($_.id): $($_.name)"
}
```

---

## 📊 Business Metrics

### Key Performance Indicators

- **Average Transaction Value:** Total Sales ÷ Transaction Count
- **Inventory Turnover:** (Will require historical sales data in future phases)
- **Profit Margin:** (Potential Profit ÷ Retail Value) × 100
- **Payable Days Outstanding:** Days since last vendor payment

### Sample Calculations

```powershell
# Average sale value
$sales = Invoke-BoopasAgent -Operation "Transaction" -Data @{
    Action = "GetSales"
    StartDate = "2025-12-01"
    EndDate = "2025-12-01"
}

$avgSale = $sales.Result.AverageTransaction
Write-Host "Average Sale: `$$([Math]::Round($avgSale, 2))"

# Inventory health
$inventory = Invoke-BoopasAgent -Operation "Inventory" -Data @{
    Action = "GetValue"
}

$stockValue = $inventory.Result.TotalRetailValue
Write-Host "Stock on Hand: `$$stockValue"
```

---

## 🔐 Security Considerations

### Local Data Storage

- All data stored in plain JSON files
- No encryption currently implemented
- **Recommendation:** Implement Azure Key Vault integration in Phase 5 for sensitive data (vendor bank accounts, payment info)

### Access Control

- No authentication layer in current implementation
- **Recommendation:** Add RBAC via IdentityAgent in Phase 5

---

## 🚀 Future Enhancements (Phase 5+)

### Planned Features

1. **Azure Integration:**
   - Sync transactions to Azure SQL Database
   - Real-time inventory sync with Azure Cosmos DB
   - Power BI dashboard integration

2. **Advanced Reporting:**
   - Weekly/monthly sales trends
   - Profit margin analysis by category
   - Customer purchase history (requires customer table)

3. **Multi-Location Support:**
   - Location-based inventory tracking
   - Inter-location transfers
   - Consolidated reporting

4. **Barcode Scanning:**
   - Camera/scanner integration via ModalityAgent
   - SKU lookup automation

5. **Payment Processing:**
   - Credit card gateway integration
   - Receipt printing
   - Refund processing

---

## 📞 Support

**Test Script:** `.\Test-BoopasAgent.ps1`  
**Helper Module:** `IntelIntent_Seeding/BoopasDataHelper.psm1`  
**Main Module:** `IntelIntent_Seeding/AgentBridge.psm1`

**Session Tracking:**

```powershell
$context = Get-AgentContext
$context.CallHistory | Where-Object Agent -eq "Boopas" | Format-Table
```

---

**Last Updated:** December 1, 2025  
**Version:** 1.0.0  
**Status:** ✅ Production Ready

# Business Central Location Setup Guide

This document outlines the steps to set up your bakery's physical location structure in Business Central.

## Main Location Configuration

### Basic Information

| Field | Value |
|-------|-------|
| Location Code | MAIN |
| Name | Boopas Bagels |
| Address | 6513 North Beach Street |
| City | Fort Worth |
| State/County | Tarrant |
| Post Code | 76137 |
| Country/Region Code | USA |

### Warehouse Configuration

| Field | Value | Description |
|-------|-------|-------------|
| Use As In-Transit | No | This is not a transit warehouse |
| Require Put-away | Yes | Formal put-away process for receiving |
| Require Pick | Yes | Formal pick process for sales |
| Bin Mandatory | Yes | Items must be stored in specific bins |
| Directed Put-away and Pick | Yes | System will suggest optimal bins |

## Zone Configuration

Zones group related bins by purpose or physical area. Set up the following zones:

| Zone Code | Description | Bin Ranking Priority |
|-----------|-------------|---------------------|
| 1 | FOH - Customer Service | 100 |
| 2 | FOH - Retail | 200 |
| 3 | BOH - Production | 300 |
| 4 | BOH - Storage | 400 |
| 5 | Vendor Managed | 500 |

## Bin Types

| Bin Type Code | Description | Usage |
|---------------|-------------|-------|
| PICKING | Bins used for customer order picking | FOH service areas |
| PUTAWAY | Bins used for receiving goods | BOH storage areas |
| PRODUCTION | Bins used during production | BOH production areas |
| STORAGE | General storage bins | Other areas |

## Bin Configuration

Configure the following bins in Business Central:

### Front of House (FOH) Bins

| Bin Code | Description | Zone | Bin Type |
|----------|-------------|------|----------|
| FOH-SRV-EMP | Service Bar (Employee Side) | 1 | PICKING |
| FOH-SRV-CUST | Service Bar (Customer Side) | 1 | PICKING |
| FOH-CHECKOUT | Checkout Area | 2 | PICKING |
| FOH-COFFEE | Coffee Bar | 2 | PICKING |
| FOH-RETAIL | Retail Area | 2 | STORAGE |
| FOH-SNAP | Snapple Cooler | 2 | STORAGE |

### Back of House (BOH) Bins

| Bin Code | Description | Zone | Bin Type |
|----------|-------------|------|----------|
| BOH-PREP | Preparation Area | 3 | PRODUCTION |
| BOH-OVEN | Oven Area | 3 | PRODUCTION |
| BOH-COOL | Cooling Area | 3 | PRODUCTION |
| BOH-STORAGE-AMB | Ambient Storage | 4 | PUTAWAY |
| BOH-STORAGE-REF | Refrigerated Storage | 4 | PUTAWAY |
| BOH-STORAGE-FRZ | Freezer Storage | 4 | PUTAWAY |

### Vendor Managed Bins

| Bin Code | Description | Zone | Bin Type |
|----------|-------------|------|----------|
| FOH-BVNDR-COKE | Coke Refrigerator | 5 | STORAGE |
| FOH-BVNDR-DP | Dr. Pepper Refrigerator | 5 | STORAGE |

## Implementation Steps

1. **Create Location**
   - Navigate to Locations list
   - Create new Location with code "MAIN"
   - Fill in address and other basic information
   - Configure warehouse settings (enable bins, put-away, and pick)

2. **Create Zones**
   - Navigate to Zones
   - Create the 5 zones listed above

3. **Create Bin Types**
   - Navigate to Bin Types
   - Create the 4 bin types listed above

4. **Create Bins**
   - Navigate to Bins
   - Create all bins listed above, assigning proper zone and bin type
   - Set appropriate bin rankings

5. **Set Default Bins**
   - For each item category, set default bins:
     - Raw Ingredients → BOH-STORAGE-AMB/REF/FRZ (based on storage type)
     - WIP → BOH-PREP or BOH-STORAGE-REF (based on stage)
     - Finished Goods → FOH-SRV-EMP
     - Retail Products → FOH-RETAIL or FOH-SNAP

## Warehouse Operations

### Receiving Process

1. Create Purchase Order
2. Receive items into appropriate BOH-STORAGE bins
3. System will suggest bins based on item storage type

### Production Process

1. Move raw ingredients from storage to BOH-PREP
2. After forming, move to appropriate storage or directly to BOH-OVEN
3. After baking, move to BOH-COOL
4. Move finished products to FOH-SRV-EMP

### Sales Process

1. For service items, pick from FOH-SRV-EMP
2. For retail items, pick from FOH-RETAIL or FOH-SNAP
3. Register sales at FOH-CHECKOUT

## Stock Counts

Schedule regular stock counts by bin:

- Daily: FOH bins (end of day)
- Weekly: BOH-PREP and BOH-STORAGE-REF
- Monthly: BOH-STORAGE-AMB and BOH-STORAGE-FRZ

## Important Considerations

1. **Temperature Control**
   - Ensure refrigerated and frozen bins have proper temperature monitoring
   - Set up alerts for temperature-sensitive items approaching shelf life limits

2. **Retail vs. Service Items**
   - Items can exist in multiple bins based on purpose
   - Same item may have different pricing when sold as retail vs. service

3. **Vendor Managed Inventory**
   - Set up special handling for vendor-managed bins
   - Create process for recording vendor-managed inventory without formal receiving

# Bakery Production and Inventory Processes

## Key Status Transitions

| Product | Status Change | Description | Business Central Implementation |
|---------|--------------|-------------|--------------------------------|
| Bagel Dough | Raw → Bulk | Ingredients are mixed to create dough | Production Order (Output) |
| Bulk Dough | Bulk → Formed | Dough is formed into bagels or boopalaches | Production Operation (Status Update) |
| Formed Products | Formed → Retarding | Products are placed on boards in walk-in | Production Operation (Status Update) |
| Retarded Products | Retarding → Baking | Products are removed from walk-in and baked | Production Operation (Status Update) |
| Baked Products | Baking → Ready-to-Sell | Products are completed and ready for sale | Production Order Completion |
| Cream Cheese | Purchased → Whipped | 30lb case is whipped into bulk form | Item Journal (Positive Output) |
| Whipped Cream Cheese | Whipped → Retail Packaged | Filled into 8oz containers | Assembly Order |

## Waste Tracking Points

Each status transition represents a potential waste tracking point:

1. **Raw to Bulk**
   - Tracking: Weight discrepancies
   - Reason codes: Recipe error, ingredient quality, equipment failure

2. **Bulk to Formed**
   - Tracking: Count of items that couldn't be properly formed
   - Reason codes: Dough consistency, equipment failure, operator error

3. **Formed to Retarding**
   - Tracking: Items damaged during board placement or transfer
   - Reason codes: Handling damage, space constraints, dropped items

4. **Retarding to Baking**
   - Tracking: Items not suitable for baking
   - Reason codes: Over-proofed, under-proofed, contaminated, damaged

5. **Baking to Ready-to-Sell**
   - Tracking: Items not meeting quality standards after baking
   - Reason codes: Overbaked, underbaked, misshapen, wrong size

6. **End-of-Day**
   - Tracking: Unsold items that can't be repurposed
   - Reason codes: Low sales, overproduction, quality deterioration

## Inventory Units and Conversions

| Item | Base Unit | Alternative Units | Conversion Factor | Usage |
|------|-----------|-------------------|-------------------|-------|
| Flour | lb | 50lb bag | 1 bag = 50 lb | Recipe ingredient |
| Yeast | oz | package | 1 package = X oz | Recipe ingredient |
| Salt | lb | box | 1 box = X lb | Recipe ingredient |
| Cream Cheese | lb | 30lb case | 1 case = 30 lb | Base product |
| Whipped Cream Cheese | lb | container | 1 container = X lb | Service product |
| Retail Cream Cheese | container | case | 1 case = X containers | Retail product |
| Bagels | each | board, rack | 1 board = 24 bagels, 1 rack = X boards | Production tracking |
| Packaged Bagels | package | - | 1 package = 6 bagels | Retail product |

## Capacity Management

| Resource | Capacity Type | Capacity Unit | Notes |
|----------|---------------|--------------|-------|
| Mixer | Machine | Batches per hour | Limits total dough production |
| Walk-in | Storage | Board count | Limits retarding capacity |
| Oven | Machine | Boards per hour | Limits baking throughput |
| Boards | Equipment | 24 bagels each | Critical capacity constraint |
| Racks | Equipment | X boards each | Walk-in organization |
| Whipping Equipment | Machine | Pounds per hour | Cream cheese processing |

## Key Stock-Keeping Units (SKUs)

| SKU Category | Examples | Inventory Type | Tracking Method |
|--------------|----------|---------------|----------------|
| Raw Materials | Flour, Yeast, Salt | Inventory | FIFO, Perpetual |
| Work-in-Progress | Bulk Dough, Formed Products | Non-Inventory | Status-based |
| Finished Goods | Baked Bagels, Cream Cheese | Inventory | FIFO, Daily Count |
| Assembly Components | Bagels, Cream Cheese | Inventory | FIFO, Daily Usage |
| Retail Products | Packaged Bagels, 8oz Cream Cheese | Inventory | FIFO, Daily Count |

## Par Value Management

Par values determine the daily production quantities and vary by:
- Day of week
- Product type
- Season or special events

**Implementation Strategy:**
1. Create a custom table for par values
2. Configure by day-of-week for each product
3. Use as input for production planning
4. Compare with actual sales for ongoing optimization

## Assembly Items Management

Assembly items combine multiple inventory components into a new saleable item:

1. **Bagel with Cream Cheese**
   - Components: Bagel (1), Cream Cheese (X oz)
   - Assembly: Made to order or pre-assembled

2. **Boopalache**
   - Components: Bulk dough (X oz), Other ingredients (varies)
   - Assembly: Through production process

**Implementation Strategy:**
1. Define assembly BOMs
2. Set up assembly policies (assemble-to-order or assemble-to-stock)
3. Configure pricing based on components plus assembly cost
4. Track component usage through assembly orders

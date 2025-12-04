# Bakery Business Central Implementation - Requirements & Strategy

## Project Overview
**Project Title:** Customized Business Central for Bakery Operations  
**Project Owner:** Nic – Vice President & COO  
**Project Sponsor:** Michelle – President & CFO

## Discovered Requirements

### 1. Inventory Management

#### 1.1 Raw Ingredients
- Multi-level unit of measure system:
  - Purchasing Unit (e.g., 50 lb bag of Sir Lancelot Flour)
  - Inventory Unit (e.g., pounds)
  - Recipe Unit (e.g., pounds/ounces)
- Allergen tracking
- Storage location tracking (ambient, refrigerated, frozen)

#### 1.2 Finished Products
- Shelf life tracking
- Status tracking (bulk, formed, retarding, baking, ready-to-sell)
- Waste tracking with reason codes at each stage

### 2. Production Process

#### 2.1 Base Recipes Discovered

##### 2.1.1 Bagel Products
- **Bagel Doughs (Plain):** 50lbs Sir Lancelot, 3.5oz yeast, 1lb kosher salt, 8oz brown sugar, 8oz honey, 1can malt, 24lbs water
- **Jalapeno Cheddar:** Bagel dough + 14oz dried jalapenos, 7oz dried red bell pepper, 1lb 12oz cheddar cheese
- **Asiago:** Bagel dough + 14oz asiago spice, 7oz parsley, 1lb 12oz asiago cheese

##### 2.1.2 Cream Cheese Products
- **Cream Cheese:** 30lb case of full fat plain cream cheese blocks (purchased as finished product)
- **Whipped Cream Cheese:** Cream cheese processed through whipping
- **Retail Cream Cheese:** 8oz containers filled from whipped cream cheese
- **Service Cream Cheese:** Bulk whipped cream cheese for a la carte service and assembly items

#### 2.2 Production Workflow

##### 2.2.1 Bagel Products Workflow
- **Path 1:** Mix bagel doughs → Store as bulk (8hr min) → Form into boopalaches (requires bulk dough + additional ingredients) → Retard (8hr min) → Bake
- **Path 2:** Mix bagel doughs → Form into bagels → Retard (16hr min) → Bake

##### 2.2.2 Cream Cheese Workflow
- **Path 1:** Receive 30lb case of cream cheese → Whip cream cheese → Store in container under service bar
- **Path 2:** Take from whipped cream cheese → Fill 8oz containers → Sell as retail product
- **Path 3:** Take from whipped cream cheese → Use for a la carte orders or as assembly ingredient

#### 2.3 Production Constraints

##### 2.3.1 Bagel Production Constraints
- Boards hold 24 bagels (6×4 configuration)
- Multiple boards per rack
- Minimum retarding times must be enforced
- Daily par values vary by day of week
- Additional production for catering and wholesale orders

##### 2.3.2 Cream Cheese Production Constraints
- Tracking of 30lb case inventory
- Conversion tracking from case to whipped bulk cream cheese
- Conversion tracking from bulk to 8oz retail containers
- Usage tracking for service and assembly items
- Shelf life tracking for all cream cheese products
- Temperature requirements for storage

#### 2.4 Daily Sales and Inventory Management

##### 2.4.1 Bagel Daily Management
- Planned bake quantities set per day based on par values
- Baker records actual bagels baked minus waste during baking
- Sales tracked throughout service
- End-of-day inventory count performed by servers
- Leftover bagels (6 or more) packaged in bags of 6 and converted to retail item for next-day sale
- Conversion tracking from fresh bagels to packaged retail item

##### 2.4.2 Cream Cheese Daily Management
- Tracking of cream cheese usage for service (a la carte)
- Tracking of cream cheese usage for assembly items (bagel with cream cheese)
- Tracking of cream cheese conversion to 8oz retail containers
- Daily inventory management of bulk cream cheese

### 3. Cost Tracking
- Recipe-level costing
- Daily cost rotation tracking
- Waste analysis
- Yield metrics (expected vs actual)

### 4. Sales Channels
- Retail (in-store)
- Catering
- Wholesale
- Channel-specific pricing and reporting

## Implementation Strategy

### Phase 1: Core Configuration

#### 1. Item Setup
- [ ] Configure items for all ingredients with multiple units of measure
- [ ] Set up allergen tracking as item attributes
- [ ] Configure storage requirements and locations

#### 2. Production BOMs
- [ ] Create bagel doughs base BOM
- [ ] Set up variant BOMs for different bagel dough types
- [ ] Configure multi-level BOMs for formed products
- [ ] Create special BOMs for boopalaches (combining bulk dough + additional ingredients)
- [ ] Configure cream cheese inventory item with multiple units of measure (30lb case, whipped bulk, 8oz retail)
- [ ] Set up conversion processes for cream cheese (case to whipped, whipped to retail containers)
- [ ] Include waste tracking at each conversion stage

#### 3. Production Routings
- [ ] Define work centers (mixer, walk-in, bagel machine, prep table, oven)
- [ ] Configure complex routing with multiple paths
- [ ] Set up capacity for boards and racks
- [ ] Create cream cheese preparation work centers
- [ ] Define packaging process for cream cheese products

### Phase 2: Custom Extensions (AL Development)

#### 1. Extended Production Management
- [ ] Custom status tracking for production stages (bulk, formed, retarding, baking, ready-to-sell)
- [ ] Waste tracking at each production stage with reason codes
- [ ] Retarding time enforcement with timestamps
- [ ] Board and rack tracking system

#### 2. Par Value Management
- [ ] Day-of-week specific par values
- [ ] Integration with sales orders
- [ ] Baker's dashboard for daily production

#### 3. Cost and Waste Tracking
- [ ] Enhanced waste tracking with reason codes
- [ ] Yield analysis reporting
- [ ] Daily cost rotation dashboard

#### 4. End-of-Day Processing
- [ ] Server interface for counting remaining inventory
- [ ] Automatic conversion of 6+ leftover bagels to packaged retail items
- [ ] Next-day inventory adjustment
- [ ] End-of-day reporting with waste metrics

### Phase 3: Reporting and Analysis

#### 1. Operational Dashboards
- [ ] Production schedule and status
- [ ] Inventory levels and shelf life
- [ ] Daily sales by channel

#### 2. Management Reports
- [ ] Cost analysis by product line
- [ ] Waste and yield metrics
- [ ] Sales trend analysis

#### 3. Assembly Item Configuration
- [ ] Configure bagels as both standalone items and assembly components
- [ ] Configure cream cheese as both retail item and assembly component
- [ ] Set up boopalaches as assembly items only

## Additional Requirements to Investigate
- Integration with POS system
- Advanced forecasting based on historical data
- Supplier portal integration
- Quality control checkpoints

## Next Steps
1. Document complete recipe list
2. Map detailed production workflow with timing
3. Define key reports needed by each stakeholder
4. Set up Business Central sandbox environment

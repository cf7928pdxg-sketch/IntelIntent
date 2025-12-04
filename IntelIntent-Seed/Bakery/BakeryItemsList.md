# Bakery Items List for Business Central Implementation

## Raw Ingredients

| Item No | Description | Base UOM | Purchase UOM | Recipe UOM | Inventory | Purchased | Sales | Assembly | Storage Type | Allergen Info | Notes |
|---------|-------------|----------|--------------|------------|-----------|-----------|-------|----------|--------------|--------------|-------|
| RM-FLOUR-SL | Sir Lancelot Flour | lb | 50 lb bag | lb/oz | Yes | Yes | No | No | Ambient | Gluten | High-protein flour for bagels |
| RM-YEAST | Yeast | oz | case | oz | Yes | Yes | No | No | Refrigerated | | Active dry yeast |
| RM-SALT-K | Kosher Salt | lb | case | lb/oz | Yes | Yes | No | No | Ambient | | |
| RM-SUGAR-BR | Brown Sugar | oz | case | oz | Yes | Yes | No | No | Ambient | | |
| RM-HONEY | Honey | oz | case | oz | Yes | Yes | No | No | Ambient | | |
| RM-MALT | Malt | can | case | can | Yes | Yes | No | No | Ambient | Gluten | |
| RM-JALAPENO-D | Dried Jalapenos | oz | case | oz | Yes | Yes | No | No | Ambient | | |
| RM-REDPEPPER-D | Dried Red Bell Pepper | oz | case | oz | Yes | Yes | No | No | Ambient | | |
| RM-CHEESE-CHED | Cheddar Cheese | oz | case | oz | Yes | Yes | No | No | Refrigerated | Dairy | |
| RM-SPICE-ASIAGO | Asiago Spice | oz | case | oz | Yes | Yes | No | No | Ambient | | |
| RM-PARSLEY | Parsley | oz | case | oz | Yes | Yes | No | No | Ambient | | |
| RM-CHEESE-ASIAGO | Asiago Cheese | oz | case | oz | Yes | Yes | No | No | Refrigerated | Dairy | |
| RM-WATER | Water | lb | N/A | lb | No | No | No | No | N/A | | |
| RM-SPICE-ITALIAN | Italian Spice | oz | case | oz | Yes | Yes | No | No | Ambient | | |
| RM-TOMATO-SD | Sun Dried Tomatoes | oz | case | oz | Yes | Yes | No | No | Ambient | | |
| RM-CRAISINS | Dried Cranberries | lb | case | lb | Yes | Yes | No | No | Ambient | | |
| RM-ORANGE-PEEL | Orange Peel | oz | case | oz | Yes | Yes | No | No | Ambient | | |
| RM-CRANBERRY-F | Frozen Cranberries | lb | case | lb | Yes | Yes | No | No | Frozen | | |
| RM-BLUEBERRY-D | Dried Blueberries | lb | case | lb | Yes | Yes | No | No | Ambient | | |
| RM-BLUEBERRY-F | Frozen Blueberries | lb | case | lb | Yes | Yes | No | No | Frozen | | |
| RM-CHOC-CHIP | Chocolate Chips | lb | case | lb | Yes | Yes | No | No | Ambient | Dairy | |
| RM-SEED-SESAME | Sesame Seeds | oz | case | oz | Yes | Yes | No | No | Ambient | | Topping |
| RM-SEED-POPPY | Poppy Seeds | oz | case | oz | Yes | Yes | No | No | Ambient | | Topping |
| RM-ONION-DRIED | Dried Onion | oz | case | oz | Yes | Yes | No | No | Ambient | | Topping |
| RM-GARLIC-DRIED | Dried Garlic | oz | case | oz | Yes | Yes | No | No | Ambient | | Topping |
| RM-SALT-TOP | Coarse Salt | oz | case | oz | Yes | Yes | No | No | Ambient | | Topping |
| RM-MIX-EVERYTHING | Everything Mix | oz | case | oz | Yes | Yes | No | No | Ambient | | Sesame, poppy, onion, garlic |

## Work-in-Process Items

| Item No | Description | Base UOM | Status Tracking | BOM Reference | Routing Reference | Notes |
|---------|-------------|----------|-----------------|---------------|------------------|-------|
| WIP-DOUGH-PLAIN | Plain Bagel Dough | lb | Bulk | BOM-DOUGH-PLAIN | RTG-DOUGH | Base dough recipe |
| WIP-DOUGH-JALCHED | Jalapeno Cheddar Dough | lb | Bulk | BOM-DOUGH-JALCHED | RTG-DOUGH | Savory inclusion |
| WIP-DOUGH-ASIAGO | Asiago Dough | lb | Bulk | BOM-DOUGH-ASIAGO | RTG-DOUGH | Savory inclusion |
| WIP-DOUGH-TOMATO | Sun Dried Tomato Dough | lb | Bulk | BOM-DOUGH-TOMATO | RTG-DOUGH | Savory inclusion |
| WIP-DOUGH-CRANOR | Cranberry Orange Dough | lb | Bulk | BOM-DOUGH-CRANOR | RTG-DOUGH | Sweet inclusion |
| WIP-DOUGH-BLUEB | Blueberry Dough | lb | Bulk | BOM-DOUGH-BLUEB | RTG-DOUGH | Sweet inclusion |
| WIP-DOUGH-CHOC | Chocolate Chip Dough | lb | Bulk | BOM-DOUGH-CHOC | RTG-DOUGH | Sweet inclusion |
| WIP-DOUGH-SWEET | Sweet Bagel Base Dough | lb | Bulk | BOM-DOUGH-SWEET | RTG-DOUGH | Base for sweet varieties |
| WIP-BAGEL-PLAIN | Formed Plain Bagel | each | Formed, Retarding | BOM-BAGEL-PLAIN | RTG-BAGEL | Base for various toppings |
| WIP-BAGEL-JALCHED | Formed Jalapeno Cheddar Bagel | each | Formed, Retarding | BOM-BAGEL-JALCHED | RTG-BAGEL | |
| WIP-BAGEL-ASIAGO | Formed Asiago Bagel | each | Formed, Retarding | BOM-BAGEL-ASIAGO | RTG-BAGEL | |
| WIP-BAGEL-TOMATO | Formed Sun Dried Tomato Bagel | each | Formed, Retarding | BOM-BAGEL-TOMATO | RTG-BAGEL | |
| WIP-BAGEL-CRANOR | Formed Cranberry Orange Bagel | each | Formed, Retarding | BOM-BAGEL-CRANOR | RTG-BAGEL | |
| WIP-BAGEL-BLUEB | Formed Blueberry Bagel | each | Formed, Retarding | BOM-BAGEL-BLUEB | RTG-BAGEL | |
| WIP-BAGEL-CHOC | Formed Chocolate Chip Bagel | each | Formed, Retarding | BOM-BAGEL-CHOC | RTG-BAGEL | |
| WIP-BAGEL-SESAME | Formed Plain Bagel with Sesame | each | Formed, Retarding | BOM-BAGEL-SESAME | RTG-BAGEL | Topped with sesame seeds |
| WIP-BAGEL-POPPY | Formed Plain Bagel with Poppy | each | Formed, Retarding | BOM-BAGEL-POPPY | RTG-BAGEL | Topped with poppy seeds |
| WIP-BAGEL-ONION | Formed Plain Bagel with Onion | each | Formed, Retarding | BOM-BAGEL-ONION | RTG-BAGEL | Topped with dried onion |
| WIP-BAGEL-GARLIC | Formed Plain Bagel with Garlic | each | Formed, Retarding | BOM-BAGEL-GARLIC | RTG-BAGEL | Topped with dried garlic |
| WIP-BAGEL-SALT | Formed Plain Bagel with Salt | each | Formed, Retarding | BOM-BAGEL-SALT | RTG-BAGEL | Topped with coarse salt |
| WIP-BAGEL-EVERYTHING | Formed Plain Bagel with Everything | each | Formed, Retarding | BOM-BAGEL-EVERYTHING | RTG-BAGEL | Topped with everything mix |
| WIP-BAGEL-EVERYTHINGSALT | Formed Plain Bagel with Everything & Salt | each | Formed, Retarding | BOM-BAGEL-EVERYTHINGSALT | RTG-BAGEL | Everything mix + salt |
| WIP-BOOP-PLAIN | Formed Plain Boopalach | each | Formed, Retarding | BOM-BOOP-PLAIN | RTG-BAGEL | |
| WIP-BOOP-JALCHED | Formed Jalapeno Cheddar Boopalach | each | Formed, Retarding | BOM-BOOP-JALCHED | RTG-BAGEL | |
| WIP-BOOP-ASIAGO | Formed Asiago Boopalach | each | Formed, Retarding | BOM-BOOP-ASIAGO | RTG-BAGEL | |
| WIP-CC-WHIPPED | Whipped Cream Cheese | lb | Ready-to-Use | BOM-CC-WHIP | RTG-CC-WHIP | |

## Finished Good Items

| Item No | Description | Base UOM | Sales UOM | Price | Shelf Life | Inventory | Par Value Mon-Thu | Par Value Fri-Sun | Notes |
|---------|-------------|----------|-----------|-------|-----------|-----------|-------------------|-------------------|-------|
| FG-BAGEL-PLAIN | Plain Bagel | each | each | 1.75 | 1 day | Yes | 10 | 15 | |
| FG-BAGEL-JALCHED | Jalapeno Cheddar Bagel | each | each | 2.00 | 1 day | Yes | 40 | 60 | |
| FG-BAGEL-ASIAGO | Asiago Bagel | each | each | 2.00 | 1 day | Yes | 40 | 60 | |
| FG-BAGEL-TOMATO | Sun Dried Tomato Bagel | each | each | 2.00 | 1 day | Yes | 35 | 50 | |
| FG-BAGEL-CRANOR | Cranberry Orange Bagel | each | each | 2.00 | 1 day | Yes | 25 | 40 | |
| FG-BAGEL-BLUEB | Blueberry Bagel | each | each | 2.00 | 1 day | Yes | 30 | 45 | |
| FG-BAGEL-CHOC | Chocolate Chip Bagel | each | each | 2.00 | 1 day | Yes | 20 | 35 | |
| FG-BAGEL-SESAME | Sesame Bagel | each | each | 1.75 | 1 day | Yes | 10 | 15 | |
| FG-BAGEL-POPPY | Poppy Bagel | each | each | 1.75 | 1 day | Yes | 10 | 15 | |
| FG-BAGEL-ONION | Onion Bagel | each | each | 1.75 | 1 day | Yes | 10 | 15 | |
| FG-BAGEL-GARLIC | Garlic Bagel | each | each | 1.75 | 1 day | Yes | 10 | 15 | |
| FG-BAGEL-SALT | Salt Bagel | each | each | 1.75 | 1 day | Yes | 10 | 15 | |
| FG-BAGEL-EVERYTHING | Everything Bagel | each | each | 1.75 | 1 day | Yes | 30 | 45 | |
| FG-BAGEL-EVERYTHINGSALT | Everything Salt Bagel | each | each | 1.75 | 1 day | Yes | 20 | 35 | |
| FG-BOOP-PLAIN | Plain Boopalach | each | each | | 1 day | Yes | | | |
| FG-BOOP-JALCHED | Jalapeno Cheddar Boopalach | each | each | | 1 day | Yes | | | |
| FG-BOOP-ASIAGO | Asiago Boopalach | each | each | | 1 day | Yes | | | |
| FG-BAGEL-PLAIN-PKG | Plain Bagels (6-pack) | package | package | 7.50 | 3 days | Yes | 5 | 10 | Converted from day-old |
| FG-BAGEL-JALCHED-PKG | Jalapeno Cheddar Bagels (6-pack) | package | package | 9.00 | 3 days | Yes | 3 | 5 | Converted from day-old |
| FG-BAGEL-ASIAGO-PKG | Asiago Bagels (6-pack) | package | package | 9.00 | 3 days | Yes | 3 | 5 | Converted from day-old |
| FG-BAGEL-TOMATO-PKG | Sun Dried Tomato Bagels (6-pack) | package | package | 9.00 | 3 days | Yes | 3 | 5 | Converted from day-old |
| FG-BAGEL-CRANOR-PKG | Cranberry Orange Bagels (6-pack) | package | package | 9.00 | 3 days | Yes | 2 | 4 | Converted from day-old |
| FG-BAGEL-BLUEB-PKG | Blueberry Bagels (6-pack) | package | package | 9.00 | 3 days | Yes | 2 | 4 | Converted from day-old |
| FG-BAGEL-CHOC-PKG | Chocolate Chip Bagels (6-pack) | package | package | 9.00 | 3 days | Yes | 2 | 4 | Converted from day-old |
| FG-BAGEL-EVERYTHING-PKG | Everything Bagels (6-pack) | package | package | 7.50 | 3 days | Yes | 3 | 6 | Converted from day-old |
| FG-CC-PLAIN-8OZ | Plain Cream Cheese (8 oz) | container | container | | 14 days | Yes | | | |

## Assembly Items

| Item No | Description | Base UOM | Components | Price | Notes |
|---------|-------------|----------|-----------|-------|-------|
| AS-BAGEL-PLAIN-CC | Plain Bagel with Cream Cheese | each | FG-BAGEL-PLAIN, WIP-CC-WHIPPED | 3.25 | |
| AS-BAGEL-JALCHED-CC | Jalapeno Cheddar Bagel with Cream Cheese | each | FG-BAGEL-JALCHED, WIP-CC-WHIPPED | 3.50 | |
| AS-BAGEL-ASIAGO-CC | Asiago Bagel with Cream Cheese | each | FG-BAGEL-ASIAGO, WIP-CC-WHIPPED | 3.50 | |
| AS-BAGEL-TOMATO-CC | Sun Dried Tomato Bagel with Cream Cheese | each | FG-BAGEL-TOMATO, WIP-CC-WHIPPED | 3.50 | |
| AS-BAGEL-CRANOR-CC | Cranberry Orange Bagel with Cream Cheese | each | FG-BAGEL-CRANOR, WIP-CC-WHIPPED | 3.50 | |
| AS-BAGEL-BLUEB-CC | Blueberry Bagel with Cream Cheese | each | FG-BAGEL-BLUEB, WIP-CC-WHIPPED | 3.50 | |
| AS-BAGEL-CHOC-CC | Chocolate Chip Bagel with Cream Cheese | each | FG-BAGEL-CHOC, WIP-CC-WHIPPED | 3.50 | |
| AS-BAGEL-SESAME-CC | Sesame Bagel with Cream Cheese | each | FG-BAGEL-SESAME, WIP-CC-WHIPPED | 3.25 | |
| AS-BAGEL-POPPY-CC | Poppy Bagel with Cream Cheese | each | FG-BAGEL-POPPY, WIP-CC-WHIPPED | 3.25 | |
| AS-BAGEL-ONION-CC | Onion Bagel with Cream Cheese | each | FG-BAGEL-ONION, WIP-CC-WHIPPED | 3.25 | |
| AS-BAGEL-GARLIC-CC | Garlic Bagel with Cream Cheese | each | FG-BAGEL-GARLIC, WIP-CC-WHIPPED | 3.25 | |
| AS-BAGEL-SALT-CC | Salt Bagel with Cream Cheese | each | FG-BAGEL-SALT, WIP-CC-WHIPPED | 3.25 | |
| AS-BAGEL-EVERYTHING-CC | Everything Bagel with Cream Cheese | each | FG-BAGEL-EVERYTHING, WIP-CC-WHIPPED | 3.25 | |
| AS-BAGEL-EVERYTHINGSALT-CC | Everything Salt Bagel with Cream Cheese | each | FG-BAGEL-EVERYTHINGSALT, WIP-CC-WHIPPED | 3.25 | |

## Purchased Finished Goods

| Item No | Description | Base UOM | Purchase UOM | Inventory | Storage | Shelf Life | Notes |
|---------|-------------|----------|--------------|-----------|---------|------------|-------|
| PFG-CC-PLAIN | Plain Cream Cheese Blocks | lb | 30 lb case | Yes | Refrigerated | 90 days | Raw material for whipped |

## Item Conversions

| From Item | To Item | Conversion Factor | Process | Notes |
|-----------|---------|-------------------|---------|-------|
| PFG-CC-PLAIN | WIP-CC-WHIPPED | 1.25 | Whipping | 30 lb case yields 37.5 lb whipped |
| WIP-CC-WHIPPED | FG-CC-PLAIN-8OZ | 0.5 | Packaging | 1 lb whipped yields 2 8-oz containers |
| FG-BAGEL-PLAIN | FG-BAGEL-PLAIN-PKG | 0.16667 | Packaging | 6 bagels yield 1 package |
| FG-BAGEL-JALCHED | FG-BAGEL-JALCHED-PKG | 0.16667 | Packaging | 6 bagels yield 1 package |
| FG-BAGEL-ASIAGO | FG-BAGEL-ASIAGO-PKG | 0.16667 | Packaging | 6 bagels yield 1 package |
| FG-BAGEL-TOMATO | FG-BAGEL-TOMATO-PKG | 0.16667 | Packaging | 6 bagels yield 1 package |
| FG-BAGEL-CRANOR | FG-BAGEL-CRANOR-PKG | 0.16667 | Packaging | 6 bagels yield 1 package |
| FG-BAGEL-BLUEB | FG-BAGEL-BLUEB-PKG | 0.16667 | Packaging | 6 bagels yield 1 package |
| FG-BAGEL-CHOC | FG-BAGEL-CHOC-PKG | 0.16667 | Packaging | 6 bagels yield 1 package |
| FG-BAGEL-EVERYTHING | FG-BAGEL-EVERYTHING-PKG | 0.16667 | Packaging | 6 bagels yield 1 package |

## Bagel Recipes/BOMs

| BOM No | Description | Base Ingredients | Inclusions | Toppings |
|--------|-------------|-----------------|------------|----------|
| BOM-DOUGH-PLAIN | Plain Bagel Dough | 50lbs Sir Lancelot, 3.5oz yeast, 1lb kosher salt, 8oz brown sugar, 8oz honey, 1can malt, 24lbs water | None | N/A |
| BOM-DOUGH-JALCHED | Jalapeno Cheddar Dough | 50lbs Sir Lancelot, 3.5oz yeast, 1lb kosher salt, 8oz brown sugar, 8oz honey, 1can malt, 24lbs water | 14oz dried jalapenos, 7oz dried red bell pepper, 1lb 12oz cheddar cheese | N/A |
| BOM-DOUGH-ASIAGO | Asiago Dough | 50lbs Sir Lancelot, 3.5oz yeast, 1lb kosher salt, 8oz brown sugar, 8oz honey, 1can malt, 24lbs water | 14oz asiago spice, 7oz parsley, 1lb 12oz asiago cheese | N/A |
| BOM-DOUGH-TOMATO | Sun Dried Tomato Dough | 50lbs Sir Lancelot, 3.5oz yeast, 1lb kosher salt, 2lbs brown sugar, 1can malt, 24lbs water | 14oz italian spice, 24oz sun dried tomatoes | N/A |
| BOM-DOUGH-SWEET | Sweet Bagel Base Dough | 50lbs Sir Lancelot, 1lb kosher salt, 5lbs brown sugar, 1can malt, 23lbs water | None | N/A |
| BOM-DOUGH-CRANOR | Cranberry Orange Dough | 50lbs Sir Lancelot, 1lb kosher salt, 5lbs brown sugar, 1can malt, 23lbs water | 2lbs craisins, 8oz orange peel, 2lbs frozen cranberries | N/A |
| BOM-DOUGH-BLUEB | Blueberry Dough | 50lbs Sir Lancelot, 1lb kosher salt, 5lbs brown sugar, 1can malt, 23lbs water | 2lbs dried blueberries, 2lbs frozen blueberries | N/A |
| BOM-DOUGH-CHOC | Chocolate Chip Dough | 50lbs Sir Lancelot, 1lb kosher salt, 5lbs brown sugar, 1can malt, 23lbs water | 3lbs chocolate chips | N/A |
| BOM-BAGEL-PLAIN | Plain Bagel | WIP-DOUGH-PLAIN | None | None |
| BOM-BAGEL-SESAME | Sesame Bagel | WIP-DOUGH-PLAIN | None | Sesame Seeds |
| BOM-BAGEL-POPPY | Poppy Bagel | WIP-DOUGH-PLAIN | None | Poppy Seeds |
| BOM-BAGEL-ONION | Onion Bagel | WIP-DOUGH-PLAIN | None | Dried Onion |
| BOM-BAGEL-GARLIC | Garlic Bagel | WIP-DOUGH-PLAIN | None | Dried Garlic |
| BOM-BAGEL-SALT | Salt Bagel | WIP-DOUGH-PLAIN | None | Coarse Salt |
| BOM-BAGEL-EVERYTHING | Everything Bagel | WIP-DOUGH-PLAIN | None | Everything Mix |
| BOM-BAGEL-EVERYTHINGSALT | Everything Salt Bagel | WIP-DOUGH-PLAIN | None | Everything Mix, Salt |
| BOM-BAGEL-JALCHED | Jalapeno Cheddar Bagel | WIP-DOUGH-JALCHED | N/A | None |
| BOM-BAGEL-ASIAGO | Asiago Bagel | WIP-DOUGH-ASIAGO | N/A | None |
| BOM-BAGEL-TOMATO | Sun Dried Tomato Bagel | WIP-DOUGH-TOMATO | N/A | None |
| BOM-BAGEL-CRANOR | Cranberry Orange Bagel | WIP-DOUGH-CRANOR | N/A | None |
| BOM-BAGEL-BLUEB | Blueberry Bagel | WIP-DOUGH-BLUEB | N/A | None |
| BOM-BAGEL-CHOC | Chocolate Chip Bagel | WIP-DOUGH-CHOC | N/A | None |

## Items to Add from Order History/Printout

When reviewing your Printout.mht file, look for the following information to help complete the items list:

### Additional Raw Ingredients

Look for any ingredients mentioned in the printout that aren't already listed above. Examples might include:

- Different flour types (e.g., whole wheat, rye)
- Additional spices or flavorings
- Other mix-in ingredients (e.g., blueberries, cinnamon, nuts, seeds)
- Packaging materials (if tracked as inventory)

### Additional Bagel Varieties

Look for any bagel types that aren't already listed. For each new variety:

1. Add to the WIP-items section as formed products
2. Add to the Finished Goods section as sellable items
3. Add to the Recipe/BOM section with the correct ingredients

### Additional Cream Cheese Varieties

Look for any flavored cream cheeses mentioned, such as:

- Scallion cream cheese
- Vegetable cream cheese
- Flavored specialty cream cheeses

### Pricing Information

Look for any pricing details that can help fill in the Price columns in the Finished Goods and Assembly Items tables.

### Par Values

Look for any information about typical order quantities that might help establish par values for different days of the week.

### Actual Items from Printout

Copy the following table and fill in with items found in your printout:

| Item Type | Description | Price | Quantity | Notes |
|-----------|-------------|-------|----------|-------|
| | | | | |

# Bakery Items Import Guide

## Overview

This guide explains how to use the provided templates and code to import your bakery items into Business Central. The process involves:

1. Collecting item data using the provided templates
2. Extending the Business Central item table with bakery-specific fields
3. Importing the item data into Business Central

## Files Provided

1. **BakeryItemsList.md**
   - A structured markdown list of all the items with their properties
   - Use this as a reference and for documentation purposes

2. **BakeryItemsTemplate.csv**
   - A CSV template with all the items pre-filled based on existing documentation
   - Use this to add new items discovered in your Printout.mht file
   - This can be imported into Excel for easier editing

3. **BakeryItemExtension.al**
   - AL code that extends the standard Business Central Item table
   - Creates a table and pages for bakery-specific item properties

4. **BakeryItemImport.al**
   - AL code for importing item data from Excel/CSV into Business Central
   - Contains the data structure expected in the import file

## How to Use These Resources

### Step 1: Extract Data from Printout.mht

1. Open your Printout.mht file
2. Review the contents for:
   - Additional bagel varieties not in our current list
   - Additional cream cheese varieties
   - Price information
   - Typical order quantities (for par values)
   - Any additional ingredients or products

### Step 2: Update the Item List

1. Open the CSV template file (`BakeryItemsTemplate.csv`) in Excel
2. Add new rows for items discovered in the Printout.mht file
3. Fill in missing information for existing items
4. Save the updated file

### Step 3: Update the Documentation

1. Update the `BakeryItemsList.md` file with any new information
2. This keeps the documentation in sync with the actual implementation

### Step 4: Implement in Business Central

1. Use the AL files as templates to create the necessary extensions in Business Central
2. Modify the object IDs as needed to fit your development environment
3. Publish the extensions to your Business Central environment
4. Use the import functionality to bring in the data from your CSV file

## Item Naming Convention

We've used the following naming convention for items:

- **RM-**: Raw Materials (ingredients)
- **WIP-**: Work in Progress (bulk dough, formed products before baking)
- **FG-**: Finished Goods (ready-to-sell products)
- **AS-**: Assembly Items (combinations of other items)
- **PFG-**: Purchased Finished Goods (ready-to-use items purchased from suppliers)

## Item Categorization

Items are categorized as:

- Raw Ingredient
- WIP (Work in Process)
- Finished Good
- Assembly Item
- Purchased Finished Good

## Production Stages

Items can be assigned to the following production stages:

- Not Applicable
- Bulk
- Formed
- Retarding
- Baking
- Ready-to-Sell

## Next Steps

1. Complete the item list with data from your Printout.mht file
2. Implement the AL extensions in your Business Central environment
3. Import the item data
4. Set up the BOMs and routings for production
5. Configure the assembly items

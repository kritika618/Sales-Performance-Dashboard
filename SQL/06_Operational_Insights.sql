/*
===============================================================================
Project        : Sales Performance Analytics Dashboard
Module         : Operational Insights
File Name      : 06_Operational_Insights.sql
Author         : Kritika Sharma
Role           : Data Analyst

Description:
This script provides operational-level insights into business performance
including order volume, product movement, revenue efficiency, and distribution
across regions and categories.

These metrics help understand business execution efficiency and demand patterns.

Focus Areas:
- Order volume analysis
- Product demand analysis
- Revenue efficiency per order
- Geographic & category distribution

Database       : BigQuery
===============================================================================
*/


/*
===============================================================================
TABLE OF CONTENTS
===============================================================================

1. Total Number of Orders
2. Total Quantity Sold
3. Average Products per Order
4. Average Revenue per Order
5. Average Profit per Order
6. Order Distribution by Region
7. Order Distribution by Category
8. Most Frequently Purchased Products

===============================================================================
*/


/*==============================================================================
1. Business Question:
What is the total number of orders?

Business Purpose:
Measure overall transaction volume in the business.
==============================================================================*/

SELECT
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`;


/*==============================================================================
2. Business Question:
What is the total quantity sold?

Business Purpose:
Understand total product movement across all transactions.
==============================================================================*/

SELECT
    SUM(Quantity) AS Total_Quantity_Sold
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`;


/*==============================================================================
3. Business Question:
What is the average products per order?

Business Purpose:
Measure average basket size per transaction.
==============================================================================*/

SELECT
    ROUND(
        SUM(Quantity) / COUNT(DISTINCT Order_ID),
        2
    ) AS Avg_Products_Per_Order
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`;


/*==============================================================================
4. Business Question:
What is the average revenue per order?

Business Purpose:
Measure revenue efficiency at order level.
==============================================================================*/

SELECT
    ROUND(
        SUM(Sales) / COUNT(DISTINCT Order_ID),
        2
    ) AS Avg_Revenue_Per_Order
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`;


/*==============================================================================
5. Business Question:
What is the average profit per order?

Business Purpose:
Measure profitability efficiency at order level.
==============================================================================*/

SELECT
    ROUND(
        SUM(Profit) / COUNT(DISTINCT Order_ID),
        2
    ) AS Avg_Profit_Per_Order
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`;


/*==============================================================================
6. Business Question:
How are orders distributed by region?

Business Purpose:
Understand geographic contribution to overall order volume.
==============================================================================*/

SELECT
    Country_Region,
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Country_Region
ORDER BY
    Total_Orders DESC;


/*==============================================================================
7. Business Question:
How are orders distributed by category?

Business Purpose:
Understand category-level contribution to order volume.
==============================================================================*/

SELECT
    Category,
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Category
ORDER BY
    Total_Orders DESC;


/*==============================================================================
8. Business Question:
Which products are most frequently purchased?

Business Purpose:
Identify high-demand products for inventory and demand planning.
==============================================================================*/

SELECT
    Product_Name,
    SUM(Quantity) AS Total_Quantity_Sold
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Product_Name
ORDER BY
    Total_Quantity_Sold DESC;


/*
===============================================================================
END OF MODULE

Module Name : Operational Insights
Business Questions Answered : 8
Project : Sales Performance Analytics Dashboard
===============================================================================
*/

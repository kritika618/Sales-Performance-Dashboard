/*
===============================================================================
Project        : Sales Performance Analytics Dashboard
Module         : Profitability Analysis
File Name      : 05_Profitability_Analysis.sql
Author         : Kritika Sharma
Role           : Data Analyst

Description:
This script analyzes overall profitability across products, categories,
regions, and customer segments. It identifies profit drivers, loss-making
areas, and profit trends over time to support strategic business decisions.

Focus Areas:
- Profit KPIs
- Margin analysis
- Product & category profitability
- Loss identification
- Time-based profit trends

Database       : BigQuery
===============================================================================
*/


/*
===============================================================================
TABLE OF CONTENTS
===============================================================================

1. Overall Profit
2. Overall Profit Margin
3. Profit by Product
4. Profit by Category
5. Profit by Region
6. Profit by Customer Segment
7. Most Profitable Product
8. Least Profitable Product
9. Products with Negative Profit
10. Profit Trend Over Time

===============================================================================
*/


/*==============================================================================
1. Business Question:
What is the overall profit?

Business Purpose:
Measure total business profitability.
==============================================================================*/

SELECT
    ROUND(SUM(Profit), 2) AS Overall_Profit
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`;


/*==============================================================================
2. Business Question:
What is the overall profit margin?

Business Purpose:
Measure profitability efficiency of the business.
==============================================================================*/

SELECT
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Total_Profit_Margin
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`;


/*==============================================================================
3. Business Question:
Which products generate the highest profit?

Business Purpose:
Identify top profit-contributing products.
==============================================================================*/

SELECT
    Product_Name,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Product_Name
ORDER BY
    Total_Profit DESC;


/*==============================================================================
4. Business Question:
Which product categories are most profitable?

Business Purpose:
Understand category-level profit contribution.
==============================================================================*/

SELECT
    Category,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Category
ORDER BY
    Total_Profit DESC;


/*==============================================================================
5. Business Question:
Which regions generate the highest profit?

Business Purpose:
Evaluate geographical profitability performance.
==============================================================================*/

SELECT
    Region,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Region
ORDER BY
    Total_Profit DESC;


/*==============================================================================
6. Business Question:
Which customer segments are most profitable?

Business Purpose:
Identify profitability across customer segments.
==============================================================================*/

SELECT
    Segment,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Segment
ORDER BY
    Total_Profit DESC;


/*==============================================================================
7. Business Question:
Which product is the most profitable?

Business Purpose:
Identify the highest profit-generating product.
==============================================================================*/

SELECT
    Product_Name,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Product_Name
ORDER BY
    Total_Profit DESC
LIMIT 1;


/*==============================================================================
8. Business Question:
Which product is the least profitable?

Business Purpose:
Identify weakest performing product.
==============================================================================*/

SELECT
    Product_Name,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Product_Name
ORDER BY
    Total_Profit ASC
LIMIT 1;


/*==============================================================================
9. Business Question:
Which products are generating losses?

Business Purpose:
Identify unprofitable products requiring corrective action.
==============================================================================*/

SELECT
    Product_Name,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Product_Name
HAVING
    Total_Profit < 0
ORDER BY
    Total_Profit ASC;


/*==============================================================================
10. Business Question:
How is profit trending over time?

Business Purpose:
Track profitability trends across time periods.
==============================================================================*/

SELECT
    EXTRACT(QUARTER FROM Order_Date) AS Quarter,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Quarter
ORDER BY
    Quarter;


/*
===============================================================================
END OF MODULE

Module Name : Profitability Analysis
Business Questions Answered : 10
Project : Sales Performance Analytics Dashboard
===============================================================================
*/

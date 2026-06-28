/*
===============================================================================
Project        : Sales Performance Analytics Dashboard
Module         : Executive KPIs
File Name      : 07_Executive_KPIs.sql
Author         : Kritika Sharma
Role           : Data Analyst

Description:
This script calculates executive-level Key Performance Indicators (KPIs)
used in the Power BI dashboard. These KPIs provide an at-a-glance view of
overall business performance for executive stakeholders.

Dashboard Usage:
These metrics are displayed as KPI Cards in the Executive Dashboard.

Database       : BigQuery
===============================================================================
*/


/*
===============================================================================
TABLE OF CONTENTS
===============================================================================

1. Total Sales
2. Total Profit
3. Profit Margin %
4. Total Orders
5. Total Customers
6. Average Order Value
7. Top Performing Region
8. Top Selling Product
9. Sales Growth %
10. Profit Growth %

===============================================================================
*/


/*==============================================================================
1. Business Question:
What are the total sales?

Business Purpose:
Measure overall business revenue.
==============================================================================*/

SELECT
    ROUND(SUM(Sales),2) AS Total_Sales
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`;



/*==============================================================================
2. Business Question:
What is the total profit?

Business Purpose:
Measure total profitability.
==============================================================================*/

SELECT
    ROUND(SUM(Profit),2) AS Total_Profit
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`;



/*==============================================================================
3. Business Question:
What is the overall profit margin?

Business Purpose:
Measure business profitability efficiency.
==============================================================================*/

SELECT
    ROUND((SUM(Profit)/SUM(Sales))*100,2) AS Profit_Margin_Percentage
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`;



/*==============================================================================
4. Business Question:
How many total orders have been placed?

Business Purpose:
Measure total business transactions.
==============================================================================*/

SELECT
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`;



/*==============================================================================
5. Business Question:
How many unique customers does the business have?

Business Purpose:
Measure customer base size.
==============================================================================*/

SELECT
    COUNT(DISTINCT Customer_ID) AS Total_Customers
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`;



/*==============================================================================
6. Business Question:
What is the Average Order Value (AOV)?

Business Purpose:
Measure average customer spending per order.
==============================================================================*/

SELECT
    ROUND(
        SUM(Sales) / COUNT(DISTINCT Order_ID),
        2
    ) AS Average_Order_Value
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`;



/*==============================================================================
7. Business Question:
Which region generates the highest sales?

Business Purpose:
Identify the best-performing geographical region.
==============================================================================*/

SELECT
    Country_Region,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Country_Region
ORDER BY
    Total_Sales DESC
LIMIT 1;



/*==============================================================================
8. Business Question:
Which product generates the highest sales?

Business Purpose:
Identify the top-selling product.
==============================================================================*/

SELECT
    Product_Name,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Product_Name
ORDER BY
    Total_Sales DESC
LIMIT 1;



/*==============================================================================
9. Business Question:
What is the Month-over-Month Sales Growth?

Business Purpose:
Track monthly sales performance.
==============================================================================*/

WITH Monthly_Sales AS
(
    SELECT
        FORMAT_DATE('%Y-%m', Order_Date) AS Month,
        ROUND(SUM(Sales),2) AS Current_Month_Sales
    FROM
        `clear-heaven-496209-u2.Superstore_Sales.store_data`
    GROUP BY
        Month
)

SELECT
    Month,
    Current_Month_Sales,
    LAG(Current_Month_Sales)
        OVER(ORDER BY Month) AS Previous_Month_Sales,

    ROUND(
        (
            Current_Month_Sales -
            LAG(Current_Month_Sales) OVER(ORDER BY Month)
        )
        /
        LAG(Current_Month_Sales) OVER(ORDER BY Month)
        *100,
        2
    ) AS Sales_Growth_Percentage

FROM Monthly_Sales
ORDER BY Month;



/*==============================================================================
10. Business Question:
What is the Month-over-Month Profit Growth?

Business Purpose:
Track monthly profitability growth.
==============================================================================*/

WITH Monthly_Profit AS
(
    SELECT
        FORMAT_DATE('%Y-%m', Order_Date) AS Month,
        ROUND(SUM(Profit),2) AS Current_Month_Profit
    FROM
        `clear-heaven-496209-u2.Superstore_Sales.store_data`
    GROUP BY
        Month
)

SELECT
    Month,
    Current_Month_Profit,
    LAG(Current_Month_Profit)
        OVER(ORDER BY Month) AS Previous_Month_Profit,

    ROUND(
        (
            Current_Month_Profit -
            LAG(Current_Month_Profit) OVER(ORDER BY Month)
        )
        /
        LAG(Current_Month_Profit) OVER(ORDER BY Month)
        *100,
        2
    ) AS Profit_Growth_Percentage

FROM Monthly_Profit
ORDER BY Month;


/*
===============================================================================
END OF MODULE

Module Name : Executive KPIs
Business Questions Answered : 10
Project : Sales Performance Analytics Dashboard
===============================================================================
*/

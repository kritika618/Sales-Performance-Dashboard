/*
===============================================================================
Project        : Sales Performance Analytics Dashboard
Module         : Sales Trend Analysis
File Name      : 03_Sales_Trend_Analysis.sql
Author         : Kritika Sharma
Role           : Data Analyst

Description:
This script analyzes sales and profit performance over time to identify
business trends, seasonal patterns, peak performance periods, and growth
behavior across years, quarters, and months.

Business Focus:
- Time-series analysis (Year, Quarter, Month)
- Revenue & Profit trends
- Growth analysis (MoM, YoY)
- Seasonality & peak periods

Database       : Google BigQuery
===============================================================================
*/


/*
===============================================================================
TABLE OF CONTENTS
===============================================================================

1. Sales by Year
2. Sales by Quarter
3. Sales by Month
4. Profit by Month
5. Best Performing Month
6. Worst Performing Month
7. Year-over-Year Growth
8. Month-over-Month Growth
9. Seasonal Trends (Monthly, Quarterly, Yearly)
10. Profit Seasonality
11. Peak Sales Period

===============================================================================
*/


/*==============================================================================
1. Business Question:
What is the total sales by year?

Business Purpose:
Understand annual revenue performance and long-term business growth trends.
==============================================================================*/

SELECT
    EXTRACT(YEAR FROM Order_Date) AS Year,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Year
ORDER BY
    Year DESC;



/*==============================================================================
2. Business Question:
What is the total sales by quarter?

Business Purpose:
Analyze quarterly performance to understand seasonal fluctuations.
==============================================================================*/

SELECT
    EXTRACT(YEAR FROM Order_Date) AS Year,
    EXTRACT(QUARTER FROM Order_Date) AS Quarter,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Year, Quarter
ORDER BY
    Year, Quarter;



/*==============================================================================
3. Business Question:
What is the total sales by month?

Business Purpose:
Track monthly sales performance to identify consistent growth or decline patterns.
==============================================================================*/

SELECT
    FORMAT_DATE('%Y-%m', Order_Date) AS Year_Month,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Year_Month
ORDER BY
    Year_Month;



/*==============================================================================
4. Business Question:
What is the total profit by month?

Business Purpose:
Monitor monthly profitability trends to evaluate business health.
==============================================================================*/

SELECT
    FORMAT_DATE('%Y-%m', Order_Date) AS Year_Month,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Year_Month
ORDER BY
    Year_Month;



/*==============================================================================
5. Business Question:
Which month performed best in terms of sales?

Business Purpose:
Identify peak revenue periods for strategic planning and forecasting.
==============================================================================*/

SELECT
    FORMAT_DATE('%Y-%m', Order_Date) AS Month,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Month
ORDER BY
    Total_Sales DESC
LIMIT 1;



/*==============================================================================
6. Business Question:
Which month performed worst in terms of sales?

Business Purpose:
Identify low-performing periods for corrective business actions.
==============================================================================*/

SELECT
    FORMAT_DATE('%Y-%m', Order_Date) AS Month,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Month
ORDER BY
    Total_Sales ASC
LIMIT 1;



/*==============================================================================
7. Business Question:
What is Year-over-Year (YoY) sales trend?

Business Purpose:
Measure long-term growth or decline in annual performance.
==============================================================================*/

WITH yearly_sales AS (
    SELECT
        EXTRACT(YEAR FROM Order_Date) AS Year,
        SUM(Sales) AS Current_Year_Sales
    FROM
        `clear-heaven-496209-u2.Superstore_Sales.store_data`
    GROUP BY Year
)

SELECT
    Year,
    Current_Year_Sales,
    LAG(Current_Year_Sales) OVER (ORDER BY Year) AS Previous_Year_Sales,

    CASE
        WHEN Current_Year_Sales > LAG(Current_Year_Sales) OVER (ORDER BY Year) THEN 'GROWING'
        WHEN Current_Year_Sales < LAG(Current_Year_Sales) OVER (ORDER BY Year) THEN 'DECLINING'
        ELSE 'STABLE'
    END AS Trend

FROM yearly_sales
ORDER BY Year DESC;



/*==============================================================================
8. Business Question:
What is Month-over-Month (MoM) sales growth?

Business Purpose:
Track short-term business performance fluctuations.
==============================================================================*/

WITH monthly_sales AS (
    SELECT
        FORMAT_DATE('%Y-%m', Order_Date) AS Month,
        SUM(Sales) AS Current_Month_Sales
    FROM
        `clear-heaven-496209-u2.Superstore_Sales.store_data`
    GROUP BY Month
)

SELECT
    Month,
    Current_Month_Sales,
    LAG(Current_Month_Sales) OVER (ORDER BY Month) AS Previous_Month_Sales,

    CASE
        WHEN Current_Month_Sales > LAG(Current_Month_Sales) OVER (ORDER BY Month) THEN 'GROWING'
        WHEN Current_Month_Sales < LAG(Current_Month_Sales) OVER (ORDER BY Month) THEN 'DECLINING'
        ELSE 'STABLE'
    END AS Trend

FROM monthly_sales
ORDER BY Month DESC;



/*==============================================================================
9. Business Question:
What are seasonal sales patterns?

Business Purpose:
Identify recurring seasonal behavior for demand planning.
==============================================================================*/

SELECT
    FORMAT_DATE('%B', Order_Date) AS Month_Name,
    EXTRACT(QUARTER FROM Order_Date) AS Quarter,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Month_Name, Quarter
ORDER BY
    Total_Sales DESC;



/*==============================================================================
10. Business Question:
How does profit vary seasonally?

Business Purpose:
Understand profitability fluctuations across months.
==============================================================================*/

SELECT
    FORMAT_DATE('%Y-%m', Order_Date) AS Month,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY Month
ORDER BY Total_Profit DESC;



/*==============================================================================
11. Business Question:
Which period represents peak sales?

Business Purpose:
Identify highest-performing time period for strategic decision-making.
==============================================================================*/

SELECT
    EXTRACT(QUARTER FROM Order_Date) AS Quarter,
    FORMAT_DATE('%B', Order_Date) AS Month,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY Quarter, Month
ORDER BY Total_Sales DESC
LIMIT 1;



/*
===============================================================================
END OF MODULE

Module Name : Sales Trend Analysis
Business Questions Answered : 11
Project : Sales Performance Analytics Dashboard
===============================================================================
*/

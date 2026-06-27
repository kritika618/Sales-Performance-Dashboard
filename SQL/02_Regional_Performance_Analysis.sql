/*
===============================================================================
Project        : Sales Performance Analytics Dashboard
Module         : Regional Performance Analysis
File Name      : 02_Regional_Performance_Analysis.sql
Author         : Kritika Sharma
Role           : Data Analyst

Description:
This SQL script analyzes regional business performance across countries,
states, and cities by evaluating revenue, profitability, revenue contribution,
sales growth trends, and regional profit margins.

Database       : Google BigQuery

Business Domain:
Regional Analytics
===============================================================================
*/


/*
===============================================================================
TABLE OF CONTENTS
===============================================================================

1. Top Revenue Generating Regions
2. Top Profit Generating Regions
3. Lowest Performing Regions
4. Revenue Contribution by Region (%)
5. Top Performing States and Cities
6. Fastest Growing Regions
7. Declining Regions
8. Profit Margin by Region

===============================================================================
*/


/*==============================================================================
1. Business Question:
Which region generates the highest revenue?

Business Purpose:
Identify the highest revenue-generating regions to support strategic
planning, market expansion, and resource allocation.
==============================================================================*/

SELECT
    Country_Region,
    ROUND(SUM(Sales),2) AS Highest_Revenue
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Country_Region
ORDER BY
    Highest_Revenue DESC;



/*==============================================================================
2. Business Question:
Which region generates the highest profit?

Business Purpose:
Evaluate regional profitability to identify the strongest performing
markets and support executive decision-making.
==============================================================================*/

SELECT
    Country_Region,
    ROUND(SUM(Profit),2) AS Highest_Profit
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Country_Region
ORDER BY
    Highest_Profit DESC;



/*==============================================================================
3. Business Question:
Which region has the lowest performance?

Business Purpose:
Identify regions generating the lowest profit to support performance
improvement initiatives.
==============================================================================*/

SELECT
    Country_Region,
    ROUND(SUM(Profit),2) AS Minimum_Profit
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Country_Region
ORDER BY
    Minimum_Profit ASC;



/*==============================================================================
4. Business Question:
What percentage of total revenue comes from each region?

Business Purpose:
Measure each region's contribution to total company revenue.
==============================================================================*/

SELECT
    Country_Region,

    ROUND(
        SUM(Sales) * 100 /
        (
            SELECT
                SUM(Sales)
            FROM
                `clear-heaven-496209-u2.Superstore_Sales.store_data`
        ),
        2
    ) AS Revenue_Contribution_Percentage

FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`

GROUP BY
    Country_Region

ORDER BY
    Revenue_Contribution_Percentage DESC;



/*==============================================================================
5. Business Question:
Which states and cities contribute the highest sales?

Business Purpose:
Identify high-performing geographic markets for expansion and
sales optimization.
==============================================================================*/

SELECT
    City,
    State_Province,

    ROUND(
        SUM(Sales),
        2
    ) AS Highest_Sales

FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`

GROUP BY
    City,
    State_Province

ORDER BY
    Highest_Sales DESC;



/*==============================================================================
6. Business Question:
Which regions are growing the fastest?

Business Purpose:
Track month-over-month sales growth to identify rapidly expanding
regional markets.
==============================================================================*/

SELECT
    *,

    CASE
        WHEN Current_Month_Sale > Prev_Month_Sale THEN 'GROWING'
        WHEN Current_Month_Sale < Prev_Month_Sale THEN 'DECLINING'
        ELSE 'STABLE'
    END AS Regional_Trend

FROM (

    SELECT
        Country_Region,
        Month,
        Current_Month_Sale,

        LAG(Current_Month_Sale)
            OVER (
                PARTITION BY Country_Region
                ORDER BY Month
            ) AS Prev_Month_Sale

    FROM (

        SELECT
            Country_Region,

            FORMAT_DATE('%Y-%m', Order_Date) AS Month,

            ROUND(
                SUM(Sales),
                2
            ) AS Current_Month_Sale

        FROM
            `clear-heaven-496209-u2.Superstore_Sales.store_data`

        GROUP BY
            Country_Region,
            Order_Date

    )

)

ORDER BY
    Current_Month_Sale DESC;



/*==============================================================================
7. Business Question:
Which regions have declining sales?

Business Purpose:
Identify regions experiencing sales decline for corrective action
and performance monitoring.
==============================================================================*/

SELECT
    *,

    CASE
        WHEN Current_Month_Sale > Prev_Month_Sale THEN 'GROWING'
        WHEN Current_Month_Sale < Prev_Month_Sale THEN 'DECLINING'
        ELSE 'STABLE'
    END AS Regional_Trend

FROM (

    SELECT
        Country_Region,
        Month,
        Current_Month_Sale,

        LAG(Current_Month_Sale)
            OVER (
                PARTITION BY Country_Region
                ORDER BY Month
            ) AS Prev_Month_Sale

    FROM (

        SELECT
            Country_Region,

            FORMAT_DATE('%Y-%m', Order_Date) AS Month,

            ROUND(
                SUM(Sales),
                2
            ) AS Current_Month_Sale

        FROM
            `clear-heaven-496209-u2.Superstore_Sales.store_data`

        GROUP BY
            Country_Region,
            Order_Date

    )

)

ORDER BY
    Current_Month_Sale ASC;



/*==============================================================================
8. Business Question:
Which region has the highest profit margin?

Business Purpose:
Measure regional profitability efficiency by comparing profit
relative to sales revenue.
==============================================================================*/

SELECT
    Country_Region,

    ROUND(
        (SUM(Profit) / SUM(Sales)) * 100,
        2
    ) AS Profit_Margin

FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`

GROUP BY
    Country_Region

ORDER BY
    Profit_Margin DESC;



/*
===============================================================================
END OF MODULE

Module Name : Regional Performance Analysis

Business Questions Answered : 8

Project : Sales Performance Analytics Dashboard

===============================================================================
*/

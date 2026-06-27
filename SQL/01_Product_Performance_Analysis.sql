```sql
/*
===============================================================================
Project        : Sales Performance Analytics Dashboard
Module         : Product Performance Analysis
File Name      : 01_Product_Performance_Analysis.sql
Author         : Kritika Sharma
Role           : Data Analyst

Description:
This SQL script performs product-level business analysis to evaluate sales,
profitability, category performance, product growth trends, revenue
contribution, and average order value.

Database       : Google BigQuery

Business Domain:
Product Analytics

===============================================================================
*/

/*
===============================================================================
TABLE OF CONTENTS
===============================================================================

1. Top Products by Sales
2. Top Products by Profit
3. Loss-Making Products
4. Revenue Contribution by Product Category
5. Profit Contribution by Product Category
6. Product Growth Trend
7. Product Sales Contribution (%)
8. Average Order Value by Product

===============================================================================
*/


/*==============================================================================
1. Business Question:
Which products generate the highest sales?

Business Purpose:
Identify products generating the highest sales to support inventory planning,
product strategy, and executive reporting.
==============================================================================*/

SELECT
    Product_ID,
    Product_Name,
    MAX(SAFE_CAST(Sales AS INT64)) AS Highest_Sales
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Product_ID,
    Product_Name
ORDER BY
    Highest_Sales DESC
LIMIT 10;



/*==============================================================================
2. Business Question:
Which products generate the highest profit?

Business Purpose:
Identify the most profitable products to support pricing decisions and
portfolio optimization.
==============================================================================*/

SELECT
    Product_ID,
    Product_Name,
    MAX(SAFE_CAST(Profit AS INT64)) AS Highest_Profit
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Product_ID,
    Product_Name
ORDER BY
    Highest_Profit DESC
LIMIT 10;



/*==============================================================================
3. Business Question:
Which products generate losses?

Business Purpose:
Identify products generating negative profit for further investigation and
profitability improvement initiatives.
==============================================================================*/

SELECT
    Product_ID,
    Product_Name,
    Profit
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
WHERE
    Profit < 0
ORDER BY
    Profit ASC
LIMIT 10;



/*==============================================================================
4. Business Question:
Which product categories contribute the highest revenue?

Business Purpose:
Evaluate revenue contribution by product category to support business planning
and investment decisions.
==============================================================================*/

SELECT
    Category,
    MAX(Sales) AS Highest_Revenue
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Category
ORDER BY
    Highest_Revenue DESC;



/*==============================================================================
5. Business Question:
Which product categories contribute the highest profit?

Business Purpose:
Identify the most profitable product categories to optimize product portfolio
and maximize profitability.
==============================================================================*/

SELECT
    Category,
    MAX(Profit) AS Highest_Profit
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Category
ORDER BY
    Highest_Profit DESC;



/*==============================================================================
6. Business Question:
Which products are growing or declining over time?

Business Purpose:
Monitor month-over-month product performance to identify products with
increasing demand and products experiencing declining sales.
==============================================================================*/

SELECT
    *,
    CASE
        WHEN Total_Quantity > PrevMonthQty THEN 'GROWING'
        WHEN Total_Quantity < PrevMonthQty THEN 'DECLINING'
        ELSE 'STABLE'
    END AS Product_Trend
FROM (

    SELECT
        Product_ID,
        Product_Name,
        Month,
        Total_Quantity,
        LAG(Total_Quantity)
            OVER (
                PARTITION BY Product_ID, Product_Name
                ORDER BY Total_Quantity
            ) AS PrevMonthQty

    FROM (

        SELECT
            Product_ID,
            Product_Name,
            FORMAT_DATE('%Y-%m', Order_Date) AS Month,
            SUM(Quantity) AS Total_Quantity

        FROM
            `clear-heaven-496209-u2.Superstore_Sales.store_data`

        GROUP BY
            Product_ID,
            Product_Name,
            Order_Date

        ORDER BY
            Total_Quantity DESC

    )

);



/*==============================================================================
7. Business Question:
What percentage of total sales comes from each product?

Business Purpose:
Measure each product's contribution to total business revenue and identify
high-impact products.
==============================================================================*/

SELECT
    Product_Name,

    SUM(Sales) * 100 /

    (
        SELECT
            SUM(Sales)
        FROM
            `clear-heaven-496209-u2.Superstore_Sales.store_data`
    ) AS Percentage_Of_Total_Sales

FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`

GROUP BY
    Product_Name;



/*==============================================================================
8. Business Question:
Which products have the highest average order value?

Business Purpose:
Identify premium products generating the highest revenue per customer order.
==============================================================================*/

SELECT
    Product_Name,

    ROUND(
        SUM(Sales) / COUNT(DISTINCT Order_ID),
        2
    ) AS Average_Order_Value

FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`

GROUP BY
    Product_Name

ORDER BY
    Average_Order_Value DESC;



/*
===============================================================================
END OF MODULE

Module Name : Product Performance Analysis

Business Questions Answered : 8

Project : Sales Performance Analytics Dashboard

===============================================================================
*/
```

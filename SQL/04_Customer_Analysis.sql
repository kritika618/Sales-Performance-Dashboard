/*
===============================================================================
Project        : Sales Performance Analytics Dashboard
Module         : Customer Purchasing Behavior
File Name      : 04_Customer_Purchasing_Behavior.sql
Author         : Kritika Sharma
Role           : Data Analyst

Description:
This script analyzes customer behavior patterns including revenue contribution,
profitability, purchase frequency, retention behavior, and customer value
segmentation.

Business Focus:
- Customer value analysis
- Purchase behavior tracking
- Retention and engagement
- Profitability by customer

Database       : BigQuery
===============================================================================
*/


/*
===============================================================================
TABLE OF CONTENTS
===============================================================================

1. Top Customers by Revenue
2. Top Customers by Profit
3. Customers with Most Orders
4. Average Order Value (AOV)
5. Repeat Customers
6. One-Time Customers
7. Revenue by Customer Segment
8. Customer Purchase Frequency
9. Customers Generating Losses

===============================================================================
*/


/*==============================================================================
1. Business Question:
Which customers generate the highest revenue?

Business Purpose:
Identify high-value customers contributing the most to overall revenue.
==============================================================================*/

SELECT
    Customer_Name,
    ROUND(SUM(Sales), 2) AS Total_Revenue
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Customer_Name
ORDER BY
    Total_Revenue DESC;



/*==============================================================================
2. Business Question:
Which customers generate the highest profit?

Business Purpose:
Identify customers contributing most to profitability.
==============================================================================*/

SELECT
    Customer_Name,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Customer_Name
ORDER BY
    Total_Profit DESC;



/*==============================================================================
3. Business Question:
Which customers place the most orders?

Business Purpose:
Measure customer engagement and purchase activity.
==============================================================================*/

SELECT
    Customer_Name,
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Customer_Name
ORDER BY
    Total_Orders DESC;



/*==============================================================================
4. Business Question:
What is the Average Order Value (AOV)?

Business Purpose:
Measure average spending behavior per order.
==============================================================================*/

SELECT
    ROUND(
        SUM(Sales) / COUNT(DISTINCT Order_ID),
        2
    ) AS Average_Order_Value
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`;



/*==============================================================================
5. Business Question:
Which customers are repeat buyers?

Business Purpose:
Identify loyal customers who generate recurring business.
==============================================================================*/

SELECT
    Customer_Name,
    COUNT(DISTINCT Order_ID) AS Order_Count
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Customer_Name
HAVING
    Order_Count > 1
ORDER BY
    Order_Count DESC;



/*==============================================================================
6. Business Question:
Which customers are one-time buyers?

Business Purpose:
Identify low-engagement customers for retention strategies.
==============================================================================*/

SELECT
    Customer_Name,
    COUNT(DISTINCT Order_ID) AS Order_Count
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Customer_Name
HAVING
    Order_Count = 1;



/*==============================================================================
7. Business Question:
What is revenue contribution by customer segment?

Business Purpose:
Understand revenue distribution across customer segments.
==============================================================================*/

SELECT
    Segment,
    ROUND(SUM(Sales), 2) AS Total_Revenue
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Segment
ORDER BY
    Total_Revenue DESC;



/*==============================================================================
8. Business Question:
What is customer purchase frequency?

Business Purpose:
Measure how frequently customers place orders.
==============================================================================*/

SELECT
    Customer_Name,
    COUNT(DISTINCT Order_ID) AS Purchase_Frequency
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Customer_Name
ORDER BY
    Purchase_Frequency DESC;



/*==============================================================================
9. Business Question:
Which customers are generating losses?

Business Purpose:
Identify unprofitable customers for corrective action.
==============================================================================*/

SELECT
    Customer_Name,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM
    `clear-heaven-496209-u2.Superstore_Sales.store_data`
GROUP BY
    Customer_Name
HAVING
    Total_Profit < 0
ORDER BY
    Total_Profit ASC;



/*
===============================================================================
END OF MODULE

Module Name : Customer Purchasing Behavior
Business Questions Answered : 9
Project : Sales Performance Analytics Dashboard
===============================================================================
*/

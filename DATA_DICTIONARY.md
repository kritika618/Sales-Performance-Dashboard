# Data Dictionary

# Sales Performance Analytics Dashboard

**Document Version:** 1.0
**Prepared By:** Kritika Sharma – Data Analyst
**Document Type:** Data Dictionary
**Project:** Sales Performance Analytics Dashboard

---

# Table of Contents

1. Purpose
2. Dataset Overview
3. Fact Table
4. Dimension Tables
5. Column Definitions
6. Business Metrics
7. Data Relationships
8. Data Standards
9. Business Rules
10. Glossary

---

# 1. Purpose

The purpose of this document is to define the structure, meaning, and business usage of all fields used throughout the Sales Performance Analytics Dashboard.

This document serves as the single source of truth for business users, analysts, and developers by ensuring consistent interpretation of business data and KPIs.

---

# 2. Dataset Overview

The dataset represents historical retail sales transactions across multiple products, customers, regions, and time periods.

The analytical model follows a **Star Schema** consisting of:

## Fact Table

* Sales Fact

## Dimension Tables

* Product
* Customer
* Geography
* Date

---

# 3. Fact Table

## Sales Fact

The Sales Fact table stores transactional sales records and serves as the primary source for analytical reporting.

### Primary Business Measures

* Sales
* Profit
* Quantity
* Discount

Each row represents a single product purchased within an order.

---

# 4. Dimension Tables

## Product Dimension

Contains descriptive information about products.

### Attributes

* Product ID
* Product Name
* Category
* Sub-Category

---

## Customer Dimension

Contains customer information.

### Attributes

* Customer ID
* Customer Name
* Segment

---

## Geography Dimension

Contains geographic hierarchy.

### Attributes

* Country
* Region
* State
* City

---

## Date Dimension

Contains calendar attributes used for time intelligence.

### Attributes

* Order Date
* Year
* Quarter
* Month

---

# 5. Column Definitions

| Column        | Data Type | Description                            | Business Purpose        |
| ------------- | --------- | -------------------------------------- | ----------------------- |
| Order_ID      | String    | Unique identifier for each order       | Counts total orders     |
| Order_Date    | Date      | Date when the order was placed         | Trend and time analysis |
| Ship_Date     | Date      | Date when the order was shipped        | Delivery analysis       |
| Ship_Mode     | String    | Shipping method used                   | Operational reporting   |
| Customer_ID   | String    | Unique customer identifier             | Customer analysis       |
| Customer_Name | String    | Customer name                          | Customer reporting      |
| Segment       | String    | Customer market segment                | Segmentation analysis   |
| Country       | String    | Customer country                       | Geographic reporting    |
| Region        | String    | Sales region                           | Regional analysis       |
| State         | String    | State or province                      | Geographic analysis     |
| City          | String    | Customer city                          | City-level reporting    |
| Postal_Code   | Integer   | Postal code                            | Geographic reference    |
| Product_ID    | String    | Unique product identifier              | Product analysis        |
| Category      | String    | Product category                       | Category reporting      |
| Sub_Category  | String    | Product sub-category                   | Product hierarchy       |
| Product_Name  | String    | Product description                    | Product reporting       |
| Sales         | Decimal   | Revenue generated from the transaction | Revenue KPI             |
| Quantity      | Integer   | Number of units sold                   | Volume analysis         |
| Discount      | Decimal   | Discount applied to the order          | Discount analysis       |
| Profit        | Decimal   | Net profit from the transaction        | Profitability analysis  |

---

# 6. Business Metrics

## Revenue Metrics

### Total Sales

**Definition**

Total revenue generated from completed sales transactions.

**Calculation**

SUM(Sales)

---

### Average Order Value (AOV)

**Definition**

Average revenue generated per customer order.

**Calculation**

Total Sales ÷ Total Orders

---

### Sales Growth %

**Definition**

Percentage increase or decrease in sales compared to the previous reporting period.

---

## Profitability Metrics

### Total Profit

**Definition**

Net profit earned after considering discounts.

**Calculation**

SUM(Profit)

---

### Profit Margin %

**Definition**

Percentage of revenue retained as profit.

**Calculation**

(Total Profit ÷ Total Sales) × 100

---

### Profit Growth %

**Definition**

Percentage change in profit compared to the previous reporting period.

---

## Operational Metrics

### Total Orders

Distinct count of Order_ID.

---

### Total Quantity Sold

Total units sold.

Calculation:

SUM(Quantity)

---

## Customer Metrics

### Total Customers

Distinct count of Customer_ID.

---

### Revenue per Customer

Total Sales ÷ Total Customers

---

### Customer Retention Rate

Percentage of customers making repeat purchases during the reporting period.

---

# 7. Data Relationships

The reporting model follows the relationships below.

```text
                    Date
                      │
                      │
Product ─────┐         │
             │         │
Customer ─── Sales Fact ─── Geography
```

Relationship Type

* Product → Sales Fact (1 : Many)
* Customer → Sales Fact (1 : Many)
* Geography → Sales Fact (1 : Many)
* Date → Sales Fact (1 : Many)

---

# 8. Data Standards

The following standards are maintained throughout the project.

## Date Format

YYYY-MM-DD

---

## Currency

USD

---

## Numeric Precision

Sales

Decimal (2)

Profit

Decimal (2)

Discount

Percentage

Quantity

Whole Number

---

## Naming Convention

Business-friendly field names are used throughout Power BI.

Examples:

* Total Sales
* Profit Margin %
* Revenue per Customer
* Average Order Value

---

# 9. Business Rules

The following rules govern analytical reporting.

* Every Order_ID represents a unique customer order.
* Sales values represent gross revenue.
* Profit values may be positive or negative.
* Discount values are expressed as percentages.
* Customer_ID uniquely identifies a customer.
* Product_ID uniquely identifies a product.
* Category and Sub-Category follow a predefined hierarchy.
* Time analysis is based on Order_Date.
* Growth metrics compare current and previous reporting periods.
* KPI calculations follow standardized business definitions across all reports.

---

# 10. Glossary

| Business Term    | Definition                                                                     |
| ---------------- | ------------------------------------------------------------------------------ |
| Revenue          | Total sales generated from completed transactions                              |
| Profit           | Net earnings after deducting costs and discounts                               |
| Profit Margin    | Percentage of revenue retained as profit                                       |
| Order            | A customer purchase identified by Order_ID                                     |
| Customer         | An individual or organization purchasing products                              |
| Product Category | High-level grouping of products                                                |
| Sub-Category     | Detailed classification within a product category                              |
| Region           | Geographic sales territory                                                     |
| KPI              | Key Performance Indicator used to measure business performance                 |
| Star Schema      | Data model consisting of one fact table connected to multiple dimension tables |
| Fact Table       | Table containing measurable business events                                    |
| Dimension Table  | Table containing descriptive business attributes                               |

---

# Document Summary

This Data Dictionary establishes standardized definitions for all business entities, attributes, relationships, and KPIs used within the Sales Performance Analytics Dashboard.

Maintaining a centralized data dictionary promotes consistent reporting, improves collaboration between business and technical teams, and ensures that analytical outputs are interpreted uniformly across the organization.

---

**End of Document**

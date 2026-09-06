# 🛒 MySQL E-Commerce Sales & Customer Analytics Project

## 📌 Project Overview

This project is an end-to-end **E-Commerce Sales & Customer Analytics solution** built using **MySQL 8.0+ and Power BI**.

It simulates a real-world e-commerce business environment involving **customers, products, orders, payments, and product returns**. MySQL is used for **database design, data management, advanced SQL analysis, and business insights**, while Power BI is used to create an **interactive dashboard for sales, customer, product, and profitability analysis**.

The project demonstrates practical skills in **SQL, advanced SQL concepts, business analytics, data modeling, DAX, and Power BI dashboard development**.

The dataset is **synthetically generated** for learning, portfolio, and analytics demonstration purposes and does not contain real customer or business data.

---

## 🎯 Project Objectives

- Design and implement a relational e-commerce database
- Generate and manage a large-scale synthetic dataset
- Perform business analysis using SQL
- Practice advanced SQL concepts
- Analyze customer purchasing behavior
- Analyze product and category performance
- Calculate revenue, profit, and profitability metrics
- Analyze payments and product returns
- Build reusable SQL Views, Stored Procedures, Functions, and Triggers
- Apply indexing and query optimization techniques
- Connect MySQL with Power BI
- Build an interactive E-Commerce Analytics Dashboard
- Demonstrate practical SQL and Power BI skills for Data Analyst / SQL roles

---

## 🛠️ Technologies Used

- **MySQL 8.0+**
- **SQL**
- **Power BI Desktop**
- **DAX**
- **MySQL Workbench**
- **Git & GitHub**

---

## 🗄️ Database Schema

The project contains the following core tables:

| Table | Description |
|---|---|
| `customers` | Customer personal and registration information |
| `customer_addresses` | Customer address information |
| `categories` | Product category information |
| `products` | Product, pricing, cost, and inventory information |
| `orders` | Customer order information |
| `order_items` | Products purchased within each order |
| `payments` | Payment transactions and statuses |
| `product_returns` | Product return information |

### Relationships

```text
customers
    │
    ├── customer_addresses
    │
    └── orders
          │
          ├── payments
          │
          └── order_items
                 │
                 ├── products
                 │      │
                 │      └── categories
                 │
                 └── product_returns
```

---

## 📊 Dataset Size

The project uses a large synthetic dataset designed to simulate an e-commerce environment.

| Table | Approx. Records |
|---|---:|
| Customers | 5,000+ |
| Customer Addresses | 5,000+ |
| Categories | 10 |
| Products | 70 |
| Orders | 15,000 |
| Order Items | 30,000+ |
| Payments | 15,000 |
| Product Returns | 1,000+ |

> **Note:** The data is synthetically generated and does not represent real customer or business data.

---

# 🔎 SQL Analysis

The project covers SQL concepts from basic queries to advanced business analytics.

## Basic SQL

- SELECT
- WHERE
- DISTINCT
- ORDER BY
- LIMIT
- BETWEEN
- IN
- LIKE
- IS NULL / IS NOT NULL
- CASE
- String Functions
- Date Functions

## DDL & DML

- CREATE
- ALTER
- DROP
- TRUNCATE
- INSERT
- UPDATE
- DELETE

## Constraints

- PRIMARY KEY
- FOREIGN KEY
- UNIQUE
- NOT NULL
- DEFAULT
- CHECK

---

## 🔗 Joins

The project includes:

- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- CROSS JOIN
- Multi-table JOINs

---

## 📊 Aggregate Functions

The project uses:

- COUNT()
- SUM()
- AVG()
- MIN()
- MAX()
- GROUP BY
- HAVING

---

## 🔍 Subqueries

The project covers:

- Scalar Subqueries
- IN / NOT IN
- EXISTS / NOT EXISTS
- Correlated Subqueries
- Derived Tables

---

## 🧩 Common Table Expressions (CTEs)

The project includes:

- Basic CTEs
- Multiple CTEs
- CTE-based Business Analysis

---

## 📈 Window Functions

The project uses:

- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- LAG()
- LEAD()
- PARTITION BY

---

# 💼 Business Analytics

The project answers practical e-commerce business questions such as:

- What is the total revenue?
- What is the average order value?
- Which products generate the most revenue?
- Which products generate the most profit?
- Which categories perform best?
- What is the monthly revenue trend?
- Who are the highest-value customers?
- Which customers are repeat customers?
- How can customers be segmented based on spending?
- What is the customer lifetime value proxy?
- What percentage of orders are cancelled?
- What is the payment success rate?
- What is the product return rate?
- Why are customers returning products?
- Which products have low stock?
- Which products have never been ordered?
- Which customers have never placed an order?

---

# ⚙️ Advanced SQL Features

## Views

Examples include:

- Customer Orders View
- Product Category View
- Order Item Sales View
- Customer Sales View
- Monthly Sales View
- Customer Segmentation View

## Stored Procedures

Examples include:

- Get Customer Orders
- Get Products by Category
- Get Customer Spending

## Functions

Examples include:

- Calculate Order Total
- Calculate Product Profit
- Calculate Customer Segment

## Triggers

Examples include:

- Automatic Stock Reduction
- Return Quantity Validation
- Default Return Status

---

# ⚡ Indexing & Query Optimization

The project also covers database performance concepts including:

- Creating indexes
- Identifying frequently used columns
- Improving query performance
- Using EXPLAIN
- Comparing query execution plans
- Optimizing analytical queries

---

# 📈 Power BI Dashboard

The MySQL database is connected to Power BI to create an interactive:

## E-Commerce Sales & Customer Analytics Dashboard

### Dashboard KPIs

- Total Revenue
- Total Profit
- Delivered Orders
- Average Order Value
- Profit Margin

### Dashboard Visuals

- Monthly Revenue Trend
- Revenue by Category
- Top 10 Products by Revenue
- Profit by Category
- Returns by Reason
- Payment Amount by Method
- Order Status Distribution
- Top 10 Customers
- Overall Profit Margin

---

# 📷 Dashboard Preview

<img width="1322" height="737" alt="Screenshot 2026-09-06 110414" src="https://github.com/user-attachments/assets/714bc74d-c29f-4d12-a3a7-282c8146e684" />


---

# 📁 Project Structure

```text
MySQL-Ecommerce-Analytics-Project/
│
├── README.md
│
├── sql/
│   ├── 01_database_setup.sql
│   ├── 02_table_creation.sql
│   ├── 03_insert_data.sql
│   ├── 04_constraints.sql
│   ├── 05_basic_queries.sql
│   ├── 06_joins.sql
│   ├── 07_aggregate_functions.sql
│   ├── 08_subqueries.sql
│   ├── 09_window_functions.sql
│   ├── 10_views.sql
│   ├── 11_stored_procedures.sql
│   ├── 12_functions.sql
│   ├── 13_triggers.sql
│   ├── 14_ctes.sql
│   ├── 15_business_analytics.sql
│   ├── 16_indexing.sql
│   └── 17_query_optimization.sql
│
├── powerbi/
│   └── Ecommerce_Sales_Customer_Analytics.pbix
│
└── Dashboard_screenshot/
    └── dashboard.png
```

---

# 🚀 How to Run the Project

## 1. Create the Database

Run:

```sql
CREATE DATABASE ecommerce_analytics;

USE ecommerce_analytics;
```

## 2. Create Tables

Run the table creation SQL file.

## 3. Generate / Load Data

Run the data generation scripts to populate the database.

## 4. Run SQL Analysis

Execute the SQL analysis files to explore the data and answer business questions.

## 5. Connect Power BI

Open Power BI Desktop and connect to:

```text
Server: localhost:3306
Database: ecommerce_analytics
```

Use **Import** mode and load the required tables.

## 6. Build / Open Dashboard

Open the Power BI file to explore the interactive dashboard.

---

# 📌 Key Skills Demonstrated

## SQL

- Relational Database Design
- Primary & Foreign Keys
- Constraints
- Data Generation
- Data Validation
- Joins
- Aggregations
- Subqueries
- CTEs
- Window Functions
- Views
- Stored Procedures
- Functions
- Triggers
- Indexing
- Query Optimization
- Business Analytics

## Power BI

- MySQL Data Connection
- Data Modeling
- Relationships
- DAX Measures
- KPI Cards
- Interactive Visualizations
- Business Dashboard Design
- Sales Analytics
- Customer Analytics
- Product Analytics
- Profitability Analysis

---

# 📊 Key Business KPIs

| KPI | Description |
|---|---|
| Total Revenue | Revenue generated from delivered orders |
| Total Profit | Profit generated from delivered sales |
| Profit Margin | Profit as a percentage of revenue |
| Delivered Orders | Number of successfully delivered orders |
| Average Order Value | Average revenue per delivered order |
| Total Customers | Number of unique customers |
| Total Quantity Sold | Total quantity of products sold |
| Return Rate | Percentage of products/orders returned |
| Cancellation Rate | Percentage of cancelled orders |
| Payment Success Rate | Percentage of successful payments |

---

# 🎓 Learning Outcomes

Through this project, I gained practical experience in:

- Designing relational databases
- Working with large datasets
- Writing complex SQL queries
- Performing business-oriented data analysis
- Building reusable SQL database objects
- Creating analytical KPIs
- Connecting SQL databases with Power BI
- Creating interactive dashboards
- Translating business questions into data-driven insights

---

# 🔄 Project Workflow

```text
Database Design
       ↓
Table Creation
       ↓
Constraints
       ↓
Data Generation
       ↓
Basic SQL Analysis
       ↓
Joins & Aggregations
       ↓
Subqueries
       ↓
CTEs
       ↓
Window Functions
       ↓
Business Analytics
       ↓
Views
       ↓
Stored Procedures
       ↓
Functions
       ↓
Triggers
       ↓
Indexing & Optimization
       ↓
Power BI Data Connection
       ↓
Data Modeling
       ↓
DAX Measures
       ↓
Interactive Dashboard
```

---

# 🧪 Data Note

The dataset used in this project is **synthetically generated** for portfolio and learning purposes.

It is designed to simulate realistic e-commerce transactions and business scenarios without using real customer or business information.

---

# 📌 Project Status

## ✅ Completed

The project covers the complete workflow from database creation and SQL analysis to Power BI dashboard development.

```text
MySQL Database
      ↓
SQL Analysis
      ↓
Business Insights
      ↓
Power BI
      ↓
Interactive Dashboard
```

---

# 👤 Author

## Sumit Todkar

Aspiring **Data Analyst / SQL Developer**

### Skills

`SQL` `MySQL` `Power BI` `DAX` `Python` `Data Analytics`

---

⭐ If you find this project useful, feel free to explore the SQL scripts and Power BI dashboard.

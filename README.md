# 🛒 Zepto SQL Data Analysis Project

## 📌 Overview

This project demonstrates end-to-end SQL-based data analysis on a quick-commerce dataset (Zepto-style). It includes database schema design, data insertion, and 30 beginner-to-intermediate SQL queries to extract meaningful business insights.

The focus is on building strong SQL fundamentals such as filtering, joins, aggregations, and basic window functions.

---

## 📂 Project Structure

```
zepto-sql-analysis/
│
├── schema.sql      -- Database schema (tables, constraints)
├── data.sql        -- Insert statements (sample dataset)
├── analysis.sql    -- 30 SQL queries for analysis
└── README.md
```

---

## 🛠 Tools & Technologies

* PostgreSQL
* pgAdmin
* SQL

---

## 📊 Key Analysis Covered

### 🔹 Basic Data Exploration

* Total customers, orders, products, and stores
* Revenue calculation for delivered orders

### 🔹 Filtering & Aggregation

* Orders by status (delivered, cancelled)
* High-value orders
* Average order value and total discounts

### 🔹 Joins & Grouping

* Orders with customer details
* Product-level sales insights
* Revenue by city and store

### 🔹 Business Insights

* Top orders by value
* Customer order frequency
* Product-wise quantity sold
* Average delivery time

### 🔹 Window Functions (Basic)

* Running total of revenue
* Ranking orders using ROW_NUMBER, RANK
* Partition-based ranking (city-wise)
* LAG function for previous order comparison
* Percentage contribution of orders

---

## 🚀 How to Run the Project

1. Create a new database in PostgreSQL

2. Run the schema file:

   ```sql
   \i schema.sql
   ```

3. Insert the data:

   ```sql
   \i data.sql
   ```

4. Run the analysis queries:

   ```sql
   \i analysis.sql
   ```

> ⚠️ Note: If tables are created under a schema (e.g., `zepto`), run:

```sql
SET search_path TO zepto;
```

---

## 💡 Key Learnings

* Writing clean and structured SQL queries
* Understanding relationships using joins
* Performing aggregations for business insights
* Using basic window functions for advanced analysis
* Organizing SQL projects for real-world use

---

## 🎯 Project Objective

To build a strong foundation in SQL and demonstrate the ability to analyze structured data for business decision-making, suitable for entry-level Data Analyst roles.

---

## 📌 Note

This project focuses on beginner to intermediate SQL concepts and avoids overly complex analytics to maintain clarity and strong fundamentals.

---

## 👤 Author

**Ritesh Nalawade**
Aspiring Data Analyst | SQL | Excel | Python | Power BI

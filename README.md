# E-commerce Sales Analysis using SQL

## Project Overview
This project analyses a fictional e-commerce business using MySQL. It explores customer orders, product performance, sales by city and category, order statuses, and customer purchasing behaviour.

The project demonstrates how SQL can be used to answer practical business questions and turn relational data into useful insights.

> **Disclaimer:** This is a learning portfolio project. The business, customers, orders and transactions are fictional. Revenue/order value is calculated as `quantity × unit_price`; it is not profit.

## Tools and Skills
- MySQL Community Server
- MySQL Workbench
- SQL: `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`, `HAVING`, aggregate functions
- `INNER JOIN` and `LEFT JOIN`
- Subqueries
- Window functions: `RANK()` and `PARTITION BY`
- Date-based analysis using `DATE_FORMAT()`

## Database Structure
The database contains four related tables:

| Table | Description | Records |
|---|---|---:|
| `customers` | Customer details and city | 10 |
| `products` | Product names, categories and prices | 8 |
| `orders` | Order dates, customers and statuses | 12 |
| `order_details` | Products, quantities and unit prices per order | 18 |

## Business Questions Answered
1. How many orders and customers are in the dataset?
2. What is the total order-line value?
3. Which products generate the highest order value?
4. What is the order value by customer city?
5. Who are the top-spending customers?
6. How does order value vary by month?
7. How much order value comes from delivered orders?
8. Which products exceed a specified order-value threshold?
9. What is the distribution of orders by status?
10. Which customers are repeat purchasers?
11. Are there customers who have never placed an order?
12. What is each customer's latest order date?
13. Which customers spend above the average customer spend?
14. Which products rank highest within each category by delivered revenue?
15. Which products sell the most units among delivered orders?

## Key Findings

### Overall dataset
- Total customers: **10**
- Total orders: **12**
- Total order-detail records: **18**
- Total order-line value across all order statuses: **₹315,700**
- Delivered order value: **₹227,700**

### Delivered revenue by product
| Product | Delivered revenue |
|---|---:|
| Laptop | ₹110,000 |
| Smartphone | ₹50,000 |
| Monitor | ₹36,000 |
| Headphones | ₹10,000 |
| Office Chair | ₹8,000 |
| Study Desk | ₹6,000 |
| Keyboard | ₹4,500 |
| Mouse | ₹3,200 |

### Delivered revenue by category
| Category | Delivered revenue | Share |
|---|---:|---:|
| Electronics | ₹196,000 | 86.1% |
| Accessories | ₹17,700 | 7.8% |
| Furniture | ₹14,000 | 6.1% |

### Other observations
- Laptop is the highest-revenue product among delivered orders.
- Headphones and Mouse are joint leaders by delivered units sold, with 4 units each.
- Mumbai has the highest total order-line value across all order statuses: ₹120,500.
- January 2026 order-line value was ₹172,800; February 2026 was ₹142,900.
- 9 of the 12 orders are marked Delivered; the remaining 3 are Cancelled, Shipped or Processing.
- Rahul Sharma and Priya Patel each placed 2 orders.

**Metric note:** City, monthly, top-customer and all-status product order-value figures include every order status unless explicitly labelled delivered. They should not be interpreted as recognised accounting revenue. The dataset is small and illustrative, so findings are not representative of a real business.

## Repository Structure
```text
Ecommerce-Sales-Analysis/
├── ecommerce_sales_analysis.sql
└── README.md
```

## How to Run
1. Install MySQL Community Server and MySQL Workbench.
2. Open `ecommerce_sales_analysis.sql` in MySQL Workbench.
3. Connect to your local MySQL server.
4. Execute the script.
5. Review the result grids for the business analysis queries.

The script uses `CREATE DATABASE IF NOT EXISTS`, `CREATE TABLE IF NOT EXISTS` and `INSERT IGNORE` so it can be rerun against the same sample database without recreating existing tables or duplicating the sample primary-key records.

## Author
**Nimish Desai**

Portfolio project created to practise SQL-based data analysis for entry-level Data Analyst roles.

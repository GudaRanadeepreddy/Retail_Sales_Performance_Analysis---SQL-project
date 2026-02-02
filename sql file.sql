CREATE DATABASE sales_analysis;
USE sales_analysis;

CREATE TABLE accounts (
id INT PRIMARY KEY,
name VARCHAR(100),
website VARCHAR(100),
lat DECIMAL(9,6),
longt DECIMAL(9,6),
primary_poc VARCHAR(100),
sales_rep_id int
);

CREATE TABLE orders (
id  INT PRIMARY KEY,
account_id INT,
occurred_at DATETIME,
standard_qty INT,
gloss_qty INT,
poster_qty INT,
total INT,
standard_amt_usd DECIMAL(10,3),
gloss_amt_usd DECIMAL(10,3),
poster_amt_usd DECIMAL(10,3),
total_amt_usd DECIMAL(9,3)
);

CREATE TABLE sales_reps (
id INT PRIMARY KEY,
name VARCHAR(100),
region_id int
);

CREATE TABLE region (
id INT PRIMARY KEY,
name VARCHAR(50)
);

CREATE TABLE web_events (
id INT PRIMARY KEY,
account_id INT,
occurred_at DATETIME,
channel VARCHAR(50)
);

-- View all customers
SELECT * FROM accounts;
SELECT * FROM region;
SELECT * FROM sales_reps;
SELECT * FROM web_events;

ALTER TABLE accounts DROP COLUMN website;

SELECT * FROM accounts WHERE primary_poc IS NULL;

DELETE FROM accounts WHERE primary_poc IS NULL;

UPDATE accounts SET primary_poc = 'UNKNOWN' 
WHERE primary_poc IS NULL;

-- Total number of orders
SELECT COUNT(*) AS total_orders FROM orders;

-- Total revenue generated
SELECT SUM(total_amt_usd) AS total_revenue FROM orders;

-- Orders with customer names
SELECT a.name AS Customer, o.account_id, o.total_amt_usd
FROM accounts a
JOIN orders o ON a.id = o.account_id;

-- Customers with their sales reps
SELECT a.name AS Customer, s.name AS sales_rep
FROM accounts a
JOIN sales_reps s ON a.sales_rep_id = s.id;

-- Revenue by customer
SELECT a.name, SUM(o.total_amt_usd) AS revenue
FROM accounts a
JOIN orders o ON a.id = o.account_id
GROUP BY a.name
ORDER BY revenue DESC;

-- Top 5 customers by revenue
SELECT a.name, SUM(o.total_amt_usd) AS revenue
FROM accounts a
JOIN orders o ON a.id = o.account_id
GROUP BY a.name
ORDER BY revenue DESC
LIMIT 5;

-- Revenue by region
SELECT r.name AS region, SUM(o.total_amt_usd) AS revenue
FROM accounts a
JOIN orders o ON a.id = o.account_id
JOIN sales_reps s ON a.sales_rep_id = s.id
JOIN region r ON s.region_id = r.id
GROUP BY r.name;

-- Best performing sales rep
SELECT s.name, SUM(o.total_amt_usd) AS total_sales
FROM orders o
JOIN accounts a ON o.account_id = a.id
JOIN sales_reps s ON a.sales_rep_id = s.id
GROUP BY s.name
ORDER BY total_sales DESC
LIMIT 1;

-- Total quantity sold per product type
SELECT SUM(standard_qty) AS standard, SUM(gloss_qty) AS gloss, SUM(poster_qty) AS poster
FROM orders;

-- Website traffic by channel
SELECT channel, COUNT(*) AS vists
FROM web_events
GROUP BY channel
ORDER BY vists DESC;

-- Accounts with highest website activity
SELECT a.name, COUNT(w.account_id) AS total_events
FROM web_events w
JOIN accounts a ON w.account_id = a.id
GROUP BY a.name
ORDER BY total_events DESC;

-- Monthly sales trend
SELECT DATE_FORMAT(occurred_at, '%Y-%M') AS months, SUM(total_amt_usd) AS revenue
FROM orders
GROUP BY months
ORDER BY months;

-- First order date per customer
SELECT a.name, MIN(o.occurred_at) AS first_order_date
FROM orders o
JOIN accounts a ON o.account_id = a.id
GROUP BY a.name;

-- Customers with no orders
SELECT a.name
FROM accounts a
JOIN orders o ON a.id = o.account_id
WHERE o.id IS NULL;

-- Average order value per customer
SELECT a.name, AVG(o.total_amt_usd) AS Avg_revenue
FROM accounts a
JOIN orders o ON a.id = o.account_id
GROUP BY a.name;

CREATE VIEW sales_overview AS
SELECT o.account_id, o.occurred_at, a.name AS customer, r.name AS region, s.name AS sales_rep, o.total_amt_usd
FROM orders o
JOIN accounts a ON o.account_id = a.id
JOIN sales_reps s ON a.sales_rep_id = s.id
JOIN region r ON s.region_id = r.id;

CREATE VIEW customer_performance AS
SELECT a.name AS customer, COUNT(o.account_id) AS total_orders, SUM(o.total_amt_usd) AS revenue, AVG(o.total_amt_usd) AS avg_order_value
FROM accounts a
LEFT JOIN orders o ON a.id = o.account_id
GROUP BY a.name;

CREATE VIEW web_analytics AS
SELECT a.name AS customer, w.channel, COUNT(*) AS visits
FROM web_events w
JOIN accounts a ON w.account_id = a.id
GROUP BY a.name, w.channel;

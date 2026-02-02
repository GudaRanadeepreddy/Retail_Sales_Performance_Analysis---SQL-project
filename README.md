# Retail_Sales_Performance_Analysis---SQL-project
This repository contains a complete SQL database setup and analysis scripts for a sales dataset, including schema creation for accounts, orders, sales reps, regions, and web events, plus key queries for revenue analysis, customer performance, and web traffic insights.

Project Overview:

A relational database was designed to analyze sales performance, customer behavior, web traffic, and regional revenue trends. The project simulates a real-world sales environment by integrating customer accounts, orders, sales representatives, regions, and web events data. It includes SQL commands to clean data (e.g., handling null primary POC), compute metrics like total revenue and top customers, and generate views for ongoing analysis.


Key Objectives:
1. Set up a sales database: Create and populate a retail sales database with the provided sales data.
2. Data Cleaning: Identify and remove any records with missing or null values.
3. Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
4. Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.​



Database Design:

The database includes 5 core tables:

1. accounts – customer and account-level details
2. orders – transaction and revenue data
3. sales_reps – sales representative information
4. region – geographical sales regions
5. web_events – website interaction and traffic data

About Data:
Tables Structure
| Table     | Key Columns                                                              | Purpose                             |
| --------- | ------------------------------------------------------------------------ | ----------------------------------- |
| accounts  | id, name, lat, long, primarypoc, salesrepid                              | Customer details and location.      |
| orders    | id, accountid, occurredat, totalamtusd, standardqty, glossqty, posterqty | Sales transactions by product type. |
| salesreps | id, name, regionid                                                       | Sales representatives.              |
| region    | id, name                                                                 | Geographic regions.                 |
| webevents | id, accountid, occurredat, channel                                       | Website visits by channel.          |


Key Features & Analysis:

• Created and managed a structured SQL database (sales_analysis).

• Data cleaning: Drops unused columns, removes nulls, sets defaults.

• Key queries:
   • Total orders and revenue.
   • Revenue by customer, region, sales rep.
   • Product quantities, web traffic by channel.
   • Monthly trends, first orders, average order value.

• Useful views: salesoverview, customerperformance, webanalytics for quick insights.

• Built SQL Views for efficient reporting:
    • sales_overview
    • customer_performance
    • web_analytics



SQL Concepts Used:

• Database & table creation

• Data cleaning (DELETE, UPDATE, ALTER)

• Joins (INNER, LEFT)

• Aggregations & grouping

• Subqueries and sorting

• Date-based analysis

• Views for reporting


Business Impact:

• Faster sales performance reporting

• Better understanding of customer value and engagement

• Identification of high-revenue customers and regions

• Actionable insights for sales and marketing optimization
​



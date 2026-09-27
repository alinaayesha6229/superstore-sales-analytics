# Superstore Sales & Profitability Analysis

## Project Overview
This project analyzes Superstore sales data to identify sales trends, profitability drivers, regional performance, customer segments, discount impact, and loss-making products.

The project demonstrates an end-to-end data analytics workflow using **Google Sheets, Microsoft SQL Server, and Power BI**.

## Tools Used
- **Google Sheets** – Data cleaning and data quality validation
- **SQL Server (SSMS)** – Data analysis and business queries
- **Power BI** – Interactive dashboard and data visualization
- **GitHub** – Project documentation and portfolio hosting

## Dataset
The dataset contains approximately **10,000 sales transaction records** covering the period **2023–2026**.

Key fields include:
- Order Date
- Customer
- Region & State
- Product Category & Sub-Category
- Sales
- Quantity
- Discount
- Profit

## Data Cleaning
Data quality checks were performed in Google Sheets before analysis.

Checks included:
- Missing values
- Duplicate records
- Sales and profit validation
- Discount validation
- Profitability classification
- Data type consistency

## SQL Analysis
Microsoft SQL Server was used to investigate:

- Overall sales and profitability
- Yearly and monthly sales trends
- Year-over-year sales growth
- Category and sub-category performance
- Regional and state performance
- Customer segment performance
- Shipping mode performance
- Discount impact on profitability
- Loss-making products

The complete SQL analysis is available in:

`sql/analysis.sql`

## Power BI Dashboard

The dashboard provides an interactive view of:

- Total Sales
- Total Profit
- Total Orders
- Total Customers
- Profit Margin
- Monthly Sales & Profit Trend
- Category Performance
- Regional Performance
- Sub-Category Profitability
- Loss-Making States
- Discount Impact on Profit
- Top 10 Loss-Making Products
- Customer Segment Performance

Interactive filters allow analysis by **Year** and **Region**.

## Key Business Insights

- Total sales reached approximately **$2.33M**, generating around **$292K profit** with an overall **12.56% profit margin**.
- Technology generated the highest category profit, while Furniture had a significantly lower profit margin.
- Tables and Bookcases were among the weakest-performing sub-categories.
- Discounts above approximately **20%** were associated with sharply weaker profitability, with higher discount ranges producing substantial losses.
- The West region generated the strongest overall profit, while the Central region had the lowest regional profit margin.
- Texas, Ohio, Pennsylvania and Illinois were among the major loss-making states.
- Consumer customers generated the largest sales volume, while Home Office had the highest average order value and profit margin.
- Several high-revenue products generated losses, showing that strong sales do not necessarily translate into profitability.

## Business Recommendations

- Review discount policies, particularly discounts exceeding 20%.
- Investigate pricing and cost structures for loss-making Furniture products.
- Review consistently loss-making products and consider pricing, discount, supplier-cost, or assortment changes.
- Investigate state-level profitability issues, particularly in major loss-making markets.
- Focus growth efforts on profitable product categories and customer segments while monitoring margin rather than sales alone.

## Dashboard Preview

Power BI dashboard screenshot will be added here.

## Project Structure

    superstore-sales-analytics/
    ├── README.md
    └── sql/
        └── analysis.sql

## Author

**Alina Ayesha**

Data Analytics Portfolio Project

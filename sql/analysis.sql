/*
=========================================================
SUPERSTORE SALES & PROFITABILITY ANALYSIS
Tool: Microsoft SQL Server
=========================================================
*/

USE SuperstoreAnalytics;
GO


-- 1. OVERALL BUSINESS PERFORMANCE

SELECT
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    COUNT(DISTINCT Customer_ID) AS Total_Customers,
    SUM(Quantity) AS Total_Quantity_Sold,
    ROUND((SUM(Profit) / NULLIF(SUM(Sales), 0)) * 100, 2)
        AS Profit_Margin_Percent
FROM dbo.superstore_sales;


-- 2. YEARLY SALES PERFORMANCE

SELECT
    YEAR(Order_Date) AS Order_Year,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND((SUM(Profit) / NULLIF(SUM(Sales), 0)) * 100, 2)
        AS Profit_Margin_Percent
FROM dbo.superstore_sales
GROUP BY YEAR(Order_Date)
ORDER BY Order_Year;


-- 3. YEAR-OVER-YEAR SALES GROWTH

WITH YearlySales AS (
    SELECT
        YEAR(Order_Date) AS Order_Year,
        SUM(Sales) AS Total_Sales
    FROM dbo.superstore_sales
    GROUP BY YEAR(Order_Date)
),
SalesGrowth AS (
    SELECT
        Order_Year,
        Total_Sales,
        LAG(Total_Sales) OVER (ORDER BY Order_Year) AS Previous_Year_Sales
    FROM YearlySales
)
SELECT
    Order_Year,
    ROUND(Total_Sales, 2) AS Total_Sales,
    ROUND(Previous_Year_Sales, 2) AS Previous_Year_Sales,
    ROUND(
        ((Total_Sales - Previous_Year_Sales) /
        NULLIF(Previous_Year_Sales, 0)) * 100,
        2
    ) AS YoY_Growth_Percent
FROM SalesGrowth
ORDER BY Order_Year;


-- 4. MONTHLY SALES AND PROFIT TREND

SELECT
    YEAR(Order_Date) AS Order_Year,
    MONTH(Order_Date) AS Order_Month,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM dbo.superstore_sales
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Order_Year, Order_Month;


-- 5. CATEGORY PERFORMANCE

SELECT
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    SUM(Quantity) AS Quantity_Sold,
    ROUND((SUM(Profit) / NULLIF(SUM(Sales), 0)) * 100, 2)
        AS Profit_Margin_Percent
FROM dbo.superstore_sales
GROUP BY Category
ORDER BY Total_Profit DESC;


-- 6. SUB-CATEGORY PROFITABILITY

SELECT
    Category,
    Sub_Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    SUM(Quantity) AS Quantity_Sold,
    ROUND((SUM(Profit) / NULLIF(SUM(Sales), 0)) * 100, 2)
        AS Profit_Margin_Percent
FROM dbo.superstore_sales
GROUP BY Category, Sub_Category
ORDER BY Total_Profit ASC;


-- 7. DISCOUNT IMPACT ON PROFITABILITY

SELECT
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.10 THEN '1-10%'
        WHEN Discount <= 0.20 THEN '11-20%'
        WHEN Discount <= 0.30 THEN '21-30%'
        WHEN Discount <= 0.40 THEN '31-40%'
        ELSE 'Above 40%'
    END AS Discount_Range,
    COUNT(*) AS Transactions,
    ROUND(AVG(Discount) * 100, 2) AS Avg_Discount_Percent,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit) / NULLIF(SUM(Sales), 0)) * 100, 2)
        AS Profit_Margin_Percent
FROM dbo.superstore_sales
GROUP BY
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.10 THEN '1-10%'
        WHEN Discount <= 0.20 THEN '11-20%'
        WHEN Discount <= 0.30 THEN '21-30%'
        WHEN Discount <= 0.40 THEN '31-40%'
        ELSE 'Above 40%'
    END
ORDER BY Avg_Discount_Percent;


-- 8. TOP 10 LOSS-MAKING PRODUCTS

SELECT TOP 10
    Product_Name,
    Category,
    Sub_Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(AVG(Discount) * 100, 2) AS Avg_Discount_Percent,
    SUM(Quantity) AS Quantity_Sold
FROM dbo.superstore_sales
GROUP BY Product_Name, Category, Sub_Category
ORDER BY Total_Profit ASC;


-- 9. REGIONAL PERFORMANCE

SELECT
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND((SUM(Profit) / NULLIF(SUM(Sales), 0)) * 100, 2)
        AS Profit_Margin_Percent
FROM dbo.superstore_sales
GROUP BY Region
ORDER BY Total_Profit DESC;


-- 10. CUSTOMER SEGMENT PERFORMANCE

SELECT
    Segment,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    COUNT(DISTINCT Customer_ID) AS Total_Customers,
    ROUND(
        SUM(Sales) / NULLIF(COUNT(DISTINCT Order_ID), 0),
        2
    ) AS Avg_Order_Value,
    ROUND((SUM(Profit) / NULLIF(SUM(Sales), 0)) * 100, 2)
        AS Profit_Margin_Percent
FROM dbo.superstore_sales
GROUP BY Segment
ORDER BY Total_Sales DESC;


-- 11. SHIPPING MODE PERFORMANCE

SELECT
    Ship_Mode,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(
        SUM(Sales) / NULLIF(COUNT(DISTINCT Order_ID), 0),
        2
    ) AS Avg_Order_Value,
    ROUND((SUM(Profit) / NULLIF(SUM(Sales), 0)) * 100, 2)
        AS Profit_Margin_Percent
FROM dbo.superstore_sales
GROUP BY Ship_Mode
ORDER BY Total_Sales DESC;


-- 12. STATE / PROVINCE PERFORMANCE

SELECT
    State_Province,
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND((SUM(Profit) / NULLIF(SUM(Sales), 0)) * 100, 2)
        AS Profit_Margin_Percent
FROM dbo.superstore_sales
GROUP BY State_Province, Region
ORDER BY Total_Profit ASC;


-- 13. LOSS-MAKING STATES AND DISCOUNT ANALYSIS

SELECT
    State_Province,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(AVG(Discount) * 100, 2) AS Avg_Discount_Percent,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND((SUM(Profit) / NULLIF(SUM(Sales), 0)) * 100, 2)
        AS Profit_Margin_Percent
FROM dbo.superstore_sales
GROUP BY State_Province
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC;

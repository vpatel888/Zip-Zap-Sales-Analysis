SELECT * 
FROM Retail.retail_sales_dataset;

-- Revenue (NORTH STAR METRIC)

SELECT SUM(`Total Amount`) AS Revenue
FROM Retail.retail_sales_dataset;

-- Revenue Throughout the Year (NEW)
SELECT Date AS date, `Total Amount` AS Revenue
FROM Retail.retail_sales_dataset
ORDER BY Date;

-- Revenue Each Month
SELECT MONTH(Date) AS Month, SUM(`Total Amount`) AS Revenue
FROM Retail.retail_sales_dataset
GROUP BY MONTH(Date)
ORDER BY month;

-- Which month had the highest revenue?
WITH monthly_revenue_CTE AS (
SELECT MONTH(Date) AS Month, SUM(`Total Amount`) As Revenue
FROM Retail.retail_sales_dataset
GROUP BY MONTH(Date)
ORDER BY month
)
-- outputs the month that has the largest revenue
SELECT Month, Revenue
FROM monthly_revenue_CTE
ORDER BY Revenue DESC
LIMIT 1;

-- Average Transaction Value (NORTH STAR METRIC)


-- ATV for 1 whole year
SELECT SUM(`Total Amount`)/ COUNT(`Transaction ID`) AS ATV
FROM Retail.retail_sales_dataset;

-- ATV Throughout the Year (NEW)
SELECT Date AS date, `Total Amount`/`Transaction ID` AS ATV
FROM Retail.retail_sales_dataset
ORDER BY Date;

-- Do customers in certain months spend more per transaction?
SELECT MONTH(Date) AS Month, SUM(`Total Amount`)/ COUNT(`Transaction ID`) AS ATV
FROM Retail.retail_sales_dataset
GROUP BY MONTH(Date)
ORDER BY month;

-- ATV For each product category (NEW)
SELECT `Product Category`, SUM(`Total Amount`)/ COUNT(`Transaction ID`) AS ATV
FROM Retail.retail_sales_dataset
GROUP BY `Product Category`;

-- Average Basket Size (NORTH STAR METRIC)

-- ABS Throughout the Year (NEW)
SELECT Date AS Date, Quantity/`Transaction ID` AS ABS
FROM Retail.retail_sales_dataset
ORDER BY Date;

-- ABS for each product category (NEW)
SELECT `Product Category`, SUM(Quantity)/COUNT(`Transaction ID`) AS ABS
FROM Retail.retail_sales_dataset
GROUP BY `Product Category`;

-- How many items do customers typically purchase in a single transaction?
-- Average Basket Size ABS for 1 year
SELECT SUM(Quantity)/COUNT(`Transaction ID`) AS ABS
FROM Retail.retail_sales_dataset;

-- Is the average basket size growing, shrinking, or staying flat?

-- Avg basket size each month
SELECT MONTH(Date) AS Month, SUM(Quantity)/COUNT(`Transaction ID`) AS ABS
FROM Retail.retail_sales_dataset
GROUP BY MONTH(Date)
ORDER BY month;

-- Do larger baskets correspond to higher revenue months?
SELECT MONTH(Date) AS Month, SUM(Quantity)/ COUNT(`Transaction ID`) AS ABS, SUM(`Total Amount`) AS Revenue
FROM Retail.retail_sales_dataset
GROUP BY MONTH(Date)
ORDER BY month;

-- MONTHLY TRANSACTIONS (NORTH STAR METRIC)

-- How many transactions occur each month?
SELECT MONTH(Date) AS Month, COUNT(`Transaction ID`) AS Number_of_transactions
FROM Retail.retail_sales_dataset
GROUP BY MONTH(Date)
ORDER BY month;

-- Do order volumes correlate with revenue, or are high-revenue months driven by higher ATV?
SELECT MONTH(Date) AS Month, COUNT(`Transaction ID`) AS Number_of_transactions, SUM(`Total Amount`) AS Revenue, SUM(`Total Amount`)/ COUNT(`Transaction ID`) AS ATV
FROM Retail.retail_sales_dataset
GROUP BY MONTH(Date)
ORDER BY month;

-- Are there months with fewer but larger orders (quantity is bigger)?
SELECT MONTH(Date) AS Month, COUNT(`Transaction ID`) AS Number_of_transactions, SUM(quantity) AS total_order_quantity
FROM Retail.retail_sales_dataset
GROUP BY MONTH(Date)
ORDER BY month;

-- Number of transactions for each product category (NEW)
SELECT `Product Category`, COUNT(`Transaction ID`) AS Transactions
FROM Retail.retail_sales_dataset
GROUP BY `Product Category`;

-- Transactions Throughout the Year (NEW)
SELECT Date AS Date, `Transaction ID` AS Transactions
FROM Retail.retail_sales_dataset
ORDER BY Date;


-- Sales by Product Category (NORTH STAR METRIC)

-- Which product category generates the most revenue?
SELECT `Product Category`, SUM(`Total Amount`) AS Revenue
FROM Retail.retail_sales_dataset
GROUP BY `Product Category`;

-- Which product categories are most popular in high-revenue months? 

-- this code outputs the product category counts for each month
WITH Category_Count_CTE AS (
SELECT MONTH(Date) AS Month, `Product Category`, COUNT(`Product Category`) AS Purchases
FROM Retail.retail_sales_dataset
GROUP BY MONTH(Date), `Product Category`
ORDER BY MONTH(Date))
-- find the top product category for each month (maybe need to use ranking here?)
, ranking_cte AS (SELECT Month, `Product Category`, Purchases, DENSE_RANK() OVER (PARTITION BY MONTH ORDER BY Purchases DESC) AS Purchases_Ranking
FROM Category_Count_CTE)
-- filter for the purchases_ranking that are equal to 1.
, popular_categories_CTE AS(SELECT Month, `Product Category`
FROM ranking_cte
WHERE Purchases_Ranking = 1)
-- how do i connect the revenue output with the top product category output?
-- correlated subqueries means the second list provides details for each item in the first list
SELECT Month, `Product Category`, (SELECT SUM(`Total Amount`) As Revenue
FROM Retail.retail_sales_dataset
WHERE MONTH(Date) = Month
) AS Revenue
FROM popular_categories_CTE
ORDER BY Revenue DESC
LIMIT 3;


-- Units Sold (NORTH STAR METRIC)
-- Does higher unit volume always mean higher revenue?
SELECT Quantity, SUM(`Total Amount`) AS Revenue
FROM Retail.retail_sales_dataset
GROUP BY Quantity
ORDER BY Quantity;

-- Are customers buying more units over time?


-- NUmber of units bought per month
SELECT MONTH(Date) AS Month, SUM(Quantity) AS Quantity
FROM Retail.retail_sales_dataset
GROUP BY MONTH(Date)
ORDER BY Month;

-- Which months had the highest volume of units sold?
SELECT MONTH(Date) AS Month, SUM(Quantity) AS Quantity
FROM Retail.retail_sales_dataset
GROUP BY MONTH(Date)
ORDER BY Quantity DESC
LIMIT 3;








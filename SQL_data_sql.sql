CREATE TABLE sales_books (
Order_Id INT PRIMARY KEY,
Order_Date DATE,
Order_Time TIME,
Customer_Id INT,
Product VARCHAR(100),
Category VARCHAR(50),
Region VARCHAR (50),
City VARCHAR (50),
Sales_Channel VARCHAR (50),
Payment_Mode VARCHAR (50),
Quantity INT,
Unit_Price NUMERIC (12,2),
Discount_Percent NUMERIC (5,2),
Revenue NUMERIC(14,2),
Discount_Amount NUMERIC(14,2),
Net_Sales NUMERIC(14,2),
Cost NUMERIC(14,2),
Profit NUMERIC(14,2)


);


-- Import data
COPY Sales_books
FROM 'D:\d for chrome\Sales_data_book.csv'
DELIMITER ','
CSV HEADER ;


-- Data check / import check
SELECT COUNT(*)
FROM Sales_books;


-- show 10 rows & columns
SELECT *
FROM Sales_books
LIMIT 10 ;



-- date check
SELECT Order_Date
FROM Sales_books
LIMIT 5 ;


-- time check
SELECT Order_Time
FROM Sales_books
LIMIT 5;


-- Null values check
SELECT
COUNT(*) FILTER(WHERE Order_Date IS NULL) AS date_null,
COUNT(*) FILTER(WHERE Order_Time IS NULL) AS time_null,
count(*) FILTER(WHERE Product IS NULL) AS Product_null,
count(*) FILTER(WHERE Profit IS NULL) AS Profit_null
FROM Sales_books;


-- wrong value check
SELECT *
FROM Sales_books
WHERE Quantity <= 0 ;


-- sales check
SELECT *
FROM Sales_books
WHERE Net_Sales <= 0 ;


-- clean table create
CREATE TABLE sales_clean AS
SELECT *
FROM sales_books;

-- buisness KPI
-- total revenue check

SELECT 
SUM(Net_sales) AS Total_revenue
FROM sales_clean ;


-- check profit
SELECT
SUM(Profit) AS Total_profit
FROM sales_clean;


-- total orders
SELECT 
COUNT(Order_Id) AS Total_orders
FROM sales_clean ;


-- most selling category
SELECT
Category,
SUM(Net_Sales) AS Sales,
SUM(Profit) AS Profit
FROM sales_clean
GROUP BY Category
ORDER BY Sales DESC;


-- region analisis
SELECT 
Region,
SUM(Net_Sales) AS Sales,
SUM(Profit) AS Profit
FROM sales_clean
GROUP BY Region
ORDER BY Sales DESC ;


-- top 10 product
SELECT
Product,
SUM(Net_Sales) AS Sales,
SUM(Profit) AS Profit
FROM sales_clean
GROUP BY Product
ORDER BY Product DESC 
LIMIT 10 ;  


-- top 10 customer
SELECT
Customer_ID,
SUM(Net_Sales) AS Purchase_Value
FROM sales_clean
GROUP BY Customer_ID
ORDER BY Purchase_Value DESC
LIMIT 10 ;



-- montholy sales trend
SELECT
EXTRACT(MONTH FROM Order_Date) AS Month,
SUM(Net_Sales) AS Sales
FROM sales_clean
GROUP BY Month
ORDER BY Month ;

-- sales channel
SELECT
Sales_Channel,
SUM(Net_Sales) AS Sales,
SUM(Profit) AS Profit
FROM sales_clean
GROUP BY Sales_Channel ;

-- payment method

SELECT
Payment_Mode,
COUNT(Order_ID) AS Orders,
SUM(Net_Sales) AS Sales
FROM sales_clean
GROUP BY Payment_Mode ; 


-- profit marjin
SELECT
Category,
ROUND(
(SUM (Profit)/ SUM(Net_Sales)*100)::NUMERIC,
2
)
AS Profit_Margin
FROM sales_clean
GROUP BY Category ;


-- time analisis (Order time)
SELECT
EXTRACT(HOUR FROM Order_Time) AS Hour,
SUM(Net_Sales) AS Sales
FROM sales_clean
GROUP BY HOUR
ORDER BY Sales DESC ;


































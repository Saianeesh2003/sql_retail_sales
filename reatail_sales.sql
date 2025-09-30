create database project_1;
USE project_1;
CREATE TABLE retail_sales
(
transactions_id INT,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(50),
age INT,
category VARCHAR(200),
quantiy float,
price_per_unit  float,
cogs  float,
total_sale FLOAT
);
--DATA CLEANING
DELETE from retail_sales
WHERE sale_date IS NULL 
or 
customer_id IS NULL 
OR
gender IS NULL 
or
age IS NULL 
OR
category IS NULL 
OR 
quantiy IS NULL 
OR 
price_per_unit IS NULL 
OR cogs IS NULL 
OR 
total_sale IS NULL ;
SELECT COUNT(*) FROM retail_sales;
-- DATA EXPLORATION
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT COUNT(DISTINCT category) FROM retail_sales;
SELECT COUNT(*)
FROM retail_sales
WHERE gender = 'Male';
SELECT * FROM retail_sales
ORDER BY total_sale DESC
LIMIT 5;
SELECT
    transactions_id,
    sale_date,
    sale_time,
    customer_id,
    gender,
    age,
    category,
quantiy,
    price_per_unit, 
   cogs,   
    total_sale,    
    (total_sale - cogs) AS profit
FROM
    retail_sales;
    -- Data Analysis & Findings
    -- Write a SQL query to retrieve all columns for sales made on '2022-11-05:
    SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
     -- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4;
   -- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT AVG(age) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
-- Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT
    category,
    SUM(total_sale) AS net_sale,
   COUNT(*) AS total_orders
FROM
    retail_sales
GROUP BY
    category;
    -- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender;
   -- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1
--Topic: Online Store Sales Analysis

-- Task: Top 3 products sold in 2025
-- The task could have been simplified using LIMIT, but it may cut off rows with identical values
WITH cte AS (
SELECT shop.title
      ,count(*) AS cnt_orders 
FROM orders
JOIN shop ON shop.id = orders.shopId
WHERE YEAR(orders.date_time) = 2025
GROUP BY shop.id)
,ranked AS (
SELECT title
	  ,cnt_orders
    ,DENSE_RANK() OVER (ORDER BY cnt_orders DESC) AS rank_ord
FROM cte)
SELECT * 
FROM ranked 
WHERE rank_ord <= 3;

-- Task: Find products with the minimum price in their category using a correlated subquery
-- The inner subquery is executed for each row of the outer query, which allows values to be compared row by row.
SELECT shop.title
      ,shop.price
      ,shop.category_id
FROM shop
WHERE shop.price = (SELECT MIN(s2.price) FROM shop s2
					          WHERE s2.category_id = shop.category_id);
 



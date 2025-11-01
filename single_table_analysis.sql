-- SELECT & FROM
USE mavenmovies;

-- list every records from the customer table
SELECT
    *
FROM
    customer;

-- Retrieve the first_name, last_name, and email columns from the customer table
SELECT
    first_name,
    last_name,
    email
FROM
    customer;
    
-- SELECT DISTINCT

-- Find out the unique rental durations 
SELECT DISTINCT
    rental_duration
FROM
    film;
    
-- WHERE

-- Find out the payment details of 1st 100 customers
-- BETWEEN checks if a value falls within a range (inclusive)
SELECT 
    customer_id, 
    rental_id, amount, 
    payment_date
FROM
    payment
WHERE
    customer_id BETWEEN 1 AND 100;  

-- Find out the payment details where amount is greater than $5
SELECT 
    customer_id, rental_id, amount, payment_date
FROM
    payment
WHERE
    amount > 5;

-- Find out the payment details where amount is greater than $5 since January 1, 2006
SELECT 
    customer_id, rental_id, amount, payment_date
FROM
    payment
WHERE
    customer_id BETWEEN 1 AND 100
        AND amount > 5
        AND payment_date > '2006-01-01';

-- Retrieve payments greater than 10 or made before January 1, 2006
SELECT 
    customer_id, rental_id, amount, payment_date
FROM
    payment
WHERE
    amount > 10
        OR payment_date < '2006-01-01';

-- Retrieve payments made by customers with IDs 1, 3, or 5
-- IN() allows you to check multiple possible values for a column.
-- It works like ID = 1 or 3 or 5
SELECT 
    customer_id, rental_id, amount, payment_date
FROM
    payment
WHERE
    customer_id IN (1 , 3, 5);

-- LIKE
-- Use LIKE to search for patterns within text values in a table.

-- Find actors whose first name starts with ‘A’
SELECT 
    first_name
FROM
    actor
WHERE
    first_name LIKE 'A%';  -- 'A%' → searches for any text that starts with the letter 'A' and can have any number of characters after it.

-- Find actors whose first name ends with ‘A’
SELECT 
    first_name
FROM
    actor
WHERE
    first_name LIKE '%A';

-- Retrieve all films with 'Epic' in their description
SELECT
    title,          
    description     
FROM
    film
WHERE
    description LIKE '%Epic%';  -- searches for any text containing the word 'Epic' anywhere in the description
    
-- Retrieve all films with 'Behind the Scenes' in the 'special_features' column
SELECT 
    title, special_features
FROM
    film
WHERE
    special_features LIKE '%Behind the Scenes%';

-- GROUP BY
-- Is used to divide data into multiple groups based on one or more columns.

-- Find the number of films in each rating category
SELECT 
    rating, 
    COUNT(film_id) as no_of_films
FROM
    film
GROUP BY rating;

-- ORDER BY
-- Use AS for clarity in SQL

-- Find out total films for each rental duration
SELECT 
    rental_duration,
    COUNT(film_id) AS count_of_films_by_rental_duration
FROM
    film
GROUP BY rental_duration
ORDER BY rental_duration ASC;

-- Group by multiple columns
SELECT 
    rating, rental_duration, COUNT(film_id)
FROM
    film
GROUP BY rating , rental_duration;
-- conclusion: There are 39 PG-rated films that have a rental duration of 6 days.

-- Aggregate Function
-- Find the minimum, maximum, and average film length for each rating category
SELECT
    rating,               -- Movie rating (e.g., G, PG, R)
    MIN(length) AS min_length,   -- Shortest film length in each rating
    MAX(length) AS max_length,   -- Longest film length in each rating
    AVG(length) AS avg_length    -- Average film length in each rating
FROM
    film
GROUP BY
    rating;
    
-- HAVING 
-- HAVING is used to filter groups of data after applying aggregate functions

-- Find customer ids having rentals less than 15
SELECT 
    customer_id, COUNT(rental_id) AS total_rentals
FROM
    rental
GROUP BY customer_id
HAVING COUNT(rental_id) < 15;

-- Find ratings with more than 200 films
SELECT 
    rating, COUNT(film_id) AS total_films
FROM
    film
GROUP BY rating
HAVING COUNT(film_id) > 200;

-- ORDER BY

-- List all the films with their lengths and rental rates from longest to shortest
SELECT 
    title, length, rental_rate
FROM
    film
ORDER BY length DESC;

-- CASE statement example
-- Performs conditional logic within a query
-- The following query uses a CASE statement with the AND operator 
-- to label customers based on their store_id and active status 
-- (e.g., 'store 1 active' or 'store 2 inactive').

SELECT 
    first_name,
    last_name,
    CASE
        WHEN store_id = 1 AND active = 1 THEN 'store 1 active'
        WHEN store_id = 1 AND active = 0 THEN 'store 1 inactive'
        WHEN store_id = 2 AND active = 1 THEN 'store 2 active'
        WHEN store_id = 2 AND active = 0 THEN 'store 2 inactive'
    END AS store_and_status
FROM
    customer;

-- CASE & COUNT (Case pivoting)

-- This query counts how many copies of each film are available in store 1 and store 2 
-- by using CASE inside COUNT() and grouping the results by film_id.

SELECT 
	film_id,
    COUNT(CASE
        WHEN store_id = 1 THEN inventory_id
        ELSE NULL
    END) AS store_1_copies,
    COUNT(CASE
        WHEN store_id = 2 THEN inventory_id
        ELSE NULL
    END) AS store_2_copies
FROM
    inventory
GROUP BY film_id
ORDER BY film_id;

-- Find out how many inactive customers in each store
SELECT 
    store_id,
    COUNT(CASE
        WHEN active = 1 THEN customer_id
        ELSE NULL
    END) AS active_customers,
    COUNT(CASE
        WHEN active = 0 THEN customer_id
        ELSE NULL
    END) AS inactive_customers
FROM
    customer
GROUP BY store_id
ORDER BY store_id;

-- provide a list of all customer identification values, with a count of rentals they have made all-time 
SELECT 
    customer_id, COUNT(rental_id) AS total_rentals
FROM
    rental
GROUP BY customer_id
ORDER BY COUNT(rental_id) DESC;


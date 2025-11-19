Use mavenmovies;

-- Different types of join
-- INNER JOIN 
-- selects records that have matching values in both table
-- make a list of all films we have in inventory (film's title, description.....)
SELECT 
	inventory.inventory_id,
    film.title, 
    film.description, 
    inventory.store_id
FROM
    film
        INNER JOIN
    inventory ON film.film_id = inventory.film_id

-- LEFT JOIN
-- keep all left table data + matching right table data (if any)

-- This followning query lists all actors and shows how many films each actor has appeared in
SELECT 
    actor.first_name, actor.last_name, COUNT(film_actor.film_id)
FROM
    actor
        LEFT JOIN
    film_actor ON film_actor.actor_id = actor.actor_id
GROUP BY actor.first_name, actor.last_name
ORDER BY COUNT(film_actor.film_id) DESC

-- Find how many actors are associated with each film title
SELECT 
    film.title,
    COUNT(film_actor.actor_id) AS total_actors
FROM
    film
        LEFT JOIN
    film_actor ON film.film_id = film_actor.film_id
GROUP BY film.title

-- Bridging
-- no common key between film and category table
-- but both have common key with film_category table
-- film_category table acts as a bridge between film & category table
SELECT 
    film.film_id, film.title, category.name
FROM
    film
Inner Join film_category on film.film_id = film_category.film_id
Inner Join category on film_category.category_id = category.category_id

-- Find list of all actors with each film title that they appear in
SELECT 
    actor.first_name, actor.last_name, film.title
FROM
    actor
Inner Join film_actor on actor.actor_id = film_actor.actor_id
Inner Join film on film_actor.film_id = film.film_id

-- Add multiple conditions
-- retrieve all films that belong to the Horror category, showing their IDs, titles, and category name.
SELECT 
    film.film_id, film.title, category.name as category_name
FROM
    film
        INNER JOIN
    film_category ON film.film_id = film_category.film_id
        INNER JOIN
    category ON category.category_id = film_category.category_id
WHERE
    category.name = 'Horror'

-- List distinct titles, descriptions available at store 2
SELECT DISTINCT
    film.title, 
    film.description, 
	inventory.store_id
FROM
    film
        INNER JOIN
    inventory ON film.film_id = inventory.film_id
WHERE
    inventory.store_id = 2

-- Alternative
SELECT DISTINCT
    film.title, film.description, inventory.store_id
FROM
    film
        INNER JOIN
    inventory ON film.film_id = inventory.film_id
        AND inventory.store_id = 2

-- UNION
-- Combine data from two or more tables, stack rows on top of each other
-- UNION removes duplicate rows
-- UNION ALL keeps duplicate rows

-- List all staff and advisor names
SELECT 
    'advisor' AS type, advisor.first_name, advisor.last_name
FROM
    advisor 
UNION SELECT 
    'staff' AS type, staff.first_name, staff.last_name
FROM
    staff
    
-- Assignment
-- Q2. 
-- list every film copy in each store along with the movie’s title, rating, rental price, and replacement cost.
-- solution:
SELECT 
    inventory.inventory_id,
    inventory.store_id,
    film.title,
    film.rating,
    film.rental_rate,
    film.replacement_cost
FROM
    inventory
        INNER JOIN
    film ON film.film_id = inventory.film_id
       
-- Q3. 
-- How many film copies (inventory items) each store has for each movie rating?
-- Solution:
SELECT 
    rating, store_id, COUNT(inventory.film_id) total_items
FROM
    inventory
        INNER JOIN
    film ON film.film_id = inventory.film_id
GROUP BY rating , store_id

-- Q4. 
-- How many films of each category are available in each store?
-- Also calculate the average and total replacement cost for those films.
-- Solution:
SELECT 
    inventory.store_id,
    category.name,
    COUNT(film.film_id) AS total_films,
    AVG(film.replacement_cost) AS avg_replacement_cost,
    SUM(film.replacement_cost) AS total_replacement_cost
FROM
    film
        INNER JOIN
    film_category ON film.film_id = film_category.film_id
        INNER JOIN
    inventory ON film_category.film_id = inventory.film_id
        INNER JOIN
    category ON film_category.category_id = category.category_id
GROUP BY category.name, inventory.store_id

-- Q5. List all customer details 
-- Solution:
SELECT 
    CONCAT(customer.first_name,
            ' ',
            customer.last_name) AS name,
	customer.store_id,
    customer.active,
    address,
    city,
    country
FROM
    customer
        LEFT JOIN
    address ON address.address_id = customer.address_id
        LEFT JOIN
    city ON city.city_id = address.city_id
        LEFT JOIN
    country ON country.country_id = city.country_id

-- Q6. 
-- Find each customer’s total rentals and total payment amount, ranked from the highest spender to the lowest.
-- Solution:
SELECT 
    CONCAT(first_name, ' ', last_name) AS name,
    COUNT(rental_id) AS total_rentals,
    SUM(amount) AS sum_of_all_payments
FROM
    payment
        LEFT JOIN
    customer ON customer.customer_id = payment.customer_id
GROUP BY name
ORDER BY sum_of_all_payments DESC

-- Q7. use of union
-- Solution:
SELECT 
    'investor' AS type, first_name, last_name, company_name
FROM
    investor 
UNION SELECT 
    'advisor' AS type, first_name, last_name, Null
FROM
    advisor 
    
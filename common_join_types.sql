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
Left Join film_category on film.film_id = film_category.film_id
Left Join category on film_category.category_id = category.category_id

-- Find list of all actors with each film title that they appear in
SELECT 
    actor.first_name, actor.last_name, film.title
FROM
    actor
Left Join film_actor on actor.actor_id = film_actor.actor_id
Left Join film on film_actor.film_id = film.film_id

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


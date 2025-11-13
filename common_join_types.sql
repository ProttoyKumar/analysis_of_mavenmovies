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


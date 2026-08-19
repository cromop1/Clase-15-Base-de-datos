USE sakila;

-- Query 1 )

CREATE OR REPLACE VIEW list_of_customers AS
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    a.address,
    a.postal_code AS zip_code,
    a.phone,
    ci.city,
    co.country,
    CASE 
        WHEN c.active = 1 THEN 'active'
        ELSE 'inactive'
    END AS status,
    c.store_id
FROM customer c
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id;



-- Query 2 ) 


CREATE OR REPLACE VIEW film_details AS
SELECT 
    f.film_id,
    f.title,
    f.description,
    c.name AS category,
    f.rental_rate AS price,
    f.length,
    f.rating,
    GROUP_CONCAT(
        DISTINCT CONCAT(a.first_name, ' ', a.last_name) 
        ORDER BY a.first_name, a.last_name 
        SEPARATOR ', '
    ) AS actors
FROM film f
LEFT JOIN film_category fc ON f.film_id = fc.film_id
LEFT JOIN category c ON fc.category_id = c.category_id
LEFT JOIN film_actor fa ON f.film_id = fa.film_id
LEFT JOIN actor a ON fa.actor_id = a.actor_id
GROUP BY 
    f.film_id,
    f.title,
    f.description,
    c.name,
    f.rental_rate,
    f.length,
    f.rating;


-- Query 3 ) 


CREATE OR REPLACE VIEW sales_by_film_category AS
SELECT 
    c.name AS category,
    SUM(p.amount) AS total_rental
FROM payment p
INNER JOIN rental r ON p.rental_id = r.rental_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY total_rental DESC;


-- Query 4)
CREATE OR REPLACE VIEW actor_information AS
SELECT 
    a.actor_id,
    a.first_name,
    a.last_name,
    COUNT(fa.film_id) AS total_films
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY 
    a.actor_id,
    a.first_name,
    a.last_name;



-- Query 5 )
CREATE OR REPLACE VIEW actor_info AS
SELECT 
    a.actor_id,
    a.first_name,
    a.last_name,
    GROUP_CONCAT(DISTINCT CONCAT(c.name, ': ', 
        (SELECT GROUP_CONCAT(f.title ORDER BY f.title SEPARATOR ', ')
         FROM sakila.film f
         JOIN sakila.film_category fc ON f.film_id = fc.film_id
         JOIN sakila.film_actor fa ON f.film_id = fa.film_id
         WHERE fc.category_id = c.category_id
           AND fa.actor_id = a.actor_id
        )
    ) ORDER BY c.name ASC SEPARATOR '; ') AS film_info
FROM sakila.actor a
LEFT JOIN sakila.film_actor fa ON a.actor_id = fa.actor_id
LEFT JOIN sakila.film_category fc ON fa.film_id = fc.film_id
LEFT JOIN sakila.category c ON fc.category_id = c.category_id
GROUP BY a.actor_id, a.first_name, a.last_name;
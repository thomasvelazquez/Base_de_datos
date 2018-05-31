#1 
SELECT country.country, count(*) as cities
FROM country 
INNER JOIN city USING (country_id)
GROUP BY country.country_id
ORDER BY 2;

#2
SELECT country.country, count(*) as cities
FROM country 
INNER JOIN city USING (country_id)
GROUP BY country.country_id
HAVING cities > 10
ORDER BY 2 DESC;

#3
SELECT CONCAT(customer.last_name, " ", customer.first_name) as name, address.address, COUNT(*) as rented, SUM(payment.amount) as payed
FROM customer 
INNER JOIN address USING (address_id)
INNER JOIN rental USING (customer_id)
INNER JOIN payment USING (rental_id)
GROUP BY customer.customer_id
ORDER BY payed DESC;

#4
SELECT DISTINCT film.title
FROM film 
LEFT JOIN inventory USING (film_id)
WHERE inventory.inventory_id IS NULL;
	
#5
SELECT film.title, inventory_id
FROM film 
INNER JOIN inventory USING (film_id)
LEFT JOIN rental USING (inventory_id)
WHERE rental_id IS NULL;
	
#6
SELECT CONCAT(c.last_name, " ",c.first_name) as name, c.store_id, film.title, rental.rental_date, rental.return_date
FROM rental 
INNER JOIN customer c USING (customer_id)
INNER JOIN inventory USING (inventory_id)
INNER JOIN film USING (film_id)
ORDER BY store_id, c.last_name;

#7
SELECT
CONCAT(c.city, ',', cy.country) AS store
, CONCAT(m.first_name,' ', m.last_name) AS manager
, SUM(p.amount) AS total_sales
FROM payment AS p
INNER JOIN rental AS r ON p.rental_id = r.rental_id
INNER JOIN inventory AS i ON r.inventory_id = i.inventory_id
INNER JOIN store AS s ON i.store_id = s.store_id
INNER JOIN address AS a ON s.address_id = a.address_id
INNER JOIN city AS c ON a.city_id = c.city_id
INNER JOIN country AS cy ON c.country_id = cy.country_id
INNER JOIN staff AS m ON s.manager_staff_id = m.staff_id
GROUP BY cy.country, c.city,m.first_name, m.last_name
ORDER BY cy.country, c.city;

#8
SELECT rating, sum(amount)
FROM film
INNER JOIN inventory USING (film_id)
INNER JOIN rental USING(inventory_id)
INNER JOIN payment USING(rental_id)
GROUP BY 1;

#9
SELECT actor.actor_id,count(1) AS film_count
FROM actor 
INNER JOIN film_actor USING (actor_id)
GROUP BY actor_id
ORDER BY film_count DESC
LIMIT 1;

#10
SELECT category.name, avg(length)
FROM film 
INNER JOIN film_category USING (film_id)
INNER JOIN category USING (category_id)
GROUP BY category.name
HAVING avg(length)>(SELECT avg(length) FROM film)
ORDER BY avg(length) DESC;



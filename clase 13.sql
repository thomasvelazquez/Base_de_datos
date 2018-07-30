1)INSERT INTO customer(store_id,first_name,last_name,address_id)
  SELECT 1,"Mario","Bros",address_id
  FROM address
  INNER JOIN city USING (city_id)
  INNER JOIN country USING (country_id)
  WHERE country.country = "United States"
  ORDER BY address_id desc
  LIMIT 1;
  
  
2)INSERT INTO rental(rental_date,inventory_id,customer_id,staff_id)
  VALUES (
        CURRENT_DATE(),
        (SELECT inventory_id FROM inventory INNER JOIN film USING (film_id) WHERE title = "ZOOLANDER FICTION" LIMIT 1),
        (SELECT customer_id FROM customer WHERE store_id = 2 LIMIT 1),
        (SELECT staff_id FROM staff WHERE store_id = 2 LIMIT 1));
        

3)UPDATE film 
  SET release_year =
 (CASE
  WHEN rating = "G" THEN 2001
  WHEN rating = "PG" THEN 2002
  WHEN rating = "PG-13" THEN 2003
  WHEN rating = "R" THEN 2004
  WHEN rating = "NC-17" THEN 2005
  END);
  
4)UPDATE rental SET return_date=CURRENT_DATE() WHERE rental_id=16051; 

5)no te permite borrar debido a las relaciones de la table films con otras tablas

DELETE FROM film_actor
WHERE film_id = 1;

DELETE FROM film_category
WHERE film_id = 1;

DELETE FROM rental
WHERE inventory_id in (select inventory_id from inventory where film_id = 1);

DELETE FROM inventory
WHERE film_id = 1;

DELETE FROM film
WHERE film_id = 1;

6)INSERT INTO rental(rental_date,inventory_id,customer_id,staff_id)
VALUES(
	   CURRENT_DATE(),
	   (SELECT inventory_id from inventory where film_id=1 LIMIT 1),
	   (SELECT customer.customer_id FROM customer LIMIT 1),
	   (SELECT staff.staff_id FROM film INNER JOIN inventory USING (film_id) INNER JOIN store USING (store_id) INNER JOIN staff USING (store_id) WHERE film.film_id=1 LIMIT 1)
	   )
INSERT INTO payment(customer_id,staff_id,rental_id,amount,payment_date)
VALUES (
        (SELECT customer_id FROM rental ORDER BY rental_id DESC LIMIT 1 ),
        (SELECT staff_id FROM rental ORDER BY rental_id DESC LIMIT 1),
        (SELECT rental_id FROM rental ORDER BY rental_id DESC LIMIT 1),
        (SELECT replacement_cost FROM film WHERE film_id=1),
        CURRENT_DATE());
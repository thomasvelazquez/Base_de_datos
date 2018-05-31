1)SELECT first_name,last_name
  FROM actor c1
  WHERE EXISTS (SELECT*
		FROM actor c2 
		WHERE c1.last_name = c2.last_name
		AND c1.actor_id <> c2.actor_id)
  ORDER BY last_name;


SELECT first_name,last_name 
  FROM actor c1 
 WHERE last_name IN (SELECT last_name 
                 FROM actor c2 
                WHERE c1.actor_id<>c2.actor_id) 
 ORDER BY last_name;


2)SELECT a.first_name,a.last_name
  FROM actor a
  WHERE NOT EXISTS (
      SELECT *
      FROM film_actor b
      WHERE a.actor_id = b.actor_id)
  ORDER BY actor_id;

SELECT a.first_name,a.last_name
  FROM actor a
  WHERE actor_id NOT IN (
      SELECT actor_id
      FROM film_actor b)
  ORDER BY actor_id;


3)SELECT COUNT(DISTINCT r1.customer_id)
  FROM rental r1
  WHERE NOT EXISTS (SELECT *
                FROM rental r2
                WHERE r1.customer_id = r2.customer_id
                AND r1.rental_id != r2.rental_id);

 
4)SELECT COUNT(DISTINCT r1.customer_id)
  FROM rental r1
  WHERE EXISTS (SELECT *
                FROM rental r2
                WHERE r1.customer_id = r2.customer_id
                AND r1.rental_id != r2.rental_id);
  


5)SELECT first_name,last_name
  FROM actor a
  WHERE EXISTS (
      SELECT *
      FROM film_actor b
      WHERE a.actor_id = b.actor_id
      AND EXISTS (
          SELECT * 
          FROM film c
          WHERE c.film_id = b.film_id
          AND title IN ('BETRAYED REAR','CATCH AMISTAD')
      )
  );

SELECT 


6)SELECT first_name,last_name
  FROM actor a
  WHERE EXISTS (
      SELECT *
      FROM film_actor b
      WHERE a.actor_id = b.actor_id
      AND EXISTS (
          SELECT * 
          FROM film c
          WHERE c.film_id = b.film_id
          AND title LIKE ('BETRAYED REAR') AND title NOT LIKE ('CATCH AMISTAD') 
      )
  );


7)SELECT first_name,last_name
  FROM actor a
  WHERE EXISTS (
      SELECT *
      FROM film_actor b
      WHERE a.actor_id = b.actor_id
      AND EXISTS (
          SELECT * 
          FROM film c
          WHERE c.film_id = b.film_id
          AND title LIKE ('BETRAYED REAR') AND ('CATCH AMISTAD')
      )
  );

SELECT actor_id 
FROM actor 
WHERE actor_id IN (SELECT actor.actor_id 

8)SELECT first_name,last_name
  FROM actor a
  WHERE EXISTS (
      SELECT *
      FROM film_actor b
      WHERE a.actor_id = b.actor_id
      AND EXISTS (
          SELECT * 
          FROM film c
          WHERE c.film_id = b.film_id
          AND title NOT LIKE ('BETRAYED REAR') OR ('CATCH AMISTAD')
      )
  );
                        


#1
CREATE OR REPLACE VIEW list_of_customer AS 
  SELECT customer_id, CONCAT(first_name ," ", last_name) AS full_name , address.address, address.postal_code, address.phone, city.city, country.country, store_id
  FROM customer 
  INNER JOIN address using (address_id)
  INNER JOIN city  using (city_id) 
  INNER join country  using (country_id);
 
 select * from list_of_customer;
#2
#Create a view named film_details, it should contain the following columns:
#film id,  title, description,  category,  price,  length,  rating, actors  - as a string of all the actors separated by comma. Hint use GROUP_CONCAT

 
 CREATE OR REPLACE VIEW film_details AS
 SELECT film_id, title, description,`length`, rating, category.name,replacement_cost, group_concat(actor.first_name, actor.last_name)
 from film
 INNER JOIN film_category USING (film_id)
 INNER JOIN category USING (category_id)
 INNER JOIN film_actor USING(film_id)
 INNER JOIN actor USING(actor_id)
 group by film_id, title, description,`length`, rating, category.name,replacement_cost
 
 select * from film_details ;
#3
 #Create view sales_by_film_category, it should return 'category' and 'total_rental' columns. SUM(payment.amount)
 CREATE OR REPLACE VIEW sales_by_film_category AS
 select name, SUM(payment.amount)
 from category
 INNER JOIN film_category USING(category_id)
 INNER JOIN film USING(film_id)
 INNER JOIN inventory USING(film_id)
 INNER JOIN rental USING(inventory_id)
 INNER JOIN payment USING(rental_id)
 group by name
 
 select * from sales_by_film_category ; 

#4
#Create a view called actor_information where it should return, actor id, first name, last name and the amount of films he/she acted on.

 CREATE OR REPLACE VIEW actor_information AS
 select actor_id, first_name, last_name, COUNT(film_actor.actor_id)
 from actor
 INNER join film_actor USING (actor_id)
 where (film_actor.actor_id = actor.actor_id)
 group by actor_id
 ; 
 
select * from actor_information; 

#5) Analyze view actor_info, explain the entire query and specially how the sub query works.
#	Be very specific, take some time and decompose each part and give an explanation for each. 


select `a`.`actor_id` AS `actor_id`, `a`.`first_name` AS `first_name`, `a`.`last_name` AS `last_name`,
#Seleccionamos el id, first_name y last_name de actor
	group_concat(
		distinct concat(
			`c`.`name`, ': ',(
			#Nos muestra el nombre de todas las categorías y ...
				select group_concat( `f`.`title` order by `f`.`title` ASC separator ', ' )
				#... las peliculas que pertenecen a esa categoria, en las cuales participo el actor, separadas por ', '
					from(( `sakila`.`film` `f`
						join `sakila`.`film_category` `fc` on(( `f`.`film_id` = `fc`.`film_id` )))
						#Hacemos un JOIN de film_category con la tabla film, cuando los film_id sean iguales
						join `sakila`.`film_actor` `fa` on(( `f`.`film_id` = `fa`.`film_id` )))
						#Hacemos un JOIN de film_actor con la tabla film, cuando los film_id sean iguales
					where(( `fc`.`category_id` = `c`.`category_id` )
					#Comparamos los category_id de ambas tablas
						and( `fa`.`actor_id` = `a`.`actor_id` )))
						#Comparamos los actor_id de ambas tablas
		)order by `c`.`name` ASC separator '; '
		#Ordenamos las categorias en orden ascendente, y las separamos con '; '
	) AS `film_info`
	#Nombramos a la cuarta columna como 'film_info'
from ((( `sakila`.`actor` `a`
		left join `sakila`.`film_actor` `fa` on ( `a`.`actor_id` = `fa`.`actor_id` ))
		left join `sakila`.`film_category` `fc` on ( `fa`.`film_id` = `fc`.`film_id` ))
		left join `sakila`.`category` `c` on( `fc`.`category_id` = `c`.`category_id` )
#Añadimos todas las tablas de las que se va a juntar información
group by `a`.`actor_id`, `a`.`first_name`, `a`.`last_name`;
#Agrupamos por las tres primeras columnas
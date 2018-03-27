CREATE DATABASE imdb; 

USE imdb;

CREATE TABLE film(
	film_id int NOT NULL AUTO_INCREMENT ,
	title varchar(30) NULL ,
	description varchar NULL ,
	release_year date NULL ,
	CONSTRAINT PK_film PRIMARY KEY (film_id)
);


CREATE TABLE actor(
	actor_id int NOT NULL AUTO_INCREMENT ,
	first_name varchar(20) NULL ,
	last_name varchar(20) NULL , 
	CONSTRAINT PK_actor PRIMARY KEY (actor_id)
);


CREATE TABLE film_actor(
	actor_id int NOT NULL ,
	film_id int NOT NULL,
	CONSTRAINT FK_film_actor_actor FOREIGN KEY (actor_id) REFERENCES actor (actor_id)
	CONSTRAINT FK_film_actor_film FOREIGN KEY (film_id) REFERENCES film (film_id)
);


ALTER TABLE film_actor ADD (
	film-actor_id int NOT NULL AUTO_INCREMENT ,
	CONSTRAINT PK_film_actor PRIMARY KEY (film-actor_id)
);


ALTER TABLE film ADD (
	last_update varchar(10) NULL ,
	film-actor_id int NOT NULL ,
	CONSTRAINT FK_film_film_actor FOREING KEY (film-actor_id) REFERENCE film_actor (film-actor_id)
);

ALTER TABLE actor ADD (
	last_update varchar(10) NULL ,
	film-actor_id int NOT NULL ,
	CONSTRAINT FK_actor_film_actor FOREING KEY (film-actor_id) REFERENCE film_actor (film-actor_id)
);








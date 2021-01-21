/*Lab | SQL Queries 8
In this lab, you will be using the Sakila database of movie rentals. You have been using this database for a couple labs already, but if you need to get the data again, refer to the official installation link.
The database is structured as follows: 
USE sakila;

Instructions
##Q1 Rank films by length (filter out the rows that have nulls or 0s in length column). 
#In your output, only select the columns title, length, and the rank.*/
SELECT title, length, rank() over (order by length) AS rank_length
from film
where length not in (0, "", " ");

##Q2 Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
#In your output, only select the columns title, length, rating and the rank.
#SELECT title, length, rank() over (order by rating) AS rank_rating, order by length) AS rank_length
#from film

SELECT title, length, rating, 
rank() over (partition by length order by rating) AS rank_length
from film
where length not in ('',0,' ');



##Q3 How many films are there for each of the categories in the category table.
#Use appropriate join to write this query
select  c.name, count(f.film_id) AS n_of_films
from sakila.category as c
join sakila.film_category as f -- default type of join is INNER JOIN. 
on c.category_id = f.category_id
group by c.name;

##Q4 Which actor has appeared in the most films?
SELECT a.first_name, a.last_name, count(f.film_id) AS n_of_films
FROM sakila.actor as a
JOIN sakila.film_actor AS f
on a.actor_id = f.actor_id
group by a.last_name;

##Q5 Most active customer (the customer that has rented the most number of films)

SELECT c.first_name, c.last_name, count(rental_id) AS n_of_rentals
FROM customer as c
JOIN rental as r
ON c.customer_id = r.customer_id
GROUP BY c.last_name
ORDER BY n_of_rentals DESC;


##Q6 Bonus: Which is the most rented film?
#The answer is Bucket Brotherhood This query might require using more than one join statement.
#Give it a try. We will talk about queries with multiple join statements later in the lessons.
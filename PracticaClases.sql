#1
select title, rating from film
where rating = "PG-13";

#2
select DISTINCT title, `length` from film;

#3
select title, rental_rate, replacement_cost from film 
where replacement_cost between 20 and 24;

#4 
select f.title, c.name, f.rating, f.special_features from film f
inner join film_category fc using(film_id)
inner join category c using(category_id)
where f.special_features = "Behind the Scenes";
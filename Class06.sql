#1
SELECT actor_id, last_name
FROM actor a1
WHERE EXISTS (SELECT *
				FROM actor a2
				WHERE a1.last_name = a2.last_name
                AND a1.actor_id <> a2.actor_id);

#2                
SELECT a.first_name, a.last_name
FROM film_actor fa
INNER JOIN actor a ON(a.actor_id = fa.actor_id)
WHERE not exists (select * from actor b where a.actor_id = b.actor_id); 

#3
SELECT c.first_name, c.last_name
FROM customer c
INNER JOIN rental r ON(r.customer_id = c.customer_id)
group by c.customer_id having count(r.rental_id) = 1;

#4 
SELECT c.first_name, c.last_name
FROM customer c
INNER JOIN rental r ON(r.customer_id = c.customer_id)
group by c.customer_id having count(r.rental_id) > 1;

#5
SELECT a.first_name, a.last_name
FROM actor a
INNER JOIN film_actor fa ON(fa.actor_id = a.actor_id)
INNER JOIN film f ON(f.film_id = fa.film_id)
WHERE f.title IN ('BETRAYED REAR','CATCH AMISTAD');

#6
SELECT a.first_name, a.last_name
FROM actor a
INNER JOIN film_actor fa ON(fa.actor_id = a.actor_id)
INNER JOIN film f ON(f.film_id = fa.film_id)
WHERE f.title = 'BETRAYED REAR' AND a.actor_id not in
(SELECT a.actor_id FROM actor a
INNER JOIN film_actor fa ON(fa.actor_id = a.actor_id)
INNER JOIN film f ON(f.film_id = fa.film_id)
WHERE f.title = 'CATCH AMISTAD');

#7
select a.first_name, a.last_name, group_concat(f.title) from actor a
inner join film_actor fa on a.actor_id = fa.actor_id
inner join film f on fa.film_id = f.film_id
where f.title = 'BETRAYED REAR' and a.actor_id in (
	select actor_id from film_actor fa
    inner join film f on f.film_id = fa.film_id
    where f.title = 'CATCH AMISTAD') group by a.actor_id;

#8
select a.first_name, a.last_name from actor a
where a.actor_id not in (
	select actor_id from film_actor fa
    inner join film f on fa.film_id = f.film_id
    where f.title = 'BETRAYED REAR'
) and actor_id not in (
	select actor_id from film_actor fa
    inner join film f on fa.film_id = f.film_id
	where f.title = 'CATCH AMISTAD'
);
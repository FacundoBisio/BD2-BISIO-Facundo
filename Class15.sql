#class15

#1
CREATE VIEW Ejercicio1 as 
	Select c.customer_id, concat(c.first_name, ' ', c.last_name) as Nombre_completo,
		a.address, ci.city, co.country,
		CASE
			WHEN c.active = 1 then 'Active'
			ELSE 'Inactive'
		END AS active,
		c.store_id
	from customer c
	join address a using(address_id)
	join city ci using(city_id)
	join country co using(country_id);

DROP VIEW Ejercicio1;

#2
create view film_details as
	Select f.film_id, f.title, f.description, c.name, f.length, f.replacement_cost, group_concat(a.first_name, ' ', a.last_name) as Lista_actores
    from film f
	join film_category fc using(film_id)
    join category c using(category_id)
    join film_actor fa using(film_id)
    join actor a using(actor_id)
    group by f.film_id, f.title, f.description, c.name, f.length, f.replacement_cost;
    
DROP VIEW film_details;

#3
create view Ejercicio3 as 
	Select c.name, sum(p.amount) as Total_rental from rental r
    join payment p using(rental_id)
    join inventory i using(inventory_id)
    join film f using(film_id)
    join film_category fc using(film_id)
    join category c using(category_id)
    group by c.name;

DROP VIEW Ejercicio3;

#4
create view actor_information as
	Select a.actor_id, a.first_name, a.last_name, group_concat(f.title) as Peliculas_actuadas, count(f.title) as NumPeliculas_actuadas
    from actor a 
    join film_actor fa using(actor_id)
    join film f using(film_id)
    group by a.actor_id, a.first_name, a.last_name;
    
# 5: The query would be like this its very similar to the 'actor_information' view

# it's different is that this one shows the category beside the film name, to do this it uses the group_concat
# and the concat function to do it.
select a.actor_id, a.first_name, a.last_name, group_concat(distinct concat(c.name, ": ", f.title) separator "; ") from actor a
inner join film_actor fa using(actor_id)
inner join film f using(film_id)
inner join film_category fc on fc.film_id = f.film_id
inner join category c on c.category_id = fc.category_id
group by a.actor_id, a.first_name, a.last_name;

/* 
6: Materialized Views
What are Materialized Views?

A materialized view is a precomputed table that stores the results of a query. This precomputed data can significantly improve query performance, especially for complex or frequently executed queries.

Why Use Materialized Views?

Enhanced Performance: By precomputing results, materialized views eliminate the need for real-time query execution, leading to faster response times.
Reduced Load on Primary Database: Materialized views can offload the burden of query processing from the main database, improving overall system performance.
Real-time Reporting: Materialized views can provide up-to-date information for real-time reporting and analytics applications.
When to Use Materialized Views:

Frequently Executed Queries: If a query is executed repeatedly, a materialized view can save significant time.
Large Datasets: For large datasets, materialized views can reduce the amount of data that needs to be processed for each query.
Complex Queries: If a query involves multiple joins or aggregations, a materialized view can simplify the query and improve performance.
Alternatives to Materialized Views:

Indexes: While indexes can improve query performance for certain types of queries, they may not be as effective for complex or ad-hoc queries.
Caching: Caching can store query results in memory, but it may not be as persistent or scalable as materialized views.
Denormalization: Denormalizing data can reduce the number of joins required for certain queries, but it can also lead to data redundancy and maintenance challenges.
DBMS Support for Materialized Views:

Most modern database management systems (DBMS) support materialized views, including:

Oracle Database: Offers robust support for materialized views, including refresh methods, query rewrite rules, and partitioning.
MySQL: Introduced materialized views in version 8.0, providing features like refresh methods and query rewrite rules.
PostgreSQL: Supports materialized views with various refresh methods and query rewrite options.
SQL Server: Offers materialized views, including indexed views for improved performance.
Teradata: Provides materialized views with support for partitioning and indexing.
Key Considerations:

Refresh Strategy: Choose an appropriate refresh strategy (e.g., on-demand, periodic, incremental) based on your data update frequency and performance requirements.
Maintenance: Ensure that materialized views are kept up-to-date with changes to the underlying data.
Query Rewrite: Configure your DBMS to rewrite queries to use materialized views when appropriate.
*/
    
    
    
    
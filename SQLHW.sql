use sakila;

--1a

select a.first_name, a.last_name
from actor a
group by 1,2

--1b

SELECT UPPER(CONCAT(first_name,' ',last_name)) as ACTOR_NAME 
FROM Actor
group by 1

--2a

SELECT actor_id, first_name, last_name
FROM actor
Where first_name like "Joe";

--2b

SELECT actor_id, first_name, last_name
FROM actor
where last_name like "%GEN%";

--2c

SELECT actor_id, first_name, last_name
FROM actor
where last_name like "%LI%"
order by 3,2

--2d

select country, country_id
from country
WHERE country in ('Afghanistan','Bangladesh','China')

--3a

ALTER TABLE actor
Add column description VARCHAR(40)
AFTER first_name;

ALTER TABLE Actor
ALTER COLUMN description blob

--3b

ALTER TABLE actor
DROP COLUMN description

--4a

select last_name, count(last_name)
from actor
group by 1

--4b

select last_name, count(last_name) as count_of_last
from actor
group by 1
Having 'count_of_last' >= 2

--4c

update actor
set first_name = "HARPO"
where first_name = "GROUCHO" and last_name = "Williams"

--4d 

UPDATE Actor 
Set first_name = 
CASE
WHEN first_name = 'HARPO'
THEN 'GROUCHO'
ELSE 'MUCHO GROUCHO'
END
WHERE actor_id = 172;

--5a

SHOW CREATE TABLE address

--6a 

select s.first_name, s.last_name, ad.address
from staff s
	left join address ad on s.address_id = ad.address_id
group by 1,2,3

--6b

select s.first_name, s.last_name, sum(p.amount) as Amount_Rung_Up
from staff s
	left join payment p on s.staff_id = p.staff_id
group by 1,2

--6c

select f.title, count(fa.actor_id) as actors
from film_actor as fa
	left join film f on f.film_id = fa.film_id
group by f.title
order by Actors desc

--6d

SELECT title, COUNT(inventory_id) AS num_copy
from film
	left join inventory using ( film_id)
WHERE title = 'Hunchback Impossible'
GROUP BY title

--6e

 SELECT c.first_name, c.last_name, sum(p.amount) as Total_Paid
from payment as p
	left join customer As c on p.customer_id = c.customer_id
group by c.customer_id
order by c.last_name

--7a

select title
from film
where title like 'K%'
or title like 'Q%'
and language_id IN
(
select language_id
from language
where name = 'English'
)

--7b

select first_name, last_name
from actor
where actor_id IN
(
select actor_id
from film_actor
where film_id =
(
select film_id
from film
WHERE title = "Alone Trip"
)
)
 

--7c

select first_name, last_name,email, country
from customer c,
	join address a on c.address_id = a.address_id
	join city ci on a.city_id = ci.city_id
	join country cnt on ci.country_id = cnt.country_id
where ctr.country = 'canada'

--7d

select title, c.name
from film f 
	join film,category fc ON f.film_id = fc.film_id
	join category c on c.category_id = fc.category_id_
where name = 'family'

--7e

select title, count(title) as 'Rentals'
from film
	join inventory on film.film_id = inventory.film_id
	join rental on inventory.inventory_id = rental.inventory_id
group by title
order by rentals desc

--7f

select s.store_id, sum(amount) as Gross
from payment p
	join rental r on p.rental_id = r.rental_id
	join inventory i on  i.inventory_id = r.inventory_id
	join store s on s.store_id = i.store_id
group by s.store_id

--7g
select store_id, city, country
from store s,
	join address a on s.address_id = a.address_id

--7h
select name as fc.Genre, concat('$',format(sum(p.amount),2)) as Gross_Revenue 
from category c
	join film_category fc ON c.category_id=fc.category_id
	join inventory i ON fc.film_id=i.film_id
	join rental r ON i.inventory_id=r.inventory_id
	join payment p ON r.rental_id=p.rental_id
group by Genre
order by sum(amount) des
LIMIT 5

--8a
create view as top_five_genres as
select sum(amount) AS tot_sales, c.name as Genre
from payment p
	JOIN rental r on p.rental_id = r.rental_id
	JOIN inventory i on r.inventory_id = i.inventory_id
	JOIN film_category fc on i.film_id = fc.film_id
    JOIN category c on (fc.category_id = c.category_id)
group by c.name
order by sum(amount) desc
LIMIT 5

--8b

select * from top_five_genres

--8c

drop view top_five_genres


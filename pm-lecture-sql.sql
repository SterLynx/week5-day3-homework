select *
from film_actor fa
join actor a
on a.actor_id = fa.actor_id;

select *
from film_actor fa
join film f
on fa.film_id = f.film_id;

select *
from film_actor fa
join actor a
on a.actor_id = fa.actor_id
join film f
on fa.film_id = f.film_id;

select * -- Determines what data is shown
from customer c
join rental r
on c.customer_id = r.customer_id
join inventory i
on r.inventory_id = i.inventory_id
join film f 
on f.film_id = i.film_id;


-- Exercise: show all the customer's first and last names whose last name starts with an R
-- and then order by the film title give results 10-20
select c.first_name, c.last_name, f.title
from customer c
join rental r
on c.customer_id = r.customer_id
join inventory i
on r.inventory_id = i.inventory_id
join film f 
on f.film_id = i.film_id
where last_name like 'R%'
order by f.title
offset 10
limit 10;

-- Exercise getting how many films have exactly 12 actors

select film_id, count(*)
from film_actor
group by film_id
having count(*) = 12;

select *
from film
where film_id in (529,802,34,892,414,517);

select *
from film
	where film_id in (
	select film_id
	from film_actor
	group by film_id
	having count(*) = 12
);

-- What employee sold the most rentals (rental table)


-- Subqueries are enclosed by parentheses
select *
from staff
where staff_id = (select staff_id
from rental
group by staff_id
order by count(*) desc
limit 1);

select *
from staff
where staff_id = 1;

-- Subqueries with the FROM clause
-- Subquery in a FROM must have an alias* you have to name it

-- Ex. Find the average number of rentals per customer
select customer_id, count(*) as number_of_rentals
from rental
group by customer_id;

select AVG(number_of_rentals)
from (
	select customer_id, count(*) as number_of_rentals
	from rental
	group by customer_id
) as customer_rental_totals;


-- Using Subqueries in DML Statements

alter table customer
add column loyalty_member BOOLEAN;

select * from customer;

-- Update the customer table to make every customer who
-- has at least 25 rentals a loyalty member

select customer_id, count(*)
from rental
group by customer_id
having count(*) >= 25
order by count desc;

update customer
set loyalty_member = true
where customer_id in (
	select customer_id
	from rental
	group by customer_id
	having count(*) >= 25
);

select *
from customer;


select *
from customer
where customer_id in
	(select customer_id
	from rental
	group by customer_id
	having count(*) >(
		select AVG(number_of_rentals)
	from (
		select customer_id, count(*) as number_of_rentals
		from rental
		group by customer_id
	) as customer_rental_totals
	));

select *
from customer


--Question 1
-- Join address and customer
select first_name, last_name, a.district
from customer c
join address a
on a.address_id = c.address_id
where district = 'Texas';

--first_name|last_name|district|
------------+---------+--------+
--Jennifer  |Davis    |Texas   |
--Kim       |Cruz     |Texas   |
--Richard   |Mccrary  |Texas   |
--Bryan     |Hardison |Texas   |
--Ian       |Still    |Texas   |


-- Question 2
select first_name, last_name, amount
from customer c
left join payment p
on c.customer_id = p.customer_id
where amount > 7;

--first_name|last_name   |amount|
------------+------------+------+
--Peter     |Menard      |  7.99|
--Peter     |Menard      |  7.99|
--Peter     |Menard      |  7.99|
--Douglas   |Graf        |  8.99|
--Ryan      |Salisbury   |  8.99|
--Ryan      |Salisbury   |  8.99|
--Ryan      |Salisbury   |  7.99|
--Roger     |Quintanilla |  8.99|
--Joe       |Gilliland   |  8.99|
-- ...


-- Question 3
--select first_name, last_name
--from customer;

--select customer_id, amount
--from payment
--where amount > 175;

select c.first_name, c.last_name, SUM(p.amount) as total_amount_paid
from customer c
join payment p on c.customer_id = p.customer_id
group by c.customer_id, c.first_name, c.last_name
having SUM(p.amount) > 175;




--customer_id|store_id|first_name|last_name|email                            |address_id|activebool|create_date|last_update            |active|
-------------+--------+----------+---------+---------------------------------+----------+----------+-----------+-----------------------+------+
--        137|       2|Rhonda    |Kennedy  |rhonda.kennedy@sakilacustomer.org|       141|true      | 2006-02-14|2013-05-26 14:49:45.738|     1|
--        144|       1|Clara     |Shaw     |clara.shaw@sakilacustomer.org    |       148|true      | 2006-02-14|2013-05-26 14:49:45.738|     1|
--        148|       1|Eleanor   |Hunt     |eleanor.hunt@sakilacustomer.org  |       152|true      | 2006-02-14|2013-05-26 14:49:45.738|     1|
--        178|       2|Marion    |Snyder   |marion.snyder@sakilacustomer.org |       182|true      | 2006-02-14|2013-05-26 14:49:45.738|     1|
--        459|       1|Tommy     |Collazo  |tommy.collazo@sakilacustomer.org |       464|true      | 2006-02-14|2013-05-26 14:49:45.738|     1|
--        526|       2|Karl      |Seal     |karl.seal@sakilacustomer.org     |       532|true      | 2006-02-14|2013-05-26 14:49:45.738|     1|


-- Question 4

select c.first_name, c.last_name, a.district, ci.city, co.country
from customer c
join address a on c.address_id = a.address_id
join city ci on a.city_id = ci.city_id
join country co on ci.country_id = co.country_id
where co.country = 'Argentina'
group by c.first_name, c.last_name, a.district, ci.city, co.country;


--first_name|last_name|district    |city                |country  |
------------+---------+------------+--------------------+---------+
--Willie    |Markham  |Buenos Aires|Almirante Brown     |Argentina|
--Jordan    |Archuleta|Buenos Aires|Avellaneda          |Argentina|
--Jason     |Morrissey|Buenos Aires|Baha Blanca         |Argentina|
--Kimberly  |Lee      |Crdoba      |Crdoba              |Argentina|
--Micheal   |Forman   |Buenos Aires|Escobar             |Argentina|
--Darryl    |Ashcraft |Buenos Aires|Ezeiza              |Argentina|
--Julia     |Flores   |Buenos Aires|La Plata            |Argentina|
--Florence  |Woods    |Buenos Aires|Merlo               |Argentina|
--Perry     |Swafford |Buenos Aires|Quilmes             |Argentina|
--Lydia     |Burke    |Tucumn      |San Miguel de Tucumn|Argentina|
--Eric      |Robert   |Santa F     |Santa F             |Argentina|
--Leonard   |Schofield|Buenos Aires|Tandil              |Argentina|
--Willie    |Howell   |Buenos Aires|Vicente Lpez        |Argentina|


-- Question 5

-- Select from film_category and list number of movies by name of category, use category_id

select c.category_id, c."name", count(fc.category_id) as num_movies_in_cat
from category c 
join film_category fc 
on c.category_id = fc.category_id
group by c.category_id
order by num_movies_in_cat desc ;


--category_id|name       |num_movies_in_cat|
-------------+-----------+-----------------+
--         15|Sports     |               74|
--          9|Foreign    |               73|
--          8|Family     |               69|
--          6|Documentary|               68|
--          2|Animation  |               66|
--          1|Action     |               64|
--         13|New        |               63|
--          7|Drama      |               62|
--         14|Sci-Fi     |               61|
--         10|Games      |               61|
--          3|Children   |               60|
--          5|Comedy     |               58|
--          4|Classics   |               57|
--         16|Travel     |               57|
--         11|Horror     |               56|
--         12|Music      |               51|



-- Question 6
select film.film_id, film.title, count(*) as num_actors
from film
join film_actor 
on film.film_id = film_actor.film_id 
group by film.film_id 
having count(*) = (
    select max(num_actors)
    from (
        select film_id, count(*) as num_actors
        from film_actor 
        group by film_id 
        order by count(*) desc
    ));


--film_id|title           |num_actors|
---------+----------------+----------+
--    508|Lambs Cincinatti|        15|


-- Question 7 

select a.actor_id, a.first_name, a.last_name, count(fa.actor_id) as num_films 
from actor a
join film_actor fa
on a.actor_id = fa.actor_id 
group by a.actor_id 
order by num_films ASC;

--actor_id|first_name|last_name|num_films|
----------+----------+---------+---------+
--     148|Emily     |Dee      |       14|


-- Question 8

select country, count(city_id)
from country c 
join city c2 
on c.country_id = c2.country_id 
group by country 
order by count(city_id) desc;


--country_id|country                              |num_cities|
------------+-------------------------------------+----------+
--        44|India                                |        60|
--        23|China                                |        53|
--       103|United States                        |        35|


-- Question 9

select a.actor_id, a.first_name, a.last_name, count(fa.film_id)
from actor a 
join film_actor fa 
on a.actor_id = fa.actor_id 
group by a.actor_id 
having count(*) between 20 and 25;

--actor_id|first_name |last_name  |count|
----------+-----------+-----------+-----+
--     114|Morgan     |Mcdormand  |   25|
--     153|Minnie     |Kilmer     |   20|
--      32|Tim        |Hackman    |   23|
--     132|Adam       |Hopper     |   22|
--      46|Parker     |Goldberg   |   24|
--     163|Christopher|West       |   21|
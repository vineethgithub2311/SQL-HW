use sakila;

select * from actor;

-- 1A

select first_name, last_name
from actor;

-- 1B

select upper(concat(first_name,' ' ,last_name)) as 'actor_name'
from actor;

-- 2A

select first_name, last_name, actor_id from actor
where first_name = 'Joe';

-- 2B

select first_name, last_name, actor_id from actor
where last_name like '%GEN%';

-- 2C

select first_name, last_name, actor_id from actor
where last_name like '%LI%'
order by last_name, first_name;

-- 2D

select country, country_id from country
where country in ('Afghanistan', 'Bangladesh', 'China')
;


-- 3A

alter table actor add column middle_name varchar(30) after first_name;
select * from actor;

-- 3B

alter table actor modify column middle_name blob;

-- 3C

alter table actor drop column middle_name;

-- 4A

select last_name, count(last_name) as 'last_name_count' from actor
group by last_name;

-- 4B

select last_name, count(last_name) as 'last_name_count' from actor
group by last_name
having last_name_count >= 2;

-- 4C

update actor
set first_name = "HARPO"
where first_name = "GROUCHO"
and last_name = "WILLIAMS";

-- 4D

update actor
set first_name = 
-- case
	-- when first_name = 'HARPO'
		-- then 'GROUCHO'
	else 'MUCHO GROUCHO'
-- end
where actor_id = 172;

-- 5A

show create table address;

-- 6A

select a.first_name, a.last_name, b.address from staff a
inner join address b
on (a.address_id = b.address_id);
  
-- 6B

select a.first_name, a.last_name, sum(b.amount) from staff as a
inner join payment as b
on b.staff_id = a.staff_id
where month(b.payment_date) = 08 and year(b.payment_date) = 2005
group by a.staff_id;


-- 6C

select b.title, count(a.actor_id) as 'Actors' from film_actor as a
inner join film as b
on b.film_id = a.film_id
group by b.title;

-- 6D
select * from film;
select * from inventory;
select title, count(inventory_id) as 'total copies' from film
inner join inventory
using (film_id)
where title = 'Hunchback Impossible'
group by title;

-- 6E

select cs.first_name, cs.last_name, sum(py.amount) as 'Total Paid Amount' from payment as py  join customer as cs
on py.customer_id = cs.customer_id
group by cs.customer_id
order by cs.last_name;

-- 7A

select title from  film
where title like 'K%'
or  title LIKE 'Q%'
and language_id IN
  (
   select language_id from language
   where name = 'English'
  );

-- 7B

select first_name, last_name from actor 
 where actor_id in 
  (select actor_id from film_actor
    where film_id = 
    (select film_id from film
       where title = 'Alone Trip')
   );

-- 7C

select first_name, last_name, email, country from customer cs 
join  address ad on (cs.address_id = ad.address_id)
join city ct on (ad.city_id = ct.city_id)
join country cn on (ct.country_id = cn.country_id)
where cn.country = 'canada';

-- 7D

select title, cs.name from film fm
join film_category fc on (fm.film_id = fc.film_id)
join category cs on (cs.category_id = fc.category_id)
where name = 'family';

-- 7E

select title, count(title) as 'Rentals' from film fm
join inventory inv on (fm.film_id = inv.film_id)
join rental rn on (inv.inventory_id = rn.inventory_id)
group by title
order by rentals desc;

-- 7F

select st.store_id, sum(amount) as Gross from payment py
join rental rn on (py.rental_id = rn.rental_id)
join inventory inv on (inv.inventory_id = rn.inventory_id)
join store st on (st.store_id = inv.store_id)
group by st.store_id;

-- 1. Create a Stored Procedure that will insert a new film into the film table with the
--following arguments: title, description, release_year, language_id, rental_duration,
--rental_rate, length, replace_cost, rating

select * 
	from film
	order by film_id desc
	limit 5;

create or replace procedure add_film(
	new_title varchar(225), 
	new_description text, 
	new_release_year year, 
	new_language_id int2, 
	new_rental_duration int2, 
	new_rental_rate numeric(4, 2), 
	new_length int2, 
	new_replacement_cost numeric(5, 2), 
	new_rating mpaa_rating
)
language plpgsql
as $$
begin
	insert into film(
		title, 
		description, 
		release_year, 
		language_id, 
		rental_duration, 
		rental_rate, 
		length, 
		replacement_cost, 
		rating
	) values (
		new_title, 
		new_description, 
		new_release_year, 
		new_language_id, 
		new_rental_duration, 
		new_rental_rate, 
		new_length, 
		new_replacement_cost, 
		new_rating
	);
end;
$$;

call add_film('X'::varchar, 'X'::text, 2023::year, 1::int2, 1::int2, 3.88::numeric, 77::int2, 3.88::numeric, 'R'::mpaa_rating);

select * 
	from film
	order by film_id desc
	limit 5;

--------------------------------------------------------------------------------------------------------------------------------

--2. Create a Stored Function that will take in a category_id and return the number of
--films in that category

create or replace function films_in_category(id integer)
returns integer
language plpgsql
as $$
	declare films_amount integer;
begin
	select count(*) into films_amount
	from film_category
	where category_id = id
	group by category_id;
	return films_amount;
end;
$$;

select category_id, count(*)
from film_category
group by category_id
limit 1;

select films_in_category(4);


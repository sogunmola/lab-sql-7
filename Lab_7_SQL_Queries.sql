/* LAB 7
*/
-- 1) Which last names are not repeated?
USE sakila;
SELECT last_name, COUNT(last_name) AS last_name_count
FROM actor
GROUP BY last_name
HAVING last_name_count = 1;

-- 2) Which last names appear more than once?
SELECT last_name, COUNT(last_name) AS last_name_count
FROM actor
GROUP BY last_name
HAVING last_name_count > 1
ORDER BY last_name_count DESC;

-- 3) Rentals by employee 
SELECT staff_id, COUNT(rental_id) AS Num_of_rentals
FROM rental
GROUP BY staff_id
ORDER BY Num_of_rentals DESC;

-- 4) Films by year.
SELECT release_year, COUNT(title) AS film_per_year
FROM film
GROUP BY release_year
ORDER BY film_per_year DESC;

-- 5) Films by rating
SELECT rating, COUNT(title) AS Nu_of_films
FROM film
GROUP BY rating
ORDER BY Nu_of_films DESC;

-- 6) Mean length by rating.
SELECT rating, round(avg(length),2) AS mean_length
FROM film
GROUP BY rating
ORDER BY mean_length DESC;

-- 7) Which kind of movies (rating) have a mean duration of more than two hours?
SELECT rating, round(avg(length),2) AS mean_length
FROM film
GROUP BY rating
-- Two hours being 120
HAVING round(mean_length,2) > 120;

-- 8) List movies and add information of average duration for their rating and original language.
SELECT title, original_language_id, rating,
avg(length) OVER (PARTITION BY rating order by original_language_id) AS avg_by_rating
FROM film;

-- 9) Which rentals are longer than expected?
SELECT * FROM (SELECT inventory_id, rental_id, datediff(return_date, rental_date) rental_duration,
avg(datediff(return_date, rental_date)) over (partition by inventory_id) average from rental) as smth
where rental_duration > average
;

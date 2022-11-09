-- Inner Join on the Actor Table and Film Actor Table
SELECT actor.actor_id, first_name, last_name, film_id
FROM film_actor
INNER JOIN actor
ON actor.actor_id = film_actor.actor_id;

-- Left Join on the actor and film_actor table
--Table A -> film_actor
--Table B -> actor
SELECT actor.actor_id, first_name, last_name, film_id
FROM film_actor
LEFT JOIN actor
ON actor.actor_id = film_actor.actor_id
WHERE first_name IS NULL and last_name IS NULL;
--Everybody has a first and last name
SELECT actor.actor_id, first_name, last_name, film_id
FROM film_actor
LEFT JOIN actor
ON actor.actor_id = film_actor.actor_id;

-- Full Join that will produce information about a customer
-- From the country of Angola
SELECT customer.first_name, customer.last_name, customer.email, country
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
FULL JOIN city
ON address.city_id = city.city_id
FULL JOIN country
ON city.country_id = country.country_id
WHERE country = 'Angola';

SELECT * 
FROM country;

-- Find all customers who live in the same state as you!
SELECT customer.first_name, customer.last_name, customer.email, district
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Florida';

-- Find all customers who live in the same state as you
SELECT customer.first_name, customer.last_name, customer.email, district
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Illinois';

SELECT customer.first_name, customer.last_name, address, district
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Georgia';


SELECT customer.first_name, customer.last_name, customer.email, city.city, address.district, country.country
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
FULL JOIN city
ON address.city_id = city.city_id
FULL JOIN country
ON city.country_id = country.country_id
WHERE district = 'Massachusetts';

SELECT customer.first_name, customer.last_name, address, district
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
FULL JOIN city
ON address.city_id = city.city_id
WHERE district = 'California';

--SubQueries
SELECT *
FROM customer;

-- Two queries split apart which become one united query to vanquish evil
-- Find a customer_id that has a total payment amount greater than 175
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175
ORDER BY SUM(amount) DESC;

-- Subquery to find the first and last names of the customers
-- with a total payment amount > 175
SELECT *
FROM customer;

SELECT store_id, first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
)
GROUP BY store_id, first_name, last_name;

-- Finding all films with a language of English
SELECT *
FROM film;


SELECT * 
FROM language;

SELECT * 
FROM film
WHERE language_id IN (
	SELECT language_id
	FROM language
	WHERE name = 'English'
);

SELECT *
FROM film
WHERE language_id IN(
	SELECT language_id
	FROM language
	WHERE name = 'Italian'
);

SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id IN (
	SELECT actor_id
	FROM film_actor
	WHERE film_id IN(
		SELECT film_id
		FROM film
		WHERE title = 'Roof Champion'
		
	)
);

-- ^^ sort of... useless subquery

SELECT actor.first_name, actor.last_name, film_actor.actor_id, film.title
FROM actor
FULL JOIN film_actor
ON actor.actor_id = film_actor.actor_id
FULL JOIN film
ON film_actor.film_id = film.film_id;

SELECT *
FROM actor;

SELECT * 
FROM film_actor;


-- Question 1
SELECT customer.first_name, customer.last_name, address, district
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

-- Question 2
SELECT customer.first_name, customer.last_name, amount, payment_id
FROM customer
FULL JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;

-- Question 3
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
);

-- Question 4
SELECT customer.first_name, customer.last_name, customer.email, city.city
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
FULL JOIN city
ON address.city_id = city.city_id
WHERE city = 'Nepal';

-- Question 5
SELECT staff.staff_id
FROM staff
FULL JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id
ORDER BY staff.staff_id DESC;

-- Question 6
SELECT inventory.film_id, film.rating
FROM inventory
FULL JOIN film
ON inventory.film_id = film.film_id
GROUP BY inventory.film_id
ORDER BY film.rating;

-- Question 7
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING payment.amount > 6.99
);

-- Question 8
SELECT rental_id
FROM rental
WHERE return_date IS NULL
GROUP BY rental_id;
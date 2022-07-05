-- LIMIT Operator
	-- Select all columns from the payment table and only include the first 20 rows.
	SELECT * FROM payment LIMIT 20;
    
    -- Select the payment date and amount columns from the payment table for rows where the payment amount is greater than 5, and only select rows whose zero-based index in the result set is between 1000-2000.
    -- needed to only grab a 1000 pieces of information staring at the 1000th entry
    SHOW EXTENDED INDEX FROM payment;
	SELECT payment_date, amount FROM payment WHERE amount > 5 LIMIT 1000 OFFSET 999;
    
    -- Select all columns from the customer table, limiting results to those where the zero-based index is between 101-200.
	SELECT * FROM customer LIMIT 99 OFFSET 100;
    
-- ORDER BY statement
	-- Select all columns from the film table and order rows by the length field in ascending order.
	SELECT * FROM film ORDER BY length ASC;
    
	-- Select all distinct ratings from the film table ordered by rating in descending order.
	SELECT DISTINCT rating FROM film ORDER BY rating DESC;
    
    -- Select the payment date and amount columns from the payment table for the first 20 payments ordered by payment amount in descending order.
	SELECT payment_date, amount FROM payment ORDER BY amount DESC LIMIT 20;
    
    -- Select the title, description, special features, length, and rental duration columns from the film table for the first 10 films with behind the scenes footage, under 2 hours in length and a rental duration between 5 and 7 days, ordered by length in descending order.
	SELECT title, description, special_features, length, rental_duration 
    FROM film 
    WHERE 'Behind the Scenes' IN (special_features)
		AND length < 120 
        AND rental_duration BETWEEN 5 AND 7
    ORDER BY length DESC
    LIMIT 10;
describe film;    

-- JOINs
	-- Select customer first_name/last_name and actor first_name/last_name columns from performing a left join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
    -- Label customer first_name/last_name columns as customer_first_name/customer_last_name
	-- Label actor first_name/last_name columns in a similar fashion.
	-- returns correct number of records: 620
    -- *the wording of the problem was super confusing. with these start by thinking of the FROM as the first BETWEEEN marker with the join as the stop
	SELECT customer.first_name as customer_first_name, customer.last_name as customer_last_name, 
			actor.first_name as actor_first_name, actor.last_name as actor_last_name
    FROM customer
    LEFT OUTER JOIN actor
    ON customer.last_name = actor.last_name;
    
	-- Select the customer first_name/last_name and actor first_name/last_name columns from performing a /right join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
	-- returns correct number of records: 200
	SELECT customer.first_name, customer.last_name, actor.first_name, actor.last_name 
    FROM customer
    RIGHT JOIN actor
    ON customer.last_name = actor.last_name;
    
	-- Select the customer first_name/last_name and actor first_name/last_name columns from performing an inner join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
	-- returns correct number of records: 43
	SELECT customer.first_name, customer.last_name, actor.first_name, actor.last_name
    FROM customer
    INNER JOIN actor
    ON customer.last_name = actor.last_name;
    
	-- Select the city name and country name columns from the city table, performing a left join with the country table to get the country name column.
	-- Returns correct records: 600
    -- *needed to use DESCRIBE in order to verify in common columns
    DESCRIBE city;
    DESCRIBE country;
    SELECT city.city, country.country
    FROM city
    LEFT JOIN country
    ON city.country_id = country.country_id;
    
	-- Select the title, description, release year, and language name columns from the film table, performing a left join with the language table to get the "language" column.
	-- Label the language.name column as "language"
	-- Returns 1000 rows
    DESCRIBE film;
    SELECT film.title, film.description, film.release_year, language.name as language
    FROM film
    LEFT JOIN language 
    ON film.language_id = language.language_id;
    
	-- Select the first_name, last_name, address, address2, city name, district, and postal code columns from the staff table, performing 2 left joins with the address table then the city table to get the address and city related columns.
-- returns correct number of rows: 2
Describe address;
	SELECT staff.first_name, staff.last_name, address.address, address.address2, city.city, address.postal_code
    FROM staff
    LEFT JOIN address
    ON staff.address_id = address.address_id
    LEFT JOIN city
    ON address.city_id = city.city_id;
    

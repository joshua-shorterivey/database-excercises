show databases;
USE sakila;

-- 1 show the databases, and USE sakila. I did that before thinking to right comments. 
-- 2 show tables within database. helps to get an idea of what db contains
	SHOW TABLES; 

/*	The questions are re-labled as as SECTIONS with their 
	subheadings as separated comments. The answers to the questions will be inline 
    with the first tab over. not sure if there is a better way to say that
    I tried to use the * for future reference to myself for things I returned, had
    to look up, or as a general heads-up. */

/* Section 1 : SELECT STATEMENTS */
-- Select all columns from the actor table. *returned 200 rows
	SELECT * FROM actor;
    
-- Select only the last_name column from the actor table.
	SELECT last_name FROM actor;
    
-- Select only the film_id, title, and release_year columns from the film table. *retured 1000 rows
	SELECT film_id, title, release_year FROM film;

/* SECTION 2: DISTINCT operator */
-- Select all distinct (different) last names from the actor table. * returned 121 rows
	SELECT DISTINCT last_name FROM actor;
-- Select all distinct (different) postal codes (*postal_code) from the address table.
	SELECT DISTINCT postal_code FROM address;
-- Select all distinct (different) ratings from the film table. *returned 5 rows
	SELECT DISTINCT rating FROM film;

/* SECTION 3: WHERE clause */

-- Select the title, description, rating, movie length columns from the films table that last 3 hours or longer. *returned 46 rows
	SELECT title, description, rating, length FROM film WHERE length >= 180;
    
-- Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
-- * from documentation: mySQL recognizes DATE values (as a string) in formats 'YYYY-MM-DD' or 'YY-MM-DD'. had to change it.
-- * returned 1000. 1000 is the limit
	SELECT payment_id, amount, payment_date FROM payment WHERE payment_date >= '2005-05-27';
    
-- Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.
-- *didn't use BETWEEN because i wanted to capture 0000 ~ 2359. returned 167 rows with either option. 
    SELECT payment_id, amount, payment_date FROM payment WHERE payment_date > 20050527 AND payment_date < 20050528;

-- Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.
-- *from documentation: use LEFT() and RIGHT() as str functions to return needed characters. research if index useable.
-- *returned 11 rows
	SELECT * FROM customer WHERE LEFT(last_name, 1) = 'S' AND RIGHT(first_name, 1) = 'N';
    
-- Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
-- *used active = 0 as stand in for inactive. had to make assumption. returned 2 rows
	SELECT * FROM customer WHERE active = 0 AND LEFT(last_name, 1) = 'M';
    
-- Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.
-- *used DESCRIBE to find primary key for category table.
-- *created list(bucket?) of values to check first character of name field against
    DESCRIBE category;
    SELECT * FROM category
    WHERE category_id > 4 AND
    LEFT(name, 1) IN ('C', 'S', 'T');
    
-- Select all columns minus the password column from the staff table for rows that contain a password.
-- *want to find better way to do this. returned 1 value 
	DESCRIBE staff;
    SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update as desired_columns FROM staff
    WHERE password IS NOT NULL;
    
-- Select all columns minus the password column from the staff table for rows that do not contain a password.
    SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update as desired_columns FROM staff
    WHERE password IS NULL;
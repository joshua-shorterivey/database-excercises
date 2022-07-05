SHOW databases;
USE sakila; 
/*	The questions are re-labled as as SECTIONS with their 
	subheadings as separated comments. The answers to the questions will be inline 
    with the first tab over. not sure if there is a better way to say that
    I tried to use the * for future reference to myself for things I returned, had
    to look up, or as a general heads-up. */

/* IN operator */
-- Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.
	-- needed to describe and view some rows first to figure out which column would contain the values needed to check against.
	-- *returned 24 rows
    DESCRIBE address;
	SELECT * FROM address LIMIT 10;
	SELECT phone, district FROM address WHERE district IN  ('California', 'England', 'Taipei', 'West Java'); 

-- Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. (Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.)
	-- *documentation: DATA_FORMAT to convert the payment_date for easy comparison. %Y  (four digit year), %m (month), %d (day) used to create formatting
	-- 	used another list comparison. returned 321 rows
    SELECT payment_id, amount, payment_date FROM payment WHERE DATE_FORMAT(payment_date, '%Y%m%d') IN ('200505252', '20050527', '20050529');
	SELECT * FROM payment LIMIT 5;
    
-- Select all columns from the film table for films rated G, PG-13 or NC-17.
	-- Used another bucket. returned 611
    SELECT DISTINCT rating FROM film;
	SELECT * FROM film WHERE rating IN ('G', 'PG-13', 'NC-17' );
 
/* BETWEEN operator */
-- Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
	-- needed to describe the payment table in order to verify the data type of the payment_date column prior to comparison. 
	-- ordered by payment_date column just for quick verification
    DESCRIBE payment;
    SELECT * FROM payment WHERE payment_date BETWEEN '2005-05-25 00:00:00' AND '2005-05-25 23:59:59' ORDER BY payment_date ASC;

-- Select the film_id, title, and descrition columns from the film table for films where the length of the description is between 100 and 120.
	-- *documentation: CHAR_LENGTH to get the length of string data types
    SELECT film_id, title, description FROM film WHERE CHAR_LENGTH(description) BETWEEN 100 AND 120;

/* LIKE operator */
-- Select the following columns from the film table for rows where the description begins with "A Thoughtful".
	-- returned 45 rows
	SELECT * FROM film WHERE description LIKE 'A Thoughtful%';
    
-- Select the following columns from the film table for rows where the description ends with the word "Boat".
	-- place wildcard directly in front of Boat in order to capture terms like U-Boat.
    SELECT * FROM film WHERE description LIKE '%Boat';
    
-- Select the following columns from the film table where the description contains the word "Database" and the length of the film is greater than 3 hours.
	SELECT * FROM film WHERE description like '%database%' AND length > 180;
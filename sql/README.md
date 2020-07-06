# SQL Test Assignment

Attached is a mysqldump of a database to be used during the test. Once finished please dump your altered version of the database and reply to this email with it attached. 

Below are the questions for this test. Please enter a full, complete, working SQL statement under each question. We do not want the answer to the question. We want the SQL command to derive the answer. We will copy/paste these commands to test the validity of the answer.

**Example:**

_Q. Select all users_

- Please return at least first_name and last_name

SELECT first_name, last_name FROM users;


------

**— Test Starts Here —**

1. Select users whose id is either 3,2 or 4
- Please return at least: all user fields

SELECT * FROM users WHERE id IN(3,2,4);

2. Count how many basic and premium listings each active user has
- Please return at least: first_name, last_name, basic, premium

SELECT
  users.first_name,
  users.last_name,
  SUM(IF(listings.status=2, 1, 0)) AS basic,
  SUM(IF(listings.status=3, 1, 0)) AS premium
FROM users
  JOIN listings ON users.id=listings.user_id
WHERE users.status=2
GROUP BY users.id;

3. Show the same count as before but only if they have at least ONE premium listing
- Please return at least: first_name, last_name, basic, premium

SELECT
  users.first_name,
  users.last_name,
  SUM(IF(listings.status=2, 1, 0)) AS basic,
  SUM(IF(listings.status=3, 1, 0)) AS premium
FROM users
  JOIN listings ON users.id=listings.user_id
WHERE users.status=2
GROUP BY users.id
HAVING premium>0;

4. How much revenue has each active vendor made in 2013
- Please return at least: first_name, last_name, currency, revenue

SELECT
  users.first_name,
  users.last_name,
  clicks.currency,
  SUM(clicks.price) AS revenue
FROM users
  JOIN listings ON users.id=listings.user_id
  JOIN clicks ON listings.id=clicks.listing_id
WHERE YEAR(clicks.created)=2013
GROUP BY users.id, clicks.currency;


5. Insert a new click for listing id 3, at $4.00
- Find out the id of this new click. Please return at least: id

INSERT INTO
  clicks(listing_id, price, created)
VALUES(3, 4.0, NOW());
SELECT LAST_INSERT_ID() as id;

6. Show listings that have not received a click in 2013
- Please return at least: listing_name

SELECT
  listings.name AS listing_name
FROM listings
WHERE id NOT IN(
  SELECT
    listing_id
  FROM clicks
  WHERE YEAR(clicks.created)=2013
);

7. For each year show number of listings clicked and number of vendors who owned these listings
- Please return at least: date, total_listings_clicked, total_vendors_affected

SELECT
  YEAR(clicks.created) AS date,
  COUNT(clicks.listing_id) AS total_listings_clicked,
  COUNT(DISTINCT(listings.user_id)) AS total_vendors_affected
FROM clicks
  JOIN listings ON clicks.listing_id=listings.id
GROUP BY YEAR(clicks.created);

8. Return a comma separated string of listing names for all active vendors
- Please return at least: first_name, last_name, listing_names

SELECT
  users.first_name,
  users.last_name,
  GROUP_CONCAT(listings.name) AS listing_names
FROM users
  JOIN listings ON users.id=listings.user_id
WHERE users.status=2
GROUP BY users.id;
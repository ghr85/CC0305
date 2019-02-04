--Codeclan Week 03 Day 05 Homework
-- Codeclan Cinema
-- Relational Databases and Ruby
-- Class

--Codeclan Week 03 Day 04
-- Pair Programming
-- IMDB Apllication

DROP TABLE screenings; -- remember order is important here
DROP TABLE tickets;
DROP TABLE customers;
DROP TABLE films;




CREATE TABLE films(
  title VARCHAR(255),
  price INT4,
  id SERIAL4 PRIMARY KEY
);

CREATE TABLE customers(
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  funds INT4,
  id SERIAL4 PRIMARY KEY
);

CREATE TABLE tickets(
  film_id INT4 REFERENCES films(id) ON DELETE CASCADE,
  customer_id INT4 REFERENCES customers(id) ON DELETE CASCADE,
  id SERIAL4 PRIMARY KEY
);

CREATE TABLE screenings(
  film_id INT4 REFERENCES films(id) ON DELETE CASCADE,
  showtime VARCHAR(255),
  capacity INT4,
  ticket_id INT4 REFERENCES tickets(id) ON DELETE CASCADE,
  id SERIAL4 PRIMARY KEY
);

INSERT INTO films (title,price) VALUES ('Halloween', 10);
INSERT INTO films (title,price) VALUES ('Black Panther', 8);
INSERT INTO films (title,price) VALUES ('Titanic', 4);
INSERT INTO films (title,price) VALUES ('Apocalypse Now',4);
INSERT INTO films (title,price) VALUES ('La La Land', 2);


INSERT INTO customers (first_name,last_name,funds) VALUES ('Jack','Nicholson',20);
INSERT INTO customers (first_name,last_name,funds) VALUES ('Bette','Middler',20);
INSERT INTO customers (first_name,last_name,funds) VALUES ('Leo','DiCaprio',40);
INSERT INTO customers (first_name,last_name,funds) VALUES ('Tom','Jones',5);
INSERT INTO customers (first_name,last_name,funds) VALUES ('Scarlett','Johansen',2);

INSERT INTO tickets (film_id,customer_id) VALUES (2,1);
INSERT INTO tickets (film_id,customer_id) VALUES (5,2);
INSERT INTO tickets (film_id,customer_id) VALUES (5,2);
INSERT INTO tickets (film_id,customer_id) VALUES (5,2);
INSERT INTO tickets (film_id,customer_id) VALUES (2,3);
INSERT INTO tickets (film_id,customer_id) VALUES (1,3);
INSERT INTO tickets (film_id,customer_id) VALUES (3,4);
INSERT INTO tickets (film_id,customer_id) VALUES (4,3);

INSERT INTO screenings (film_id,showtime,capacity,ticket_id) VALUES ('4','13:00', 3,8);
INSERT INTO screenings (film_id,showtime,capacity,ticket_id) VALUES ('3','14:00', 4,7);
INSERT INTO screenings (film_id,showtime,capacity,ticket_id) VALUES ('1','15:00', 4,6);
INSERT INTO screenings (film_id,showtime,capacity,ticket_id) VALUES ('2','16:00', 2,1);
INSERT INTO screenings (film_id,showtime,capacity,ticket_id) VALUES ('2','19:00', 2,5);
INSERT INTO screenings (film_id,showtime,capacity,ticket_id) VALUES ('2','21:00', 3,7);
INSERT INTO screenings (film_id,showtime,capacity,ticket_id) VALUES ('1','16:00', 4,6);
INSERT INTO screenings (film_id,showtime,capacity,ticket_id) VALUES ('1','19:00', 1,6);
INSERT INTO screenings (film_id,showtime,capacity,ticket_id) VALUES ('3','19:00', 2,7);
INSERT INTO screenings (film_id,showtime,capacity,ticket_id) VALUES ('3','21:00', 3,7);
INSERT INTO screenings (film_id,showtime,capacity,ticket_id) VALUES ('4','19:00', 4,8);

-- DROP TABLE tickets;
DROP TABLE movies;
DROP TABLE customers;

CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  funds INT
);

CREATE TABLE movies (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    price INT
);

CREATE TABLE tickets (
  id SERIAL PRIMARY KEY,
  movie_id INT REFERENCES movies(id) ON DELETE CASCADE,
  customer_id INT REFERENCES customers(id) ON DELETE CASCADE
);

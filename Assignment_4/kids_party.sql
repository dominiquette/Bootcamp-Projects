-- ========== DataBase ==========

-- Create a Database called kids_party_booking if it doesn't exist and use it.
CREATE DATABASE Kids_Party_Booking;

-- Use the created database
USE Kids_Party_Booking;


-- =========== Create Tables ===========

-- Create customers table to store customer information
CREATE TABLE IF NOT EXISTS customers (
	customer_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    surname VARCHAR(60) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    number VARCHAR(15) NOT NULL
);

-- Create themes table to store party themes
CREATE TABLE IF NOT EXISTS themes (
	theme_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    theme_name VARCHAR(60) NOT NULL
);

-- Create parties table to store party information
CREATE TABLE IF NOT EXISTS parties (
	party_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    theme_id INTEGER NOT NULL,
    location VARCHAR(200),
    FOREIGN KEY (theme_id) REFERENCES themes(theme_id)
);

-- Create bookings table to store booking information
CREATE TABLE IF NOT EXISTS bookings (
	booking_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    party_id INTEGER NOT NULL,
    party_date DATE NOT NULL,
    party_time TIME NOT NULL,
    num_guests INTEGER,
    booking_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (party_id) REFERENCES parties(party_id),
    UNIQUE (party_date, party_id)
    );


-- =========== Data Insert Into Tables ===========

-- Insert data into customers table
INSERT INTO customers 
(name, surname, email, number) VALUES 
('Harry', 'Potter', 'harry@gmail.com', '0208 888 7654');

-- Insert data into themes table
INSERT INTO themes 
(theme_name) VALUES 
('Superheroes'),
('Disney Princess'),
('Barbie'),
('Minecraft'),
('Space Adventure');

-- Insert data into parties table
INSERT INTO parties 
(theme_id, location) VALUES 
(1, 'East London Soft play'),
(2, 'Castle Hall'),
(3, 'Dream doll Land'),
(4, 'Lego Land'),
(5, 'Science Museum');

-- Insert data into bookings table
INSERT INTO bookings 
(customer_id, party_id, party_date, party_time, num_guests, booking_date) VALUES 
(1, 1, '2024-08-01', '14:00', 15, '2024-07-01');


-- =========== Queries ===========

-- Verify Users table
--SELECT * FROM customers;

---- Verify BirthdayThemes table
--SELECT * FROM themes;

---- Verify Parties table
--SELECT * FROM Parties;

---- Verify Bookings table
--SELECT * FROM Bookings;


-- Query to retrieve all information of bookings with join operations
--SELECT b.booking_id, c.name, c.surname, t.theme_name, p.location, b.party_date, b.party_time, b.num_guests, b.booking_date
--FROM bookings b
--JOIN customers c ON b.customer_id = c.customer_id
--JOIN parties p ON b.party_id = p.party_id
--JOIN themes t ON p.theme_id = t.theme_id;


--  Checking availability for a specific date, e.g., '2024-08-01'
--SELECT
--    t.theme_name,
--    p.location,
--    COUNT(b.booking_id) AS bookings_count,
--    CASE
--        WHEN COUNT(b.booking_id) > 0 THEN 'Booked'
--        ELSE 'Available'
--    END AS availability
--FROM themes t
--LEFT JOIN parties p ON t.theme_id = p.theme_id
--LEFT JOIN bookings b ON p.party_id = b.party_id
--    AND b.party_date = '2024-08-01' -- Adjust date as needed
--GROUP BY t.theme_name, p.location;


-- View all themes and their corresponding locations
--SELECT
--    t.theme_name,
--    p.location
--FROM themes t
--JOIN parties p ON t.theme_id = p.theme_id;


---- Order bookings by booking_id in descending order
--SELECT * FROM bookings ORDER BY booking_id DESC;

-- Uncomment to drop database
-- DROP database kids_party_booking;
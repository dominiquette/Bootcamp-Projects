-- ========== Scenario: Art Workshop Management System ==========

/*
Scenario:
My friend runs an art workshop centre offering creative classes for kids, the ages between 4-11 years. 
To make things smoother and boost how the centre is managed - handling workshop schedules, kids' enrolments, 
collecting feedback, and managing membership programmes - I've taken on the job of building a solid database system.

This database system aims to bring together and improve how data is handled, providing efficient tools to manage workshops, 
track enrolments, gather feedback, and keep membership records. The aim is to help the workshop centre deliver top-notch 
art experiences, boost customer satisfaction, and help make smart decisions based on data.

By building this SQL database, I hope to make a real difference to how the art workshop centre runs, ensuring everything's 
in order and delivering great service to young art fans and their families.
*/


-- ========== DataBase ==========

-- Create a Database called ArtyFartyWorkshop if it doesn't exist and use it.
CREATE DATABASE IF NOT EXISTS ArtyFartyWorkshop;

USE ArtyFartyWorkshop;

-- =========== Create Tables ===========

-- Table for storing information about workshops.
CREATE TABLE IF NOT EXISTS  Workshop (
	workshop_id INTEGER AUTO_INCREMENT PRIMARY KEY,
	workshop_name VARCHAR(60) NOT NULL,
	description VARCHAR(200),
	schedule_date DATE NOT NULL,
	schedule_time TIME NOT NULL
);


-- Table for storing parents information.
CREATE TABLE IF NOT EXISTS Parents (
	parent_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    parent_firstname VARCHAR(55) NOT NULL,
    parent_lastname VARCHAR(55),
    parent_email VARCHAR(60) NOT NULL,
    parent_number VARCHAR(15) NOT NULL
);


-- Table for storing information about children.
CREATE TABLE IF NOT EXISTS Children (
	child_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    parent_id INTEGER,
	first_name VARCHAR(55) NOT NULL,
	last_name VARCHAR(55) NOT NULL,
	age INTEGER NOT NULL CHECK (age >= 4 AND age <= 11),
	gender CHAR(10),
	FOREIGN KEY (parent_id) REFERENCES Parents(parent_id)
);


-- Table for storing enrollment information.
CREATE TABLE IF NOT EXISTS Enrollment (
	enroll_id INTEGER AUTO_INCREMENT PRIMARY KEY,
	child_id INTEGER,
	workshop_id INTEGER,
	enrollment_date DATE,
	FOREIGN KEY (child_id) REFERENCES Children(child_id),
	FOREIGN KEY(workshop_id) REFERENCES Workshop(workshop_id)
);

-- Table for storing feedback about workshops.
CREATE TABLE IF NOT EXISTS Feedback (
	feedback_id INTEGER AUTO_INCREMENT PRIMARY KEY,
	workshop_id INTEGER,
	rating INTEGER CHECK (rating >= 1 AND rating <= 5) NOT NULL,
	comments VARCHAR (60),
	date_submitted DATE,
	FOREIGN KEY (workshop_id) REFERENCES Workshop(workshop_id)
);

-- Table for storing membership information.
CREATE TABLE IF NOT EXISTS Membership (
	membership_id INTEGER AUTO_INCREMENT PRIMARY KEY,
	child_id INTEGER,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	membership_status CHAR(20) NOT NULL,
	FOREIGN KEY (child_id) REFERENCES Children(child_id)
);

-- Table for storing payment information.
CREATE TABLE IF NOT EXISTS Payments (
    payment_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    membership_id INTEGER,
    amount DECIMAL(8,2) NOT NULL,
    payment_date DATE NOT NULL,
    FOREIGN KEY (membership_id) REFERENCES Membership(membership_id)
);

-- Table for storing supply information for workshops.
CREATE TABLE IF NOT EXISTS Supplies (
	supply_id INTEGER AUTO_INCREMENT PRIMARY KEY,
	workshop_id INTEGER,
	supply_material VARCHAR(55) NOT NULL,
	quantity INTEGER NOT NULL,
	FOREIGN KEY (workshop_id) REFERENCES Workshop(workshop_id)
);


-- =========== Data Insert Into Tables ===========

-- Insert data into Workshop table.
INSERT INTO Workshop
(workshop_name, description, schedule_date, schedule_time)
VALUES
( 'Slime Making', 'Make your own glow in the dark slime!', '2024-08-06', '10:00'),
( 'Space Scultures', 'Create 3D space objects', '2024-08-07', '10:00'),
( 'Bubble Painting', 'Theme will be SILLY', '2024-09-08', '10:00'),
( 'Animal Bookmarks', 'Animals book marks out of card', '2024-08-09', '10:00'),
( 'Paper Lanterns', 'Create floral round paper lanterns', '2024-08-12', '10:30'),
( 'Animal Collages', 'Lets make animals out of shapes and different textures', '2024-08-13', '10:30'),
( 'Marble Printing', 'Experimenting with different marble painting techniques', '2024-08-14', '10:30'),
( 'Bird Feeder', 'Using natural elements to make a bird feeder', '2024-08-15', '10:30'),
( 'Butterfly', 'Making flyinf butterlies', '2024-01-20', '09:00');


-- Insert data into Parents table
INSERT INTO Parents (parent_firstname, parent_lastname, parent_email, parent_number)
VALUES
('Emily', 'Smith', 'emily.smith@gmail.com', '07911123456'),
('Mary', 'Johnson', 'mary.j@virginmedia.co.uk', '07700987654'),
('Jack', 'Williams', 'jackwilliams@live.net', '07894234567'),
('Alexander', 'Brown', 'alexander.brown@gmail.com', '07555876543'),
('Sam', 'David', 's.davis@yahoo.co.uk', '07412345678'),
('John', 'Doe', 'johndoe@gmail.com', '07600654321'),
('Laura', 'Wilson', 'laura.wilson@gmail.com', '07777432156'),
('Sam', 'Moore', 'sam.m@hotmail.co.uk', '07999567890');

-- Insert data into Children table.
INSERT INTO Children
(first_name, last_name, age, gender, parent_id)
VALUES
('Liam', 'Smith', 7, 'M', 1),
('Olivia', 'Johnson', 5, 'F', 2),
('Noah', 'Williams', 9, 'M', 3),
('Emma', 'Brown', 6, NULL, 4),
('Jackson', 'Davis', 8, 'M', 5),
('Ava', 'Miller', 10, 'F', 6),
('James', 'Wilson', 4, 'M', 7),
('Isabella', 'Moore', 5, 'F', 8);


-- Insert data into Enrollment table.
INSERT INTO Enrollment
(Child_id, workshop_id, enrollment_date)
VALUES
( 1, 1, '2024-05-20'),
( 2, 1, '2024-05-21'),
( 3, 2, '2024-05-21'),
( 4, 5, '2024-05-22'),
( 5, 7, '2024-06-01'),
( 6, 4, '2024-05-23'),
( 7, 8, '2024-06-10'),
( 8, 3, '2024-06-09'),
( 4, 3, '2024-06-08'),
( 2, 2, '2024-05-22');


-- Insert data into Feedback table.
INSERT INTO Feedback
(workshop_id, rating, comments, date_submitted)
VALUES
( 1, 5, 'Slime class is so fun!', '2024-01-20'),
( 3, 4, NULL, '2024-02-01'),
( 1, 5, 'Awesome, my child loved it', '2024-02-02'),
( 2, 3, 'Was great but too advance for my child', '2024-01-29'),
( 6, 5, NULL, '2024-01-05'),
( 8, 5, 'We got an amazing art to take home', '2024-02-12'),
( 5, 4, NULL, '2024-02-10'),
( 7, 5, 'Soo awesome!', '2024-02-25');


-- Insert data into Membership table.
INSERT INTO Membership
(child_id, start_date, end_date, membership_status)
VALUES
( 1, '2023-10-22', '2024-10-22', 'Active'),
( 2, '2024-02-18', '2025-02-18', 'Active'),
( 3, '2023-05-22', '2024-05-22', 'Deactive'),
( 4, '2024-06-01', '2025-06-01', 'Active'),
( 5, '2023-09-25', '2024-09-25', 'Active'),
( 6, '2023-12-30', '2024-12-30', 'Active'),
( 7, '2024-04-27', '2025-04-27', 'Active'),
( 8, '2023-11-08', '2024-11-08', 'Active');


-- Insert data into Payments table.
INSERT INTO Payments
(membership_id, amount, payment_date)
VALUES
( 1, 30.00, '2023-10-20'),
( 2, 30.00, '2024-02-01'),
( 3, 30.00, '2023-05-21'),
( 4, 30.00, '2024-06-01'),
( 5, 30.00, '2023-09-23'),
( 6, 30.00, '2023-12-20'),
( 7, 30.00, '2024-04-20'),
( 8, 30.00, '2023-11-07');


-- Insert data into Supplies table.
INSERT INTO Supplies
(workshop_id, supply_material, quantity)
VALUES
( 1, 'PVA Glue', 19),
( 2, 'PVA Glue', 19),
( 5, 'PVA Glue', 19),
( 1, 'Acrylic Paint', 20),
( 3, 'Acrylic Paint', 20),
( 1, 'Slime Activator', 30),
( 6, 'Colour Card', 22),
( 4, 'Colour Card', 22),
( 5, 'Tissue Paper', 49),
( 5, 'Dried Flowers', 35),
( 8, 'String', 18),
( 2, 'Recyle Materials', 39),
( 8, 'Recyle Materials', 39),
( 3, 'Straws', 41),
( 7, 'Tray', 20),
( 8, 'Glitter', 80);



-- ========= Test to Check tables & data =========

-- SELECT * FROM Workshop;
-- SELECT * FROM Children;
-- SELECT * FROM Parents;
-- SELECT * FROM Enrollment;
-- SELECT * FROM Feedback;
-- SELECT * FROM Membership;
-- SELECT * FROM Payments;
-- SELECT * FROM Supplies;


-- ================ QUERIES =================

-- Retrieve all the workshops in date order.
-- This query selects workshop names, descriptions, and formats the schedule date and time for readability.
SELECT 
    workshop_name,
    description,
    DATE_FORMAT(schedule_date, '%d-%m-%Y') AS formatted_date,
    TIME_FORMAT(schedule_time, '%h:%i %p') AS formatted_time
FROM Workshop
ORDER BY schedule_date;


-- This query counts the number of children enrolled in the 'Slime Making' workshop by joining Enrollment and Workshop tables.
SELECT COUNT(enrollment.child_id) AS Number_of_children
FROM Enrollment enrollment
JOIN Workshop workshop ON enrollment.workshop_id = workshop.workshop_id
WHERE workshop.workshop_name = 'Slime Making';


-- This query selects the first and last names of children along with the workshop name for those enrolled in 'Slime Making'.
SELECT c.first_name, c.last_name, w.workshop_name
FROM Enrollment e
JOIN Children c ON e.child_id = c.child_id
JOIN Workshop w ON e.workshop_id = w.workshop_id
WHERE w.workshop_name = 'Slime Making';


-- This query calculates the average rating from the Feedback table and rounds it to one decimal place.
SELECT ROUND(AVG(rating), 1) AS AverageFeedbackRating 
FROM Feedback;


-- This query selects the workshop name and its average rating, ordering by the highest rating and limiting the result to the top one.
SELECT
    workshop.workshop_name,
    ROUND(AVG(feedback.rating), 0) AS average_rating
FROM Workshop workshop
LEFT JOIN Feedback feedback ON workshop.workshop_id = feedback.workshop_id
GROUP BY workshop.workshop_name
ORDER BY average_rating DESC
LIMIT 1;

-- This query retrieves details of active memberships, including children's names and membership dates, ordered by the end date.
SELECT 
    children.first_name,
    children.last_name,
    membership.start_date,
    membership.end_date,
    membership.membership_status
FROM Membership membership
JOIN Children children ON membership.child_id = children.child_id
WHERE membership.membership_status = 'Active'
ORDER BY end_date;


-- This query selects children's first and last names and orders them by the last name in ascending order.
SELECT first_name, last_name 
FROM Children
ORDER BY last_name ASC;


-- This query groups enrollments by month and year, formatting the date for readability and counting the total enrollments per month.
SELECT 
    DATE_FORMAT(enrollment.enrollment_date, '%m-%Y') AS enrollment_month,
    COUNT(enrollment.enroll_id) AS total_enrollments
FROM Enrollment enrollment
GROUP BY enrollment_month
ORDER BY enrollment_month;


-- This query calculates the total revenue generated from all membership payments by summing the amount.
SELECT 
    SUM(amount) AS total_revenue
FROM Payments;


-- This query identifies children enrolled in more than one workshop by counting distinct workshop IDs per child and using the HAVING clause.
SELECT 
    children.first_name,
    children.last_name,
    COUNT(DISTINCT enrollment.workshop_id) AS workshops_enrolled
FROM Children children
JOIN Enrollment enrollment ON children.child_id = enrollment.child_id
GROUP BY children.first_name, children.last_name
HAVING workshops_enrolled > 1;


-- ============== Data Update ==============

-- SQL_SAFE_UPDATES is a mode that prevents updates and deletes without a WHERE clause that uses a key column.
-- Temporarily disabling SQL_SAFE_UPDATES to allow the update operation.
SET SQL_SAFE_UPDATES = 0;

-- Update a specific parent phone number.
-- Ensure to enter the correct names in WHERE.
UPDATE Parents
SET parent_number = '0789111111'
WHERE parent_firstname = 'MAry' AND parent_lastname = 'Johnson';

-- Re-enabling SQL_SAFE_UPDATES to to restore the safety feature..
SET SQL_SAFE_UPDATES = 1;

-- Check the update.
SELECT * FROM Parents WHERE parent_firstname = 'Mary' AND parent_lastname = 'Johnson';


-- ============ DELETE DATA ==============

-- Temporarily disable safe update mode to allow deletion without key-based WHERE clauses
SET SQL_SAFE_UPDATES = 0;

-- Delete all workshops scheduled before a specific date. This is to delete the workshops that have ended.
DELETE FROM Workshop
WHERE schedule_date < '2024-08-05';

-- Restore safe update mode to prevent unintentional data modifications.
SET SQL_SAFE_UPDATES = 1;

-- Check to see if an old workshop such as 'Butterfly' has been deleted older than 05-08-2024.
SELECT workshop_id, workshop_name, schedule_date
FROM Workshop
WHERE schedule_date < '2024-08-05';


-- ============= STORED PROCEDURE =============
-- Creating a stored procedure to add a new child and their parent details to the database.
-- This procedure takes input parameters for both the child and parent details and inserts them into the Children and Parents tables.

DELIMITER //
-- Define the store prcedure name Add_New_Child_And_Parent.
CREATE PROCEDURE Add_New_Child_And_Parent (
    IN first_name VARCHAR(55),  		-- Input childs first name.
    IN last_name VARCHAR(55),			-- Input childs last name.
    IN age INTEGER,						-- Input childs age.
    IN gender CHAR(1),					-- Input childs gender.
    IN parent_firstname VARCHAR(55),	-- Input Parents first name.
    IN parent_lastname VARCHAR(55),		-- Input Parents last name.
    IN parent_email VARCHAR(60),		-- Input Parents email.
    IN parent_number VARCHAR(15)		-- Input Parents number.
)
BEGIN
    DECLARE last_parent_id INTEGER;     -- Variable to store the last inserted parent ID.
    
    -- Insert parent information into the Parents table.
    INSERT INTO Parents (parent_firstname, parent_lastname, parent_email, parent_number)
    VALUES (parent_firstname, parent_lastname, parent_email, parent_number);
    
    -- Retrieve the parent_id of the newly inserted parent.
    SET last_parent_id = LAST_INSERT_ID();
    
	-- Insert child information into the Children table, linking to the new parent
    INSERT INTO Children (first_name, last_name, age, gender, parent_id)
    VALUES (first_name, last_name, age, gender, last_parent_id);
    
    -- Return a meesage once new data has been added.
    SELECT CONCAT('CHILD: ', first_name, ' ', last_name, ' & PARENT: ', parent_firstname, ' ', parent_lastname, ' have been successfully added!') AS add_status;
END //

-- Reset the delimiter back to the default.
DELIMITER ;


-- Scenario: There is a new child being signed up for a membership. Parent will add their child details and their own contact details.

-- Call the stored procedure with a test sample data.
CALL Add_New_Child_And_Parent('Jessica', 'Alter', 6, 'F', 'Katie', 'Harry', 'katieh@gmail.com', '07432156789');


-- Query the Children table to ensure the new child has been added.
-- SELECT * FROM Children;

-- Uncomment to Drop database
-- DROP DATABASE IF EXISTS ArtyFartyworkshop;

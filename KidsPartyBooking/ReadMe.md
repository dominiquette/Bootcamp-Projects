
# Running the Kids Party Booking API

This is a step-by-step instructions on how to run the Kids Party Booking API, including editing the configuration file, installing necessary requirements, running the server, and understanding the expected outcomes.

## Prerequisites

Before running the API, ensure you have the following installed on your system:
- Python 3.8 or higher
- MySQL Server
- pip (Python package installer)


## Installation

### Install required packages


To install the required packages, open your terminal and run:

`pip install flask`

`pip install requests`

`pip install mysql-connector-python`


## Create DATABASE

Ensure your MySQL server is running.

Open your MySQL, login and then open up the file [kids_party.sql](kids_party.sql).

Run the file to create the **Kids_Party_Booking** database and tables.

## Config file 

In the [config.py](config.py), you will need to replace **USER**, **PASSWORD** and **HOST** with your own MySQL crendentials:

- USER = 'your_mysql_username'  
- PASSWORD = 'your_mysql_password'
- HOST = 'localhost'
- DATABASE = 'Kids_Party_Booking'

Keep DATABASE as 'Kids_Party_Booking'.


## How to run the files

Open all your files, then run [app.py](app.py) file.

This will run the Flask server

You should see an output:
* Running on http://127.0.0.1:5001/ (Press CTRL+C to quit)


Next open the [main.py](main.py) file and run it to interact with the API.

You can now use the [main.py](main.py) file to book a birthday party and interact with the API.



## API Endpoints

#### Get Availability

```http
  GET /availability/<date>
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `date`    | `string` | **Required**. The date to check availability (YYYY-MM-DD) |



#### Book a Party

```http
  POST /book_party
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `name`    | `string` | **Required**. Customers's first name |
| `surname` | `string` | **Required**. Customer's last name |
| `email` | `string` | **Required**. Customers email |
| `number` | `string` | **Required**. Customers contact number |
| `party_date` | `string` | **Required**. Date of the party (YYYY-MM-DD) |
| `party_time` | `string` | **Required**. Time of the party (HH:MM) |
| `num_guest` | `int` | **Required**. Number of guests |
| `party_id` | `int` | **Required**. ID of the theme to book |


#### Delete a Booking

```http
  DELETE /delete_booking/<booking_id>

```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `booking_id`    | `int` | **Required**. ID of the booking to delete |

## Test

To verify bookings made, query the MySQL database:




```bash
USE Kids_Party_Booking;

SELECT b.booking_id, c.name, c.surname, t.theme_name, p.location, b.party_date, b.party_time, b.num_guests, b.booking_date
FROM bookings b
JOIN customers c ON b.customer_id = c.customer_id
JOIN parties p ON b.party_id = p.party_id
JOIN themes t ON p.theme_id = t.theme_id;
```
This will display detailed information about each booking stored in the database.
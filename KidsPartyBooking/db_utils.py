import mysql.connector  # Importing MySQL connector for database interactions
from config import USER, PASSWORD, HOST, DATABASE  # Importing database configuration from config module


# Custom exception for handling database connection errors
class DbConnectionError(Exception):
    pass


# Function to connect to the database
def _connect_to_db():
    try:
        # Establish a connection to the MySQL database using credentials from the config module
        cnx = mysql.connector.connect(
            host=HOST,
            user=USER,
            password=PASSWORD,
            database=DATABASE
        )
        return cnx
    except mysql.connector.Error as err:
        # Raise a custom exception if the connection fails
        raise DbConnectionError(f"Error connecting to database: {err}")


# Function to get available themes for a given date
def get_available_themes(date):
    try:
        db_connection = _connect_to_db()  # Connect to the database
        cur = db_connection.cursor()  # Create a cursor to execute queries
        # SQL query to fetch themes that are not booked for the specified date
        query = """
        SELECT t.theme_id, t.theme_name, p.location 
        FROM themes t
        LEFT JOIN parties p ON t.theme_id = p.theme_id
        LEFT JOIN bookings b ON p.party_id = b.party_id AND b.party_date = %s
        WHERE b.party_id IS NULL
        """
        cur.execute(query, (date,))  # Execute the query with the provided date
        result = cur.fetchall()  # Fetch all results from the query
        # Create a list of dictionaries representing available themes
        themes = [{"theme_id": row[0], "theme_name": row[1], "location": row[2]} for row in result]
        return themes
    except Exception as e:
        # Raise a custom exception if there is an error in fetching data
        raise DbConnectionError(f"Failed to read data from DB: {e}")
    finally:
        if db_connection:
            db_connection.close()  # Ensure the database connection is closed


# Function to add a new booking
def add_booking(customer_data, party_data):
    try:
        db_connection = _connect_to_db()  # Connect to the database
        cur = db_connection.cursor()  # Create a cursor to execute queries

        # Insert customer details into the customers table
        insert_customer_query = """
        INSERT INTO customers (name, surname, email, number)
        VALUES (%s, %s, %s, %s)
        """
        cur.execute(insert_customer_query,
                    (customer_data['name'], customer_data['surname'], customer_data['email'], customer_data['number']))
        customer_id = cur.lastrowid  # Retrieve the last inserted customer ID

        # Insert booking details into the bookings table
        insert_booking_query = """
        INSERT INTO bookings (customer_id, party_id, party_date, party_time, num_guests, booking_date)
        VALUES (%s, %s, %s, %s, %s, CURDATE())
        """
        cur.execute(insert_booking_query, (
            customer_id, party_data['party_id'], party_data['party_date'], party_data['party_time'],
            party_data['num_guests']))

        # Retrieve the last inserted booking ID
        booking_id = cur.lastrowid

        db_connection.commit()  # Commit the transaction
        # Return a success message with the booking ID
        return {"message": f"Booking successful! Your booking ID is: {booking_id}", "booking_id": booking_id}
    except Exception as e:
        db_connection.rollback()  # Roll back the transaction in case of an error
        raise DbConnectionError(f"Failed to add booking: {e}")
    finally:
        if db_connection:
            db_connection.close()  # Ensure the database connection is closed


# Function to delete a booking by its ID
def delete_booking_by_id(booking_id):
    try:
        db_connection = _connect_to_db()  # Connect to the database
        cur = db_connection.cursor()  # Create a cursor to execute queries

        # SQL query to delete a booking based on its ID
        delete_booking_query = """
        DELETE FROM bookings
        WHERE booking_id = %s
        """
        cur.execute(delete_booking_query, (booking_id,))  # Execute the query with the provided booking ID
        db_connection.commit()  # Commit the transaction

        if cur.rowcount == 0:
            # If no rows were affected, return a message indicating no booking was found
            return {"message": f"No booking found with booking ID: {booking_id}\n"}
        else:
            # Return a success message indicating the booking was deleted
            return {"message": f"Booking ID: {booking_id}, has been deleted.\n"}

    except Exception as e:
        db_connection.rollback()  # Roll back the transaction in case of an error
        raise DbConnectionError(f"Failed to delete booking: {e}")
    finally:
        if db_connection:
            db_connection.close()  # Ensure the database connection is closed

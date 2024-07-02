from flask import Flask, request, jsonify  # Importing Flask for creating the web server, request to handle incoming data, and jsonify to send JSON responses
from db_utils import get_available_themes, add_booking, delete_booking_by_id  # Importing utility functions from a custom module 'db_utils'


# Creating a Flask application instance
app = Flask(__name__)


# Route to get available themes for a specific date
@app.route('/availability/<date>', methods=['GET'])
def availability(date):
    try:
        themes = get_available_themes(date)  # Fetching available themes for the given date
        if not themes:
            return jsonify({"message": "No available themes for this date."}), 404 # If no themes are available, return a 404 response
        return jsonify(themes), 200  # Return the list of available themes with a 200 OK status
    except Exception as e:
        return jsonify({"error": str(e)}), 500  # Return an error message with a 500 Internal Server Error status in case of an exception


# Route to book a party
@app.route('/book_party', methods=['POST'])
def book_party():
    try:
        data = request.get_json()
        customer_data = {
            "name": data['name'],
            "surname": data['surname'],
            "email": data['email'],
            "number": data['number']
        }
        party_data = {
            "party_id": data['party_id'],
            "party_date": data['party_date'],
            "party_time": data['party_time'],
            "num_guests": data['num_guests']
        }

        # Check if party is already booked for the given date
        themes = get_available_themes(data['party_date'])
        booked_theme_ids = [theme['theme_id'] for theme in themes]
        if party_data['party_id'] not in booked_theme_ids:
            return jsonify({"error": "Selected theme is already booked for the specified date"}), 409  # If the theme is booked, return a 409 Conflict status

        result = add_booking(customer_data, party_data)  # Add the booking using utility function
        return jsonify(result), 201  # Return the result with a 201 Created status
    except Exception as e:
        return jsonify({"error": str(e)}), 500  # Return an error message with a 500 Internal Server Error status in case of an exception


# Route to delete a booking by ID
@app.route('/delete_booking/<booking_id>', methods=['DELETE'])
def delete_booking(booking_id):
    try:
        result = delete_booking_by_id(booking_id)  # Delete the booking using utility function
        return jsonify(result), 200  # Return the result with a 200 OK status
    except Exception as e:
        return jsonify({"error": str(e)}), 500  # Return an error message with a 500 Internal Server Error status in case of an exception


if __name__ == '__main__':
    app.run(debug=True, port=5001)  # Run the Flask application with debugging enabled on port 5001

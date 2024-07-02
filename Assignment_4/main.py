import json  # Importing JSON library to handle JSON data
import requests  # Importing Requests library to make HTTP requests
import sys  # Importing sys for output manipulation
from datetime import datetime  # Importing datetime to handle date and time
from time import sleep  # Importing sleep to create loading animation


# Function to get availability by date from the API
def get_availability_by_date(date):
    result = requests.get(f'http://localhost:5001/availability/{date}')
    return result.json()


# Function to display available themes
def display_availability(themes):
    print(f"{'Theme ID':<10} {'Theme Name':<20} {'Location':<20}")
    print('-' * 53)
    for theme in themes:
        print(f"{theme['theme_id']:<10} {theme['theme_name']:<20} {theme['location']:<20}")


# Function to add a new booking using the API
def add_new_booking(booking_data):
    response = requests.post(
        'http://localhost:5001/book_party',
        headers={'Content-Type': 'application/json'},
        data=json.dumps(booking_data)
    )
    # Return an error message if the theme is already booked
    if response.status_code == 409:  # HTTP 409 Conflict - Theme already booked
        return {"error": response.json().get('error', 'Booking failed due to conflict')}
    else:
        return response.json()


# Function to delete a booking by Theme ID using the API
def delete_booking_by_id(booking_id):
    response = requests.delete(f'http://localhost:5001/delete_booking/{booking_id}')
    return response.json()


# Function to display a loading animation
def loading_animation():
    for _ in range(1, 9):  # Loop to repeat the animation sequence
        for i in ("⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"):
            sleep(0.02)  # Animation speed
            sys.stdout.write('\rLoading ' + i)
            sys.stdout.flush()
        sys.stdout.write('\r' + ' ' * 11 + '\r')  # Clear the line after the animation
        sys.stdout.flush()


# Main function to run the program
def run():
    # Welcome message
    print('\t\t·⁺˚*•̩̩͙✩•̩̩͙*˚⁺‧͙⁺˚*•̩̩͙✩•̩̩͙*˚⁺‧͙⁺˚*•̩̩͙✩•̩̩͙*˚⁺‧')
    print('•̩̩͙✩•̩̩͙*˚⁺‧͙ Welcome to Kids Party Booking •̩͙✩•̩̩͙*˚⁺‧͙')
    print('\t\t·⁺˚*•̩̩͙✩•̩̩͙*˚⁺‧͙⁺˚*•̩̩͙✩•̩̩͙*˚⁺‧͙⁺˚*•̩̩͙✩•̩̩͙*˚⁺‧\n')

    # Loop to get a valid date input from the user
    while True:
        date = input('Please enter the date you wish to book (e.g., YYYY-MM-DD): ')
        try:
            datetime.strptime(date, '%Y-%m-%d')
            break
        except ValueError:
            print('ERROR! Please enter the date in the format YYYY-MM-DD.\n')

    # Display loading animation
    loading_animation()

    # Display available themes for the selected date
    print()
    slots = get_availability_by_date(date)
    print('\t✦•·········•✦ AVAILABILITY ✦•·········•✦')
    print('-' * 53)
    display_availability(slots)
    print()

    # Main action loop for booking, deleting or exiting
    while True:
        print("Do you want to book a party, delete a booking or exit? ")
        action = input("Enter 'book', 'delete', or 'exit': ").strip().lower()
        if action == 'book':
            # Get a valid email address from the user
            while True:
                email = input('\nEnter your email: ')
                if '@' in email:
                    break
                print("ERROR!: Please enter a valid email address.")

            # Get the number of guests from the user
            while True:
                try:
                    num_guests = int(input('Enter the number of guests attending to the party: '))
                    break
                except ValueError:
                    print("ERROR!: Please enter a valid number for the number of guests.")

            # Get a valid theme ID from the user. Error message if the chosen ID not the ones shown
            while True:
                try:
                    while True:
                        party_id = int(input('Enter the theme ID of the theme you like to book, as displayed above: '))
                        if any(theme['theme_id'] == party_id for theme in slots):
                            break
                        else:
                            print("ERROR!: Please enter one of the available theme ID numbers as shown above.\n")
                    break
                except ValueError:
                    print("ERROR!: Please enter a number for the Theme ID.")

            # Get a valid time from the user
            while True:
                party_time = input('Enter the time you want the party to start (e.g., 14:00): ')
                try:
                    datetime.strptime(party_time, '%H:%M')
                    break
                except ValueError:
                    print("ERROR!: Please enter the time in the format HH:MM.\n")

            # Collect booking data from the user
            booking_data = {
                "name": input('Enter your name: '),
                "surname": input('Enter your surname: '),
                "email": email,
                "number": input('Enter your contact number: '),
                "party_date": date,
                "party_time": party_time,
                "num_guests": num_guests,
                "party_id": party_id
            }
            print()

            # Attempt to add the new booking and display the result
            result = add_new_booking(booking_data)
            print(result.get('message', 'Booking failed!'))
            print()

        elif action == 'delete':
            # Get a valid booking ID from the user
            while True:
                try:
                    booking_id = int(input('\nEnter your booking ID to delete booking: '))
                    break
                except ValueError:
                    print("\nERROR!: Booking ID must be a number.")

            print()
            # Attempt to delete the booking and display the result
            result = delete_booking_by_id(booking_id)
            print(result.get('message', 'Booking deletion failed'))

        elif action == 'exit':
            # Exit the program
            print('\nSee you soon!')
            break

        else:
            # Handle invalid action input
            print("ERROR!: Please enter 'book', 'delete', or 'exit':\n")


if __name__ == '__main__':
    run()

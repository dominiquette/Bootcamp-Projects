# ============= Importing Libraries =================
import requests  # Library for making HTTP requests. 'pip install requests' in terminal to install module
import random  # Library generates random numbers or choices
import sys  # System-specific parameters and functions. Used for the 'delay(s)' function
import time  # Time related functions. Used for time.sleep()
from datetime import datetime  # Library for handling date and time


# ==================== Functions ====================

def character():
    """
    Retrieves a random Star Wars character from the Star Wars API SWAPI.
    - This function selects a random character ID from the list 'people_no'.
    - It then makes a request to the Star Wars API to fetch the character details.
    - The function returns a dictionary with the character's name, gender, birth year and height.

    Star Wars SWAPI does not require any API Keys.

    Returns:
    A dictionary containing the character's name, gender, birth year, and height.
    """
    # List if characters ID
    people_no = [1, 2, 3, 4, 5, 10, 11, 13, 14, 16, 20, 21, 22, 24, 25, 26, 36, 44, 51, 58, 67, 79]
    random_no = random.choice(people_no)  # Randomly selects a character ID number from the list
    url = f'https://swapi.dev/api/people/{random_no}/'  # Number is inserted to the API url to select character ID
    response = requests.get(url)  # Sends a GET request to the API URL
    people = response.json()  # Parse the response JSON data

    # Dictionary containing the returned Star Wars character details
    character_info = {
        'name': people['name'],
        'gender': people['gender'],
        'birth_year': people['birth_year'],
        'height': people['height'],
    }
    return character_info


def delay(s):
    """
    Prints the given string with a delay between each letter/number/symbol to create a typewriter effect.
    """
    for c in s:
        sys.stdout.write(c)  # Write the character to the standard output
        sys.stdout.flush()  # Flush the standard output to ensure immediate display
        time.sleep(0.05)  # Introduce a delay of 0.05 seconds between characters


def loading():
    """
    Creates an animated 'loading character' message as a lightsaber effect in random colours.
    - This function randomly selects an ANSI colour code for the lightsaber effect.

    Returns: The loading character string with the colour codes.
    """
    # List of ANSI colour codes for the lightsaber to change colour
    colour_no = [41, 42, 43, 44, 45, 46]
    random_colour = random.choice(colour_no)  # Randomly selects a colour
    return f'════|' + f'\33[30m\33[{random_colour}m         LOADING CHARACTER......       \33[0m\n'


def scramble(word):
    """
    Scrambles the letters of a word.
    Returns: The scrambled word.
    """
    words = list(word)
    random.shuffle(words)
    return ''.join(words)


def scramble_sentence(sentence):
    """
    Scrambles the letters of each word in a sentence.
    Returns: The sentence with scrambled words.
    """
    scrambled_words = [scramble(word) for word in sentence.split()]
    return ' '.join(scrambled_words)


def first_and_last_letter(word):
    """
    Retrieves the first and last letters of a given word.
    Returns: A string showing the first and last letters.
    """
    first_letter = word[:1]
    last_letter = word[-1:]
    return "The First Letter is: " + first_letter.upper() + "\n" + "The Last Letter is: " + last_letter


def main():
    """
    The main game function to run the Star Wars game.
    - The game consists of 5 rounds where the player guesses a scrambled Star Wars character's name.
    - The player can ask for clues or exit the round.
    - Points are awarded for correct guesses, and the final score is written to a file.
    """
    points = 0

    for rounds in range(1, 6):  # Loop 5 rounds of the game
        clue_counter = 0

        print(f"\n\t\t\t\tROUND: {rounds}/5\n")
        time.sleep(1)  # Introduce a delay of 1 second between lines

        # Display loading lightsaber animation
        loading_character = loading()
        delay(loading_character)
        time.sleep(1)

        # Retrieve information about a random Star Wars character
        chosen_player = character()
        character_name = chosen_player['name'].upper()
        character_gender = chosen_player['gender'].upper()
        character_height = chosen_player['height'].upper()
        character_birth = chosen_player['birth_year'].upper()
        # Scramble the character's name
        scrambled_sentence = scramble_sentence(character_name)
        # Get the first and last letters of the scrambled name
        sliceword = first_and_last_letter(character_name)

        # Display scrambled name and instructions
        print(f"\n\n\t✵ ✮ ⛥       {scrambled_sentence}       ⛥ ✮ ✵")
        # print(f"Test: {character_name}") # This is for admin to test to get past the correct answer.
        print("\nCan you guess the name of this character is above, by unscrambling their name?")
        print("Enter 'clue' if you need help.")
        print("Enter 'exit' if you give up.")

        # While loop to handle user guesses
        while True:
            guessed_name = input("\nEnter here: ").upper()
            if guessed_name == character_name:
                print("\nYes you are correct!\n")
                print(" ✦•·········•✦•·········•✦")
                # Display the correct character information
                print(f"\t Name: {character_name}")
                print(f"\t Height: {character_height}cm")
                print(f"\t Gender: {character_gender}")
                print(f"\t Birth Year: {character_birth}")
                print(" ✦•·········•✦•·········•✦\n")
                points += 1
                # Display user's name and points earned.
                print(f"Well done {name.capitalize()}! You have scored {points} points.")
                time.sleep(2)
                break

            # Provide a clue is user requests one
            elif guessed_name == 'CLUE':
                if clue_counter == 0:
                    print(sliceword)  # First clue: first and last letters of the characters name
                elif clue_counter == 1:
                    print(f"The character's gender is: {character_gender}")  # Second clue: character's gender
                else:
                    print("You have used up all your clues. No more clues available.")
                clue_counter += 1

            # Exit the round if user request to exit.
            elif guessed_name == 'EXIT':
                print("\nYou have lost this round.")
                print(f"The correct name is: {character_name}")
                print(f"\nYour score is {points} points.")
                time.sleep(2)
                break
            else:
                # Display incorrect guess message and ask user to try again
                print("Incorrect! Please try again.")

    # Display final score after all the rounds are completed
    print(f"\n◢◤◢◤◢◤ Your final score is: {points}/5 ◢◤◢◤◢◤\n")

    # Write score to a file, including the date and time played.
    date_time = datetime.now().strftime('%d-%m-%Y %H:%M')
    with open('starwars_points.txt', 'a+') as points_file:  # File name is: 'starwars_points.txt'
        points_file.write(f"Date and Time: {date_time} | Your score: {points}/5 points\n")


# ===================== GAME =====================

# Display introduction to the game
print("✩₊˚.⋆☾⋆⁺₊✧ STAR WARS GAME ✩₊˚.⋆☾⋆⁺₊✧\n")
time.sleep(1)
print("May the Force be with you, brave one! ")
time.sleep(0.5)

# User enters their name
name = input("What is your name, traveler?: ")

# Greet the user by their name
print(f"\n✩ Greetings, {name.capitalize()}! Welcome to the galaxy far, far away. ✩ ")
time.sleep(1)

# Main game loop
while True:
    # Run the main game function
    main()
    # Ask the user if they want to play again
    restart = input("Would you like to play again? Type 'YES' or 'NO': ").lower()

    # Start a new round of the game if the player wants to play again
    if restart == 'yes':
        continue

    # Display goodbye message and exit out of the loop if user does not want to play again
    if restart == 'no':
        print("\n·͙⁺˚*•̩̩͙✩•̩̩͙*˚⁺‧͙⁺˚*•̩̩͙✩•̩̩͙*˚⁺‧͙⁺˚*•̩̩͙✩•̩̩͙*˚⁺‧͙")
        print(f"    Thank you for playing {name.capitalize()}!")
        print("Until we meet again in this star system,")
        print("   May the Force be with you always!")
        print("         Goodbye traveler!")
        print("·͙⁺˚*•̩̩͙✩•̩̩͙*˚⁺‧͙⁺˚*•̩̩͙✩•̩̩͙*˚⁺‧͙⁺˚*•̩̩͙✩•̩̩͙*˚⁺‧͙")
        break

# ==================== Reference =====================
"""
https://stackoverflow.com/questions/22161075/how-to-scramble-the-words-in-a-sentence-python - scramble words & sentence
https://stackoverflow.com/questions/63667312/printing-in-the-different-line-in-python - delay text for loading animation
https://stackoverflow.com/questions/57557419/how-to-add-a-delay-or-wait-to-a-print-python - time.sleep()

"""

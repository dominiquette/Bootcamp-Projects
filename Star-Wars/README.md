#  ⭐ Star Wars Game ⭐

This is a  Star Wars-themed game that interacts with the Star Wars API to fetch a character and their data. 

The game scrambles the character names and asks the player to guess the correct name.



You will need:
- Python 3
- Requests module

## Installation

To install the Request Module, open terminal and run:

`pip install requests`



## How to Play 

open file: [starwars_game.py](starwars_game.py) in your chosen python IDE

### Game Rules:

1. A random Star Wars character will be chosen.

2. The character's name will be scrambled.

3. Unscramble the name to make your guess.
   You can make unlimited guesses.

4. You have the option to request 2 clues by entering 'clue'.

5. You have the option to give up by entering 'exit'.

6. Earn one point for each correct answer.
   No points will be awarded if you give up.

7. Your score will be displayed showing the number of points out of 5.
   Your points will be saved in a file for record-keeping alongside with the   date and time you played the game.
   



## Files

- [starwars_game.py](starwars_game.py): - The main game
- [starwars_points.txt](starwars_points.py): - Will open automatically or create a new file to record scores.



## API 

The game uses the Star Wars API (https://swapi.dev/) to fetch characters data.

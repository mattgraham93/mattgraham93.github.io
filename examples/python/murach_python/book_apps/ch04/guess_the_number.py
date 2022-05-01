# Matt Graham
# 5/8/2021
# PROG 108
# This program is a guessing game for players to set their difficulty and fall within specific parameters.

import random

LIMIT = 0


def display_title():
    print("Welcome to Guess the Number!")
    print()


def play_game(difficulty, score):
    # establish baseline variables for error checking
    number = 10000
    count = 1
    count_limit = 100
    guess_limit = LIMIT

    # based on user input, set the parameters to win
    guess_limit, count_limit = set_difficulty(difficulty)

    # establish guessing game
    number = random.randint(1, guess_limit)
    counts_left = count_limit

    print("I'm thinking of a number from 1 to %s.\nYou have a total of %s attempts.\n" %
          (str(guess_limit), str(counts_left)))
    print("The number: %s" % str(number))

    # while guess limit has not been exceeded, proceed
    while True:
        while counts_left > 0:
            guess = int(input("Your guess:\n"))
            if guess < number:
                print("Too low.")
                count += 1
                counts_left -= 1
                print("You have %s attempts left." % str(counts_left))

            elif guess > number:
                print("Too high.")
                count += 1
                counts_left -= 1
                print("You have %s attempts left." % str(counts_left))

            elif guess == number:
                if count == 1:
                    print("You guessed it in %s try!" % str(count))
                else:
                    print("You guessed it in %s tries!" % str(count))
                score += 1
                return score
        return


# establish difficulty for each game type here
def set_difficulty(difficulty):
    if difficulty == 'e':
        guess_limit = 10
        count_limit = 5
    elif difficulty == 'm':
        guess_limit = 100
        count_limit = 8
    elif difficulty == 'h':
        guess_limit = 1000
        count_limit = 10
    return guess_limit, count_limit


def main():
    display_title()
    name = input("What's your name?\n")
    again = "y"
    score = 0
    while again.lower() == "y":
        difficulty = input("%s, would you like easy (e), medium (m), or hard (h) mode?\n" % name)
        difficulty = difficulty[0:1].lower()
        score = play_game(difficulty, score)
        if score == 1:
            print("You have won %s time!" % str(score))
        else:
            print("You have won %s times!" % str(score))
        again = input("Would you like to play again? (y/n):\n")
        print()
    print("Bye, %s!" % name)


# if started as the main module, call the main function
if __name__ == "__main__":
    main()

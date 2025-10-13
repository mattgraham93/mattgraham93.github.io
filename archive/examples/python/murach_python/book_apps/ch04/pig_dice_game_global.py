#!/usr/bin/env python3

import random

turn = 1
score = 0
score_this_turn = 0
turn_over = False
game_over = False

def main():
    display_rules()
    play_game()

def display_rules():
    print("Let's Play PIG!")
    print()
    print("* See how many turns it takes you to get to 20.")
    print("* Turn ends when you hold or roll a 1.")
    print("* If you roll a 1, you lose all points for the turn.")
    print("* If you hold, you save all points for the turn.")
    print()

def play_game():
    while not game_over:
        take_turn()
    print()
    print("Game over!")

def take_turn():
    global turn_over

    print("TURN", turn)
    turn_over = False
    while not turn_over:
        choice = input("Roll or hold? (r/h): ")
        if choice == "r":
            roll_die()
        elif choice == "h":
            hold_turn()
        else:
            print("Invalid choice. Try again.")

def roll_die():
    global turn, score_this_turn, turn_over

    die = random.randint(1, 6)
    print("Die:", die)
    if die == 1:
        score_this_turn = 0
        turn += 1
        print("Turn over. No score.\n")
        turn_over = True
    else:
        score_this_turn += die

def hold_turn():
    global turn, score_this_turn, score, turn_over, game_over

    print("Score for turn:", score_this_turn)
    score += score_this_turn
    score_this_turn = 0
    print("Total score:", score, "\n")

    turn_over = True
    if score >= 20:
        game_over = True
        print("You finished in", turn, "turns!")
    turn += 1

# if started as the main module, call the main function
if __name__ == "__main__":
    main()

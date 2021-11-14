import random


# this is the main driver of the game to keep main clean and organized
def game() -> object:
    # print welcome message and review rules
    print("------------- Welcome!! -------------")
    print("First, let's go over the rules.")

    print_rules()

    # set computer name and get user's
    comp_name = set_name()
    print("You will be going against a computer, their name is %s!\n" % comp_name)

    player_name = input("First, what is your name?\n> ")
    print("Lovely to meet you, %s!" % player_name)

    # set baseline scores at the start of the game with appropriate names
    scores = [[comp_name, 0], [player_name, 0]]
    # consent to play
    play = int(input("Are you ready to start?\nType [1] for yes or [2] for no\n> "))

    # when the user selects what we want, we play or quit. Otherwise, we ask for better input.
    while play in (1, 2):
        if play == 1:
            # begin playing the game
            scores = play_game(scores)
            # print("scores set") # debugging
            print("\n----------------Scoreboard----------------\n")
            print_scores(scores)
            # confirm player wants to continue
            play = play_check()
        elif play == 2:
            # quit the game
            print("-------- Game over --------\n")
            break
        continue
    else:
        print("Please enter a valid option")
        play = input("Type [1] to play, or [2] to quit.\n> ")

    print("\n----------------Final scores---------------")
    print_scores(scores)

    # set winner placeholder variables
    winner = ""
    max_score = 0
    # define who the winner is
    for score in scores:
        if score[1] > max_score:
            max_score = score[1]
            winner = score[0]

    # print the winner and their score
    print("Winner: " + winner + " with %s points!" % str(max_score))

    return -1


# define and randomly set a gender neutral name
def set_name():
    # list of gender neutral first names and random last names.
    # Set first and last names to random integers and their
    # respective index for each list
    first_name = ['Morgan', 'Finley', 'Riley', 'Jessie', 'Kendall']
    last_name = ['Blaese', 'Moore', 'Brown', 'Williams', 'Taylor']
    rand1 = random.randint(0, 4)
    rand2 = random.randint(0, 4)

    full_name = first_name[rand1] + " " + last_name[rand2]

    return full_name


# simplified rule printing to reduce clutter
def print_rules():
    print("--------- Rules ---------")
    print("Like Rock, Paper, Scissors - you have three choices - Fire, Water, Electricity")
    print("Electricity??? Yes!")
    print("Electricity beats water, water beats fire, and fire beats electricity.")
    print("So: electricity > water > fire > electricity")
    print("I know, 'World Melting' is a bit dramatic. But we have to do clickbait!")


# defines and returns scores back to the main driving function
def play_game(scores):
    # print("---------play game-------") # debugging
    # assign random selection for computer, let user select 1, 2, or 3
    comp_slctd = random.randint(1, 3)
    play_slctd = int(input("Please enter your selection, [1] - Electricity, [2] - Water, [3] - Fire\n> "))

    # determine winner based on input
    winner = check_winner(comp_slctd, play_slctd)

    # 2 is tie, otherwise use determined winner's index and add to their score
    if winner == 2:
        print("It's a tie")
    else:
        winner_rec = scores[winner]
        winner_score = winner_rec[1]
        winner_score += 1
        winner_rec[1] = winner_score
        scores[winner] = winner_rec

    return scores


# determines winner based on parameters below
def check_winner(comp_slctd, play_slctd):
    # print("check winner") # debugging

    # 1 beats 2
    # 2 beats 3
    # 3 beats 1
    # all tie with each other

    if comp_slctd == play_slctd:
        return 2
    elif comp_slctd == 1 and play_slctd == 2:
        print("You lost!")
        print("Electricity beats water.")
        return 0
    elif comp_slctd == 2 and play_slctd == 3:
        print("You lost!")
        print("Water beats fire!")
        return 0
    elif comp_slctd == 3 and play_slctd == 1:
        print("You lost!")
        print("Fire beats electricity!")
        return 0
    else:
        print("You won!")
        return 1


# formatted leaderboard of scores
def print_scores(scores):
    print("{:<25}{: <8}".format(*['Name', 'Score']))
    for score in scores:
        print("{: <25}{: <8}".format(*score))


# easier way to check and validate user acceptance
def play_check():
    play = int(input("Keep playing? [1] for yes, [2] for no\n> "))
    return play

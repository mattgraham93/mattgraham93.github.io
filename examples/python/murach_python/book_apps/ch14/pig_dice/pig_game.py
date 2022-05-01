from game import Game

def display_welcome():
    print("Let's Play PIG!")
    print()
    print("* See how many turns it takes you to get to 20.")
    print("* Turn ends when you hold or roll a 1.")
    print("* If you roll a 1, you lose all points for the turn.")
    print("* If you hold, you save all points for the turn.")
    print()

def play_game():
    game = Game()
    while not game.isGameOver:
        take_turn(game)

def take_turn(game):
    print("TURN", game.turn)
    game.scoreThisTurn = 0
    game.isTurnOver = False
    while not game.isTurnOver:
        choice = input("Roll or hold? (r/h): ")
        if choice == "r":
            roll_die(game)
        elif choice == "h":
            hold_turn(game)
        else:
            print("Invalid choice. Try again.")

def roll_die(game):
    game.die.roll()
    print("Die:", game.die.value)
    if game.die.value == 1:
        game.scoreThisTurn = 0
        game.turn += 1
        game.isTurnOver = True
        print("Turn over. No score.\n")
    else:
        game.scoreThisTurn += game.die.value

def hold_turn(game):
    game.score += game.scoreThisTurn
    game.isTurnOver = True
    print("Score for turn:", game.scoreThisTurn)
    print("Total score:", game.score, "\n")
    if game.score >= 20:
        game.isGameOver = True
        print("You finished in", game.turn, "turns!")
    else:
        game.turn += 1

def main():
    display_welcome()
    while True:    
        play_game()
        choice = input("Play again? (y/n): ")
        print()
        if choice != "y":
            print("Bye!")
            break
        
# if started as the main module, call the main function
if __name__ == "__main__":
    main()

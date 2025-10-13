#!/usr/bin/env python3

def display_welcome():
    print("The Test Scores program")
    print("Enter 'x' to exit")
    print("")

def get_scores():
    score_total = 0
    counter = 0
    while True:
        score = input("Enter test score: ")
        if score == "x":
            return  score_total, counter
        else:
            score = int(score)
            if score >= 0 and score <= 100:
                score_total += score
                counter += 1 
            else:
                print("Test score must be from 0 through 100. " +
                      "Score discarded. Try again.")

def process_scores(score_total, count):
    # calculate average score
    average = score_total / count
                
    # format and display the result
    print()
    print("Score total:       ", score_total)
    print("Number of Scores:  ", count)
    print("Average Score:     ", average)

def main():
    display_welcome()
    score_total, count = get_scores()
    process_scores(score_total, count)
    print("")
    print("Bye!")

# if started as the main module, call the main function
if __name__ == "__main__":
    main()



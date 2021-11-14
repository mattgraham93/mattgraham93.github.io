# Matt Graham
# ISIT 333
# 10/21/2021

import statistics


# A cute little name to start
def display_welcome():
    print("Welcome to the Windy Score Analyzing tool")
    print("Enter 'x' to exit and receive your summary")
    print("...........................................")


# append score to scores list, return scores when the user is complete
def get_scores():
    scores = []
    while True:
        score = input("Enter test score: ")
        if score == "x":
            # return on quit
            return scores
        else:
            score = int(score)
            # validate score
            # could ask educator if they would like to set a max score
            if 0 <= score <= 100:
                scores.append(score)
            else:
                print("Test score must be from 0 through 100. " +
                      "Score discarded. Try again.")


def process_scores(scores):
    # run quick summary
    score_total = sum(scores)
    score_count = len(scores)
    min_score = min(scores)
    max_score = max(scores)
    med_score = statistics.median(scores)
    average = score_total / score_count

    # format and display the result
    print("...........................................")
    print("................. Summary .................\n")
    print("Score total:       ", score_total)
    print("Number of Scores:  ", score_count)
    print("Average Score:     ", average)
    print("Low Score:         ", min_score)
    print("High Score:        ", max_score)
    print("Median Score:      ", med_score)


def main():
    display_welcome()
    scores = get_scores()

    if len(scores) != 0:
        process_scores(scores)
    else:
        print("End of program")
    print("...........................................\n")
    print("Thank you for using our program!")


# if started as the main module, call the main function
if __name__ == "__main__":
    main()

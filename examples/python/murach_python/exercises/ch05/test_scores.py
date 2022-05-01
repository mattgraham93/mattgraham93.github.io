# Test Case Values
# Test Num         Inputs         Expected Output       Actual Output     Pass/Fail
#    1             15 15 15             15                30              Fail
#    2             15 15 15             15                15              Pass
#    2             75 90 15             60                15              Pass

# I removed the counter add when a user did NOT submit 'x', and instead kept the single +=1 when a valid score has been
# added.

# display a welcome message
print("The Test Scores application")
print()
print("Enter test scores")
print("Enter 'x' to end input")
print("======================")

# initialize variables
counter = 0
score_total = 0
test_score = 0

while True:
    test_score = input("Enter test score (or 'x' to quit): ")
    if test_score != "x":
        test_score = int(test_score)
    else:
        break
    if test_score >= 0 and test_score <= 100:
        score_total += test_score
        counter += 1
    else:
        print("Test score must be from 0 through 100. Score discarded. Try again.")   

# calculate average score
average_score = round(score_total / counter)
                
# format and display the result
print("======================")
print("Total Score:", score_total,
      "\nAverage Score:", average_score
      )
print()
print("Bye")



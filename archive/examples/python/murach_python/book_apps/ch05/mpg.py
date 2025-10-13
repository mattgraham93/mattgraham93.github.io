#!/usr/bin/env python3

# display a welcome message
print("The Miles Per Gallon application")
print()

# get input from the user
choice = "y"
while choice.lower() == "y":
    miles_driven = float(input("Enter miles driven:         "))
    gallons_used = float(input("Enter gallons of gas used:  "))

    if miles_driven <= 0:
        print("Miles driven must be greater than zero. Please try again.")
    elif gallons_used <= 0:
        print("Gallons used must be greater than zero. Please try again.")
    else:
        # calculate and display miles per gallon
        mpg = round((miles_driven // gallons_used), 2)   # // s.b /
        print("Miles Per Gallon:          ", mpg)
    choice = input("Continue? (y/n): ")
    print()

print("Bye")




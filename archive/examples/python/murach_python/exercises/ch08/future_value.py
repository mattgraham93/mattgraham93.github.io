#!/usr/bin/env python3
        
def get_number(prompt, low, high):
    while True:
        number = float(input(prompt))
        if number > low and number <= high:
            is_valid = True
            return number
        else:
            print("Entry must be greater than " + str(low) 
                  + " and less than or equal to " + str(high) + ".")
            
def get_integer(prompt, low, high):
    while True:
        number = int(input(prompt))
        if number > low and number <= high:
            is_valid = True
            return number
        else:
            print("Entry must be greater than " + str(low) 
                  + " and less than or equal to " + str(high) + ".")


def calculate_future_value(monthly_investment, yearly_interest, years):
    # convert yearly values to monthly values
    monthly_interest_rate = yearly_interest / 12 / 100
    months = years * 12

    # calculate future value
    future_value = 0.0
    for i in range(months):
        future_value += monthly_investment
        monthly_interest = future_value * monthly_interest_rate
        future_value += monthly_interest

    return future_value

def main():
    choice = "y"
    while choice.lower() == "y":
        # get input from the user
        monthly_investment = get_number("Enter monthly investment:\t", 0, 1000)
        yearly_interest_rate = get_number("Enter yearly interest rate:\t", 0, 15)
        years = get_integer("Enter number of years:\t\t", 0, 50)

        # get and display future value
        future_value = calculate_future_value(
            monthly_investment, yearly_interest_rate, years)
        
        print()
        print("Future value:\t\t\t" + str(round(future_value, 2)))
        print()

        # see if the user wants to continue
        choice = input("Continue? (y/n): ")
        print()

    print("Bye!")
    
if __name__ == "__main__":
    main()

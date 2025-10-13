#!/usr/bin/env python3

from datetime import datetime
import locale

def get_arrival_date():
    while True:
        date_str = input("Enter arrival date (YYYY-MM-DD): ")
        try:
            arrival_date = datetime.strptime(date_str, "%Y-%m-%d")
        except ValueError:
            print("Invalid date format. Try again.")
            continue

        # strip non-zero time values from datetime object
        now = datetime.now()
        today = datetime(now.year, now.month, now.day)        
        if arrival_date < today:
            print("Arrival date must be today or later. Try again.")
            continue
        else:
            return arrival_date

def get_departure_date(arrival_date):
    while True:
        date_str = input("Enter departure date (YYYY-MM-DD): ")
        try:
            departure_date = datetime.strptime(date_str, "%Y-%m-%d")
        except ValueError:
            print("Invalid date format. Try again.")
            continue
            
        if departure_date <= arrival_date:
            print("Departure date must be after arrival date. Try again.")
            continue
        else:
            return departure_date

def main():    
    print("The Hotel Reservation program\n")
    while True:
        # get datetime objects from user
        arrival_date = get_arrival_date()
        departure_date = get_departure_date(arrival_date)
        print()

        # calculate nights and cost
        rate = 85.0
        rate_message = ""
        if arrival_date.month == 8:    # August is high season
            rate = 105.0
            rate_message = "(High season)"
        total_nights = (departure_date - arrival_date).days
        total_cost = rate * total_nights

        # format resultsif result.lower() != "y":
        date_format = "%B %d, %Y"
        locale.setlocale(locale.LC_ALL, '')
        print("Arrival Date:  ", arrival_date.strftime(date_format))
        print("Departure Date:", departure_date.strftime(date_format))
        print("Nightly rate:  ", locale.currency(rate), rate_message)
        print("Total nights:  ", total_nights)
        print("Total price:   ", locale.currency(total_cost))
        print()

        # check whether the user wants to continue
        result = input("Continue? (y/n): ")
        print()
        if result.lower() != "y":
            print("Bye!")
            break
         
if __name__ == "__main__":
    main()

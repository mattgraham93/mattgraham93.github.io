#!/usr/bin/env python3

from tkinter import *
from tkinter import ttk
import locale

# a function that computes the future value
def calculate_future_value(monthly_investment,
                           yearly_interest_rate,
                           years):

    # convert yearly values to monthly values
    monthly_interest_rate = yearly_interest_rate / 12 / 100
    months = years * 12

    #calculate the future value
    future_value = 0
    for i in range(months):
        future_value = future_value + monthly_investment
        monthly_interest_amount = future_value * monthly_interest_rate
        future_value = future_value + monthly_interest_amount

    #return the future value
    return future_value

# called when the Calculate button is clicked
def on_calculate_clicked(monthly_investment_entry,
                         yearly_interest_rate_entry,
                         years_entry,
                         future_value_label):

    # convert the string values in the text entry boxes to numbers
    monthly_investment = float(monthly_investment_entry.get())
    yearly_interest_rate = float(yearly_interest_rate_entry.get())
    years = int(years_entry.get())

    # set the future value label to the value returned by the
    # calculate_future_value function
    future_value_label.set(locale.currency(
        calculate_future_value(monthly_investment,
                               yearly_interest_rate,
                               years), grouping=True))

# main fuction, called when the program starts
def main():    
    # set the locale for use in currency formatting
    result = locale.setlocale(locale.LC_ALL, '')
    if result == 'C' or result.startswith('C/'):
        locale.setlocale(locale.LC_ALL, 'en_US')
    
    # create the Tk application root window
    root = Tk()
    root.title("Future Value Calculator")

    # create and configure the frame for the root window
    frame = ttk.Frame(root, padding="10 10 10 10")
    frame.grid(column=0, row=0, sticky=(N, W, E, S))
    frame.columnconfigure(0, weight=1)
    frame.rowconfigure(0, weight=1)

    # create variables to hold the values in the widgets
    monthly_investment_entry = StringVar()
    yearly_interest_rate_entry = StringVar()
    years_entry = StringVar()
    future_value_label = StringVar()

    # set up a lambda so we can pass data to the callback function for the
    # calculate button.
    cb = lambda *args: on_calculate_clicked(monthly_investment_entry,
                                            yearly_interest_rate_entry,
                                            years_entry,
                                            future_value_label)

    # create the labels and text entry widgets, and add them to the grid
    ttk.Label(frame, text="Monthly Investment:").grid(column=0, row=0, sticky=E)
    monthly_investment_field = ttk.Entry(frame, width=25,
                                         textvariable=monthly_investment_entry)
    monthly_investment_field.grid(column=1, row=0)

    ttk.Label(frame, text="Yearly Interest Rate:").grid(column=0, row=1,
                                                        sticky=E)
    ttk.Entry(frame, width=25, textvariable=yearly_interest_rate_entry).grid(
        column=1, row=1)

    ttk.Label(frame, text="Years:").grid(column=0, row=2, sticky=E)
    ttk.Entry(frame, width=25, textvariable=years_entry).grid(
        column=1, row=2)

    ttk.Label(frame, text="Future Value:").grid(column=0, row=3, sticky=E)
    ttk.Entry(frame, width=25, textvariable=future_value_label,
              state="readonly").grid(
                  column=1, row=3)

    # create the button frame and add the buttons
    button_frame = ttk.Frame(frame)
    button_frame.grid(column=0, row=4, columnspan=2, sticky=E)
    ttk.Button(button_frame, text="Calculate", command=cb,
               underline=0).grid(column=0, row=0, padx=5)
    ttk.Button(button_frame, text="Exit", command=root.destroy,
               underline=1).grid(column=1, row=0)

    # add some padding between the widgets so they look nice
    for child in frame.winfo_children():
        child.grid_configure(padx=5, pady=3)

    # give focus to the monthly investment field when the app starts
    monthly_investment_field.focus()

    # bind some keyboard shortcuts to the buttons
    root.bind("<Alt-c>", cb)
    root.bind("<Alt-x>", lambda *args: root.destroy())

    # start the Tk event handling loop
    root.mainloop()

# if we were started as the main module, call the main function
if __name__ == "__main__":
    main()


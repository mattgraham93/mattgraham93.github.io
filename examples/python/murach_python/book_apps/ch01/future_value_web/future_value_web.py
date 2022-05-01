#!/usr/bin/env python

from flask import Flask, request, url_for, render_template
import locale

result = locale.setlocale(locale.LC_ALL, '')
if result == 'C' or result.startswith('C/'):
    locale.setlocale(locale.LC_ALL, 'en_US')

app = Flask(__name__)

def calculate_future_value(monthly_investment,
                           yearly_interest_rate,
                           years):
    monthly_interest_rate = yearly_interest_rate / 12 / 100
    months = years * 12

    future_value = 0
    for i in range(months):
        future_value = future_value + monthly_investment
        monthly_interest_amount = future_value * monthly_interest_rate
        future_value = future_value + monthly_interest_amount

    return future_value

@app.route("/")
def show_index():
    fv = {
        "monthly_investment": "",
        "yearly_interest_rate": "",
        "years": "",
        "future_value": ""
        }

    return render_template("index.html", fv=fv)

@app.route("/calculate", methods=["POST"])
def calculate():
    monthly_investment = float(request.form["monthly_investment"])
    yearly_interest_rate = float(request.form["yearly_interest_rate"])
    years = int(request.form["years"])
    
    future_value = locale.currency(calculate_future_value(monthly_investment,
                                                          yearly_interest_rate,
                                                          years),
                                   grouping=True)
    fv = {
        "monthly_investment": monthly_investment,
        "yearly_interest_rate": yearly_interest_rate,
        "years": years,
        "future_value": future_value
        }

    return render_template("index.html", fv=fv)

if __name__ == "__main__":
    app.run()

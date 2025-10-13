#!/usr/bin/env python3

# display a title
print("The Invoice program")
print()

choice = "y"
while choice == "y":
    # get user entry
    order_total = float(input("Enter order total: "))
    print()               

    # determine discount percent
    if order_total > 0 and order_total < 100:
        discount_percent = 0
    elif order_total >= 100 and order_total < 250:
        discount_percent = .1
    elif order_total >= 250:
        discount_percent = .2
            
    # calculate results
    discount = order_total * discount_percent
    subtotal = order_total - discount
    sales_tax = subtotal * .05
    invoice_total = subtotal + sales_tax

##    # calculate results (this works)
##    discount = round(order_total * discount_percent, 2)
##    subtotal = order_total - discount
##    sales_tax = round(subtotal * .05, 2)
##    invoice_total = subtotal - sales_tax
    
    # display the results
    print("Order total:     {:11.2f}".format(order_total))
    print("Discount amount: {:11.2f}".format(discount))
    print("Subtotal:        {:11.2f}".format(subtotal))
    print("Sales tax:       {:11.2f}".format(sales_tax))
    print("Invoice total:   {:11.2f}".format(invoice_total))
    print()

    choice = input("Continue? (y/n): ")
    print()
    
print("Bye")

from decimal import Decimal
from decimal import ROUND_HALF_UP
import locale
# set user's system language settings
locale.setlocale(locale.LC_ALL, '')


def main():
    print("The Invoice program")
    print()

    choice = "y"
    while choice == "y":
        shipping_rate = Decimal("0.085")
        # get the user entry
        order_total = Decimal(input("Enter order total: "))
        order_total = order_total.quantize(Decimal("1.00"), ROUND_HALF_UP)
        print()

        # determine the discount percent
        if order_total > 0 and order_total < 100:
            discount_percent = Decimal("0")
        elif order_total >= 100 and order_total < 250:
            discount_percent = Decimal(".1")
        elif order_total >= 250:
            discount_percent = Decimal(".2")

        # calculate the results
        discount = order_total * discount_percent
        discount = discount.quantize(Decimal("1.00"), ROUND_HALF_UP)
        subtotal = order_total - discount
        shipping_cost = subtotal * shipping_rate
        shipping_cost = shipping_cost.quantize(Decimal("1.00"), ROUND_HALF_UP)
        tax_percent = Decimal(".05")
        sales_tax = subtotal * tax_percent
        sales_tax = sales_tax.quantize(Decimal("1.00"), ROUND_HALF_UP)
        invoice_total = subtotal + sales_tax + shipping_cost
        order_total = locale.currency(order_total, grouping=True)
        invoice_total = locale.currency(invoice_total, grouping=True)

        s1 = 20
        s2 = ">10"

        print(f"{'Order total:':{s1}}{order_total:{s2}}")
        print(f"{'Discount amount:':{s1}}{discount:{s2}}")
        print(f"{'Subtotal:':{s1}}{subtotal:{s2}}")
        print(f"{'Shipping cost:':{s1}}{shipping_cost:{s2}}")
        print(f"{'Sales tax:':{s1}}{sales_tax:{s2}}")
        print(f"{'Invoice total:':{s1}}{invoice_total:{s2}}")
        print()

        choice = input("Continue? (y/n): ")
        print()

    print("Bye!")


if __name__ == "__main__":
    main()

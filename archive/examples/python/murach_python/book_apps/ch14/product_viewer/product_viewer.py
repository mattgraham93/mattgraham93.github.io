from objects import Product

def show_products(products):
    print("PRODUCTS")
    for i in range(len(products)):
        product = products[i]
        print(str(i+1) + ". " + product.name)
    print()

def show_product(product):
    print("PRODUCT DATA")
    print("Name:             {:s}".format(product.name))
    print("Price:            {:.2f}".format(product.price))
    print("Discount percent: {:d}%".format(product.discountPercent))
    print("Discount amount:  {:.2f}".format(product.getDiscountAmount()))
    print("Discount price:   {:.2f}".format(product.getDiscountPrice()))
    print()

def main():
    print("The Product Viewer program")
    print()
    
    # a tuple of Product objects
    products = (Product("Stanley 13 Ounce Wood Hammer", 12.99, 62),
                Product('National Hardware 3/4" Wire Nails', 5.06, 0),
                Product("Economy Duct Tape, 60 yds, Silver", 7.24, 0))
    show_products(products)

    while True:
        number = int(input("Enter product number: "))
        print()
        
        product = products[number-1]
        show_product(product)

        choice = input("View another product? (y/n): ")
        print()
        if choice != "y":
            print("Bye!")
            break
        

if __name__ == "__main__":
    main()

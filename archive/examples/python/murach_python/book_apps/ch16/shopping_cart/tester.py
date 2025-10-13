import db
from business import Product, LineItem, Cart

products = db.get_products()
product = products[1]
lineItem = LineItem(product, 2)
cart = Cart()
cart.addItem(lineItem)
print("Product:  ", product.name)
print("Price:    ", product.getDiscountPrice())
print("Quantity: ", lineItem.quantity)
print("Total:    ", cart.getTotal())

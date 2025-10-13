def factorial(num):
    fact = 1
    for number in range(1, num+1):
        fact = number * fact
    return fact

def main():
    print("0! =", factorial(0))
    print("1! =", factorial(1))
    print("2! =", factorial(2))
    print("3! =", factorial(3))
    print("4! =", factorial(4))
    print("5! =", factorial(5))

if __name__ == "__main__":
    main()

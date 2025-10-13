def factorial(num):
    if num == 0:
        return 1
    else:
        return num * factorial(num - 1)

def main():
    print("0! =", factorial(0))
    print("1! =", factorial(1))
    print("2! =", factorial(2))
    print("3! =", factorial(3))
    print("4! =", factorial(4))
    print("5! =", factorial(5))

if __name__ == "__main__":
    main()

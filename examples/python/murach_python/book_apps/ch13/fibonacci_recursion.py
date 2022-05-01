def fib(n):
    if n == 0:
        return 0
    elif n == 1:
        return 1
    else:
        return fib(n - 1) + fib(n - 2)

def main():
    for i in range(1116):
        print(fib(i), end=", ")
    print("...")

if __name__ == "__main__":
    main()

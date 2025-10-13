def fib(n):
    if n == 0:
        return 0
    elif n == 1:
        return 1
    n1 = 0
    n2 = 1
    fib = 0
    for i in range(2, n+1):
        fib = n1 + n2
        n1 = n2
        n2 = fib
    return fib

def main():
    for i in range(16):
        print(fib(i), end=", ")
    print("...")

if __name__ == "__main__":
    main()

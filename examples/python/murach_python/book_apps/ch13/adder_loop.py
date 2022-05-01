def add_numbers(upper):
    total = 0
    for number in range(upper + 1):
        total += number
    return total

def main():
    total = add_numbers(5)
    print("Total:", total)

if __name__ == "__main__":
    main()

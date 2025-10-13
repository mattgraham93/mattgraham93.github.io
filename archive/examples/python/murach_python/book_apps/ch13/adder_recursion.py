def add_numbers(upper):
    if upper == 0:
        return upper
    else:
         return upper + add_numbers(upper - 1)

def main():
    total = add_numbers(5)
    print("Total:", total)

if __name__ == "__main__":
    main()

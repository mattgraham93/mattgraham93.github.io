from builtins import ValueError


def main():
    print("Hi!")
    name = get_name()
    age = get_age()
    password = get_pass()

    print(f"Thank you! {name}")
    print(f"You are {age} years old.")
    print(f"It is bad practice to print your password...")
    print(f"But here it is anyways lol {password}")


def get_name():
    return input("What is your name?\n> ")


def get_age():
    try:
        age = int(input("How old are you?\n> "))
        return age
    except ValueError:
        print("Please enter a whole number:")


def get_pass():
    while True:
        password = input("Please enter your password: ")

        if len(password) < 8:
            print("Please enter a password greater than 8 characters: ")
        else:
            return password


if __name__ == "__main__":
    main()

import sqlite


def main():
    db_name = "C:/mattgraham93.github.io/DataSpellProjects/data/ISIT333.db"
    sqlite.connect(db_name)

    user_input = 0

    while True:

        user_input = input("Please select an option:")
        if user_input == 1:
            print("option 1")
        elif user_input == 2:
            print("option 2")
        elif user_input == 3:
            print("option 3")
        elif user_input == 4:
            print("option 3")
        elif user_input == 5:
            print("Thank you! The connection is now closing.")
            break
        else:
            print("Please select a valid option")


if __name__ == "__main__":
    main()
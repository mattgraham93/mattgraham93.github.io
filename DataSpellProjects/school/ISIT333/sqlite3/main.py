import sqlite


def main():
    print("------- START PROGRAM -------\n")
    print("Welcome to the Pulp Fiction database! It was, at one point, my favorite movie. I don't think it is anymore.")
    print("Feel free to browse around and learn more about the characters!\n ")
    # set database name/location
    db_name = "C:/mattgraham93.github.io/DataSpellProjects/data/ISIT333.db"
    table_name = "users"
    # connect to db and create table
    print("----------- Establishing connection -----------")
    conn, cursor = sqlite.connect(db_name)
    sqlite.create_table(cursor, table_name)
    print(f"------ Successfully connected to {table_name}! -------\n")
    # set baseline error count to track when to re-print menu
    error_count = -1

    while True:
        # print menu if first load or user has submitted the wrong input 5 times
        if error_count == -1:
            menu()
            error_count += 1
        elif error_count > 4:
            # reset counter after 5 failed attempts
            menu()
            error_count = 0
        # otherwise run the program
        else:
            user_input = input("\nPlease select an option: ")
            try:
                user_input = int(user_input)
            # check to make sure we are only accepting integer input for easy navigation. Pass to failure message
            except ValueError:
                pass

            if user_input == 1:
                error_count = 0
                sqlite.create_table(cursor, table_name)  # debugging
                print("table created")  # debugging
            elif user_input == 2:
                print("Let's add a user!\n")
                error_count = 0
                sqlite.add_user(cursor, table_name)  # debugging
                menu()
            elif user_input == 3:
                print("option 3")
                error_count = 0
                sqlite.print_table(cursor, table_name)
            elif user_input == 4:
                print("option 4")
                error_count = 0
            elif user_input == 5:
                print("\n----------------- FINAL TABLE ----------------")
                sqlite.print_table(cursor, table_name)
                # commit changes
                conn.commit()
                print("Changes committed")
                # close the connection
                conn.close()
                print("Connection closed")
                # end the program
                break
            # failure message
            else:
                error_count += 1
                print("---------------- ERROR ---------------")
                print(f"---- Error count: {error_count} -----")  # debugging
                print("---- Please select a valid option ----\n")


def menu():
    print("--------------------- MENU --------------------")
    print("1: Setup table and add base users  ------------")
    print("2: Add new user  ------------------------------")
    print("3: Print table  -------------------------------")
    print("4: Report  ------------------------------------")
    print("5: Commit changes and exit  -------------------")


if __name__ == "__main__":
    main()

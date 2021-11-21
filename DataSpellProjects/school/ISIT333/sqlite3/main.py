# Matt Graham
# 11/18/21
# Lab 8 - SQLite3 database manipulation

import sqlite


def main():
    print("------- START PROGRAM -------\n")
    print("Welcome to the Pulp Fiction database! It was, at one point, my favorite movie.")
    print("Feel free to browse around and learn more about the characters!\n ")
    print("NOTE: You must select 5 before ending the program to commit all changes.\n ")
    # set database name/location
    db_name = "C:/mattgraham93.github.io/DataSpellProjects/data/ISIT333.db"
    table_name = "users"
    # connect to db and create table
    print("----------- Establishing connection -----------")
    conn, cursor = sqlite.connect(db_name)
    # setup table if it does not exist
    sqlite.create_table(cursor, table_name)
    print(f"------ Successfully connected to {db_name}.{table_name}! -------\n")
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
                error_count = -1
                sql = """
                    SELECT rowid, * FROM users
                """
                sqlite.report_query(cursor, sql)
            elif user_input == 2:
                print("----- You selected: Users with W as their last name ---\n")
                error_count = -1
                sql = """
                    SELECT rowid, * from users WHERE last_name like 'W%'
                """
                sqlite.report_query(cursor, sql)
            elif user_input == 3:
                print("----- You selected: All WA residents -----\n")
                error_count = -1
                sql = """
                    SELECT rowid, * from users WHERE state like 'WA'
                """
                sqlite.report_query(cursor, sql)
            elif user_input == 4:
                print("----- You selected: Add user -----\n")
                error_count = -1
                sqlite.add_user(cursor, table_name)
            elif user_input == 5:
                print("\n----------------- FINAL TABLE ----------------")
                sql = """
                    SELECT rowid, * FROM users
                """
                sqlite.report_query(cursor, sql)
                # commit changes
                conn.commit()
                print("All changes committed")
                # close the connection
                conn.close()
                print("Connection closed")
                # end the program
                break
            # failure message and share error count
            else:
                error_count += 1
                print("---------------- ERROR ---------------")
                print(f"---- Error count: {error_count} -----")  # debugging
                print("---- Please select a valid option ----\n")


def menu():
    print("--------------------- MENU --------------------")
    print("1: Show all records for all users  ------------")
    print("2: Show all users with W as their last name ---")
    print("3: Show all records for Washington residents --")
    print("4: Add user -----------------------------------")
    print("5: Commit changes and exit  -------------------")


if __name__ == "__main__":
    main()

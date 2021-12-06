import sqlite3

import sqlite
import reports


# would like to get some basic list of random info from internet to pass in


def main():
    print()

    db_name = "C:/mattgraham93.github.io/DataSpellProjects/data/ISIT333.db"
    table_name = "employees"

    # connect to db and create table
    print("----------- Establishing connection -----------")
    conn, cursor = sqlite.connect(db_name, table_name)

    # set baseline error count to track when to re-print menu
    error_count = -1

    while True:
        print("getting employee dataframe")
        employee_df = reports.pd.read_sql_query(f"select * from {table_name}", conn)
        print(employee_df)

        # print menu if first load, returning from previous section, or user has submitted the wrong input 5 times
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
                print()
            elif user_input == 2:
                print()
            elif user_input == 3:
                print()
            elif user_input == 4:
                # employees is only used when loading initial users
                sqlite.add_employee(conn, cursor, table_name, employee_df, mode="user")
            elif user_input == 5:
                sqlite.update_rate(conn, cursor, table_name, employee_df)
            elif user_input == 6:
                print()
            elif user_input == 7:
                print()
            elif user_input == 8:
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
    print()
    print("--------------------- MENU --------------------")
    print("1: Employee email and department info ---------")
    print("2: Employee address and contact list ----------")
    print("3: Search employee database -------------------")
    print("4: Add new employee ---------------------------")
    print("5: Update an hourly rate ----------------------")
    print("6: Update contact information -----------------")
    print("7: Remove an employee -------------------------")
    print("8: Commit changes and exit  -------------------")
    print("-----------------------------------------------")
    print()

    # TODO - SQL
    #  Create a function to add an employee using the given inputs.
    #  Automatically assign a random employee id and automatically create an email address from their first and last
    #  name. Allow the user to input all other fields. (15 points) -- DONE
    #  Create function to generate email address -- DONE
    #  Create an update hourly rate function that will allow the user to update the hourly rate for a given employee.
    #  (10 points)
    #  Create an update contact information function that will allow the user to update the street address, city, state,
    #  zipcode, and phone number for a given employee. (10 points)
    #  Create a delete function that will allow the user to delete a given employee. (10 points)
    #  Create a search function to search for an employee by last name. Then list all of the matches of the last
    #  name, first name, email and department name. (15 points)

    # TODO - pandas
    #  Create a function to list all employee id numbers, names, email addresses, and their department name. (5 points)
    #  Create a function to list all employee names, full addresses, and phone numbers. (5 points)


if __name__ == "__main__":
    main()

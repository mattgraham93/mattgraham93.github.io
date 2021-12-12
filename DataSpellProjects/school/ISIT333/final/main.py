# Matt Graham
# 11/29/2021
# Final project - Database reporting

import sqlite
import reports


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
        # print("getting employee dataframe") # debugging
        # get raw dataframe for reporting
        employee_df = reports.list_employees(conn)
        # set index to be the employee ID
        employee_df.set_index('employee_ID', inplace=True)
        # print(employee_df) # debugging

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
            print()
            try:
                user_input = int(user_input)
            # check to make sure we are only accepting integer input for easy navigation. Pass to failure message
            except ValueError:
                pass

            if user_input == 1:
                # print employee department list
                print("----- Getting employee department list -----\n")
                print(reports.employee_departments(employee_df))
                error_count = reset_error()
            elif user_input == 2:
                # print employee contact list
                print("------- Getting employee contact list ------\n")
                print(reports.employee_contacts(employee_df))
                error_count = reset_error()
            elif user_input == 3:
                # search database
                print("-------------- Find an employee ------------\n")
                error_count = reset_error()
                print("You will see all people with matching last names and their associated departments.")
                # let person immediately quit if desired, otherwise, we will proceed with the search
                user_sel = input("Please type the person's last name or [x] to quit: ")
                print()
                if user_sel == 'x':
                    continue
                print(reports.get_department_search(employee_df, user_sel))
            elif user_input == 4:
                # add a user to database
                print("-------=------- Add employee --------------\n")
                # user adds employee to database
                sqlite.add_employee(conn, table_name, employee_df, mode="user")
                error_count = reset_error()
            elif user_input == 5:
                # update rate in database
                print("--------------- Update rate ----------------\n")
                sqlite.update_rate(conn)
                error_count = reset_error()
            elif user_input == 6:
                # update employee contact information in the database
                print("-------- Update contact information --------\n")
                sqlite.update_contact_info(conn)
                error_count = reset_error()
            elif user_input == 7:
                # remove an employee from the database
                print("------------ Remove an employee -------------\n")
                sqlite.remove_employee(conn)
                error_count = reset_error()
            elif user_input == 8:
                print("Thank you for using our employee database program! We hope you found it helpful. :)")
                # commit changes
                conn.commit()
                print("---------- All changes committed ----------")
                # close the connection
                conn.close()
                print("----------- Connection closed --------------")
                print("---------------- Goodbye -------------------")
                # end the program
                break
            # failure message and share error count
            else:
                error_count += 1
                print("---------------- ERROR ---------------")
                print(f"---- Error count: {error_count} -----")  # debugging
                print("---- Please select a valid option ----\n")


def reset_error():
    # after each successful transaction, we reset the error to ensure the user sees the menu
    return -1


def menu():
    # default menu - add items here as your elif statements grow
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


if __name__ == "__main__":
    main()

    # TODO
    #   Test test test - DONE
    #   finalize comments - DONE
    #   Identify unused functions
    #   optimize, but only after initial submission

    # TODO - SQL
    #  Create a function to add an employee using the given inputs.
    #  Automatically assign a random employee id and automatically create an email address from their first and last
    #  name. Allow the user to input all other fields. (15 points) -- DONE, TESTED
    #  Create function to generate email address -- DONE, TESTED
    #  Create an update hourly rate function that will allow the user to update the hourly rate for a given employee.
    #  (10 points) -- DONE, TESTED
    #  Create an update contact information function that will allow the user to update the street address, city, state,
    #  zipcode, and phone number for a given employee. (10 points) -- DONE, TESTED
    #  Create a delete function that will allow the user to delete a given employee. (10 points) -- DONE, TESTED

    # TODO - pandas
    #  Create a function to list all employee id numbers, names, email addresses, and their department name. (5 points)
    #  -- DONE, TESTED
    #  Create a function to list all employee names, full addresses, and phone numbers. (5 points)--  DONE, TESTED
    #  Create a search function to search for an employee by last name. Then list all of the matches of the last
    #  name, first name, email and department name. (15 points) -- DONE, TESTED

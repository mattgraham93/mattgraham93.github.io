import sqlite
import reports


# would like to get some basic list of random info from internet to pass in


def main():
    print()

    db_name = "C:/mattgraham93.github.io/DataSpellProjects/data/ISIT333.db"
    table_name = "employees"

    # connect to db and create table
    print("----------- Establishing connection -----------")
    conn, cursor = sqlite.connect(db_name)
    print("----------- Database connected -----------")
    print("----------- Checking for table -----------")

    # TODO - Make this check if the table exists or not, display when done
    # setup table if it does not exist
    sqlite.create_table(conn, cursor, table_name)
    print(f"------ Successfully connected to {db_name}.{table_name}! -------\n")
    # otherwise get dataframe
    print("getting employee dataframe")
    employee_df = reports.pd.read_sql_query(f"select * from {table_name}", conn)
    print(employee_df)

    # now that I have the data frame.... now what?

    # TODO - SQL
    #  Create a function to add an employee using the given inputs.
    #  Automatically assign a random employee id and automatically create an email address from their first and last
    #  name. Allow the user to input all other fields. (15 points)
    #  Create an update hourly rate function that will allow the user to update the hourly rate for a given employee.
    #  (10 points)
    #  Create an update contact information function that will allow the user to update the street address, city, state,
    #  zipcode, and phone number for a given employee. (10 points)
    #  Create a delete function that will allow the user to delete a given employee. (10 points)

    # TODO - pandas
    #  Create a function to list all employee id numbers, names, email addresses, and their department name. (5 points)
    #  Create a function to list all employee names, full addresses, and phone numbers. (5 points)
    #  Create a search function to search for an employee by last name. Then list all of the matches of the last
    #  name, first name, email and department name. (15 points)

    if __name__ == "__main__":
        main()

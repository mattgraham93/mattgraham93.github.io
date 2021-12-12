import pandas as pd


def list_employees(conn):
    # get the entire list of employees from the database
    return pd.read_sql_query(f"select * from employees", conn)


def find_employee(df, user_sel):
    # get the employee dataframe by last name >> todo not sure if duplicate_empByLastName
    return df["last_name"] == user_sel


def employee_departments(df):
    # get all employees, their email, and department
    return df.loc[:, ['first_name', 'last_name', 'email', 'department']]


def employee_contacts(df):
    # get all employee contact information
    return df.loc[:, ['first_name', 'last_name', 'address', 'city', 'state', 'zipcode']]


def get_employee_by_last_name(df, user_sel):
    # get employee by last name >> todo not sure if duplicate_empByLastName
    return df.query(f"last_name = '{user_sel}'")


def get_employee_by_emp_id(df, user_id):
    # get employee by user id
    return df.query(f"employee_ID == {int(user_id)}")


def get_user_id(df, user_sel):
    # get user id by last name >> todo need to see if used
    return df["employeeID"].query(f"last_name = {user_sel}")


def get_department_search(df, last_name):
    # create reduced dataframe to isolate location
    reduce_df = df["last_name"] == last_name
    # return specific columns from query
    return df[reduce_df].loc[:, ['first_name', 'last_name', 'department']]


def get_print_list(df):
    # print reduced column view for search functions
    print(df.loc[:, ['employee_ID', 'first_name', 'last_name', 'department', 'email', 'hourly_rate', 'state', 'zipcode']])

import pandas as pd


def find_employee(conn, user_sel):
    return pd.read_sql_query(f"select employee_ID, first_name, last_name, email, department from employees where employees.employee_ID like {user_sel}", conn)


def list_employees(conn):
    return pd.read_sql_query(f"select * from employees", conn)


def employee_departments(df):
    return df.loc[:, ['first_name', 'last_name', 'email', 'department']]


def employee_contacts(df):
    return df.loc[:, ['first_name', 'last_name', 'address', 'city', 'state', 'zipcode']]


def get_employee_by_last_name(df, user_sel):
    return df.query(f"last_name = {user_sel}")


def get_user_id(df, user_sel):
    return df["employeeID"].query(f"last_name = {user_sel}")


def get_department_search(df):
    last_name = get_last_name()
    return df.query(f"last_name = {last_name}")
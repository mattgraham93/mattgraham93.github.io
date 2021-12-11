import pandas as pd


def find_employee(df, user_sel):
    reduce_df = df["last_name"] == user_sel
    return reduce_df


def list_employees(conn):
    return pd.read_sql_query(f"select * from employees", conn)


def employee_departments(df):
    return df.loc[:, ['first_name', 'last_name', 'email', 'department']]


def employee_contacts(df):
    return df.loc[:, ['first_name', 'last_name', 'address', 'city', 'state', 'zipcode']]


def get_employee_by_last_name(df, user_sel):
    return df.query(f"last_name = '{user_sel}'")


def get_user_id(df, user_sel):
    return df["employeeID"].query(f"last_name = {user_sel}")


def get_department_search(df):
    last_name = get_last_name()
    return df.query(f"last_name = {last_name}")
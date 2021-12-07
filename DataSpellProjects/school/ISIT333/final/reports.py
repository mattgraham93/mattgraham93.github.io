import pandas as pd


def find_employee(conn, user_sel):
    return pd.read_sql_query(f"select * from employees where employees.employee_ID like {user_sel}", conn)


def list_employees(conn):
    return pd.read_sql_query(f"select * from employees", conn)


def employee_departments(df):
    return df.loc[:, ['first_name', 'last_name', 'email', 'department']]

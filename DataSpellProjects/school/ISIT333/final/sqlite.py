import sqlite3
import random as rand

import pandas as pd


def load_employee(conn, cursor, table_name, employee):
    employee_id = employee[0]
    user_firstname = employee[1]
    user_lastname = employee[2]
    user_address = employee[3]
    user_city = employee[4]
    user_state = employee[5]
    user_zipcode = employee[6]
    user_email = employee[7]
    user_phone = employee[8]
    hourly_rate = employee[9]
    department = employee[10]

    sql = f"""
                    INSERT INTO {table_name} (employee_id, first_name, last_name, address, city, state, zipcode, email, phone, hourly_rate, department)
                    VALUES (?,?,?,?,?,?,?,?,?,?,?)
                """

    cursor.execute(table_name, (employee_id, user_firstname, user_lastname, user_address, user_city, user_state, user_zipcode, user_email, user_phone, hourly_rate, department))
    conn.commit()


def add_employee(conn, cursor, table_name, employees, mode):
    if mode == "user":
        employee_id = check_rand(employees, rand_int=rand.randint(1000, 9999))
        user_firstname = input("First name: ")
        user_lastname = input("Last name: ")
        user_address = input("Address: ")
        user_city = input("City: ")
        user_state = input("State: ")
        user_zipcode = input("Zipcode: ")
        user_email = input("Email: ")
        user_phone = input("Phone: ")
        hourly_rate = input("Hourly rate: $")
        department = input("Department: ")
        # expect to reach else statement? want to go to load
        employee = [employee_id, user_firstname, user_lastname, user_address, user_city, user_state, user_zipcode,
                    user_email, user_phone, hourly_rate, department]
        load_employee(conn, cursor, table_name, employee)
        print(f"{user_firstname} added successfully!\n")
        pass
    elif mode == "load":
        for employee in employees:
            load_employee(conn, cursor, table_name, employee)
            print(f"{employee[1]} added successfully!\n")
    else:
        print("Reached else statement, what happened?")


def generate_employees(conn, cursor, table_name):
    employees = []
    first_id = rand.randint(1000, 9999)
    first_names = ["Name", "Name", "Name", "Name", "Name"]
    last_names = ["Name", "Name", "Name", "Name", "Name"]

    for i in range(15):
        if i == 0:
            employee_id = rand.randint(1000, 9999)
        else:
            employee_id = check_rand(employees, rand_int=rand.randint(1000, 9999))
        first_name = first_names[rand.randint(0, 4)]
        last_name = last_names[rand.randint(0, 4)]
        address = ""
        city = ""
        state = ""
        zipcode = ""
        email = ""
        phone = ""
        hourly_rate = 11.11
        department = ""

        # create employee
        employee = [
            employee_id, first_name, last_name, address, city, state, zipcode, email, phone, hourly_rate, department
        ]

        # add employee to employee list
        employees.append(employee)

        load_employee(conn, cursor, table_name, employee)
        i += 1


def check_rand(employees, rand_int):
    for employee in employees:
        # continue checking for random integers until one does not match
        if employee[0] == rand_int:
            generate_employees(employees, rand.randint(1000, 9999))
        # otherwise the random int is valid
        else:
            return rand_int


def connect(db_name):
    # connect to database and return connection and cursor to main
    conn = sqlite3.connect(db_name)
    cursor = conn.cursor()
    return conn, cursor


def create_table(conn, cursor, table_name):
    # create the table if it doesn't already exist
    # note that primary keys are automatically created in sqlit3 and referenced as rowid -- noted!
    cursor.execute(f"CREATE TABLE IF NOT EXISTS {table_name} "
                   f"(employee_ID INTEGER, first_name TEXT, last_name TEXT, address TEXT, "
                   "city TEXT, state TEXT, zipcode TEXT, email TEXT, phone TEXT, hourly_rate REAL, department TEXT)")

    # setup initial employees
    generate_employees(conn, cursor, table_name)

    sql = f"""
        select * from {table_name}
    """

    cursor.execute(sql)
    employees = cursor.fetchall()

    # create baseline records of data
    add_employee(conn, cursor, table_name, employees, mode="load")

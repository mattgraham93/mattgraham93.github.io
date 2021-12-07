import sqlite3
import random as rand
import names
import random_address
import reports


def remove_employee(conn, cursor):
    print()


def update_rate(conn, cursor):
    people = reports.list_employees(conn)

    while True:
        try:
            print(people)
            # get user input
            user_sel = input("Please type the person's last name or [x] to quit: ")
            found = reports.find_employee(conn, user_sel)
            # check user input and if they want to quit
            if user_sel.lower() == 'x':
                # return False to return to the menu
                return False
            # raise an error when the dataframe is empty
            if people[found].empty:
                raise RuntimeError("Last name does not exist")
            elif len(people[found]) > 1:
                print("There is more than one person with that last name!")
                print(people[found])
            else:
                # otherwise print the dataframe
                print(people[found])
                # return true to continue looping through search feature
                return True
        except Exception as e:
            print(f"{e}. Please search again.")






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

    cursor.execute(sql, (employee_id, user_firstname, user_lastname, user_address, user_city, user_state, user_zipcode, user_email, user_phone, hourly_rate, department))
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
        user_email = set_email(user_firstname, user_lastname)
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
    departments = ["Leadership", "Technology", "People", "DE&I", "Finance", "Operations"]
    for i in range(15):
        if i == 0:
            employee_id = rand.randint(1000, 9999)
        else:
            employee_id = check_rand(employees, rand_int=rand.randint(1000, 9999))
        first_name = names.get_first_name()
        last_name = names.get_last_name()
        address = random_address.real_random_address().get('address1')
        city = random_address.real_random_address().get('city')
        state = random_address.real_random_address().get('state')
        zipcode = random_address.real_random_address().get('postalCode')
        email = set_email(first_name, last_name)
        phone = create_phone()
        hourly_rate = round(rand.uniform(10, 85), 2)
        department = departments[rand.randint(0, 5)]

        # create employee
        employee = [
            employee_id, first_name, last_name, address, city, state, zipcode, email, phone, hourly_rate, department
        ]

        # add employee to employee list
        employees.append(employee)

        load_employee(conn, cursor, table_name, employee)
        i += 1


def create_phone():
    first = str(rand.randint(200, 899))
    middle = str(rand.randint(100,999))
    last = str(rand.randint(1000, 9999))

    return f"{first}-{middle}-{last}"


def set_email(first_name, last_name):
    return first_name[0] + last_name[0:4] + "@bigcorp.com"


def check_rand(employees, rand_int):
    for employee in employees:
        # continue checking for random integers until one does not match
        if employee[0] == rand_int:
            generate_employees(employees, rand.randint(1000, 9999))
        # otherwise the random int is valid
        else:
            return rand_int


def create_table(conn, cursor, table_name):
    # create the table if it doesn't already exist
    # note that primary keys are automatically created in sqlite3 and referenced as rowid -- noted!
    cursor.execute(f"CREATE TABLE IF NOT EXISTS {table_name} "
                   f"(employee_ID INTEGER, first_name TEXT, last_name TEXT, address TEXT, "
                   "city TEXT, state TEXT, zipcode TEXT, email TEXT, phone TEXT, hourly_rate REAL, department TEXT)")

    # setup initial employees
    generate_employees(conn, cursor, table_name)


def connect(db_name, table_name):
    # connect to database and return connection and cursor to main
    conn = sqlite3.connect(db_name)
    cursor = conn.cursor()
    print("----------- Checking for table -----------")
    try:
        # setup table if it does not exist
        cursor.execute(f"select * from {table_name}")
    except sqlite3.OperationalError:
        create_table(conn, cursor, table_name)
    print(f"------ Successfully connected to {db_name}.{table_name}! -------\n")
    return conn, cursor


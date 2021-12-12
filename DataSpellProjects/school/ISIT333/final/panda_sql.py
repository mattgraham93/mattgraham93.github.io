def get_last_name(employees):
    while True:
        try:
            print(employees)

            # get user input
            user_sel = input("\nPlease type the person's last name or [x] to return to the main menu: ")

            # check user input and if they want to quit
            if user_sel.lower() == 'x':
                # return False to return to the menu
                return False
            # search employee dataframe
            found = reports.find_employee(employees, user_sel)
            # raise an error when the dataframe is empty
            if employees[found].empty:
                raise RuntimeError("Last name does not exist")
            # check to make sure only one person is found, otherwise isolate by user id
            # todo - not tested this functionality yet, need to add same last name
            elif len(employees[found]) > 1:
                print("There is more than one person with that last name!")
                # show multiple records
                print(employees[found])
                # if more than one person is found, make user select by user id
                user_id = input("Please enter an employee ID: ")
                set_rate(user_id, cursor)
                conn.commit()
                return True
            else:
                # print the dataframe
                print(f"------ {employees[found]['first_name'].values[0]} {employees[found]['last_name'].values[0]} was found! -------")
                print(employees[found])
                # set employee id to user id since user input the last name
                user_id = employees[found]['employee_ID'].values[0]

                # print(employees[found].columns) # debugging
                # print(f"employee ID: {user_id}") # debugging

                # set the new rate
                rate = set_rate(user_id, conn)

                # print confirmation message
                print(f"{employees[found]['first_name'].values[0]}'s hourly rate has been updated to ${str(rate)}\n")

                # continue through loop until user is finished updating rates
                continue
        except Exception as e:
            print(f"{e}. Please search again.")


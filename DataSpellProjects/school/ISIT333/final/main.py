import pandas as pd
import sqlite


def main():
    print()

    db_name = "C:/mattgraham93.github.io/DataSpellProjects/data/ISIT333.db"
    table_name = "users"

    # connect to db and create table
    print("----------- Establishing connection -----------")
    conn, cursor = sqlite.connect(db_name)

    # setup table if it does not exist
    cursor.execute("select * from users")
    row = cursor.fetchone()
    if row is None:
        sqlite.create_table(cursor, table_name)
    print(f"------ Successfully connected to {db_name}.{table_name}! -------\n")

    print("getting employee dataframe")
    employee_df = pd.read_sql_query(f"select * from {table_name}", conn)
    print(employee_df)


if __name__ == "__main__":
    main()

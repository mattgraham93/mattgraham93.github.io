import sqlite
import reports


def main():
    print()

    db_name = "C:/mattgraham93.github.io/DataSpellProjects/data/ISIT333.db"
    table_name = "employees"

    # connect to db and create table
    print("----------- Establishing connection -----------")
    conn, cursor = sqlite.connect(db_name)
    print("----------- Database connected -----------")
    print("----------- Checking for table -----------")
    # setup table if it does not exist
    sqlite.create_table(conn, cursor, table_name)
    print(f"------ Successfully connected to {db_name}.{table_name}! -------\n")

    print("getting employee dataframe")
    employee_df = reports.pd.read_sql_query(f"select * from {table_name}", conn)
    print(employee_df)


if __name__ == "__main__":
    main()

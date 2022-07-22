import mariadb
import sys


def db_conn():
    try:
        conn = mariadb.connect(
            user="root",
            password="kisec123",
            host="localhost",
            port=3306,
            database="vdm"
        )
    except mariadb.Error as e:
        print(f"Error connecting to MariaDB Platform: {e}")
        sys.exit(1)

    return conn

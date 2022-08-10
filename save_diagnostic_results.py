import mariadb
import db_conn

conn = db_conn.db_conn()
cur = conn.cursor()
insert_query = 'insert into diagnostic_results(type_code, result) values (?, ?)'

f = open("C:\\Users\\USER\\Desktop\\result.txt", 'r')

lines = f.readlines()
for line in lines:
    type_code = line.strip().split(' ')[0]
    result = line.strip().split(' ')[1]

    try:
        cur.execute(insert_query, (type_code, result))
        conn.commit()
    except mariadb.Error as e:
        print(f"Error: {e}")

f.close()
conn.close()

import mariadb
import db_conn
from packaging import version

def get_software_list(cur):
    sql = 'select name, version from software_list'
    try:
        cur.execute(sql)
    except mariadb.Error as e:
        print(f"Error: {e}")
    rows = cur.fetchall()

    return rows


def vuln_comparison(cur, softwares):
    sql_all = 'select * from cve_list'
    try:
        cur.execute(sql_all)
    except mariadb.Error as e:
        print(f"Error: {e}")
    rows = cur.fetchall()
    for row in rows:
        for software in softwares:
            if row[5].lower() in software[0].lower():
                if version.parse(row[6]) <= version.parse(software[1]) <= version.parse(row[7]):
                    print('vuln!!!')
                else:
                    print('no vuln.')


if __name__ == "__main__":
    conn = db_conn.db_conn()
    cur = conn.cursor()

    softwares = get_software_list(cur)
    vuln_comparison(cur, softwares)

    conn.close()

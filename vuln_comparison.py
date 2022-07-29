import mariadb
import db_conn
from packaging import version

def get_software_list(cur):
    get_software_list_query = 'select name, version from software_list'
    try:
        cur.execute(get_software_list_query)
    except mariadb.Error as e:
        print(f"Error: {e}")
    rows = cur.fetchall()

    return rows


def vuln_comparison(cur, softwares):
    get_cve_list_query = 'select * from cve_list'
    update_query = 'update software_list set vuln_check = %s, vuln_id = %s where name = %s'
    try:
        cur.execute(get_cve_list_query)
    except mariadb.Error as e:
        print(f"Error: {e}")
    rows = cur.fetchall()
    for row in rows:
        for software in softwares:
            if row[5].lower() in software[0].lower():
                if version.parse(row[6]) <= version.parse(software[1]) <= version.parse(row[7]):
                    try:
                        cur.execute(update_query, ('1', row[0]), software[0])
                        conn.commit()
                    except mariadb.Error as e:
                        print(f"Error: {e}")
                else:
                    try:
                        cur.execute(update_query, ('0', None, software[0]))
                        conn.commit()
                    except mariadb.Error as e:
                        print(f"Error: {e}")


if __name__ == "__main__":
    conn = db_conn.db_conn()
    cur = conn.cursor()

    softwares = get_software_list(cur)
    vuln_comparison(cur, softwares)

    conn.close()

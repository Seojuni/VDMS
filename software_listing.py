import subprocess
import os
import db_conn
import mariadb


def software_listing():
    f = open('output.txt', 'w')
    cmd = ['powershell.exe', 'Get-CimInstance', 'Win32_Product', '|', 'Sort-Object', '-property', 'Name', '|',
           'Format-Table', '-Property', 'Name,', 'Version']
    software_list = subprocess.run(cmd, stdout=subprocess.PIPE, text=True)
    f.write(software_list.stdout)
    f.close()


def update_data(conn, cur):
    insert_query = 'insert into software_list(name, version) values (?, ?)'
    select_query = 'select count(*) from software_list'

    f = open('output.txt', 'r')
    line = f.readlines()
    file_len = len(line) - 6
    try:
        cur.execute(select_query)
    except mariadb.Error as e:
        print(f"Error: {e}")
    row = cur.fetchone()[0]

    if file_len == row:
        return
    elif row == 0:
        for l in line[4:-2]:
            if " " in l.strip().split(' '):
                software = " ".join(l.strip().split(' ')[:-2]).rstrip()
            else:
                software = " ".join(l.strip().split(' ')[:-1]).rstrip()
            version = l.strip().split(' ')[-1]

            try:
                cur.execute(insert_query, (software, version))
                conn.commit()
            except mariadb.Error as e:
                print(f"Error: {e}")
    else:
        for l in line[row+1:-2]:
            if " " in l.strip().split(' '):
                software = " ".join(l.strip().split(' ')[:-2]).rstrip()
            else:
                software = " ".join(l.strip().split(' ')[:-1]).rstrip()
            version = l.strip().split(' ')[-1]

            try:
                cur.execute(insert_query, (software, version))
                conn.commit()
            except mariadb.Error as e:
                print(f"Error: {e}")

    f.close()
    os.remove('output.txt')


if __name__ == "__main__":
    conn = db_conn.db_conn()
    cur = conn.cursor()

    software_listing()
    update_data(conn, cur)

    conn.close()

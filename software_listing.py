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


def insert_data():
    conn = db_conn.db_conn()
    cur = conn.cursor()
    query = 'insert into software_list(name, version) values (?, ?)'

    f = open('output.txt', 'r')
    line = f.readlines()
    for l in line[4:-2]:
        print(l.strip().split(' '))
        if " " in l.strip().split(' '):
            software = " ".join(l.strip().split(' ')[:-2])
        else:
            software = " ".join(l.strip().split(' ')[:-1])
        print("software : " + software)
        version = l.strip().split(' ')[-1]
        print("version : " + version)
        print(" ")

        try:
            cur.execute(query, (software, version))
            conn.commit()
        except mariadb.Error as e:
            print(f"Error: {e}")

    conn.close()
    f.close()
    os.remove('output.txt')


if __name__ == "__main__":
    software_listing()
    insert_data()

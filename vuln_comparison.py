import mariadb
import db_conn
from packaging import version
import webbrowser
from win10toast_click import ToastNotifier


class App():
    def __init__(self):
        super().__init__()
        self.conn = db_conn.db_conn()
        self.cur = self.conn.cursor()

    def __del__(self):
        self.conn.close()

    def open_url(self):
        try:
            webbrowser.open_new('https://nvd.nist.gov/vuln/detail/' + self.vuln_id)
        except:
            print('Failed to open URL. Unsupported variable type.')

    def get_software_list(self):
        get_software_list_query = 'select name, version from software_list'
        try:
            self.cur.execute(get_software_list_query)
        except mariadb.Error as e:
            print(f"Error: {e}")
        self.softwares = self.cur.fetchall()


    def vuln_comparison(self):
        get_cve_list_query = 'select * from cve_list'
        update_query = 'update software_list set vuln_check = %s, vuln_id = %s where name = %s'
        try:
            self.cur.execute(get_cve_list_query)
        except mariadb.Error as e:
            print(f"Error: {e}")
        self.rows = self.cur.fetchall()
        for row in self.rows:
            for software in self.softwares:
                if row[5].lower() in software[0].lower():
                    if version.parse(row[6]) <= version.parse(software[1]) <= version.parse(row[7]):
                        try:
                            self.cur.execute(update_query, ('1', row[0]), software[0])
                            self.conn.commit()

                            self.vuln_id = row[0]
                            toaster = ToastNotifier()
                            toaster.show_toast(
                                '[취약점 발생] ' + row[5],  # title
                                row[3],  # message
                                icon_path=None,
                                duration=5,
                                threaded=True,
                                callback_on_click=self.open_url
                            )
                        except mariadb.Error as e:
                            print(f"Error: {e}")
                    else:
                        try:
                            print('no')
                            self.cur.execute(update_query, ('0', None, software[0]))
                            self.conn.commit()
                        except mariadb.Error as e:
                            print(f"Error: {e}")


if __name__ == "__main__":
    app = App()

    app.get_software_list()
    app.vuln_comparison()

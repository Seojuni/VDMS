import tkinter
import tkinter.messagebox
import customtkinter

# vulnerability diagnosis
from ttkwidgets import CheckboxTreeview
from tkinter import ttk
import datetime
import winreg as reg
import subprocess
import time

# create report
from docx import Document
from docx.shared import Cm, Pt, RGBColor
import socket
import mariadb
import db_conn
import matplotlib.pyplot as plt
from matplotlib import font_manager, rc
from docx2pdf import convert
import os
from PyPDF2 import PdfFileMerger

# cve list
import webbrowser

# cve crawler
import threading
import schedule

customtkinter.set_appearance_mode("System")  # Modes: "System" (standard), "Dark", "Light"
customtkinter.set_default_color_theme("blue")  # Themes: "blue" (standard), "green", "dark-blue"


class App(customtkinter.CTk):
    WIDTH = 1280
    HEIGHT = 760

    def __init__(self):
        super().__init__()

        self.title("VDM.py")
        self.geometry(f"{App.WIDTH}x{App.HEIGHT}")
        self.protocol("WM_DELETE_WINDOW", self.on_closing)  # call .on_closing() when app gets closed

        # ============ create two frames ============
        self.grid_columnconfigure(1, weight=1)
        self.grid_rowconfigure(0, weight=1)

        self.frame_left = customtkinter.CTkFrame(master=self,
                                                 width=180,
                                                 corner_radius=0)
        self.frame_left.grid(row=0, column=0, sticky="nswe")

        self.frame_right = customtkinter.CTkFrame(master=self)
        self.frame_right.grid(row=0, column=1, sticky="nswe", padx=20, pady=20)

        # ============ frame_left ============
        self.frame_left.grid_rowconfigure(0, minsize=10)   # empty row with minsize as spacing
        self.frame_left.grid_rowconfigure(6, weight=1)  # empty row as spacing
        self.frame_left.grid_rowconfigure(8, minsize=20)    # empty row with minsize as spacing
        self.frame_left.grid_rowconfigure(11, minsize=10)  # empty row with minsize as spacing

        self.label_1 = customtkinter.CTkLabel(master=self.frame_left,
                                              text="Vulnerability Diagnosis",
                                              text_font=("Roboto Medium", -16))  # font name and size in px
        self.label_1.grid(row=1, column=0, pady=0, padx=0)
        self.label_2 = customtkinter.CTkLabel(master=self.frame_left,
                                              text="and Management",
                                              text_font=("Roboto Medium", -16))  # font name and size in px
        self.label_2.grid(row=2, column=0, pady=10, padx=10)

        self.button_1 = customtkinter.CTkButton(master=self.frame_left,
                                                text="취약점 진단",
                                                command=self.one_button_event)
        self.button_1.grid(row=3, column=0, pady=10, padx=20)

        self.button_2 = customtkinter.CTkButton(master=self.frame_left,
                                                text="CVE List",
                                                command=self.two_button_event)
        self.button_2.grid(row=4, column=0, pady=10, padx=20)

        self.button_3 = customtkinter.CTkButton(master=self.frame_left,
                                                text="Dashboard",
                                                command=self.three_button_event)
        self.button_3.grid(row=5, column=0, pady=10, padx=20)

        self.label_mode = customtkinter.CTkLabel(master=self.frame_left, text="Appearance Mode:")
        self.label_mode.grid(row=9, column=0, pady=0, padx=20, sticky="w")

        self.optionmenu_1 = customtkinter.CTkOptionMenu(master=self.frame_left,
                                                        values=["Light", "Dark", "System"],
                                                        command=self.change_appearance_mode)
        self.optionmenu_1.grid(row=10, column=0, pady=10, padx=20, sticky="w")

        # ============ frame_right ============
        self.frame_right.rowconfigure((0), weight=1)
        #self.frame_right.rowconfigure(7, weight=10)
        self.frame_right.columnconfigure((0), weight=1)
        #self.frame_right.columnconfigure(2, weight=0)

        self.frame_main = customtkinter.CTkFrame(master=self.frame_right)
        self.frame_main.grid(row=0, column=0, sticky="nsew")

        self.frame_main.rowconfigure(0, weight=1)
        self.frame_main.columnconfigure(0, weight=1)
        self.label_info = customtkinter.CTkLabel(master=self.frame_main,
                                                   text="Main Frame",
                                                   height=100,
                                                   corner_radius=6,  # <- custom corner radius
                                                   fg_color=("white", "gray38"),  # <- custom tuple-color
                                                   justify=tkinter.LEFT)
        self.label_info.grid(column=0, row=0, sticky="nwe", padx=15, pady=15)

        t = threading.Thread(target=self.cve_crawler)
        t.start()

        # set default values
        self.optionmenu_1.set("Dark")

    def cve_crawler(self):
        os.system("pythonw -u cve_crawler.py > log.log 2>&1")

        schedule.every(2).hour.do(self.cve_crawler)
        while True:
            schedule.run_pending()

    # go to vulnerability diagnosis
    def one_button_event(self):
        self.frame_one = customtkinter.CTkFrame(master=self.frame_right)
        self.frame_one.grid(row=0, column=0, sticky="nsew")

        self.frame_one.rowconfigure(0, weight=1)
        self.frame_one.columnconfigure(0, weight=1)

        my_os = self.get_os()
        date = self.get_date()

        s = ttk.Style()
        s.theme_use("clam")
        s.configure("Treeview.Heading", font=(None, 14), rowheight=int(14 * 10))
        s.configure("Treeview", font=(None, 12), rowheight=int(12 * 5))

        tree = CheckboxTreeview(self.frame_one)
        tree.grid()

        tree["columns"] = ["one"]
        tree.heading("#0", text='취약점 진단(' + my_os + ')')
        tree.heading("#1", text=date)

        if my_os == "Windows 10":
            tree.insert('', tkinter.END, text='계정 관리', iid=1, open=False)
            tree.insert('', tkinter.END, text='서비스 관리', iid=2, open=False)
            tree.insert('', tkinter.END, text='패치 관리', iid=3, open=False)
            tree.insert('', tkinter.END, text='보안 관리', iid=4, open=False)

            acc = ['[PC-01] (상) 패스워드의 주기적 변경', '[PC-02] (상) 패스워드 정책이 해당 기관의 보안 정책에 적합하게 설정',
                   '[PC-15] (중) 복구 콘솔에서 자동 로그온을 금지하도록 설정']

            for i in range(len(acc)):
                code = acc[i].split(' ')[0]
                tree.insert('', tkinter.END, text=acc[i], iid=code, open=False)

            for i in range(len(acc)):
                code = acc[i].split(' ')[0]
                for j in range(len(acc)):
                    tree.move(code, 1, j)

            ser = ['[PC-03] (상) 공유 폴더 제거', '[PC-04] (상) 항목의 불필요한 서비스 제거',
                   '[PC-05] (상) Windows Messenger와 같은 상용 메신저의 사용 금지', '[PC-16] (중) 파일시스템이 NTFS 포맷으로 설정',
                   '[PC-17] (중) 대상 시스템이 Windows 서버를 제외한 다른 OS로 멀티 부팅이 가능하지 않도록 설정',
                   '[PC-18] (하) 브라우저 종료 시 임시 인터넷 파일 폴더의 내용을 삭제하도록 설정']

            for i in range(len(ser)):
                code = ser[i].split(' ')[0]
                tree.insert('', tkinter.END, text=ser[i], iid=code, open=False)

            for i in range(len(ser)):
                code = ser[i].split(' ')[0]
                for j in range(len(ser)):
                    tree.move(code, 2, j)

            patch = ['[PC-06] (상) HOT FIX 등 최신 보안패치 적용', '[PC-07] (상) 최신 서비스팩 적용',
                     '[PC-08] (상) MS-Office, 한글, 어도비 아크로뱃 등 응용 프로그램에 대한 최신 보안패치 및 벤더 권고사항 적용']

            for i in range(len(patch)):
                code = patch[i].split(' ')[0]
                tree.insert('', tkinter.END, text=patch[i], iid=code, open=False)

            for i in range(len(patch)):
                for j in range(len(patch)):
                    code = patch[i].split(' ')[0]
                    tree.move(code, 3, j)

            sec = ['[PC-09] (상) 바이러스 백신 프로그램 설치 및 주기적 업데이트', '[PC-10] (상) 바이러스 백신 프로그램에서 제공하는 실시간 감시 기능 활성화',
                   '[PC-11] (상) OS에서 제공하는 침입차단 기능 활성화', '[PC-12] (상) 화면보호기 대기 시간 설정 및 재시작 시 암호 보호 설정',
                   '[PC-13] (상) CD, DVD, USB 메모리 등과 같은 미디어의 자동실행 방지 등 이동식 미디어에 대한 보안대책 수립',
                   '[PC-14] (상) PC 내부의 미사용(3개월) ActiveX 제거', '[PC-19] (중) 원격 지원을 금지하도록 정책 설정']

            for i in range(len(sec)):
                code = sec[i].split(' ')[0]
                tree.insert('', tkinter.END, text=sec[i], iid=code, open=False)

            for i in range(len(sec)):
                code = sec[i].split(' ')[0]
                for j in range(len(sec)):
                    tree.move(code, 4, j)

        tree.grid(row=0, column=0, sticky='nsew')

        self.button_start = customtkinter.CTkButton(master=self.frame_one,
                                                text="Start",
                                                command=lambda: self.vuln_diagnosis(tree))
        self.button_start.grid(row=1, column=0, pady=10, padx=20)

    # go to cve list
    def two_button_event(self):
        self.frame_two = customtkinter.CTkFrame(master=self.frame_right)
        self.frame_two.grid(row=0, column=0, sticky="nsew")

        self.frame_two.rowconfigure(0, weight=1)
        self.frame_two.columnconfigure(0, weight=1)
        self.label_two = customtkinter.CTkLabel(master=self.frame_two,
                                                   text="CVE LIST",
                                                   height=20,
                                                   corner_radius=6,  # <- custom corner radius
                                                   fg_color=("white", "gray38"),  # <- custom tuple-color
                                                   justify=tkinter.LEFT)
        self.label_two.pack(fill="x", padx=15, pady=15)

        s = ttk.Style()
        s.theme_use("clam")
        s.configure("Treeview.Heading", font=(None, 14), rowheight=int(14 * 10))
        s.configure("Treeview", font=(None, 12), rowheight=int(12 * 5))

        self.treeview = tkinter.ttk.Treeview(self.frame_two,
                                        height=50,
                                        columns=["vuln_id", "pub_date", "last_mod_date", "description", "score", "software",
                                                 "start_version", "end_version", "cwe_id", "cwe_name"],
                                        displaycolumns=["vuln_id", "pub_date", "last_mod_date", "description", "score",
                                                        "software", "start_version", "end_version", "cwe_id", "cwe_name"]
                                        )
        ysb = ttk.Scrollbar(self.frame_two, orient="vertical", command=self.treeview.yview)
        ysb.pack(side='right', fill='y', pady=15)
        self.treeview.configure(yscrollcommand=ysb.set)
        self.treeview.pack(fill="x", padx=15, pady=15)

        self.treeview.column("#0", width=40)
        self.treeview.heading("#0", text="Num")
        self.treeview.column("vuln_id", width=150, anchor="center")
        self.treeview.heading("vuln_id", text="CVE Code", anchor="center")
        self.treeview.column("pub_date", width=150, anchor="center")
        self.treeview.heading("pub_date", text="Published Date", anchor="center")
        self.treeview.column("last_mod_date", width=150, anchor="center")
        self.treeview.heading("last_mod_date", text="Last Modified", anchor="center")
        self.treeview.column("description", width=150, anchor="center")
        self.treeview.heading("description", text="Description", anchor="center")
        self.treeview.column("score", width=100, anchor="center")
        self.treeview.heading("score", text="Score", anchor="center")
        self.treeview.column("software", width=150, anchor="center")
        self.treeview.heading("software", text="Software", anchor="center")
        self.treeview.column("start_version", width=150, anchor="center")
        self.treeview.heading("start_version", text="Start Version", anchor="center")
        self.treeview.column("end_version", width=150, anchor="center")
        self.treeview.heading("end_version", text="End Version", anchor="center")
        self.treeview.column("cwe_id", width=150, anchor="center")
        self.treeview.heading("cwe_id", text="CWE ID", anchor="center")
        self.treeview.column("cwe_name", width=150, anchor="center")
        self.treeview.heading("cwe_name", text="CWE Name", anchor="center")

        self.treeview.bind("<Double-1>", self.OnDoubleClick)

        conn = db_conn.db_conn()
        cur = conn.cursor()

        select_query = "select * from cve_list"

        try:
            cur.execute(select_query)
        except mariadb.Error as e:
            print(f"Error: {e}")

        resultset = cur.fetchall()

        for i, data in enumerate(resultset):
            self.treeview.insert("", tkinter.END, text=i+1, values=data, iid=data[0])

        conn.close()

    # view cve detail webpage
    def OnDoubleClick(self, event):
        item = self.treeview.selection()[0]
        webbrowser.open('https://nvd.nist.gov/vuln/detail/'+self.treeview.item(item, "values")[0])

    # go to Dashboard
    def three_button_event(self):
        self.frame_main = customtkinter.CTkFrame(master=self.frame_right)
        self.frame_main.grid(row=0, column=0, sticky="nsew")

        self.frame_main.rowconfigure(0, weight=1)
        self.frame_main.columnconfigure(0, weight=1)
        self.label_info = customtkinter.CTkLabel(master=self.frame_main,
                                                 text="Main Frame",
                                                 height=100,
                                                 corner_radius=6,  # <- custom corner radius
                                                 fg_color=("white", "gray38"),  # <- custom tuple-color
                                                 justify=tkinter.LEFT)
        self.label_info.grid(column=0, row=0, sticky="nwe", padx=15, pady=15)

    def get_os(self):
        key = reg.HKEY_LOCAL_MACHINE
        key_value = "SOFTWARE\Microsoft\Windows NT\CurrentVersion"

        open = reg.OpenKey(key, key_value, 0, reg.KEY_READ)
        value, type = reg.QueryValueEx(open, "ProductName")

        reg.CloseKey(open)

        return " ".join(str(value).split(' ')[0:2])

    def get_date(self):
        week = datetime.date.today().weekday()
        days = str(datetime.date.today().day)
        month = datetime.date.today().month
        year = str(datetime.date.today().year)

        weeks = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
        months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
        date = weeks[week] + ", " + days + " " + months[month] + " " + year

        return date

    def vuln_diagnosis(self, tree):
        self.frame_one = customtkinter.CTkFrame(master=self.frame_right)
        self.frame_one.grid(row=0, column=0, sticky="nsew")

        self.frame_one.rowconfigure(0, weight=1)
        self.frame_one.columnconfigure(0, weight=1)

        selected = tree.get_checked()
        print(selected)
        flg = 0
        self.digdate = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')

        # textbox log
        self.scroll = tkinter.Scrollbar(self.frame_one, orient='vertical')
        self.lbox = tkinter.Listbox(self.frame_one, yscrollcommand=self.scroll.set, width=116)
        self.scroll.config(command=self.lbox.yview)
        self.lbox.grid(row=0, column=0, columnspan=5, sticky="nsew")
        self.append_log('Started diagnosing vulnerabilities.')

        # progress bar
        self.progressbar = customtkinter.CTkProgressBar(master=self.frame_one)
        self.progressbar.grid(row=1, column=0, sticky="ew", padx=15, pady=15)
        self.progressbar.set(0)

        self.button_save = customtkinter.CTkButton(master=self.frame_one,
                                                   text="Save",
                                                   command=self.create_report,
                                                   state="disabled")
        self.button_save.grid(row=2, column=0, pady=10, padx=20)

        # selected batch run
        for item in selected:
            self.append_log('Start diagnosing the ' + item[1:-1])

            #subprocess.call(['C:\\Users\\USER\\Desktop\\vdm\\script\\Windows PC\\' + item[1:-1] + '.bat'])
            print('C:\\Users\\USER\\Desktop\\vdm\\script\\Windows PC\\' + item[1:-1] + '.bat')

            self.progressbar.set((selected.index(item)+1) / len(selected) * 1.0)
            self.append_log(item[1:-1] + ' has been diagnosed.')

        flg = 1
        self.append_log('Vulnerability diagnosis is complete.')

        if flg == 1:
            self.button_save.configure(state="enabled")

    def append_log(self, msg):
        self.now = str(datetime.datetime.now())[0:-7]
        self.lbox.insert(tkinter.END, "[{}] {}".format(self.now, msg))
        self.lbox.update()
        self.lbox.see(tkinter.END)

    def create_report(self):
        conn = db_conn.db_conn()
        cur = conn.cursor()

        # save diagnostic result
        insert_query = 'insert into diagnostic_results(type_code, result) values (?, ?)'

        f = open("C:\\Users\\USER\\Desktop\\vdm\\script\\Windows PC\\result.txt", 'r')

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
        os.remove("C:\\Users\\USER\\Desktop\\vdm\\script\\Windows PC\\result.txt")

        # create pie chart
        select_query = 'select * from diagnostic_results'
        total_cnt = 0
        vuln_list = []
        pc_categorie1 = ['PC-01', 'PC-02', 'PC-15']
        pc_categorie2 = ['PC-03', 'PC-04', 'PC-05', 'PC-16', 'PC-17', 'PC-18']
        pc_categorie3 = ['PC-06', 'PC-07', 'PC-08']
        pc_categorie4 = ['PC-09', 'PC-10', 'PC-11', 'PC-12', 'PC-13', 'PC-14', 'PC-19']
        c1_cnt = 0
        c2_cnt = 0
        c3_cnt = 0
        c4_cnt = 0

        try:
            cur.execute(select_query)
        except mariadb.Error as e:
            print(f"Error: {e}")

        rows = cur.fetchall()
        for row in rows:
            if 'PC' in row[0]:
                total_cnt += 1
                if row[1] == '2':
                    vuln_list.append(row[0])
                    if row[0] in pc_categorie1:
                        c1_cnt += 1
                    elif row[0] in pc_categorie2:
                        c2_cnt += 1
                    elif row[0] in pc_categorie3:
                        c3_cnt += 1
                    elif row[0] in pc_categorie4:
                        c4_cnt += 1
            if 'W' in row[0]:
                print('Server')

        font_path = "C:/Windows/Fonts/NGULIM.TTF"
        font = font_manager.FontProperties(fname=font_path).get_name()
        rc('font', family=font)

        vuln_per = '%.1f' % (len(vuln_list) / total_cnt * 100.0)
        good_per = '%.1f' % (100.0 - float(vuln_per.split('%')[0]))

        ratio = [good_per, vuln_per]
        labels = ['양호', '취약']
        colors = ['#8fd9b6', '#ff9999']
        explode = [0.05, 0]

        plt.figure(figsize=(5, 5), dpi=100)
        plt.pie(ratio, labels=labels, autopct='%.1f%%', colors=colors, explode=explode)
        plt.savefig('pie1.png')

        plt.clf()

        ratio = [c1_cnt, c2_cnt, c3_cnt, c4_cnt]
        labels = ['계정 관리', '서비스 관리', '패치 관리', '보안 관리']
        explode = [0.05, 0.05, 0.05, 0.05]

        plt.pie(ratio, labels=labels, autopct='%.1f%%', explode=explode)
        plt.savefig('pie2.png')

        # create report cover
        doc = Document()

        doc.add_heading('취약점 진단 결과 보고서', level=0)
        doc.add_heading('점검 대상', level=1)
        table = doc.add_table(rows=3, cols=2)
        table.style = doc.styles['Table Grid']
        first_row = table.rows[0].cells
        first_row[0].text = '대상 이름'
        first_row[1].text = socket.gethostname()
        second_row = table.rows[1].cells
        second_row[0].text = '대상 운영체제'
        second_row[1].text = self.get_os()
        third_row = table.rows[2].cells
        third_row[0].text = '점검 시각'
        third_row[1].text = self.digdate

        doc.add_paragraph('')
        doc.add_paragraph('')

        doc.add_heading('점검 결과', level=1)
        p = doc.add_paragraph()
        p.add_run('  취약항목 : ').bold = True
        for vuln in vuln_list:
            if vuln == vuln_list[-1]:
                p.add_run(vuln)
            else:
                p.add_run(vuln + ', ')

        p = doc.add_paragraph()
        r = p.add_run()
        r.add_picture('pie1.png', width=Cm(7.5), height=Cm(7.5))
        r.add_picture('pie2.png', width=Cm(7.5), height=Cm(7.5))

        doc.add_paragraph('')
        doc.add_paragraph('')
        doc.add_paragraph('')
        doc.add_paragraph('')
        doc.add_paragraph('')

        para = doc.add_paragraph('해당 취약점 진단은 KISA 주요정보통신기반시설 기술적 취약점 분석ㆍ평가 방법 상세가이드를 기반하여 진단하였습니다.')
        para = doc.paragraphs[-1].runs
        doc.paragraphs[-1].runs[0].italic = True
        for run in para:
            run.font.size = Pt(8)
            run.font.color.rgb = RGBColor(0x78, 0x95, 0x3D)

        doc.save('report.docx')
        os.remove('pie1.png')
        os.remove('pie2.png')

        # report cover docx to pdf
        inputFile = 'report.docx'
        outputFile = 'report.pdf'
        file = open(outputFile, 'w')
        file.close()

        convert(inputFile, outputFile)
        os.remove(inputFile)

        # merge reports
        merger = PdfFileMerger()

        merger.append(outputFile)
        for vuln in vuln_list:
            merger.append("C:\\Users\\USER\\Desktop\\vdm\\Report Source\\Windows PC\\" + vuln + ".pdf")

        merger.write("C:\\Users\\USER\\Desktop\\Report.pdf")
        merger.close()

        os.remove(outputFile)

        conn = db_conn.db_conn()
        tkinter.messagebox.showinfo("Save", "보고서가 저장되었습니다.")

    def change_appearance_mode(self, new_appearance_mode):
        customtkinter.set_appearance_mode(new_appearance_mode)

    def on_closing(self, event=0):
        self.destroy()


if __name__ == "__main__":
    app = App()
    app.mainloop()

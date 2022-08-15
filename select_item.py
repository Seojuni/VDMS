#CheckboxTreeview 오류 시 cmd창에서 pip install ttkwidgets 명령어 실행
#pip 버전이 최신버전이 아니라면 python -m pip install --upgrade pip 명령어 실행 후 위에 명령어 다시 실행
from ttkwidgets import CheckboxTreeview 

import tkinter as tk
import tkinter
from tkinter import ttk
from tkinter import *
from tkinter.messagebox import showinfo
import tkinter.messagebox as msbox

from datetime import datetime

import platform

import subprocess



my_os=platform.system()
os_rel=platform.release()



#if my_os=="Darwin":
#    my_os="Mac"


datetime.today()
datetime.today().year
datetime.today().month
datetime.today().day

day=datetime.today().strftime("%A"+', '+"%d"+' '+"%B"+' '+"%Y")


    

# create root window
root = tk.Tk()
root.title('취약점 진단')
root.geometry('1280x960')





# configure the grid layout
root.rowconfigure(0, weight=1)
root.columnconfigure(0, weight=1)





# create a treeview
tree = CheckboxTreeview(root)
tree.grid()
       
#def select_item():
    
    





tree["columns"]=["one"]
if os_rel=="10" or "11":
    name='PC'
else:
    name='Server'
tree.heading("#0", text='취약점 진단('+my_os+' '+name+')')
tree.heading("#1", text=day)




if my_os=="Windows":
    if os_rel=="10" or "11":
        # adding data
        tree.insert('', tk.END, text='계정 관리', iid=0, open=False)
        tree.insert('', tk.END, text='서비스 관리', iid=1, open=False)
        tree.insert('', tk.END, text='패치 관리', iid=2, open=False)
        tree.insert('', tk.END, text='보안 관리', iid=3, open=False)


        acc=['Administrator 계정 이름 변경 또는 보안성 강화','Guest 계정 비활성화','불필요한 계정 제거','계정 잠금 임계값 설정','해독 가능한 암호화를 사용하여 암호 저장 해제','관리자 그룹에 최소한의 사용자 포함','Everyone 사용권한을 익명 사용자에 적용 해제',
             '계정 잠금 기간 설정','패스워드 복잡성 설정','패스워드 최소 암호 길이','패스워드 최대 사용 기간','패스워드 최소 사용 기간','마지막 사용자 이름 표시 안함','로컬 로그온 허용', '익명 SID/이름 변환 허용 해제',
             '최근 암호 기억', '콘솔 로그온 시 로컬 계정에서 빈 암호 사용 제한','원격터미널 접속 가능한 사용자 그룹 제한']

        for i in range(6, 24):
            tree.insert('', tk.END, text=acc[i-6], iid=i, open=False)
            

        for i in range(6, 24):
            for j in range(0, 19):
                tree.move(i, 0, j)


        ser=['공유 권한 및 사용자 그룹 설정','하드디스크 기본 공유 제거','불필요한 서비스 제거','IIS 서비스 구동 점검', 'IIS 디렉토리 리스팅 제거','IIS CGI 실행 제한','IIS 상위 디렉토리 접근 금지', 'IIS 불필요한 파일 제거','IIS 웹프로세스 권한 제한',
             'IIS 링크 사용 금지','IIS 파일 업로드 및 다운로드 제한','IIS DB 연결 취약점 점검','IIS 가상 디렉토리 삭제','IIS 데이터파일 ACL 적용', 'IIS 미사용 스크립트 매핑 제거', 'IIS Exec 명령어 쉘 호출 진단', 'IIS WebDAV 비활성화',
             'NetBIOS 바인딩 서비스 구동 점검','FTP 서비스 구동 점검','FTP 디렉토리 접근 권한 설정','Anonymous FTP 금지', 'FTP 접근 제어 설정', 'DNS Zone Transfer 설정', 'RDS(Remonte Data Services) 제거',
             '최신 서비스팩 적용', '터미널 서비스 암호화 수준 설정','IIS 웹 서비스 정보 숨김','SNMP 서비스 구동 점검', 'SNMP 서비스 커뮤니티스트링의 복잡성 설정','SNMP Access control 설정','DNS 서비스 구동 점검',
             'HTTP/FTP/SMTP 배너 차단','Telnet 보안 설정', '불필요한 ODBC/OLE=DB 데이터소스와 드라이브 제거', '원격터미널 접속 타임아웃 설정', '예약된 작업에 의심스러운 명령이 등록되어 있는지 점검']

        for i in range(24, 60):
            tree.insert('', tk.END, text=ser[i-24], iid=i, open=False)
            

        for i in range(24, 60):
            for j in range(0, 37):
                tree.move(i, 1, j)




        patch=['최신 HOT FIX 적용', '백신 프로그램 업데이트', '정책에 따른 시스템 로깅설정']

        for i in range(60, 63):
            tree.insert('', tk.END, text=patch[i-60], iid=i, open=False)

        for i in range(60, 63):
            for j in range(0, 3):
                tree.move(i, 2, j)




        sec=['백신 프로그램 설치','SAM 파일 접근 통제 설정','화면보호기 설정','로그온 하지않고 시스템 종료 허용 해제','원격 시스템에서 강제로 시스템 종료', '보안감사를 로그할 수 없는 경우 즉시 시스템 종료 해제', 'SAM 계정과 공유의 익명 열거 허용 안함',
             'Autologon 기능 제어', '이동식 미디어 포맷 및 꺼내기 허용', '디스크 볼륨 암호화 설정', 'Dos 공격 방어 레지스트리 설정', '사용자가 프린터 드라이버를 설치할 수 없게 함','세션 연결을 중단하기 전에 필요한 유휴시간',
             '경고 메시지 설정', '사용자별 홈 디렉토리 권한 설정', 'LAN Manager 인증 수준','보안 채널 데이터 디지털 암호화 또는 서명', '파일 및 디렉토리 보호', '컴퓨터 계정 암호 최대 사용 기간','시작 프로그램 목록 분석']

        for i in range(63, 83):
            tree.insert('', tk.END, text=sec[i-67], iid=i, open=False)

        for i in range(63, 83):
            for j in range(0, 20):
                tree.move(i, 3, j)


        


    else:


        # adding data
        tree.insert('', tk.END, text='계정 관리', iid=0, open=False)
        tree.insert('', tk.END, text='서비스 관리', iid=1, open=False)
        tree.insert('', tk.END, text='패치 관리', iid=2, open=False)
        tree.insert('', tk.END, text='로그 관리', iid=3, open=False)
        tree.insert('', tk.END, text='보안 관리', iid=4, open=False)
        tree.insert('', tk.END, text='DB 관리', iid=5, open=False)



        acc=['Administrator 계정 이름 변경 또는 보안성 강화','Guest 계정 비활성화','불필요한 계정 제거','계정 잠금 임계값 설정','해독 가능한 암호화를 사용하여 암호 저장 해제','관리자 그룹에 최소한의 사용자 포함','Everyone 사용권한을 익명 사용자에 적용 해제',
             '계정 잠금 기간 설정','패스워드 복잡성 설정','패스워드 최소 암호 길이','패스워드 최대 사용 기간','패스워드 최소 사용 기간','마지막 사용자 이름 표시 안함','로컬 로그온 허용', '익명 SID/이름 변환 허용 해제',
             '최근 암호 기억', '콘솔 로그온 시 로컬 계정에서 빈 암호 사용 제한','원격터미널 접속 가능한 사용자 그룹 제한']

        for i in range(6, 24):
            tree.insert('', tk.END, text=acc[i-6], iid=i, open=False)
            

        for i in range(6, 24):
            for j in range(0, 19):
                tree.move(i, 0, j)


        ser=['공유 권한 및 사용자 그룹 설정','하드디스크 기본 공유 제거','불필요한 서비스 제거','IIS 서비스 구동 점검', 'IIS 디렉토리 리스팅 제거','IIS CGI 실행 제한','IIS 상위 디렉토리 접근 금지', 'IIS 불필요한 파일 제거','IIS 웹프로세스 권한 제한',
             'IIS 링크 사용 금지','IIS 파일 업로드 및 다운로드 제한','IIS DB 연결 취약점 점검','IIS 가상 디렉토리 삭제','IIS 데이터파일 ACL 적용', 'IIS 미사용 스크립트 매핑 제거', 'IIS Exec 명령어 쉘 호출 진단', 'IIS WebDAV 비활성화',
             'NetBIOS 바인딩 서비스 구동 점검','FTP 서비스 구동 점검','FTP 디렉토리 접근 권한 설정','Anonymous FTP 금지', 'FTP 접근 제어 설정', 'DNS Zone Transfer 설정', 'RDS(Remonte Data Services) 제거',
             '최신 서비스팩 적용', '터미널 서비스 암호화 수준 설정','IIS 웹 서비스 정보 숨김','SNMP 서비스 구동 점검', 'SNMP 서비스 커뮤니티스트링의 복잡성 설정','SNMP Access control 설정','DNS 서비스 구동 점검',
             'HTTP/FTP/SMTP 배너 차단','Telnet 보안 설정', '불필요한 ODBC/OLE=DB 데이터소스와 드라이브 제거', '원격터미널 접속 타임아웃 설정', '예약된 작업에 의심스러운 명령이 등록되어 있는지 점검']

        for i in range(24, 60):
            tree.insert('', tk.END, text=ser[i-24], iid=i, open=False)
            

        for i in range(24, 60):
            for j in range(0, 37):
                tree.move(i, 1, j)




        patch=['최신 HOT FIX 적용', '백신 프로그램 업데이트', '정책에 따른 시스템 로깅설정']

        for i in range(60, 63):
            tree.insert('', tk.END, text=patch[i-60], iid=i, open=False)

        for i in range(60, 63):
            for j in range(0, 3):
                tree.move(i, 2, j)


        log=['로그의 정기적 검토 및 보고', '원격으로 엑세스 할 수 있는 레지스트리 경로', '이벤트 로그 고나리 설정', '원격에서 이벤트 로그파일 접근 차단']

        for i in range(63, 67):
            tree.insert('', tk.END, text=log[i-63], iid=i, open=False)

        for i in range(63, 67):
            for j in range(0, 4):
                tree.move(i, 3, j)



        sec=['백신 프로그램 설치','SAM 파일 접근 통제 설정','화면보호기 설정','로그온 하지않고 시스템 종료 허용 해제','원격 시스템에서 강제로 시스템 종료', '보안감사를 로그할 수 없는 경우 즉시 시스템 종료 해제', 'SAM 계정과 공유의 익명 열거 허용 안함',
             'Autologon 기능 제어', '이동식 미디어 포맷 및 꺼내기 허용', '디스크 볼륨 암호화 설정', 'Dos 공격 방어 레지스트리 설정', '사용자가 프린터 드라이버를 설치할 수 없게 함','세션 연결을 중단하기 전에 필요한 유휴시간',
             '경고 메시지 설정', '사용자별 홈 디렉토리 권한 설정', 'LAN Manager 인증 수준','보안 채널 데이터 디지털 암호화 또는 서명', '파일 및 디렉토리 보호', '컴퓨터 계정 암호 최대 사용 기간','시작 프로그램 목록 분석']

        for i in range(67, 87):
            tree.insert('', tk.END, text=sec[i-67], iid=i, open=False)

        for i in range(67, 87):
            for j in range(0, 20):
                tree.move(i, 4, j)



        tree.insert('', tk.END, text='Windows 인증 모드 사용', iid=87, open=False)
        tree.move(87, 5, 0)

        



    

list_frame=Frame(root)
filename=str(day)+'.txt'

#해당 py파일이 존재해야 오류안남
def saveFile():
    file=open(filename,"w")
    
    selected=tree.focus()
    temp=tree.item(selected,'values')
    

    if my_os=="Windows":
        if os_rel=="10" or "11":
            if (selected=='0'):
                for i in range(6, 24): #앞에 0이 붙어야하는데
                    subprocess.call([r'C:\Users\USER\Desktop\script\Windows PC\PC-'+str(i).zfill(2)+'.bat'])
                    #print('C:UsersUSEResktopscriptindows PCPC-' + str(i).zfill(2) + '.bat')#파일출력 확인
            elif (selected=='1'):
                for i in range(24, 60):
                    subprocess.call([r'C:\Users\USER\Desktop\script\Windows PC\PC-'+str(i)+'.bat'])
            elif (selected=='2'):
                for i in range(60, 63):
                    subprocess.call([r'C:\Users\USER\Desktop\script\Windows PC\PC-'+str(i)+'.bat'])
            elif (selected=='3'):
                for i in range(63, 67):
                    subprocess.call([r'C:\Users\USER\Desktop\script\Windows PC\PC-'+str(i)+'.bat'])
            elif (selected=='4'):
                for i in range(67, 87):
                    subprocess.call([r'C:\Users\USER\Desktop\script\Windows PC\PC-'+str(i)+'.bat'])
            elif (selected=='5'):
                subprocess.call([r'C:\Users\USER\Desktop\script\Windows PC\PC-'+str(i)+'.bat'])#sub 파일 open
            else: #위에는 부모선택 시 자녀 파일 오픈 해당 부분은 선택한 부분만 open
                subprocess.call([r'C:\Users\USER\Desktop\script\Windows PC\PC-'+str(selected).zfill(2)+'.bat'])
            #print('C:UsersUSERDesktopcriptindows PCPC-'+str(i).zfill(2)+'.bat') #파일출력 확인
        
        else:
            if (selected=='0'):
                for i in range(6, 24):
                    subprocess.call([r'C:\Users\USER\Desktop\script\Windows Server\W-'+str(i).zfill(2)+'.bat'])
            elif (selected=='1'):
                for i in range(24, 60):
                    subprocess.call([r'C:\Users\USER\Desktop\script\Windows Server\W-'+str(i)+'.bat'])
            elif (selected=='2'):
                for i in range(60, 63):
                    subprocess.call([r'C:\Users\USER\Desktop\script\Windows Server\W-'+str(i)+'.bat'])
            elif (selected=='3'):
                for i in range(63, 83):
                    subprocess.call([r'C:\Users\USER\Desktop\script\Windows Server\W-'+str(i)+'.bat'])
            else: #위에는 부모선택 시 자녀 파일 오픈 해당 부분은 선택한 부분만 open
                subprocess.call([r'C:\Users\USER\Desktop\script\Windows Server\W-'+str(selected).zfill(2)+'.bat'])
    
    
    
        


btn1=Button(root, text='start', command=saveFile)
btn1.grid(row=1, column=0)



# place the Treeview widget on the root window
tree.grid(row=0, column=0, sticky='nsew')

# run the app
root.mainloop()




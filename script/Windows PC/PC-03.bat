@ECHO OFF
rem[PC-03] (상) 2. 서비스 관리 >.3 공유 폴더 제거
secedit /EXPORT /CFG LocalSecurityPolicy.txt

TYPE LocalSeurityPoilicy.txt | findstr "C$ D$ Admin$" > share_folder.txt

rem 1 : 양호 /2: 취약
IF EXIST "C:\share_folder\" (
    net share /delete C$
    net share /delete D$
    net share /delete Admin$
        ECHO PC-03 1 >> result.txt
        )
else (
        ECHO PC-03 2 >> result.txt
)

DEL LocalSeurityPolicy.txt
DEL share_folder.txt






@ECHO OFF
REM[PC-09] (상) 4. 보안관리 > 4.1 바이러스 백신 프로그램 설치 및 주기적 업데이트

secedit /EXPORT /CFG LocalSeurityPoilicy.txt

TYPE LocalSecurityPolicy.txt | find -i "INSTALLING_VACCINE" >> vaccine.txt
TYPE LocalSecurityPolicy.txt | find -i "LATEST_UPDATES" >> updates.txt

IF %INSTALLING_VACCINE% EQU 1(
    IF %LATEST_UPDATES% EQU 1(
       ECHO PC-09 1 >> result.txt
     )ELSE( 
        ECHO PC-09 2 >> result.txt
     )
)ELSE(

 ECHO PC-09 2 >> result.txt
)

DEL LocalSeurityPoilicy.txt
DEL vaccine.txt
DEL updates.txt
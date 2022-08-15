@ECHO OFF 
REM [PC-10] (상) 4.보안관리> 바이러스 백신 프로그램에서 제공하는 실시간 감시 기능 
활성화
secedit /EXPORT /CFG LocalSeurityPolicy.txt

TYPE LocalSeurityPoilicy.txt | find -i "REAL_TIME_INSPECTION" >> inspection.txt


rem 1 : 양호 /2: 취약
IF %REAL_TIME_INSPECTION% EQU 1(
        ECHO PC-09 1 >> result.txt
)ELSE(
 ECHO PC-09 2 >> result.txt
)

DEL LocalSeurityPolicy.txt
DEL inspection.txt

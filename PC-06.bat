@ECHO OFF
REM[PC-06] (상) 3. 패치 관리 > 3.1 HOT FIX 등 최신 보안패치 적용

secedit /EXPORT /CFG LocalSeurityPoilicy.txt

TYPE LocalSecurityPolicy.txt | find -i "HOT_FIX" >> HOT__FIX.txt
TYPE LocalSecurityPolicy.txt | find -i "managementProcedure" >> manage_pro.txt

rem 1: 양호/ 2: 취약


IF %HOT_FIX% EQU 1(
    IF %managementProcedure% EQU 1(
        ECHO PC-06 1 >> result.txt
    )
    ELSE ECHO PC-06 2 >> result.txt
)ELSE ECHO PC-06 >> result.txt

DEL LocalSeurityPoilicy.txt
DEL HOT_FIX.txt
DEL manage_pro.txt
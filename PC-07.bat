REM[PC-07] (상) 3. 패치관리 > 3.2 최신 서비스팩 적용

secedit /EXPORT /CFG LocalSeurityPoilicy.txt

TYPE LocalSecurityPolicy.txt | find -i "LATEST_SERVICES" >> lastes.txt
TYPE LocalSecurityPolicy.txt | find -i "managementProcedure" >> manage_pro.txt

IF %LATEST_SERVICES% EQU 1(
    IF %managementProcedure% EQU 1(
        ECHO PC-07 1 >> result.txt
    ) ELSE ECHO PC-07 2 >> result.txt
)ELSE(

 ECHO PC-07 2 >> result.txt
)

DEL LocalSeurityPoilicy.txt
DEL lastes.txt
DEL manage_pro.txt
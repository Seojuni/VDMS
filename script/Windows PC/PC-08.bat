@ECHO OFF

rem [PC-08] (상) 3. 패치관리 > 3.3 MS-Office, 한글, 어도비 등의 으용 프로그램에 대한 최신 보안 패치 및 벤더 권고사항 적용

secedit /EXPORT /CFG LocalSeurityPolicy.txt
TYPE LocalSecurityPolicy.txt | find -i "LATEST_PATCHES" > lastes.txt
TYPE LocalSecurityPolicy.txt | find -i "managementProcedure" > manage_pro.txt

rem 1 : 양호 / 2 : 취약
IF %LATEST_PATCHES% EQU 1 (
    IF %managementProcedure% EQU 1 (
        ECHO PC-08 1 >> result.txt
    ) ELSE (
        ECHO PC-08 2 >> result.txt
    )
) ELSE (
    ECHO PC-08 2 >> result.txt
)

DEL LocalSeurityPolicy.txt
DEL lastes.txt
DEL manage_pro.txt

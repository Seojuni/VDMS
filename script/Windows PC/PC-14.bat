@ECHO OFF

REM[PC-14] (상) 4.보안관리 > 4.6 PC내부의 미사용(3개월) ActiveX 제거

secedit /EXPORT /CFG LocalSeurityPoilicy.txt
TYPE LocalSecurityPolicy.txt | find -i "ActiveX_INSPECTION" >> inspection.txt
TYPE LocalSecurityPolicy.txt | find -i "ActiveX_Delete" >>delete.txt

rem 1 : 양호 /2: 취약



IF %ActiveX_INSPECTION% EQU 1(
    IF %ActiveX_Delete% EQU 1(
            ECHO PC-14 1 result.txt
    )ELSE(
            ECHO PC-14 2 result.txt
    )
)ELSE(
    ECHO PC-14 2 result.txt
)

DEL LocalSecurityPolicy.txt
DEL inspection.txt
DEL delete.txt

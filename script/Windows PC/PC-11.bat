@ECHO OFF
REM[PC-11] (상) 4. 보안관리 > 4.3 OS에서 제공하는 침입차단 기능 활성화

secedit /EXPORT /CFG LocalSeurityPoilicy.txt
TYPE LocalSecurityPolicy.txt | find -i "WINDOWS_FIREWALL" >> windows.txt
TYPE LocalSecurityPolicy.txt | find -i "OTHER_FIREWALL" >>other.txt

rem 1 : 양호 /2: 취약


IF %WINDOWS_FIREWALL% EQU 1(
    IF %PAID_FIREWALL% EQU 1
        ECHO PC-11 1 >> result.txt
    )ELSE(
        ECHO PC-11 2 >> result.txt
    )
)ELSE(
    ECHO PC-11 2 >> result.txt
)

DEL LocalSecurityPolicy.txt
DEL windows.txt
DEL other.txt

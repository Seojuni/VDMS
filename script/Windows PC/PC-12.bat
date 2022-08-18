@ECHO OFF
rem [PC-12] (상) 4. 보안 관리 > 4.4 화면보호기 대기 시간 설정 및 재시작 시 암호로 보호 설정

secedit /EXPORT /CFG LocalSeurityPolicy.txt
TYPE LocalSecurityPolicy.txt | find -i "SCREEN_SAVER" > windows.txt
TYPE LocalSecurityPolicy.txt | find -i "PASSWORD_PROTECTION" > password_protect.txt

rem 1 : 양호 / 2 : 취약
IF %SCREEN_SAVER% LEQ 10 (
    IF %PASSWORD_PROTECTION% EQU 1 (
        ECHO PC-12 1 >> result.txt
    ) ELSE (
        ECHO PC-12 2 >> result.txt
    )
) ELSE (
    ECHO PC-12 2 >> result.txt
)


DEL LocalSecurityPolicy.txt
DEL windows.txt
DEL password_protect.txt

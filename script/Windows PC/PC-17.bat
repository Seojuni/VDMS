@ECHO OFF

REM[PC-17] (중) 2.서비스 관리 > 2.5 대상 시스템이 Windows 서버를 제외한 다른 OS로 멀티부틸이 가능하지 않도록 설정


secedit /EXPORT /CFG LocalSeurityPolicy.txt
TYPE LocalSecurityPolicy.txt | find -i "MULTI_BOOTING" >> multi.txt

IF %MULTI_BOOTING% EQU 1 (
    ECHO PC-16 1 >> result.txt
)ELSE (
    ECHO PC-16 2 >> result.txt

)

DEL LocalSecurityPolicy.txt
DEL multi.txt



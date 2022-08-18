@ECHO OFF

rem [PC-04] (상) 2.서비스 관리 > 2.2 불필요한 서비스 제거

secedit /EXPORT /CFG LocalSeurityPolicy.txt

TYPE LocalSecurityPolicy.txt | find -i "Unnecessary_service" > uncecessary.txt

rem 1 : 양호 /2: 취약

IF %Unnecessary_service% NEQ 1 (
    ECHO PC-04 1 >> result.txt
) ELSE (
    ECHO PC-04 2 >> result.txt
)

DEL LocalSecurityPolicy.txt
DEL Unnecessary.txt 

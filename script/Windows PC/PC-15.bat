@ECHO OFF

REM[PC-15] (중) 1. 계정관리 > 1.3 복구 콘솔에서 자동 로그온을 금지하도록 설정

secedit /EXPORT /CFG LocalSeurityPoilicy.txt
TYPE LocalSecurityPolicy.txt | find -i "Recovery_Console" >> recovery.txt


rem 1 : 양호 /2: 취약

IF %Recovery_Console% NEQ 1 (
    ECHO PC-15 1 >> result.txt
)ELSE(
    ECHO PC-15 2 >> result.txt
)

DEL LocalSecurityPolicy.txt
DEL recovery.txt
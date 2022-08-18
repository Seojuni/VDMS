@ECHO OFF

rem [PC-19] (중) 4.보안관리 > 4.7 원격 지우너을 금지하도록 정책 설정

secedit /EXPORT /CFG LocalSeurityPolicy.txt
TYPE LocalSecurityPolicy.txt | find -i "REMOTE_PROCEDURE" > remote.txt

rem 1 : 양호 / 2 : 취약
IF %REMOTE_PROCEDURE% NEQ 1 (
    ECHO PC-19 1 >> result.txt
) ELSE (
    ECHO PC-19 2 >> resuilt.txt
)

DEL LocalSecurityPolicy.txt
DEL remote.txt

@ECHO OFF

REM[PC-18] (하) 2.서비스 관리 > 2.6 브라우저 종료 시 임시 인터넷 파일 폴더의 내용을 삭제하도록 설정

secedit /EXPORT /CFG LocalSeurityPoilicy.txt

TYPE LocalSecurityPolicy.txt | find -i "EMPTY_FOLDER" >> empty.txt

IF %EMPTY_FOLDER% EQU 1(
    ECHO PC-18 1 >> result.txt
)ELSE (
    ECHO PC-18 2 >> result.txt
)

DEL LocalSecurityPolicy.txt
DEL empty.txt
PAUSE
@ECHO OFF

REM[PC-13] (상) 4. 보안관리 > 4.5 CD, DVD, USB메모리 등과 같은 미디어의 자동실행 방지 등 이동식 미디어에 대한 보안대책 수립

secedit /EXPORT /CFG LocalSeurityPoilicy.txt
TYPE LocalSecurityPolicy.txt | find -i "AUTOMATIC_MEDIA" >> auto_media.txt
TYPE LocalSecurityPolicy.txt | find -i "MANAGEMENT_PROCEDURE" >>management.txt

rem 1 : 양호 /2: 취약


IF %AUTOMATIC_MEDIA% NEQ 1(
    IF %MANAGEMENT_PROCEDURE% EQU 1(
             ECHO PC-13 1 >> result.txt
    )ELSE(
             ECHO PC-13 2 >> result.txt
    )   
)ELSE(
     ECHO PC-13 2 result.txt
)

DEL LocalSecurityPolicy.txt
DEL auto_media.txt
DEL management.txt
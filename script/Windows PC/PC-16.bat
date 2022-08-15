@ECHO OFF

REM[PC-16] (중) 2.서비스 관리 > 2.4 파일 시스템을 NTFS 포맷으로 설정

secedit /EXPORT /CFG LocalSeurityPolicy.txt
TYPE LocalSecurityPolicy.txt | find -i "FILE_SYSTEM_NTFS" >> NTFS.txt
TYPE LocalSecurityPolicy.txt | find -i "FILE_SYSTEM_FAT32" >> FAT32.txt


rem 1 : 양호 /2: 취약

IF %FILE_SYSTEM_NTFS% EQU 1(
         ECHO PC-16 1 >> result.txt
)ELSE(
     %FILE_SYSTEM_FAT32(
        ECHO PC-16 2 >>  result.txt
    )
)

DEL LocalSecurityPolicy.txt
DEL NTFS.txt
DEL FAT32.txt

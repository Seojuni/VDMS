@ECHO OFF

rem [PC-05] (상) 2.서비스 관리 > 2.3 Windows Messenger와 같은 상용 메신저의 사용금지

secedit /EXPORT /CFG LocalSeurityPolicy.txt
TYPE LocalSecurityPolicy.txt | find -i "Windows_Messenger" > Messenger.txt
TYPE LocalSecurityPolicy.txt | find -i "commercialMessengerInstallation" > CMMSN_INSTL.txt

rem 1 : 양호 /2: 취약
If %Windows_Messenger% NEQ 1 (
        IF %commercialMessengerInstallation% NEQ 1 (
                ECHO PC-05 1 >> result.txt
        ) ELSE (
                ECHO PC-05 2 >> result.txt
        )
) ELSE (
        ECHO PC-05 2 >> result.txt
)

DEL LocalSecurityPolicy.txt
DEL Messenger.txt
DEL CMMSN_INSTL.txt

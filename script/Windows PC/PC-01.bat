@ECHO OFF

rem [PC-01] (상) 1. 계정관리 > 1.1 패스워드의 주기적 변경

secedit /EXPORT /CFG LocalSecurityPolicy.txt
TYPE LocalSecurityPolicy.txt | find "MinimumPasswordAge =" > passwd_minage.txt
TYPE LocalSecurityPolicy.txt | find "MaximumPasswordAge =" > passwd_maxage.txt

FOR /f "tokens=1-3" %%a IN (passwd_minage.txt) DO SET passwd_minage=%%c
FOR /f "tokens=1-3" %%a IN (passwd_maxage.txt) DO SET passwd_maxage=%%c

rem 1 : 양호 / 2 : 취약
IF %passwd_maxage% LEQ 90 (
	IF %passwd_minage% GEQ 1 (
		ECHO PC-01 1 > result.txt
	) ELSE (
		ECHO PC-01 2 > result.txt
	)
) ELSE (
	ECHO PC-01 2 > result.txt
)

DEL LocalSecurityPolicy.txt
DEL passwd_minage.txt
DEL passwd_maxage.txt

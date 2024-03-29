@ECHO OFF

rem [PC-02] (상) 1. 계정관리 > 1.2 패스워드 정책이 해당 기관의 보안 정책에 적합하게 설정

secedit /EXPORT /CFG LocalSecurityPolicy.txt
TYPE LocalSecurityPolicy.txt | find "PasswordComplexity =" > passwd_comp.txt
TYPE LocalSecurityPolicy.txt | find "MinimumPasswordLength =" > passwd_minlen.txt
FOR /f "tokens=1-3" %%a IN (passwd_comp.txt) DO SET passwd_complexity=%%c
FOR /f "tokens=1-3" %%a IN (passwd_minlen.txt) DO SET passwd_minlength=%%c

rem 1 : 양호 / 2 : 취약
IF %passwd_complexity% EQU 1 (
	IF %passwd_minlength% GEQ 8 (
		ECHO PC-02 1 >> result.txt
	) ELSE (
		ECHO PC-02 2 >> result.txt
	)
) ELSE (
	ECHO PC-02 2 >> result.txt
)

DEL LocalSecurityPolicy.txt
DEL passwd_comp.txt
DEL passwd_minlen.txt

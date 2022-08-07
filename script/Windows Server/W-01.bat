@echo off
REM [W-01] (상) 1. 계정관리 > 1.1 Administrator 계정 이름 변경 또는 보안성 강화

chcp 437 >nul 2>&1
:W_01
set YEAR=%date:~0,4%
set MONTH=%date:~5,2%
set DAY=%date:~8,2%

set OUTPUT_DIRECTORY=C:\INSPECT\%YEAR%_%MONTH%_%DAY%_INSPECTION\
set OUTPUT_FILE=%OUTPUT_DIRECTORY%INSPECTION_OUTPUT.txt
set DETAIL_FILE=%OUTPUT_DIRECTORY%W_01.txt

:: FILE EXISTENCE CHECK
if NOT EXIST %OUTPUT_DIRECTORY% (mkdir %OUTPUT_DIRECTORY%)
echo. >> %DETAIL_FILE%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 			> %DETAIL_FILE%
echo :: 							>> %DETAIL_FILE%
echo ::  [W-01] Administrator Name Check 			>> %DETAIL_FILE%
echo :: 							>> %DETAIL_FILE%
echo ::  Check Administrator's Name is configured,		>> %DETAIL_FILE%
echo ::  Password is set					>> %DETAIL_FILE%
echo ::								>> %DETAIL_FILE%
echo ::  PASS : Default Administrator name is changed or	>> %DETAIL_FILE%
echo ::  Strong Password is applied				>> %DETAIL_FILE%
echo ::								>> %DETAIL_FILE%
echo ::  	>> %DETAIL_FILE%
echo ::								>> %DETAIL_FILE%
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::			>> %DETAIL_FILE%
echo. 							>> %DETAIL_FILE%

secedit /export /cfg %OUTPUT_DIRECTORY%secedit.txt >nul 2>&1
set vulcount=0

type %OUTPUT_DIRECTORY%secedit.txt | findstr /bic:"NewAdministratorName" > %OUTPUT_DIRECTORY%tmp_w_01.txt
for /f "tokens=1,2 delims==" %%a in (%OUTPUT_DIRECTORY%tmp_w_01.txt) do set conf=%%b

if %conf% EQU "Administrator" (set /A vulcount+=1)
echo Administrators Account Name is %conf%			>> %DETAIL_FILE%

net user %conf% | find /i "Password required" > %OUTPUT_DIRECTORY%tmp_w_01.txt
for /f "tokens=1,3 delims= " %%a in (%OUTPUT_DIRECTORY%tmp_w_01.txt) do set conf=%%b

if %conf% NEQ Yes (set /A vulcount+=1)
echo Administrator PASSWORD Required? "%conf%"		>> %DETAIL_FILE%

if %vulcount% EQU 2 (set result=W_01 = FAIL) else (set result=W_01 = PASS)
echo %result%
echo %result% >> %OUTPUT_FILE%

if EXIST %OUTPUT_DIRECTORY%tmp_w_01.txt (del %OUTPUT_DIRECTORY%tmp_w_01.txt)
if EXIST %OUTPUT_DIRECTORY%secedit.txt (del %OUTPUT_DIRECTORY%secedit.txt)

:FINISH
pause >nul 2>&1

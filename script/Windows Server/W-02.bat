@echo off
chcp 437 >nul 2>&1

: [W-02] (상) 1. 계정관리 > 1.2 Guest 계정 비활성화

set YEAR=%date:~0,4%
set MONTH=%date:~5,2%
set DAY=%date:~8,2%

set OUTPUT_DIRECTORY=C:\INSPECT\%YEAR%_%MONTH%_%DAY%_INSPECTION\
set OUTPUT_FILE=%OUTPUT_DIRECTORY%INSPECTION_OUTPUT.txt
set DETAIL_FILE=%OUTPUT_DIRECTORY%W_02.txt

:: FILE EXISTENCE CHECK
if NOT EXIST %OUTPUT_DIRECTORY% (mkdir %OUTPUT_DIRECTORY%)
echo. >> %DETAIL_FILE%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 			> %DETAIL_FILE%
echo :: 							>> %DETAIL_FILE%
echo ::  [W-02] Guest Account Disabled 			>> %DETAIL_FILE%
echo :: 							>> %DETAIL_FILE%
echo ::  Check Disabled Status of Guest Account		>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::  PASS : Pass if Guest Account is Disabled		>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::                                                                    	>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::			>> %DETAIL_FILE%
echo. 							>> %DETAIL_FILE%

secedit /export /cfg %OUTPUT_DIRECTORY%secedit.txt >nul 2>&1

type %OUTPUT_DIRECTORY%secedit.txt | findstr /bic:"NewGuestName" > %OUTPUT_DIRECTORY%tmp_w_02.txt
for /f "tokens=1,2 delims==" %%a in (%OUTPUT_DIRECTORY%tmp_w_02.txt) do set conf=%%b

echo Guest Name is %conf%			>> %DETAIL_FILE%

net user %conf% | find /i "Account active" > %OUTPUT_DIRECTORY%tmp_w_02.txt
for /f "tokens=1,3 delims= " %%a in (%OUTPUT_DIRECTORY%tmp_w_02.txt) do set conf=%%b

echo Guest Account is activated? "%conf%"		>> %DETAIL_FILE%

if %conf% EQU Yes (set result=W_02 = FAIL) else (set result=W_02 = PASS)
echo %result%
echo %result% >> %OUTPUT_FILE%

if EXIST %OUTPUT_DIRECTORY%tmp_w_02.txt (del %OUTPUT_DIRECTORY%tmp_w_02.txt)
if EXIST %OUTPUT_DIRECTORY%secedit.txt (del %OUTPUT_DIRECTORY%secedit.txt)

:FINISH
pause >nul 2>&1

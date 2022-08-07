@echo off
chcp 437 >nul 2>&1

: [W-04] (상) 1. 계정관리 > 1.4 계정 잠금 임계값 설정

set YEAR=%date:~0,4%
set MONTH=%date:~5,2%
set DAY=%date:~8,2%

set OUTPUT_DIRECTORY=C:\INSPECT\%YEAR%_%MONTH%_%DAY%_INSPECTION\
set OUTPUT_FILE=%OUTPUT_DIRECTORY%INSPECTION_OUTPUT.txt
set DETAIL_FILE=%OUTPUT_DIRECTORY%W_04.txt

:: FILE EXISTENCE CHECK
if NOT EXIST %OUTPUT_DIRECTORY% (mkdir %OUTPUT_DIRECTORY%)
echo. >> %DETAIL_FILE%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 			> %DETAIL_FILE%
echo :: 							>> %DETAIL_FILE%
echo ::  [W-04] Lockout Threshold Check 			>> %DETAIL_FILE%
echo :: 							>> %DETAIL_FILE%
echo ::  Check Lockout Threshold Policy count			>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::  PASS : Lockout Threshold is less than 6			>> %DETAIL_FILE%
echo ::           and Lockout count is configured(not 0)		>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::                                                                    	>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::			>> %DETAIL_FILE%
echo. 							>> %DETAIL_FILE%

secedit /export /cfg %OUTPUT_DIRECTORY%secedit.txt >nul 2>&1

type %OUTPUT_DIRECTORY%secedit.txt | findstr /bic:"LockoutBadCount" > %OUTPUT_DIRECTORY%tmp_w_04.txt
for /f "tokens=1,2 delims==" %%a in (%OUTPUT_DIRECTORY%tmp_w_04.txt) do set conf=%%b

if %conf% EQU 0 (
  set result=W-04 = FAIL
  echo Lock Policy not configured	>> %DETAIL_FILE%
) else if %conf% GEQ 6 (
  set result=W-04 = FAIL
  echo Lock After "%conf%" count Bad Password is entered	>> %DETAIL_FILE%
) else (
  set result=W-04 = PASS
  echo Lock After "%conf%" count Bad Password is entered	>> %DETAIL_FILE%
)

echo %result%
echo %result% >> %OUTPUT_FILE%

if EXIST %OUTPUT_DIRECTORY%tmp_w_04.txt (del %OUTPUT_DIRECTORY%tmp_w_04.txt)
if EXIST %OUTPUT_DIRECTORY%secedit.txt (del %OUTPUT_DIRECTORY%secedit.txt)

:FINISH
pause >nul 2>&1

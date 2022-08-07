@echo off
chcp 437 >nul 2>&1

: [W-05] (상) 1. 계정관리 > 1.5 해독 가능한 암호화를 사용하여 암호 저장 해제

set YEAR=%date:~0,4%
set MONTH=%date:~5,2%
set DAY=%date:~8,2%

set OUTPUT_DIRECTORY=C:\INSPECT\%YEAR%_%MONTH%_%DAY%_INSPECTION\
set OUTPUT_FILE=%OUTPUT_DIRECTORY%INSPECTION_OUTPUT.txt
set DETAIL_FILE=%OUTPUT_DIRECTORY%W_05.txt

:: FILE EXISTENCE CHECK
if NOT EXIST %OUTPUT_DIRECTORY% (mkdir %OUTPUT_DIRECTORY%)
echo. >> %DETAIL_FILE%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 			> %DETAIL_FILE%
echo :: 							>> %DETAIL_FILE%
echo ::  [W-05] ClearPassword Check 			>> %DETAIL_FILE% 
echo :: 							>> %DETAIL_FILE%
echo ::  Check ClearPassword is set			>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::  PASS : ClearTextPassword is disabled at policy		>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::                                                                        	>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::			>> %DETAIL_FILE%
echo. 							>> %DETAIL_FILE%

secedit /export /cfg %OUTPUT_DIRECTORY%secedit.txt >nul 2>&1

type %OUTPUT_DIRECTORY%secedit.txt | findstr /bic:"ClearTextPassword" > %OUTPUT_DIRECTORY%tmp_w_05.txt
for /f "tokens=1,2 delims==" %%a in (%OUTPUT_DIRECTORY%tmp_w_05.txt) do set conf=%%b

if %conf% EQU 0 (
  set result=W-05 = FAIL
  echo ClearPassword is set	>> %DETAIL_FILE%
) else (
  set result=W-05 = PASS
  echo ClearPassword is unset	>> %DETAIL_FILE%
)

echo %result%
echo %result% >> %OUTPUT_FILE%

if EXIST %OUTPUT_DIRECTORY%tmp_w_05.txt (del %OUTPUT_DIRECTORY%tmp_w_05.txt)
if EXIST %OUTPUT_DIRECTORY%secedit.txt (del %OUTPUT_DIRECTORY%secedit.txt)

:FINISH
pause >nul 2>&1

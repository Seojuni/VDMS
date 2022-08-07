@echo off
chcp 437 >nul 2>&1

: [W-10] (상) 2. 서비스 관리 > 2.4 IIS 서비스 구동 점검

set YEAR=%date:~0,4%
set MONTH=%date:~5,2%
set DAY=%date:~8,2%

set OUTPUT_DIRECTORY=C:\INSPECT\%YEAR%_%MONTH%_%DAY%_INSPECTION\
set OUTPUT_FILE=%OUTPUT_DIRECTORY%INSPECTION_OUTPUT.txt
set DETAIL_FILE=%OUTPUT_DIRECTORY%W_10.txt

:: FILE EXISTENCE CHECK
if NOT EXIST %OUTPUT_DIRECTORY% (mkdir %OUTPUT_DIRECTORY%)
echo. >> %DETAIL_FILE%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 			> %DETAIL_FILE%
echo :: 							>> %DETAIL_FILE%
echo ::  [W-10] IIS Service Check 			>> %DETAIL_FILE% 
echo :: 							>> %DETAIL_FILE%
echo ::  Check IIS Service is running or not		>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::  PASS : IIS is disabled				>> %DETAIL_FILE%
echo ::  Need Review : IIS is running				>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::                                                                       	>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::			>> %DETAIL_FILE%
echo. 							>> %DETAIL_FILE%

net start | find /i "IISADMIN" >nul 2>&1
if %errorlevel% EQU 0 (
  set result=W-10 = Need Review
  echo IIS Service Detected, Really need iis? >> %DETAIL_FILE%
) else (
  set result=W-10 = PASS
  echo Hooooly Shit IIS Undetected >> %DETAIL_FILE%
)

echo %result%
echo %result% >> %OUTPUT_FILE%

:FINISH
pause >nul 2>&1

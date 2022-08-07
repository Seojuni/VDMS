@echo off
chcp 437 >nul 2>&1

: [W-14] (상) 2. 서비스 관리 > 2.8 IIS 불필요한 파일 제거

set YEAR=%date:~0,4%
set MONTH=%date:~5,2%
set DAY=%date:~8,2%

set OUTPUT_DIRECTORY=C:\INSPECT\%YEAR%_%MONTH%_%DAY%_INSPECTION\
set OUTPUT_FILE=%OUTPUT_DIRECTORY%INSPECTION_OUTPUT.txt
set DETAIL_FILE=%OUTPUT_DIRECTORY%W_13.txt

:: FILE EXISTENCE CHECK
if NOT EXIST %OUTPUT_DIRECTORY% (mkdir %OUTPUT_DIRECTORY%)
echo. >> %DETAIL_FILE%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 			> %DETAIL_FILE%
echo :: 							>> %DETAIL_FILE%
echo ::  [W-14] IIS Unneeded Directory Check			>> %DETAIL_FILE% 
echo :: 							>> %DETAIL_FILE%
echo ::  Check whether IIS Unneeded Directory Exist		>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::  RESULT : Always "Need Review"			>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::                                                                      	>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::			>> %DETAIL_FILE%
echo. 							>> %DETAIL_FILE%

cd c:\inetpub\iissamples >nul 2>&1

if %errorlevel% EQU 0 (
  echo SAMPLE IIS File Exist c:\inetpub\iissamples >> %DETAIL_FILE%
) 

type c:\winnt\help\iishelp >nul 2>&1

if %errorlevel% EQU 0 (
  echo IIS Help Exist >> %DETAIL_FILE%
) 

echo %result%
echo W-14 = Need Review >> %OUTPUT_FILE%

:FINISH
pause >nul 2>&1

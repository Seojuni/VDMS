@echo off
chcp 437 >nul 2>&1

: [W-09] (상) 2. 서비스 관리 > 2.3 불필요한 서비스 제거

set YEAR=%date:~0,4%
set MONTH=%date:~5,2%
set DAY=%date:~8,2%

set OUTPUT_DIRECTORY=C:\INSPECT\%YEAR%_%MONTH%_%DAY%_INSPECTION\
set OUTPUT_FILE=%OUTPUT_DIRECTORY%INSPECTION_OUTPUT.txt
set DETAIL_FILE=%OUTPUT_DIRECTORY%W_09.txt

:: FILE EXISTENCE CHECK
if NOT EXIST %OUTPUT_DIRECTORY% (mkdir %OUTPUT_DIRECTORY%)
echo. >> %DETAIL_FILE%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 			> %DETAIL_FILE%
echo :: 							>> %DETAIL_FILE%
echo ::  [W-09] Unneeded Service Check 			>> %DETAIL_FILE% 
echo :: 							>> %DETAIL_FILE%
echo ::  Check Wheter Unneeded Services running or not		>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::  RESULT : Always "Need Review"			>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::                                                                    	>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::			>> %DETAIL_FILE%
echo. 							>> %DETAIL_FILE%

net start >> %DETAIL_FILE%
set result=W-09 = Need Review

echo %result%
echo %result% >> %OUTPUT_FILE%

:FINISH
pause >nul 2>&1

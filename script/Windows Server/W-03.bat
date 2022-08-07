@echo off
chcp 437 >nul 2>&1

: [W-03] (상) 1. 계정관리 > 1.3 불필요한 계정 제거

set YEAR=%date:~0,4%
set MONTH=%date:~5,2%
set DAY=%date:~8,2%

set OUTPUT_DIRECTORY=C:\INSPECT\%YEAR%_%MONTH%_%DAY%_INSPECTION\
set OUTPUT_FILE=%OUTPUT_DIRECTORY%INSPECTION_OUTPUT.txt
set DETAIL_FILE=%OUTPUT_DIRECTORY%W_03.txt

:: FILE EXISTENCE CHECK
if NOT EXIST %OUTPUT_DIRECTORY% (mkdir %OUTPUT_DIRECTORY%)
echo. >> %DETAIL_FILE%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 			> %DETAIL_FILE%
echo :: 							>> %DETAIL_FILE%
echo ::  [W-03] Unneeded Account Check			>> %DETAIL_FILE%
echo :: 							>> %DETAIL_FILE%
echo ::  Check Existence of Unneeded Account			>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::  RESULT : Always "Need Review"			>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::                                                                          	>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::			>> %DETAIL_FILE%
echo. 							>> %DETAIL_FILE%

net user 	>> %DETAIL_FILE%

rem Please Write Customized DSQUERY Command for needed

set result=W_03 = Need Review
echo %result%
echo %result% >> %OUTPUT_FILE%

:FINISH
pause >nul 2>&1

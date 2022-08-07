@echo off
chcp 437 >nul 2>&1

: [W-06] (상) 1. 계정관리 > 1.6 관리자 그룹에 최소한의 사용자 포함

set YEAR=%date:~0,4%
set MONTH=%date:~5,2%
set DAY=%date:~8,2%

set OUTPUT_DIRECTORY=C:\INSPECT\%YEAR%_%MONTH%_%DAY%_INSPECTION\
set OUTPUT_FILE=%OUTPUT_DIRECTORY%INSPECTION_OUTPUT.txt
set DETAIL_FILE=%OUTPUT_DIRECTORY%W_06.txt

:: FILE EXISTENCE CHECK
if NOT EXIST %OUTPUT_DIRECTORY% (mkdir %OUTPUT_DIRECTORY%)
echo. >> %DETAIL_FILE%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 			> %DETAIL_FILE%
echo :: 							>> %DETAIL_FILE%
echo ::  [W-06] Administrator Group's Member 			>> %DETAIL_FILE% 
echo :: 							>> %DETAIL_FILE%
echo ::  Check whether Administrator Groups include 		>> %DETAIL_FILE%
echo ::  Unneeded Member or Not	 			>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::  RESULT : Always "Need Review"			>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::                                                                    	>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::			>> %DETAIL_FILE%
echo. 							>> %DETAIL_FILE%

net localgroup Administrators >> %DETAIL_FILE%
set result=W-06 = Need Review

echo %result%
echo %result% >> %OUTPUT_FILE%

:FINISH
pause >nul 2>&1

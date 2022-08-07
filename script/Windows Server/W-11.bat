@echo off
chcp 437 >nul 2>&1

: [W-11] (상) 2. 서비스 관리 > 2.5 디렉토리 리스팅 제거

set YEAR=%date:~0,4%
set MONTH=%date:~5,2%
set DAY=%date:~8,2%

set OUTPUT_DIRECTORY=C:\INSPECT\%YEAR%_%MONTH%_%DAY%_INSPECTION\
set OUTPUT_FILE=%OUTPUT_DIRECTORY%INSPECTION_OUTPUT.txt
set DETAIL_FILE=%OUTPUT_DIRECTORY%W_11.txt

:: FILE EXISTENCE CHECK
if NOT EXIST %OUTPUT_DIRECTORY% (mkdir %OUTPUT_DIRECTORY%)
echo. >> %DETAIL_FILE%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 			> %DETAIL_FILE%
echo :: 							>> %DETAIL_FILE%
echo ::  [W-11] IIS Directory Traversal 			>> %DETAIL_FILE% 
echo :: 							>> %DETAIL_FILE%
echo ::  Check whether IIS Directory Traversal Feature		>> %DETAIL_FILE%
echo ::  is unchecked ot not					>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::  PASS : IIS Directory Traversal is Unchecked		>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::                                                                   	>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::			>> %DETAIL_FILE%
echo. 							>> %DETAIL_FILE%

cd %systemroot%\System32\inetsrc\ >nul 2>&1
appcmd.exe list config | find /i "directoryBrowse enabled' | find /i "false" >nul 2>&1

if %errorlevel% EQU 0 (
  set result=W-11 = PASS
  echo IIS Directory Traversal Disabled >> %DETAIL_FILE%
) else (
  set result=W-11 = FAIL
  echo IIS Directory Traversal Enabled >> %DETAIL_FILE%
)

echo %result%
echo %result% >> %OUTPUT_FILE%

:FINISH
pause >nul 2>&1

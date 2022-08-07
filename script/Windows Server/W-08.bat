@echo off
chcp 437 >nul 2>&1

: [W-08] (상) 2. 서비스 관리 > 2.2 하드디스크 기본 공유 제거

set YEAR=%date:~0,4%
set MONTH=%date:~5,2%
set DAY=%date:~8,2%

set OUTPUT_DIRECTORY=C:\INSPECT\%YEAR%_%MONTH%_%DAY%_INSPECTION\
set OUTPUT_FILE=%OUTPUT_DIRECTORY%INSPECTION_OUTPUT.txt
set DETAIL_FILE=%OUTPUT_DIRECTORY%W_08.txt

:: FILE EXISTENCE CHECK
if NOT EXIST %OUTPUT_DIRECTORY% (mkdir %OUTPUT_DIRECTORY%)
echo. >> %DETAIL_FILE%
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 			> %DETAIL_FILE%
echo :: 							>> %DETAIL_FILE%
echo ::  [W-08] Unable default share 				>> %DETAIL_FILE% 
echo :: 							>> %DETAIL_FILE%
echo ::  Inspect Default Share is configured  			>> %DETAIL_FILE%
echo ::  and Registry key Authoshare is configured	 	>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::  PASS : Always "Partially PASS", Autoshare is configured	>> %DETAIL_FILE%
echo ::           Need Futher review to Default Share Drive to confirm PASS >> %DETAIL_FILE%
echo ::  FAIL :  Autoshare is not configured			>> %DETAIL_FILE%
echo ::                                                                       	>> %DETAIL_FILE%
echo ::							>> %DETAIL_FILE%
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::			>> %DETAIL_FILE%
echo. 							>> %DETAIL_FILE%

echo Need Review to this share drives are really need : >> %DETAIL_FILE%
net share >> %DETAIL_FILE%
echo. >> %DETAIL_FILE%

set conf=100

reg query  "HKLM\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters" | find /i "AutoShareServer" >nul 2>&1
if %errorlevel% EQU 0 (
  reg query "HKLM\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters" | find /i "AutoShareServer" > %OUTPUT_DIRECTORY%tmp_w_08.txt
  for /f "tokens=1,3 delims= " %%a in (%OUTPUT_DIRECTORY%tmp_w_08.txt) do set conf=%%b
) else (
  set result=W-08 = FAIL
)

if %conf% EQU 0x0 (
  set result=W-08 = Partially PASS
) else (
  set result=W-08 = FAIL
)

echo %result%
echo %result% >> %OUTPUT_FILE%

if EXIST %OUTPUT_DIRECTORY%tmp_w_08.txt (del %OUTPUT_DIRECTORY%tmp_w_08.txt)

:FINISH
pause >nul 2>&1

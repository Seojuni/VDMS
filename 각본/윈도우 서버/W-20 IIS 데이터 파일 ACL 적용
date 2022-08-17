echo. W-20 START
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo [ W-20 "IIS 데이터 파일 ACL 적용" ]                                             >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo ■ 수동점검 ■                                                                       >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
type [RESULT]_applicationHost.config | find "physicalPath"		         >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
type [RESULT]_applicationHost.config | find "physicalPath"		         >>   path.txt
echo.																							>>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo ■ everyone권한이 허용되지 않는 파일 확장자(.exe, .dll, .cmd, .pl, .asp, .inc, .shtm, .shtml)  ■		>>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo. 																							>>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
For /F "tokens=4 delims= " %%j IN (path.txt) DO cacls %%j\*.exe /T | find /I "Everyone" 		>> acl-F.txt
For /F "tokens=4 delims= " %%j IN (path.txt) DO cacls %%j\*.dll /T | find /I "Everyone" 		>> acl-F.txt
For /F "tokens=4 delims= " %%j IN (path.txt) DO cacls %%j\*.cmd /T | find /I "Everyone" 		>> acl-F.txt
For /F "tokens=4 delims= " %%j IN (path.txt) DO cacls %%j\*.pl /T | find /I "Everyone" 		>> acl-F.txt
For /F "tokens=4 delims= " %%j IN (path.txt) DO cacls %%j\*.asp /T | find /I "Everyone" 		>> acl-F.txt
For /F "tokens=4 delims= " %%j IN (path.txt) DO cacls %%j\*.inc /T | find /I "Everyone" 		>> acl-F.txt
For /F "tokens=4 delims= " %%j IN (path.txt) DO cacls %%j\*.shtm /T | find /I "Everyone" 		>> acl-F.txt
For /F "tokens=4 delims= " %%j IN (path.txt) DO cacls %%j\*.shtml /T | find /I "Everyone" 		>> acl-F.txt
TYPE acl-F.txt																					>>	[RESULT]_%COMPUTERNAME%_WINSVR.txt 
echo.																							>>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo ■ everyone권한이 R만 허용되는 파일 확장자(.txt, .gif, .jpg, .html)  ■									>>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.																							>>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
For /F "tokens=4 delims= " %%j IN (path.txt) DO cacls %%j\*.txt | find /I "Everyone" 			>> acl-R.txt
For /F "tokens=4 delims= " %%j IN (path.txt) DO cacls %%j\*.gif | find /I "Everyone" 			>> acl-R.txt
For /F "tokens=4 delims= " %%j IN (path.txt) DO cacls %%j\*.jpg | find /I "Everyone" 			>> acl-R.txt
For /F "tokens=4 delims= " %%j IN (path.txt) DO cacls %%j\*.html | find /I "Everyone" 		>> acl-R.txt
TYPE acl-R.txt																					>>	[RESULT]_%COMPUTERNAME%_WINSVR.txt 
echo.																							>>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
TYPE acl-R.txt | find /v "Everyone:R"															>> acl-F.txt
echo.																							>>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
type acl-F.txt | find /I "Everyone" 			> nul
IF ERRORLEVEL 1 ECHO Result : Good																>>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
IF NOT ERRORLEVEL 1 ECHO Result : Vulnerable													>>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
del path.txt
del acl-F.txt
del acl-R.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo W-20 END                                                                                   >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo ======================================================================================     >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt

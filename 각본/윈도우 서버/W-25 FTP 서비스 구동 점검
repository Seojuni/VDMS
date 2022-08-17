echo. W-25 START
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo [ W-25 "FTP 서비스 구동 점검" ]                                                 >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo ■ FTP 서비스 구동 확인 ■																		>>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
net start | find "Microsoft FTP Service" > nul
IF ERRORLEVEL 1 echo FTP Service Disabled                                         >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
IF NOT ERRORLEVEL 1 echo FTP Service Enabled                                  >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo ■ FTP 포트 확인(21번) ■												 						>>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
netstat -na | find "21" | find /I "LISTENING"			         >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo W-25 END                                                                             >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo ======================================================================================     >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt

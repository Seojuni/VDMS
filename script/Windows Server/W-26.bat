echo. W-26 START
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo [ W-26 "FTP 디렉터리 접근권한 설정" ]                                         >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
net start | find "FTP" > nul
IF ERRORLEVEL 1 GOTO DIRACL-FTP-DISABLE
IF NOT ERRORLEVEL 1 GOTO DIRACL-FTP-ENABLE
:DIRACL-FTP-DISABLE
echo FTP Service Disabled                                                                >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
GOTO W-26 END
:DIRACL-FTP-ENABLE
:: reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MSFtpsvc\Parameters\Virtual Roots" /s    >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt 2>&1
echo ■ C:\Inetpub\ftproot 접근 권한 ■                                            >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
icacls "C:\Inetpub\ftproot" | find /v "파일을 처리했으며"                        >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo ■ 입력 받은 ftp 디렉터리 접근 권한 ■                                        >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo 입력 받은 ftp 디렉터리 : "%ftpR% "                                             >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
icacls "%ftpR% " | find /v "파일을 처리했으며"                                      >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
:W-26 END
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo W-26 END                                                                             >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo ======================================================================================     >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt

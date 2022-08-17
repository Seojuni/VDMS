echo. W-17 START
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo [ W-17 "IIS 파일 업로드 및 다운로드 제한" ]                                  >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo. #파일 업로드 #                                                                      >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
type c:\Windows\System32\Inetsrv\config\applicationHost.config | findstr /i "RequestEntityAllowed"     >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo. #파일 다운로드 #                                                                    >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
type c:\Windows\System32\Inetsrv\config\applicationHost.config | findstr /i "BufferingLimit"    >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo W-17 END                                                                             >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo ======================================================================================     >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt

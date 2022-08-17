echo. W-23 START
echo.                                                                                           >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo [ W-23 "IIS WevDAV 비활성화" ]                                                 >>  [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo ■  수동점검  ■                                                                      >>  [RESULT]_%COMPUTERNAME%_WINSVR.txt
type [RESULT]_applicationHost.config | find "webdav.dll"                         >>  [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo W-23 END                                                                             >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo ======================================================================================     >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
del [RESULT]_administration.config
del [RESULT]_applicationHost.config
del [RESULT]_redirection.config

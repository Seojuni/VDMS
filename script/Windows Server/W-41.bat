echo. W-41 START
echo.                                                                                           >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo [ W-41 "보안 감사를 로그할 수 없는 경우 즉시 시스템 종료" ]           >>     [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
type [RESULT]_%COMPUTERNAME%_Local_Security_Policy.txt | find /I "CrashOnAuditFail"             >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo W-41 END                                                                             >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo ======================================================================================     >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt

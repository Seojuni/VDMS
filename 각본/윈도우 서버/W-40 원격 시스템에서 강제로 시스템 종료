echo. W-40 START
echo.                                                                                           >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo [ W-40 "원격 시스템에서 강제로 시스템 종료" ]                              >>   [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
type [RESULT]_%COMPUTERNAME%_Local_Security_Policy.txt | find /I "SeRemoteShutdownPrivilege"    >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo W-40 END                                                                             >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo ======================================================================================     >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt

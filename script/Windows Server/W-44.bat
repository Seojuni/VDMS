echo. W-44 START
echo.                                                                                           >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo [ W-44 "이동식 미디어 포맷 및 꺼내기 허용" ]                                >>   [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
type [RESULT]_%COMPUTERNAME%_Local_Security_Policy.txt | find /I "AllocateDASD"                 >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo W-44 END                                                                             >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo ======================================================================================     >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt

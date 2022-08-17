echo. W-42 START
echo.                                                                                           >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo [ W-42 "SAM 계정과 공유의 익명 열거 허용 안함" ]                         >>   [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
type [RESULT]_%COMPUTERNAME%_Local_Security_Policy.txt | find /I "RestrictAnonymous"            >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo W-42 END                                                                            >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo ======================================================================================     >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>    [RESULT]_%COMPUTERNAME%_WINSVR.txt

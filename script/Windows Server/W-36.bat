echo. W-36 START
echo.                                                                                           >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo [ W-36 "백신 프로그램 확인" ]                                                    >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo. # 서비스 목록 확인 #                                                               >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
net start                                                                                       >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo. # 실행 중인 프로그램 목록 확인 #                                              >>  [RESULT]_%COMPUTERNAME%_WINSVR.txt
tasklist                                                                                         >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo W-36 END                                                                             >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo ======================================================================================     >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >> [RESULT]_%COMPUTERNAME%_WINSVR.txt

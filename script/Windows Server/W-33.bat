echo. W-33 START
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo [ W-33 "백신 프로그램 업데이트" ]                                              >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo. # 백신 프로그램 실행 여부 #                                                     >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
net start | findstr /I "AlYac Hauri V3 test Symantec AVG"                        >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo. # 백신 프로그램 최신 업데이트 여부 #                                        >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
reg query "HKLM\SOFTWARE\test\DynaUpdate\Schedule\SUpdate0\Style"                             >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt 2>&1
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo W-33 END                                                                             >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo ======================================================================================     >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt

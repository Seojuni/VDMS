echo. W-30 START
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo [ W-30 "RDS(RemoteDataService)제거" ]                                       >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.  # '/MSADC' 디렉터리 존재 확인 #                                             >>            [RESULT]_%COMPUTERNAME%_WINSVR.txt
reg query "HKLM\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\Virtual Roots" | find /I "MSADC"     >> [RESULT]_%COMPUTERNAME%_WINSVR.txt 2>&1
echo.                                                                                           >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.  # 'RDSServer.DataFactory' 레지스트리 키 존재 확인 #                     >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\ADCLaunch" | find /I "RDSServer.DataFactory"     >> [RESULT]_%COMPUTERNAME%_WINSVR.txt 2>&1
echo.                                                                                           >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.  # 'AdvancedDataFactory' 레지스트리 키 존재 확인 #                                                >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\ADCLaunch" | find /I "AdvancedDataFactory"       >> [RESULT]_%COMPUTERNAME%_WINSVR.txt 2>&1
echo.                                                                                           >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.  # 'VbBusObj.VbBusObjCls' 레지스트리 키 존재 확인 #                                               >> [RESULT]_%COMPUTERNAME%_WINSVR.txt
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\ADCLaunch" | find /I "VbBusObj.VbBusObjCls"      >> [RESULT]_%COMPUTERNAME%_WINSVR.txt 2>&1
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo W-30 END                                                                                   >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo ======================================================================================     >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt

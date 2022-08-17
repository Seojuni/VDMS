echo. W-38 START
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo [ W-38 "화면보호기 설정" ]                                                       >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo # 화면보호기 활성화 여부 #                                                       >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
reg query "HKCU\Control Panel\Desktop" /v ScreenSaveActive               >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt 2>&1
echo # 화면보호기 암호 사용 여부 #                                                   >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
reg query "HKCU\Control Panel\Desktop" /v ScreenSaverIsSecure           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt 2>&1
echo # 화면 보호기 대기시간(초) #                                                     >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
reg query "HKCU\Control Panel\Desktop" /v ScreenSaveTimeOut           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt 2>&1
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo # (로컬 그룹 정책 설정)화면보호기 활성화 여부 #                                                          >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
reg query "HKCU\Software\Policies\Microsoft\Windows\Control Panel\Desktop" /v ScreenSaveActive  >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt 2>&1
echo # (로컬 그룹 정책 설정)화면보호기 암호 사용 여부 #                                                        >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
reg query "HKCU\Software\Policies\Microsoft\Windows\Control Panel\Desktop" /v ScreenSaverIsSecure     >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt 2>&1
echo # (로컬 그룹 정책 설정)화면 보호기 대기시간(초) #                                                        >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
reg query "HKCU\Software\Policies\Microsoft\Windows\Control Panel\Desktop" /v ScreenSaveTimeOut >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt 2>&1
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo W-38 END                                                                             >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo ======================================================================================     >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt
echo.                                                                                           >>	[RESULT]_%COMPUTERNAME%_WINSVR.txt

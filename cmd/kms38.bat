@echo off
reg query HKEY_USERS\S-1-5-19 1>nul 2>nul || goto :RunAsAdmin

:menu
cls
echo ==============
echo KMS38激活工具
echo ==============
echo 1. Windows 10/11 专业版
echo 2. Windows 10/11 教育版
echo 3. Windows 10/11 专业教育版
echo 4. Windows 10/11 专业工作站版
echo 5. Windows 10/11 企业版
echo 6. Windows 10/11 企业版 LTSC 2024/2021/2019
echo 7. Windows 10 企业版 LTSB 2016
echo 8. Windows 10 企业版 LTSB 2015
echo 9. Windows Server 2025 数据中心版
echo a. Windows Server 2025 标准版
echo b. Windows Server 2022 数据中心版
echo c. Windows Server 2022 标准版
echo d. Windows Server 2019 数据中心版
echo e. Windows Server 2019 标准版
echo f. Windows Server 2016 数据中心版
echo g. Windows Server 2016 标准版
echo --------------
set /p os="请选择："
if "%os%" == "1" set product_key=W269N-WFGWX-YVC9B-4J6C9-T83GX & goto :Activate
if "%os%" == "2" set product_key=NW6C2-QMPVW-D7KKK-3GKT6-VCFB2 & goto :Activate
if "%os%" == "3" set product_key=6TP4R-GNPTD-KYYHQ-7B7DP-J447Y & goto :Activate
if "%os%" == "4" set product_key=NRG8B-VKK3Q-CXVCJ-9G2XF-6Q84J & goto :Activate
if "%os%" == "5" set product_key=NPPR9-FWDCX-D2C8J-H872K-2YT43 & goto :Activate
if "%os%" == "6" set product_key=M7XTQ-FN8P6-TTKYV-9D4CC-J462D & goto :Activate
if "%os%" == "7" set product_key=DCPHK-NFMTC-H88MJ-PFHPY-QJ4BJ & goto :Activate
if "%os%" == "8" set product_key=WNMTR-4C88C-JK8YV-HQ7T2-76DF9 & goto :Activate
if "%os%" == "9" set product_key=D764K-2NDRG-47T6Q-P8T8W-YP6DF & goto :Activate
if "%os%" == "a" set product_key=TVRH6-WHNXV-R9WG3-9XRFY-MY832 & goto :Activate
if "%os%" == "b" set product_key=WX4NM-KYWYW-QJJR4-XV3QB-6VM33 & goto :Activate
if "%os%" == "c" set product_key=VDYBN-27WPP-V4HQT-9VMD4-VMK7H & goto :Activate
if "%os%" == "d" set product_key=WMDGN-G9PQG-XVVXX-R3X43-63DFG & goto :Activate
if "%os%" == "e" set product_key=N69G4-B89J2-4G8F4-WWYCC-J464C & goto :Activate
if "%os%" == "f" set product_key=CB7KF-BWN84-R7R2Y-793K2-8XDDG & goto :Activate
if "%os%" == "g" set product_key=WC2BQ-8NRM3-FDDYY-2BFGV-KHKQY & goto :Activate
goto :menu

:Activate
echo 正在激活...
::应用Key和ID
cscript.exe //nologo "%SystemRoot%\System32\slmgr.vbs" -ipk %product_key% >nul
cscript.exe //nologo "%SystemRoot%\System32\slmgr.vbs" -ato | findstr /i /r /c:"([0-9a-f]*-[0-9a-f]*-[0-9a-f]*-[0-9a-f]*-[0-9a-f]*)" >"%temp%\kms_lisence_id.tmp"
powershell -Command "(Get-Content -Path '%temp%\kms_lisence_id.tmp') -replace '.*([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}).*','$1' | Out-File -Encoding ascii -FilePath '%temp%\kms_lisence_id.tmp'"
set /p lisence_id=<"%temp%\kms_lisence_id.tmp"
del /f /q "%temp%\kms_lisence_id.tmp"
wmic path SoftwareLicensingProduct where ID='%lisence_id%' call ReArmsku >nul
set "GTdir=%ProgramData%\Microsoft\Windows\ClipSVC\GenuineTicket"
::生成数字门票
set "signature=C52iGEoH+1VqzI6kEAqOhUyrWuEObnivzaVjyef8WqItVYd/xGDTZZ3bkxAI9hTpobPFNJyJx6a3uriXq3HVd7mlXfSUK9ydeoUdG4eqMeLwkxeb6jQWJzLOz41rFVSMtBL0e+ycCATebTaXS4uvFYaDHDdPw2lKY8ADj3MLgsA="
set "sessionId=TwBTAE0AYQBqAG8AcgBWAGUAcgBzAGkAbwBuAD0ANQA7AE8AUwBNAGkAbgBvAHIAVgBlAHIAcwBpAG8AbgA9ADEAOwBPAFMAUABsAGEAdABmAG8AcgBtAEkAZAA9ADIAOwBQAFAAPQAwADsARwBWAEwASwBFAHgAcAA9ADIAMAAzADgALQAwADEALQAxADkAVAAwADMAOgAxADQAOgAwADcAWgA7AEQAbwB3AG4AbABlAHYAZQBsAEcAZQBuAHUAaQBuAGUAUwB0AGEAdABlAD0AMQA7AAAA"
<nul set /p "=<?xml version="1.0" encoding="utf-8"?><genuineAuthorization xmlns="http://www.microsoft.com/DRM/SL/GenuineAuthorization/1.0"><version>1.0</version><genuineProperties origin="sppclient"><properties>OA3xOriginalProductId=;OA3xOriginalProductKey=;SessionId=%sessionId%;TimeStampClient=2022-10-11T12:00:00Z</properties><signatures><signature name="clientLockboxKey" method="rsa-sha256">%signature%</signature></signatures></genuineProperties></genuineAuthorization>" >"%GTdir%\GenuineTicket"
copy /y /b "%GTdir%\GenuineTicket" "%GTdir%\GenuineTicket.xml" >nul
::应用数字门票
net stop sppsvc /y >nul
net start sppsvc /y >nul
net stop ClipSVC /y >nul
net start ClipSVC /y >nul
timeout /t 10 >nul
clipup.exe -v -o %GTdir%\ >nul
::执行激活命令
cscript.exe //nologo "%SystemRoot%\System32\slmgr.vbs" -ato >nul
cscript.exe //nologo "%SystemRoot%\System32\slmgr.vbs" -xpr | findstr /i "2038" && (echo. & echo 激活成功。（按任意键退出） & pause >nul && exit )
::激活失败
echo 激活失败。（按任意键退出）
pause >nul && exit

:RunAsAdmin
%1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
exit /B

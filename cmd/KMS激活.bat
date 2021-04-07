@echo off

:CheckAdmin
set random_dir=C:\Windows\test_permissions_%random%\
rd %random_dir% >nul 2>nul
md %random_dir% >nul 2>nul
rd %random_dir% >nul 2>nul
if %errorlevel% neq 0 (goto RunAsAdmin) else (goto Run)

:RunAsAdmin
%1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
exit /B

:Run
echo 选择操作系统版本：
echo 1. Windows 7 旗舰版
echo 2. Windows Server 2008 R2 数据中心版
echo 3. Windows 10 专业工作站版
echo 4. Windows 10 企业版 LTSC
echo 5. Windows Server 2019 数据中心版
set /p select=请选择：
if "%select%"=="1" (goto Win7)
if "%select%"=="2" (goto Win2008R2)
if "%select%"=="3" (goto Win10WS)
if "%select%"=="4" (goto Win10LTSC)
if "%select%"=="5" (goto Win2019)
goto Run

:Win7
set key=MGX79-TPQB9-KQ248-KXR2V-DHRTD
goto Activate

:Win2008R2
set key=74YFP-3QFB3-KQT8W-PMXWJ-7M648
goto Activate

:Win10WS
set key=NRG8B-VKK3Q-CXVCJ-9G2XF-6Q84J
goto Activate

:Win10LTSC
set key=M7XTQ-FN8P6-TTKYV-9D4CC-J462D
goto Activate

:Win2019
set key=WMDGN-G9PQG-XVVXX-R3X43-63DFG
goto Activate

:Activate
slmgr.vbs /ipk M7XTQ-FN8P6-TTKYV-9D4CC-J462D
slmgr.vbs /skms kms.03k.org
slmgr.vbs /ato

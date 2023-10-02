@echo off
::生成UUID
set r=%random%
set vbs_file="%temp%\uuid_%r%.vbs"
set uuid_file="%temp%\uuid_%r%.txt"
echo set obj = CreateObject("Scriptlet.TypeLib") >%vbs_file%
echo WScript.StdOut.WriteLine LCase(Mid(obj.GUID, 2, 36)) >>%vbs_file%
cscript //NoLogo %vbs_file% >%uuid_file%
set /p uuid=<%uuid_file%
del /f /q %vbs_file%
del /f /q %uuid_file%

::输入参数
set /p dist_name=发行版名称：
set /p base_path=ext4.vhdx所在文件夹：
set dist_ver=2
set /p set_default=设置为默认发行版(y/n)：

::重建注册表信息
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss\{%uuid%} /v State /t REG_DWORD /d 1 /f
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss\{%uuid%} /v DistributionName /t REG_SZ /d "%dist_name%" /f
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss\{%uuid%} /v Version /t REG_DWORD /d %dist_ver% /f
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss\{%uuid%} /v BasePath /t REG_SZ /d "%base_path%" /f
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss\{%uuid%} /v Flags /t REG_DWORD /d 15 /f
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss\{%uuid%} /v DefaultUid /t REG_DWORD /d 1000 /f

::设置为默认
if "%set_default%"=="y" (
  reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss /v DefaultDistribution /t REG_SZ /d {%uuid%} /f
  reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss /v DefaultVersion /t REG_DWORD /d %dist_ver% /f
)

pause.
@echo off
::����UUID
set r=%random%
set vbs_file="%temp%\uuid_%r%.vbs"
set uuid_file="%temp%\uuid_%r%.txt"
echo set obj = CreateObject("Scriptlet.TypeLib") >%vbs_file%
echo WScript.StdOut.WriteLine LCase(Mid(obj.GUID, 2, 36)) >>%vbs_file%
cscript //NoLogo %vbs_file% >%uuid_file%
set /p uuid=<%uuid_file%
del /f /q %vbs_file%
del /f /q %uuid_file%

::�������
set /p dist_name=���а����ƣ�
set /p base_path=ext4.vhdx�����ļ��У�
set dist_ver=2
set /p set_default=����ΪĬ�Ϸ��а�(y/n)��

::�ؽ�ע�����Ϣ
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss\{%uuid%} /v State /t REG_DWORD /d 1 /f
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss\{%uuid%} /v DistributionName /t REG_SZ /d "%dist_name%" /f
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss\{%uuid%} /v Version /t REG_DWORD /d %dist_ver% /f
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss\{%uuid%} /v BasePath /t REG_SZ /d "%base_path%" /f
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss\{%uuid%} /v Flags /t REG_DWORD /d 15 /f
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss\{%uuid%} /v DefaultUid /t REG_DWORD /d 1000 /f

::����ΪĬ��
if "%set_default%"=="y" (
  reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss /v DefaultDistribution /t REG_SZ /d {%uuid%} /f
  reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss /v DefaultVersion /t REG_DWORD /d %dist_ver% /f
)

pause.
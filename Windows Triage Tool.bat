@ECHO off
color A0
mode con: cols=50 lines=120

:: Check for admin privileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
ECHO Requesting administrative privileges...
set "vbsGetPrivileges=%temp%\OEgetPriv.vbs"
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "%~fs0", "", "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%"
del "%vbsGetPrivileges%"
exit /B

:gotPrivileges
setlocal & pushd .
cd /d %~dp0

:start
CLS
color 0A
ECHO - - - - %USERDOMAIN%\%USERNAME% 
ECHO - - - -  WINDOWS TRIAGE TOOL  - - - -
ECHO                   ^^                  
ECHO                  /^|\
ECHO                 / ^| \  
ECHO       PROCESS  /  ^|  \  NETWORK
ECHO       EVENTS  /   O   \ ACTIVITY
ECHO              /  /   \  \
ECHO             / /       \ \
ECHO            /_____________\   
ECHO              PERSISTANCE
ECHO              MECHANISMS
ECHO _______________________________________
ECHO        NETWORK ACTIVITY TOOLS
ECHO =======================================
ECHO       1 = Netstat            
ECHO       2 = Check Open Ports
ECHO       3 = Procmon            
ECHO       4 = Process Explorer
ECHO       5 = Wireshark  
ECHO       6 = IP Configuration
ECHO       7 = Traceroute
ECHO       8 = Network Share View
ECHO       9 = Check DNS hosts File
ECHO _______________________________________
ECHO       PERSISTANCE MECHANISMS TOOLS
ECHO =======================================       
ECHO       10 = Task Scheduler
ECHO       11 = Regedit
ECHO       12 = Autoruns
ECHO       13 = Services
ECHO       14 = List User Accounts
ECHO       15 = List User Groups
ECHO _______________________________________
ECHO       PROCESS EVENT TOOLS
ECHO =======================================
ECHO       16 = Strings
ECHO       17 = Tasklist
ECHO       18 = PE Detective
ECHO       19 = Process Explorer
ECHO _______________________________________
ECHO       SYSTEM AND SECURITY TOOLS
ECHO =======================================
ECHO       20 = System Information
ECHO       21 = Event Viewer
ECHO       22 = Disk Usage
ECHO       23 = Windows Defender Scan
ECHO       24 = Task Manager
ECHO       25 = Registry Editor
ECHO       26 = DirectX Diagnostic Tool
ECHO       27 = Performance Monitor
ECHO       28 = Resource Monitor
ECHO       29 = Disk Cleanup
ECHO       30 = Disk Management
ECHO       31 = Windows Security Center
ECHO       32 = Check for Windows Updates
ECHO       33 = System Integrity Check
ECHO ---------------------------------------   
set /p inp= ENTER NUMBER TO LAUNCH TOOL:

:: Validate input and launch appropriate tool
call :launchTool %inp%
goto start

:launchTool
setlocal
set "choice=%1"
:: NETWORK TOOLS
if /i "%choice%" == "1" ( start cmd.exe /k netstat -a -b -f -o -q 10 & exit /b )
if /i "%choice%" == "2" (
    start cmd.exe /k "netstat -an | findstr LISTEN" & exit /b
)
if /i "%choice%" == "3" ( start procmon.exe & exit /b )
if /i "%choice%" == "4" ( start procexp.exe & exit /b )
if /i "%choice%" == "5" ( start wireshark.exe & exit /b )
if /i "%choice%" == "6" ( start cmd /k ipconfig /all & exit /b )
if /i "%choice%" == "7" ( start cmd /k tracert 8.8.8.8 & exit /b )
if /i "%choice%" == "8" ( start cmd /k net share & exit /b )
if /i "%choice%" == "9" ( start notepad.exe C:\Windows\System32\drivers\etc\hosts & exit /b )
:: PERSISTANCE TOOLS
if /i "%choice%" == "10" ( start taskschd.msc & exit /b )
if /i "%choice%" == "11" ( start regedit.exe & exit /b )
if /i "%choice%" == "12" ( start autoruns.exe & exit /b )
if /i "%choice%" == "13" ( start services.exe & exit /b )
if /i "%choice%" == "14" ( start cmd /k net user & exit /b )
if /i "%choice%" == "15" ( start cmd /k net localgroup & exit /b )
:: PROCESS EVENT TOOLS
if /i "%choice%" == "16" ( start cmd /k strings & exit /b )
if /i "%choice%" == "17" ( start cmd /k tasklist /SVC & exit /b )
if /i "%choice%" == "18" ( start "PE Detective" "C:\Program Files\NTCore\Explorer Suite\PE Detective.exe" & exit /b )
if /i "%choice%" == "19" ( start procexp.exe & exit /b )
:: SYSTEM AND SECURITY TOOLS
if /i "%choice%" == "20" ( start cmd /k systeminfo & exit /b )
if /i "%choice%" == "21" ( start eventvwr.msc & exit /b )
if /i "%choice%" == "22" ( start cmd /k chkdsk & exit /b )
if /i "%choice%" == "23" ( start powershell start-mpscan -scantype fullscan & exit /b )
if /i "%choice%" == "24" ( start taskmgr.exe & exit /b )
if /i "%choice%" == "25" ( start regedit.exe & exit /b )
if /i "%choice%" == "26" ( start dxdiag.exe & exit /b )
if /i "%choice%" == "27" ( start perfmon.msc & exit /b )
if /i "%choice%" == "28" ( start resmon.exe & exit /b )
if /i "%choice%" == "29" ( start cleanmgr.exe & exit /b )
if /i "%choice%" == "30" ( start diskmgmt.msc & exit /b )
if /i "%choice%" == "31" ( start ms-settings:privacy & exit /b )
if /i "%choice%" == "32" ( start ms-settings:windowsupdate & exit /b )
if /i "%choice%" == "33" ( start powershell -NoProfile -Command "Start-Process powershell -ArgumentList '-NoProfile -Command & {sfc /scannow}' -Verb RunAs" & exit /b )

:: If invalid choice
ECHO Invalid choice. Please enter a number between 1 and 33.
timeout /t 2 /nobreak >nul
exit /b

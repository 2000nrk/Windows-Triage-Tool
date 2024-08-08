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
ECHO - - %USERDOMAIN%\%USERNAME% - -
ECHO - - - - WINDOWS TRIAGE HELPER - - - -
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
ECHO       2 = Procmon            
ECHO       3 = Process Explorer
ECHO       4 = Wireshark  
ECHO       5 = IP Configuration
ECHO       6 = Traceroute
ECHO       7 = Network Share View
ECHO _______________________________________
ECHO       PERSISTANCE MECHANISMS TOOLS
ECHO =======================================       
ECHO       8 = Task Scheduler
ECHO       9 = Regedit
ECHO       10 = Autoruns
ECHO       11 = Services
ECHO       12 = List Users
ECHO       13 = List Groups
ECHO _______________________________________
ECHO       PROCESS EVENT TOOLS
ECHO =======================================
ECHO       14 = Strings
ECHO       15 = Tasklist
ECHO       16 = PE Detective
ECHO       17 = Process Explorer
ECHO _______________________________________
ECHO       SYSTEM AND SECURITY TOOLS
ECHO =======================================
ECHO       18 = System Information
ECHO       19 = Event Viewer
ECHO       20 = Disk Usage
ECHO       21 = File Integrity Checker
ECHO       22 = Windows Defender Scan
ECHO       23 = Windows Update
ECHO       24 = Task Manager
ECHO       25 = Registry Editor
ECHO       26 = DirectX Diagnostic Tool
ECHO       27 = Performance Monitor
ECHO       28 = Resource Monitor
ECHO       29 = Disk Cleanup
ECHO       30 = Disk Management
ECHO       31 = Windows Security Center
ECHO       32 = Check for Windows Updates
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
if /i "%choice%" == "2" ( start procmon.exe & exit /b )
if /i "%choice%" == "3" ( start procexp.exe & exit /b )
if /i "%choice%" == "4" ( start wireshark.exe & exit /b )
if /i "%choice%" == "5" ( start cmd /k ipconfig /all & exit /b )
if /i "%choice%" == "6" ( start cmd /k tracert 8.8.8.8 & exit /b )
if /i "%choice%" == "7" ( start cmd /k net share & exit /b )
:: PERSISTANCE TOOLS
if /i "%choice%" == "8" ( start taskschd.msc & exit /b )
if /i "%choice%" == "9" ( start regedit.exe & exit /b )
if /i "%choice%" == "10" ( start autoruns.exe & exit /b )
if /i "%choice%" == "11" ( start services.exe & exit /b )
if /i "%choice%" == "12" (
    start cmd /k "wmic useraccount list full"
    exit /b
)
if /i "%choice%" == "13" (
    start cmd /k "wmic group list full"
    exit /b
)
:: PROCESS EVENT TOOLS
if /i "%choice%" == "14" ( start cmd /k strings & exit /b )
if /i "%choice%" == "15" ( start cmd /k tasklist /SVC & exit /b )
if /i "%choice%" == "16" ( start "PE Detective" "C:\Program Files\NTCore\Explorer Suite\PE Detective.exe" & exit /b )
if /i "%choice%" == "17" ( start procexp.exe & exit /b )
:: SYSTEM AND SECURITY TOOLS
if /i "%choice%" == "18" ( start cmd /k systeminfo & exit /b )
if /i "%choice%" == "19" ( start eventvwr.msc & exit /b )
if /i "%choice%" == "20" ( start cmd /k chkdsk & exit /b )
if /i "%choice%" == "21" ( start cmd /k fc /? & exit /b )
if /i "%choice%" == "22" ( start msascui.exe & exit /b )
if /i "%choice%" == "23" ( start ms-settings:windowsupdate & exit /b )
if /i "%choice%" == "24" ( start taskmgr.exe & exit /b )
if /i "%choice%" == "25" ( start regedit.exe & exit /b )
if /i "%choice%" == "26" ( start dxdiag.exe & exit /b )
if /i "%choice%" == "27" ( start perfmon.msc & exit /b )
if /i "%choice%" == "28" ( start resmon.exe & exit /b )
if /i "%choice%" == "29" ( start cleanmgr.exe & exit /b )
if /i "%choice%" == "30" ( start diskmgmt.msc & exit /b )
if /i "%choice%" == "31" ( start ms-settings:privacy & exit /b )
if /i "%choice%" == "32" ( start ms-settings:windowsupdate & exit /b )

:: If invalid choice
ECHO Invalid choice. Please enter a number between 1 and 32.
timeout /t 2 /nobreak >nul
exit /b

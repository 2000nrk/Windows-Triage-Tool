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
ECHO       6 = Ping Test
ECHO       7 = Traceroute
ECHO       8 = Network Share View
ECHO _______________________________________
ECHO       PERSISTANCE MECHANISMS TOOLS
ECHO =======================================       
ECHO       9 = Task Scheduler
ECHO       10 = Regedit
ECHO       11 = Autoruns
ECHO       12 = Services
ECHO       13 = List Users
ECHO       14 = List Groups
ECHO _______________________________________
ECHO       PROCESS EVENT TOOLS
ECHO =======================================
ECHO       15 = Strings
ECHO       16 = Tasklist
ECHO       17 = PE Detective
ECHO       18 = Process Explorer
ECHO _______________________________________
ECHO       SYSTEM AND SECURITY TOOLS
ECHO =======================================
ECHO       19 = System Information
ECHO       20 = Event Viewer
ECHO       21 = Disk Usage
ECHO       22 = File Integrity Checker
ECHO       23 = Windows Defender Scan
ECHO       24 = Windows Update
ECHO       25 = Task Manager
ECHO       26 = Registry Editor
ECHO       27 = DirectX Diagnostic Tool
ECHO       28 = Performance Monitor
ECHO       29 = Resource Monitor
ECHO       30 = Disk Cleanup
ECHO       31 = Disk Management
ECHO       32 = Windows Security Center
ECHO       33 = Check for Windows Updates
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
if /i "%choice%" == "6" (
    set /p target=Enter the IP address or hostname to ping: 
    if "%target%"=="" (goto start)
    start cmd /k ping %target% & exit /b
)
if /i "%choice%" == "7" ( start cmd /k tracert 8.8.8.8 & exit /b )
if /i "%choice%" == "8" ( start cmd /k net share & exit /b )
:: PERSISTANCE TOOLS
if /i "%choice%" == "9" ( start taskschd.msc & exit /b )
if /i "%choice%" == "10" ( start regedit.exe & exit /b )
if /i "%choice%" == "11" ( start autoruns.exe & exit /b )
if /i "%choice%" == "12" ( start services.exe & exit /b )
if /i "%choice%" == "13" (
    start cmd /k net user
    exit /b
)
if /i "%choice%" == "14" (
    start cmd /k net localgroup
    exit /b
)
:: PROCESS EVENT TOOLS
if /i "%choice%" == "15" ( start cmd /k strings & exit /b )
if /i "%choice%" == "16" ( start cmd /k tasklist /SVC & exit /b )
if /i "%choice%" == "17" ( start "PE Detective" "C:\Program Files\NTCore\Explorer Suite\PE Detective.exe" & exit /b )
if /i "%choice%" == "18" ( start procexp.exe & exit /b )
:: SYSTEM AND SECURITY TOOLS
if /i "%choice%" == "19" ( start cmd /k systeminfo & exit /b )
if /i "%choice%" == "20" ( start eventvwr.msc & exit /b )
if /i "%choice%" == "21" ( start cmd /k chkdsk & exit /b )
if /i "%choice%" == "22" ( start cmd /k fc /? & exit /b )
if /i "%choice%" == "23" ( start msascui.exe & exit /b )
if /i "%choice%" == "24" ( start ms-settings:windowsupdate & exit /b )
if /i "%choice%" == "25" ( start taskmgr.exe & exit /b )
if /i "%choice%" == "26" ( start regedit.exe & exit /b )
if /i "%choice%" == "27" ( start dxdiag.exe & exit /b )
if /i "%choice%" == "28" ( start perfmon.msc & exit /b )
if /i "%choice%" == "29" ( start resmon.exe & exit /b )
if /i "%choice%" == "30" ( start cleanmgr.exe & exit /b )
if /i "%choice%" == "31" ( start diskmgmt.msc & exit /b )
if /i "%choice%" == "32" ( start ms-settings:privacy & exit /b )
if /i "%choice%" == "33" ( start ms-settings:windowsupdate & exit /b )

:: If invalid choice
ECHO Invalid choice. Please enter a number between 1 and 33.
timeout /t 2 /nobreak >nul
exit /b

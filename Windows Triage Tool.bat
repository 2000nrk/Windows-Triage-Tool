@ECHO off
color A0
ECHO RUNNING AS ADMINISTRATOR

:: Check for admin privileges
:init
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (ECHO ELEV & shift /1 & goto gotPrivileges)
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /B

:gotPrivileges
setlocal & pushd .
cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

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
ECHO         NETWORK ACTIVITY TOOLS
ECHO =======================================
ECHO             1 = Netstat            
ECHO             2 = Procmon            
ECHO             3 = Process Explorer
ECHO             4 = Wireshark  
ECHO             5 = IP Configuration
ECHO             6 = Ping Test
ECHO             7 = Traceroute
ECHO             8 = Network Share View
ECHO _______________________________________
ECHO       PERSISTANCE MECHANISMS TOOLS
ECHO =======================================       
ECHO             9 = Task Scheduler
ECHO             10 = Regedit
ECHO             11 = Autoruns
ECHO             12 = Services
ECHO _______________________________________
ECHO          PROCESS EVENT TOOLS
ECHO =======================================
ECHO            13 = Strings
ECHO            14 = Tasklist
ECHO            15 = PE Detective
ECHO            16 = Process Explorer
ECHO _______________________________________
ECHO         SYSTEM AND SECURITY TOOLS
ECHO =======================================
ECHO            17 = System Information
ECHO            18 = Event Viewer
ECHO            19 = Disk Usage
ECHO            20 = File Integrity Checker
ECHO            21 = Windows Defender Scan
ECHO            22 = Windows Update
ECHO            23 = Task Manager
ECHO            24 = Registry Editor
ECHO            25 = DirectX Diagnostic Tool
ECHO            26 = Performance Monitor
ECHO            27 = Resource Monitor
ECHO            28 = Disk Cleanup
ECHO            29 = Disk Management
ECHO            30 = Windows Security Center
ECHO            31 = Check for Windows Updates
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
if /i "%choice%" == "6" ( start cmd /k ping 8.8.8.8 & exit /b )
if /i "%choice%" == "7" ( start cmd /k tracert 8.8.8.8 & exit /b )
if /i "%choice%" == "8" ( start cmd /k net share & exit /b )
:: PERSISTANCE TOOLS
if /i "%choice%" == "9" ( start taskschd.msc & exit /b )
if /i "%choice%" == "10" ( start regedit.exe & exit /b )
if /i "%choice%" == "11" ( start autoruns.exe & exit /b )
if /i "%choice%" == "12" ( start services.exe & exit /b )
:: PROCESS EVENT TOOLS
if /i "%choice%" == "13" ( start cmd /k strings & exit /b )
if /i "%choice%" == "14" ( start cmd /k tasklist /SVC & exit /b )
if /i "%choice%" == "15" ( start "PE Detective" "C:\Program Files\NTCore\Explorer Suite\PE Detective.exe" & exit /b )
if /i "%choice%" == "16" ( start procexp.exe & exit /b )
:: SYSTEM AND SECURITY TOOLS
if /i "%choice%" == "17" ( start cmd /k systeminfo & exit /b )
if /i "%choice%" == "18" ( start eventvwr.msc & exit /b )
if /i "%choice%" == "19" ( start cmd /k chkdsk & exit /b )
if /i "%choice%" == "20" ( start cmd /k fc /? & exit /b )
if /i "%choice%" == "21" ( start msascui.exe & exit /b )
if /i "%choice%" == "22" ( start ms-settings:windowsupdate & exit /b )
if /i "%choice%" == "23" ( start taskmgr.exe & exit /b )
if /i "%choice%" == "24" ( start regedit.exe & exit /b )
if /i "%choice%" == "25" ( start dxdiag.exe & exit /b )
if /i "%choice%" == "26" ( start perfmon.msc & exit /b )
if /i "%choice%" == "27" ( start resmon.exe & exit /b )
if /i "%choice%" == "28" ( start cleanmgr.exe & exit /b )
if /i "%choice%" == "29" ( start diskmgmt.msc & exit /b )
if /i "%choice%" == "30" ( start ms-settings:privacy & exit /b )
if /i "%choice%" == "31" ( start ms-settings:windowsupdate & exit /b )

:: If invalid choice
ECHO Invalid choice. Please enter a number between 1 and 31.
timeout /t 2 /nobreak >nul
exit /b

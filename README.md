# Windows Triage Tool
```
- - - - %USERDOMAIN%\%USERNAME%     
- - - -  WINDOWS TRIAGE TOOL  - - - -
                  ^
                 /|\
                / | \
      PROCESS  /  |  \  NETWORK
      EVENTS  /   O   \ ACTIVITY
             /  /   \  \
            / /       \ \
           /_____________\
             PERSISTANCE
             MECHANISMS
_______________________________________
       NETWORK ACTIVITY TOOLS
=======================================
      1 = Netstat
      2 = Check Open Ports
      3 = Procmon
      4 = Process Explorer
      5 = Wireshark
      6 = IP Configuration
      7 = Traceroute
      8 = Network Share View
      9 = Check DNS Hosts File
_______________________________________
      PERSISTANCE MECHANISMS TOOLS
=======================================
      10 = Task Scheduler
      11 = Registry Editor
      12 = Autoruns
      13 = Services
      14 = List User Accounts
      15 = List User Groups
_______________________________________
      PROCESS EVENT TOOLS
=======================================
      16 = Strings
      17 = Tasklist
      18 = PE Detective
      19 = Process Explorer
_______________________________________
      SYSTEM AND SECURITY TOOLS
=======================================
      20 = Open VirusTotal
      21 = System Information
      22 = Event Viewer
      23 = Disk Usage
      24 = Windows Defender Scan
      25 = Task Manager
      26 = DirectX Diagnostic Tool
      27 = Performance Monitor
      28 = Resource Monitor
      29 = Disk Cleanup
      30 = Disk Management
      31 = Windows Security Center
      32 = Check for Windows Updates
      33 = System Integrity Check
---------------------------------------
ENTER NUMBER TO LAUNCH TOOL:
```

## Overview

The Windows Triage Tool is a batch script utility designed for Cybersecurity professionals to assist in quickly accessing a variety of essential tools and utilities for system administration, network monitoring, persistence mechanism analysis, and process/event investigation on Windows operating systems. This script simplifies the process of launching these tools by providing a user-friendly menu interface.

## Requirements:
- Windows operating system (Windows 7 or later recommended).
- Wireshark https://www.wireshark.org/download.html
- Windows Sysinternals https://learn.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite
    or Run the following from cmd promts to install:

      winget show "Sysinternals Suite"
  
      winget install "Sysinternals Suite"
  
- Administrative privileges (the script will prompt for elevation).

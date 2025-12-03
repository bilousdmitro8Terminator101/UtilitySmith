@echo off
:: Checking for administrator privileges...
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ===============================================
    echo   This script needs to be run by Administrator!
    echo ===============================================
    echo.
    echo I'm restarting with administrator privileges...
    echo.
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit
)

mode con cols=200 lines=60

title Utility Box Console v.1.0.0
color 0B

:menu
cls 
echo ====================================================
echo       UTILITY BOX CONSOLE v.1.0.0 Main menu 
echo ====================================================
echo. 
echo Press key [1] = Utilities console
echo Press key [2] = DISM console
echo Press key [3] = Deep Cleaner console
echo Press key [4] = Shutdown console
echo ====================================================
echo Press key [X] = EXIT
echo ====================================================
echo.
echo ----------------------------------------------------
echo Press Alt+ENTER = full screen mode
echo ====================================================
set /p choice=Select an action ; press ENTER:
echo ====================================================


if /I "%choice%"=="1" goto Utilities_console 
if /I "%choice%"=="2" goto dismconsole
if /I "%choice%"=="3" goto Deep_Cleaner
if /I "%choice%"=="4" goto Shutdown_console 
if /I "%choice%"=="X" goto end

:: ---------------- Utilities console ----------------
:Utilities_console
color 0A
cls
echo ============================================
echo         Utilities console
echo ============================================
echo Insert number [1] = Disc manager
echo Insert number [2] = System version
echo Insert number [3] = Mobility Center (For laptop only)
echo Insert number [4] = Notepad
echo Insert number [5] = Explorer (My computer folder)
echo Insert number [6] = Windows Turning components ON / OFF
echo Insert number [7] = Windows servises
echo Insert number [8] = Audio devices
echo Insert number [9] = Sound mixer
echo Insert number [10] = Device manager
echo Insert number [11] = About PC
echo Insert number [12] = System configuration
echo Insert number [13] = Regedit (!!! CAUTION !!! - CHANGING REGISTRY VALUES MAY DAMAGE YOUR SYSTEM OR MAKE IT UNSTABLE)
echo Insert number [14] = Task manager
echo Insert number [15] = Power control classic
echo Insert number [16] = Time ; date
echo Insert number [17] = System properties
echo Insert number [18] = Programs ; components
echo Insert number [19] = Control folders
echo Insert number [20] = System recovery (Control panel)
echo.

echo =========================================
echo Press key [M] = Main menu
echo -----------------------------------------
echo Press key [X] = EXIT
echo =========================================
echo.
echo =========================================
set /p choice=Select an action ; press ENTER:
echo =========================================

if "%choice%"=="1" start diskmgmt.msc & goto Utilities_console
if "%choice%"=="2" systeminfo | more & goto Utilities_console
if "%choice%"=="3" start mblctr & goto Utilities_console
if "%choice%"=="4" start notepad & goto Utilities_console
if "%choice%"=="5" start explorer & goto Utilities_console
if "%choice%"=="6" start OptionalFeatures.exe & goto Utilities_console
if "%choice%"=="7" start services.msc & goto Utilities_console
if "%choice%"=="8" start mmsys.cpl & goto Utilities_console
if "%choice%"=="9" start sndvol & goto Utilities_console
if /i "%choice%"=="10" start devmgmt.msc & goto Utilities_console
if /i "%choice%"=="11" start msinfo32 & goto Utilities_console
if /i "%choice%"=="12" msconfig & goto Utilities_console
if /i "%choice%"=="13" start Regedit & goto Utilities_console
if /i "%choice%"=="14" start taskmgr & goto Utilities_console
if /i "%choice%"=="15" start control powercfg.cpl & goto Utilities_console
if /i "%choice%"=="16" start timedate.cpl & goto Utilities_console
if /i "%choice%"=="17" start SystemPropertiesProtection & goto Utilities_console
if /i "%choice%"=="18" start appwiz.cpl & goto Utilities_console
if /i "%choice%"=="19" start control folders & goto Utilities_console
if /i "%choice%"=="20" start rstrui.exe

if /I "%choice%"=="M" goto menu
if /I "%choice%"=="X" exit

goto Utilities_console

:: ---------------- DISM console ----------------
:dismconsole
color 0C
cls
echo ============================================
echo          DISM CONSOLE
echo ============================================
echo.
echo Press key [1] = Repairing damaged components
echo Press key [2] = Enable .NET Framework 3.5 (From mount ISO \ DVD \ USB device)
echo Press key [3] = Enable DirectPlay
echo Press key [4] = Driver backup
echo Press key [5] = List of all Windows features
echo Press key [6] = Quick damage check
echo Press key [7] = Deep scan of system files
echo.
echo =========================================
echo Press key [M] = Main menu
echo -----------------------------------------
echo Press key [X] = EXIT
echo =========================================
echo.
echo =========================================
set /p choice=Select an action ; press ENTER:
echo =========================================

if /I "%choice%"=="1" DISM /Online /Cleanup-Image /RestoreHealth & pause & goto dismconsole
if /I "%choice%"=="2" goto netfx
if /I "%choice%"=="3" DISM /Online /Enable-Feature /FeatureName:DirectPlay /All & pause & goto dismconsole
if /I "%choice%"=="4" goto DriverExport
if /I "%choice%"=="5" DISM /Online /Get-Features & pause & goto dismconsole
if /I "%choice%"=="6" DISM /Online /Cleanup-Image /CheckHealth & pause & goto dismconsole
if /I "%choice%"=="7" DISM /Online /Cleanup-Image /ScanHealth & pause & goto dismconsole
if /I "%choice%"=="M" goto menu
if /I "%choice%"=="X" exit
goto dismconsole

:: ---------------- Deep Cleaner ----------------
:Deep_Cleaner
color 0F
cls
echo ============================================
echo         DEEP CLEANER
echo ============================================
echo Press key [1] = Clear the update cache
echo Press key [2] = Clear Temp files
echo Press key [3] = Clean Manager
echo Press key [4] = Delete folder "Windows.old" (WARNING!!! THIS CANNOT BE UNDONE AND SYSTEM ROLLBACK WILL BE UNAVAILABLE.)
echo.
echo =========================================
echo Press key [M] = Main menu
echo -----------------------------------------
echo Press key [X] = EXIT
echo =========================================
echo.
echo =========================================
set /p choice=Select an action: press ENTER
echo =========================================

if "%choice%"=="1" goto cleanup
if "%choice%"=="2" goto tempclean
if "%choice%"=="3" start cleanmgr & goto backcleaner
if "%choice%"=="4" goto dellwindowsold
if /I "%choice%"=="M" goto menu
if /I "%choice%"=="X" exit
goto Deep_Cleaner

:cleanup
echo Clearing the update cache...
DISM /Online /Cleanup-Image /StartComponentCleanup
goto backcleaner

:tempclean
echo Cleaning temp files...
del /s /q %temp%\*.*
del /s /q C:\Windows\Temp\*.*
del /s /q C:\Windows\Prefetch\*.*
del /s /q C:\Windows\SoftwareDistribution\*.*
echo Temp files have been cleaned!
goto backcleaner

:backcleaner
echo.
echo ============================================
echo   Press [M] to return to Main menu
echo --------------------------------------------
echo   Press [X] to EXIT
echo ============================================

set /p back=
if /I "%back%"=="M" goto menu
if /I "%back%"=="X" exit
echo Invalid choice, try again.
goto backcleaner


:: ---------------- Shutdown console ----------------
:Shutdown_console
color 0E
cls
echo ==================================
echo         SHUTDOWN CONSOLE
echo ==================================
echo.
echo Press key [1] = Hibernate PC
echo Press key [2] = Shutdown PC
echo Press key [3] = Reboot PC
echo Press key [4] = Special loading options mode
echo Press key [5] = Find the BOOT MENU Key
echo Press key [6] = Find the BIOS \ UEFI Key
echo Press key [7] = Find the RECOVERY Key
echo Press key [8] = Reboot to BIOS \ UEFI
echo Press key [9] = Reboot to RECOVERY MODE

echo.
echo =========================================
echo Press key [M] = Main menu
echo -----------------------------------------
echo Press key [X] = EXIT
echo =========================================
echo.
echo =========================================
set /p choice=Select an action ; press ENTER:
echo =========================================

if "%choice%"=="1" shutdown /h & exit
if "%choice%"=="2" shutdown /s /t 0
if "%choice%"=="3" shutdown /r /f /t 0
if "%choice%"=="4" shutdown /r /o /t 0
if "%choice%"=="5" goto BootMenu
if "%choice%"=="6" goto BIOSSetup
if "%choice%"=="7" goto RecoveryMode
if "%choice%"=="8" shutdown /r /fw
if "%choice%"=="9" shutdown /r /o /t 0



if /I "%choice%"=="M" goto menu
if /I "%choice%"=="X" exit

goto Shutdown_console

:: ---------------- BOOT MENU ----------------
:BootMenu
color 0F
setlocal EnableDelayedExpansion
title Utility Box Console - Boot Menu

echo.
echo ================================
echo     Check for support /fw
echo ================================
echo.

wmic computersystem get manufacturer > manufacturer.txt
set "fwSupport=0"

:: Check for support /fw
shutdown /fw /t 0 /c "Support test /fw" >nul 2>&1
if %errorlevel%==0 (
    set "fwSupport=1"
)

:: Manufacturer receipt
for /f "skip=1 tokens=* delims=" %%a in (manufacturer.txt) do set "vendor=%%a"
del manufacturer.txt

:: Key output Boot Menu
echo Label: !vendor!
echo.

set "key=F12"
if /i "!vendor!"=="ASUS" set "key=F8"
if /i "!vendor!"=="Gigabyte" set "key=F12"
if /i "!vendor!"=="MSI" set "key=F11 or F3"
if /i "!vendor!"=="HP" set "key=Esc or F9"
if /i "!vendor!"=="Dell" set "key=F12"
if /i "!vendor!"=="Lenovo" set "key=F12 or Enter or F11"
if /i "!vendor!"=="Acer" set "key=F12 or F10"
if /i "!vendor!"=="eMachines" set "key=F12"
if /i "!vendor!"=="Packard Bell" set "key=F12 or F10 or F8"
if /i "!vendor!"=="Samsung" set "key=Esc or F4"
if /i "!vendor!"=="Toshiba" set "key=F8 or F11"
if /i "!vendor!"=="Sony Vaio" set "key=F11 or Esc or F10"
if /i "!vendor!"=="Fujitsu Siemens" set "key=F12"



echo ================================================
echo Manufacturer detected: !vendor!
echo ------------------------------------------------
echo Boot Menu key: !key!
echo ================================================


:: Reboot confirmation
if "!fwSupport!"=="1" (
    echo The system supports the transition to UEFI over /fw.
    echo.
    choice /m "Do you want to reboot with a transition to Boot Menu?"
    if errorlevel 2 (
        echo Abolition.
        pause
    ) else (
        shutdown /r /fw /t 0
    )
) else (
    echo Warning: /fw is not supported on your system.
    echo Please reboot manually and press !key! at startup.
    pause
)

endlocal
goto Shutdown_console

:: ---------------- BIOS SETUP ----------------
:BIOSSetup
color 0F
setlocal EnableDelayedExpansion
title Utility Box Console - BIOS Setup

echo.
echo ================================
echo     BIOS/UEFI Setup Keys
echo ================================
echo.

wmic computersystem get manufacturer > manufacturer.txt
for /f "skip=1 tokens=* delims=" %%a in (manufacturer.txt) do set "vendor=%%a"
del manufacturer.txt

set "biosKey=Del"
if /i "!vendor!"=="ASUS" set "biosKey=Delete or F2 or Esc or Fn+F2"
if /i "!vendor!"=="Gigabyte" set "biosKey=Delete"
if /i "!vendor!"=="MSI" set "biosKey=Delete"
if /i "!vendor!"=="HP" set "biosKey=Esc or F10 or F1 or F2"
if /i "!vendor!"=="Dell" set "biosKey=F2 or Delete"
if /i "!vendor!"=="Lenovo" set "biosKey=F1 or F2 or F12 or Fn+F2"
if /i "!vendor!"=="Acer" set "biosKey=F2 or Delete or F1 or Esc or Ctrl+Alt"
if /i "!vendor!"=="Samsung" set "biosKey=F2 or Delete"
if /i "!vendor!"=="Toshiba" set "biosKey=F2 or Esc or F1 or F12"
if /i "!vendor!"=="Sony Vaio" set "biosKey=F2 or F3 or F1 or Delete or assist"
if /i "!vendor!"=="Fujitsu Siemens" set "biosKey=F2"
if /i "!vendor!"=="eMachines" set "biosKey=F2 or Delete"
if /i "!vendor!"=="Packard Bell" set "biosKey=F2 or Delete"

echo ================================================
echo Manufacturer detected: !vendor!
echo ------------------------------------------------
echo BIOS/UEFI Setup key: !biosKey!
echo ================================================

pause
endlocal
goto Shutdown_console


:: ---------------- RECOVERY MODE ----------------
:RecoveryMode
color 0F
setlocal EnableDelayedExpansion
title Utility Box Console - Recovery Mode

echo.
echo ================================
echo     Recovery Mode Keys
echo ================================
echo.

wmic computersystem get manufacturer > manufacturer.txt
for /f "skip=1 tokens=* delims=" %%a in (manufacturer.txt) do set "vendor=%%a"
del manufacturer.txt

set "recKey=F9"
if /i "!vendor!"=="ASUS" set "recKey=F9"
if /i "!vendor!"=="HP" set "recKey=F11"
if /i "!vendor!"=="Dell" set "recKey=Ctrl+F11"
if /i "!vendor!"=="Lenovo" set "recKey=F11 or Novo button or F8 or 0 (zero)"
if /i "!vendor!"=="Acer" set "recKey=Alt+F10"
if /i "!vendor!"=="Samsung" set "recKey=F4"
if /i "!vendor!"=="Toshiba" set "recKey=0 (zero) or F8 or Fn+0 (zero)"
if /i "!vendor!"=="Sony Vaio" set "recKey=Assist button or F10"
if /i "!vendor!"=="Fujitsu Siemens" set "recKey=F12 or F8 or 0 (zero) or Fn+0 (zero)"
if /i "!vendor!"=="eMachines" set "recKey=Alt+F10"
if /i "!vendor!"=="MSI" set "recKey=F3"
if /i "!vendor!"=="Packard Bell" set "recKey=F10"

echo ================================================
echo Manufacturer detected: !vendor!
echo ------------------------------------------------
echo Recovery Mode key: !recKey!
echo ================================================

pause
endlocal
goto Shutdown_console

:netfx
cls
echo ============================================
echo   .NET Framework 3.5 Installer
echo ============================================
echo Searching installation media...
set found=0

for %%d in (D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%d:\sources\sxs (
        echo Found source at %%d:\
        set found=1
        dism /online /enable-feature /featurename:NetFx3 /All /Source:%%d:\sources\sxs /LimitAccess
        goto backnetfx
    )
)

if %found%==0 (
    echo --------------------------------------------------------------
    echo No installation media found.
    echo --------------------------------------------------------------
    echo Please insert DVD/USB or mount ISO with \sources\sxs folder.
    echo --------------------------------------------------------------
)
goto backnetfx

:backnetfx
echo.
echo ============================================
echo   Press [M] to return to Main menu
echo --------------------------------------------
echo   Press [X] to EXIT
echo ============================================

set /p back=
if /I "%back%"=="M" goto menu
if /I "%back%"=="X" exit
goto backnetfx

:DriverExport

@echo off
title Utility Box Console - Export drivers
color 0A

set "driverDir=D:\MyDrivers"

:: Check if the folder exists, if not, create it
if not exist "%driverDir%" (
    echo Creating a folder %driverDir%...
    mkdir "%driverDir%"
)

:: Driver export
echo Driver export to %driverDir%...
DISM /Online /Export-Driver /Destination:"%driverDir%"

start "" "%driverDir%"

pause
goto dismconsole

:dellwindowsold
title Utility Box Console - Removind Windows.old
color 0C

echo =====================================================================
echo   WARNING!!! YOU ARE ABOUT TO DELETE THE Windows.old FOLDER.
echo   THIS CANNOT BE UNDONE AND SYSTEM ROLLBACK WILL BE UNAVAILABLE.
echo =====================================================================
echo.
echo ------------------------------------------------------
set /p confirm1=Are you sure you want to continue? (Y/N):
echo ------------------------------------------------------
if /I not "%confirm1%"=="Y" goto Deep_Cleaner

echo.
echo ------------------------------------------------------
set /p confirm2=Confirm deletion again. Windows.old (Y/N):
echo ------------------------------------------------------
if /I not "%confirm2%"=="Y" goto Deep_Cleaner

echo -----------------------------------
echo Removal folder Windows.old...
echo -----------------------------------
rd /s /q C:\Windows.old

echo ------------------------------------------------
echo Folder Windows.old Deleted successfully!
echo ------------------------------------------------

pause
goto Deep_Cleaner



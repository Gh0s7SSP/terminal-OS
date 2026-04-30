@echo off
title TERM OS v2.0
color 0A
mode con: cols=80 lines=40

powershell -Command "Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass" >nul 2>&1

:: ════════════════════════════
::         BOOT SEQUENCE
:: ════════════════════════════
cls
echo.
echo  [========================================]
echo  [         TERM OS v2.0  BIOS             ]
echo  [========================================]
echo.
timeout /t 1 >nul
echo  [OK] Initializing hardware...
timeout /t 1 >nul
echo  [OK] Loading kernel modules...
timeout /t 1 >nul
echo  [OK] Mounting virtual filesystem...
timeout /t 1 >nul
echo  [OK] Starting desktop environment...
timeout /t 1 >nul
echo  [OK] All systems ready.
echo.
echo  by 4y0ubyyyy
timeout /t 2 >nul

:: ════════════════════════════
::         LOGIN SCREEN
:: ════════════════════════════
:login
cls
echo.
echo  ╔══════════════════════════════════════╗
echo  ║                                      ║   idk how to fix this pls contact me...
echo  ║          T E R M   O S  v2.          ║
echo  ║              hell yeahhh             ║
echo  ╠══════════════════════════════════════╣
echo  ║                                      ║
echo  ║   Please log in to continue.         ║
echo  ║                                      ║
echo  ╚══════════════════════════════════════╝
echo.

set /p loginuser=  Username: 
set /p loginpass=  Password: 

if /i "%loginuser%"=="admin" if "%loginpass%"=="1234" goto boot_ok
if /i "%loginuser%"=="root"  if "%loginpass%"=="toor"  goto boot_ok

echo.
echo  [!!] ACCESS DENIED — invalid credentials.AKA your dumbahh couldnt even login lol
timeout /t 2 >nul
goto login

:boot_ok
echo.
echo  [**] Welcome back, %loginuser%! Loading desktop.....
timeout /t 1 >nul

:: ════════════════════════════
::         LAUNCH DESKTOP
:: ════════════════════════════
powershell -ExecutionPolicy Bypass -File "%~dp0desktop.ps1" -Username "%loginuser%"
exit
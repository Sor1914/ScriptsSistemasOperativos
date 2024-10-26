@echo off
setlocal enabledelayedexpansion

:checkSystem
REM Obtener el uso de CPU
for /f "skip=1" %%p in ('wmic cpu get loadpercentage') do (
    set cpuLoad=%%p
    goto checkMemory
)

:checkMemory
REM Obtener la memoria libre
for /f "skip=1" %%m in ('wmic OS get FreePhysicalMemory /Value') do (
    set mem=%%m
    set memFree=!mem:~19,-1!
)

REM Obtener la memoria total
for /f "skip=1" %%t in ('wmic computersystem get totalphysicalmemory') do (
    set totalMem=%%t
    set /a totalMemMB=!totalMem:~0,-3!/1024
)

REM Convertir la memoria libre a porcentaje
set /a usedMemPct=(totalMemMB - (memFree / 1024)) * 100 / totalMemMB

REM Comprobar si el uso de CPU o memoria supera el 80%
if %cpuLoad% GTR 80 (
    echo Advertencia: El uso de CPU ha superado el 80%%.
    powershell -command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('El uso de CPU ha superado el 80%','Advertencia de CPU')}"
)

if %usedMemPct% GTR 80 (
    echo Advertencia: El uso de Memoria ha superado el 80%%.
    powershell -command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('El uso de Memoria ha superado el 80%','Advertencia de Memoria')}"
)

timeout /t 30 >nul
goto checkSystem

@echo off
rem Definir la ruta de la carpeta donde se guardarán los archivos
set ruta=C:\monitoreo_firewall

rem Crear la carpeta si no existe
if not exist "%ruta%" (
    mkdir "%ruta%"    
)

rem Verificar si el archivo de estado anterior existe, si no, crearlo
if not exist "%ruta%\firewall_last.txt" (
    echo Creando archivo de estado anterior...
    netsh advfirewall firewall show rule name=all > "%ruta%\firewall_last.txt"
)

:monitor
rem Guardar el estado actual de las reglas de firewall en la carpeta especificada
netsh advfirewall firewall show rule name=all > "%ruta%\firewall_state.txt"

rem Comparar el estado actual con el último estado conocido
fc "%ruta%\firewall_state.txt" "%ruta%\firewall_last.txt" > "%ruta%\cambios.txt"
if errorlevel 1 (
    echo Cambios detectados en las reglas de firewall
    echo Enviando alerta...

    rem Mostrar la diferencia (cambio) en un archivo temporal
    setlocal enabledelayedexpansion
    set "cambios="
    for /f "delims=" %%a in (%ruta%\cambios.txt) do (
        set "cambios=!cambios! %%a"
    )

    rem Llamar a PowerShell para mostrar alerta
    powershell -command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('ALERTA: Se ha detectado una modificacion en el Firewall')"
    
    rem Actualizar el estado guardado
    copy /y "%ruta%\firewall_state.txt" "%ruta%\firewall_last.txt" > nul
) else (
    echo No se detectaron cambios en las reglas de firewall.
)

rem Esperar 5 segundos antes de verificar nuevamente
timeout /t 5 /nobreak > nul
goto monitor
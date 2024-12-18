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
    netsh advfirewall show allprofiles state > "%ruta%\firewall_last.txt"
)

:monitor
rem Guardar el estado actual del firewall en la carpeta especificada
netsh advfirewall show allprofiles state > "%ruta%\firewall_state.txt"

rem Comparar el estado actual con el último estado conocido
fc "%ruta%\firewall_state.txt" "%ruta%\firewall_last.txt" > "%ruta%\cambios.txt"
if errorlevel 1 (
    echo Cambios detectados en el firewall
    echo Enviando alerta...

    rem Mostrar la diferencia (cambio) en un archivo temporal
    setlocal enabledelayedexpansion
    set "cambios="
    for /f "delims=" %%a in (%ruta%\cambios.txt) do (
        set "cambios=!cambios! %%a"
    )

    rem Enviar alerta emergente con el cambio detectado
    msg * "ALERTA: Cambio en el firewall detectado: !cambios!"
    
    rem Actualizar el estado guardado
    copy "%ruta%\firewall_state.txt" "%ruta%\firewall_last.txt"
) else (
    echo No se detectaron cambios en el firewall.
)

rem Esperar 5 segundos antes de verificar nuevamente
timeout /t 5 /nobreak > nul
goto monitor
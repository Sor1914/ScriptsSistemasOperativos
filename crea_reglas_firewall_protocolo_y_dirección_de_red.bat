@echo off
setlocal enabledelayedexpansion

set /p "PORT=Ingresa el número del puerto que deseas configurar: "
echo Selecciona la acción:
echo 1. Permitir tráfico en el puerto
echo 2. Bloquear tráfico en el puerto
set /p "ACTION=Elige una opción (1 o 2): "
echo Selecciona el protocolo:
echo 1. TCP
echo 2. UDP
set /p "PROTOCOL=Elige una opción (1 o 2): "
echo Selecciona la dirección:
echo 1. Entrada
echo 2. Salida
set /p "DIRECTION=Elige una opción (1 o 2): "

if "%PROTOCOL%"=="1" (
    set "PROTO=TCP"
) else if "%PROTOCOL%"=="2" (
    set "PROTO=UDP"
) else (
    echo Opción de protocolo no válida.
    pause
    exit /b 1
)

if "%DIRECTION%"=="1" (
    set "DIR=in"
) else if "%DIRECTION%"=="2" (
    set "DIR=out"
) else (
    echo Opción de dirección no válida.
    pause
    exit /b 1
)

if "%ACTION%"=="1" (
    netsh advfirewall firewall add rule name="Permitir Tráfico en Puerto %PORT%" protocol=%PROTO% dir=%DIR% localport=%PORT% action=allow
    if %errorlevel% equ 0 (
        echo El puerto %PORT% en protocolo %PROTO% ha sido permitido en dirección %DIR%.
    ) else (
        echo Error al permitir el puerto %PORT% en protocolo %PROTO% en dirección %DIR%.
    )
) else if "%ACTION%"=="2" (
    netsh advfirewall firewall add rule name="Bloquear Tráfico en Puerto %PORT%" protocol=%PROTO% dir=%DIR% localport=%PORT% action=block
    if %errorlevel% equ 0 (
        echo El puerto %PORT% en protocolo %PROTO% ha sido bloqueado en dirección %DIR%.
    ) else (
        echo Error al bloquear el puerto %PORT% en protocolo %PROTO% en dirección %DIR%.
    )
) else (
    echo Opción de acción no válida. Usa "1" para permitir o "2" para bloquear.
)

pause

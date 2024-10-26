@echo off
setlocal enabledelayedexpansion

echo Ingresa el rango de puertos (ejemplo: 1000-2000):
set /p "PORT_RANGE="
echo Selecciona la acción:
echo 1. Permitir tráfico en el rango de puertos
echo 2. Bloquear tráfico en el rango de puertos
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
    netsh advfirewall firewall add rule name="Permitir Rango de Puertos %PORT_RANGE%" protocol=%PROTO% dir=%DIR% localport=%PORT_RANGE% action=allow
    if %errorlevel% equ 0 (
        echo El rango de puertos %PORT_RANGE% en protocolo %PROTO% ha sido permitido en dirección %DIR%.
    ) else (
        echo Error al permitir el rango de puertos %PORT_RANGE% en protocolo %PROTO% en dirección %DIR%.
    )
) else if "%ACTION%"=="2" (
    netsh advfirewall firewall add rule name="Bloquear Rango de Puertos %PORT_RANGE%" protocol=%PROTO% dir=%DIR% localport=%PORT_RANGE% action=block
    if %errorlevel% equ 0 (
        echo El rango de puertos %PORT_RANGE% en protocolo %PROTO% ha sido bloqueado en dirección %DIR%.
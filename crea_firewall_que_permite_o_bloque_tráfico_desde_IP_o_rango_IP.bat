@echo off
setlocal enabledelayedexpansion

echo Ingresa la dirección IP o el rango de IPs (ejemplo: 192.168.1.100 o 192.168.1.0/24):
set /p "IP_ADDRESS="
echo Selecciona la acción:
echo 1. Permitir tráfico desde esta IP/rango
echo 2. Bloquear tráfico desde esta IP/rango
set /p "ACTION=Elige una opción (1 o 2): "
echo Selecciona la dirección:
echo 1. Entrada
echo 2. Salida
set /p "DIRECTION=Elige una opción (1 o 2): "

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
    netsh advfirewall firewall add rule name="Permitir IP %IP_ADDRESS%" dir=%DIR% remoteip=%IP_ADDRESS% action=allow
    if %errorlevel% equ 0 (
        echo Tráfico desde la IP/rango %IP_ADDRESS% ha sido permitido en dirección %DIR%.
    ) else (
        echo Error al permitir el tráfico desde %IP_ADDRESS% en dirección %DIR%.
    )
) else if "%ACTION%"=="2" (
    netsh advfirewall firewall add rule name="Bloquear IP %IP_ADDRESS%" dir=%DIR% remoteip=%IP_ADDRESS% action=block
    if %errorlevel% equ 0 (
        echo Tráfico desde la IP/rango %IP_ADDRESS% ha sido bloqueado en dirección %DIR%.
    ) else (
        echo Error al bloquear el tráfico desde %IP_ADDRESS% en dirección %DIR%.
    )
) else (
    echo Opción de acción no válida. Usa "1" para permitir o "2" para bloquear.
)

pause
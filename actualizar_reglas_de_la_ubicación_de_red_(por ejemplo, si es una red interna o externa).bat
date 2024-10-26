@echo off
setlocal enabledelayedexpansion

echo Ingresa el número de puerto o servicio que deseas modificar:
set /p "PORT="
echo Selecciona la acción:
echo 1. Permitir acceso desde la red interna (ejemplo: 192.168.1.0/24)
echo 2. Bloquear acceso desde la red externa (ejemplo: 0.0.0.0/0)
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
    set "REMOTE_IP=192.168.1.0/24"
    netsh advfirewall firewall add rule name="Permitir %PORT% desde red interna" protocol=TCP dir=%DIR% localport=%PORT% remoteip=%REMOTE_IP% action=allow
    if %errorlevel% equ 0 (
        echo El puerto %PORT% ha sido permitido desde la red interna %REMOTE_IP%.
    ) else (
        echo Error al permitir el puerto %PORT% desde la red interna %REMOTE_IP%.
    )
) else if "%ACTION%"=="2" (
    set "REMOTE_IP=0.0.0.0/0"
    netsh advfirewall firewall add rule name="Bloquear %PORT% desde red externa" protocol=TCP dir=%DIR% localport=%PORT% remoteip=%REMOTE_IP% action=block
    if %errorlevel% equ 0 (
        echo El puerto %PORT% ha sido bloqueado para acceso externo %REMOTE_IP%.
    ) else (
        echo Error al bloquear el puerto %PORT% para acceso externo %REMOTE_IP%.
    )
) else (
    echo Opción de acción no válida. Usa "1" para permitir o "2" para bloquear.
)

pause
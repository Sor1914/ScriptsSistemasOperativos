@echo off
setlocal enabledelayedexpansion

set /p "PORT=Ingresa el número del puerto: "
echo Selecciona la acción:
echo 1. Apertura de puerto
echo 2. Bloqueo de puerto
set /p "ACTION=Elige una opción (1 o 2): "
echo Selecciona el perfil de red:
echo 1. Público
echo 2. Privado
echo 3. Dominio
set /p "PROFILE=Elige un perfil de red (1, 2 o 3): "

if "%PROFILE%"=="1" (
    set "NET_PROFILE=public"
) else if "%PROFILE%"=="2" (
    set "NET_PROFILE=private"
) else if "%PROFILE%"=="3" (
    set "NET_PROFILE=domain"
) else (
    echo Opción de perfil de red no válida.
    pause
    exit /b 1
)

if "%ACTION%"=="1" (
    netsh advfirewall firewall add rule name="Abrir Puerto %PORT% en %NET_PROFILE%" protocol=TCP dir=in localport=%PORT% action=allow profile=%NET_PROFILE%
    if %errorlevel% equ 0 (
        echo El puerto %PORT% ha sido abierto exitosamente para el perfil de red %NET_PROFILE%.
    ) else (
        echo Error al abrir el puerto %PORT% para el perfil de red %NET_PROFILE%.
    )
) else if "%ACTION%"=="2" (
    netsh advfirewall firewall add rule name="Bloquear Puerto %PORT% en %NET_PROFILE%" protocol=TCP dir=in localport=%PORT% action=block profile=%NET_PROFILE%
    if %errorlevel% equ 0 (
        echo El puerto %PORT% ha sido bloqueado exitosamente para el perfil de red %NET_PROFILE%.
    ) else (
        echo Error al bloquear el puerto %PORT% para el perfil de red %NET_PROFILE%.
    )
) else (
    echo Opción de acción no válida. Usa "1" para abrir o "2" para bloquear.
)

pause
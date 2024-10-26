@echo off
setlocal enabledelayedexpansion

echo Selecciona el servicio:
echo 1. Habilitar/Deshabilitar RDP (puerto 3389)
echo 2. Habilitar/Deshabilitar SMB (puerto 445)
set /p "SERVICE=Elige un servicio (1 o 2): "
echo Selecciona la acción:
echo 1. Habilitar servicio
echo 2. Bloquear servicio
set /p "ACTION=Elige una acción (1 o 2): "

if "%SERVICE%"=="1" (
    set "PORT=3389"
    set "SERVICE_NAME=RDP"
) else if "%SERVICE%"=="2" (
    set "PORT=445"
    set "SERVICE_NAME=SMB"
) else (
    echo Opción de servicio no válida.
    pause
    exit /b 1
)

if "%ACTION%"=="1" (
    netsh advfirewall firewall add rule name="Habilitar %SERVICE_NAME%" protocol=TCP dir=in localport=%PORT% action=allow
    if %errorlevel% equ 0 (
        echo El servicio %SERVICE_NAME% ha sido habilitado exitosamente.
    ) else (
        echo Error al habilitar el servicio %SERVICE_NAME%.
    )
) else if "%ACTION%"=="2" (
    netsh advfirewall firewall add rule name="Bloquear %SERVICE_NAME%" protocol=TCP dir=in localport=%PORT% action=block
    if %errorlevel% equ 0 (
        echo El servicio %SERVICE_NAME% ha sido bloqueado exitosamente.
    ) else (
        echo Error al bloquear el servicio %SERVICE_NAME%.
    )
) else (
    echo Opción de acción no válida. Usa "1" para habilitar o "2" para bloquear.
)

pause
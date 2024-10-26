@echo off
setlocal enabledelayedexpansion

echo Ingresa la ruta completa del programa (ejemplo: C:\Program Files\App\App.exe):
set /p "PROGRAM_PATH="
echo Selecciona la acción:
echo 1. Permitir el programa
echo 2. Bloquear el programa
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
    netsh advfirewall firewall add rule name="Permitir Programa %PROGRAM_PATH%" dir=%DIR% program="%PROGRAM_PATH%" action=allow
    if %errorlevel% equ 0 (
        echo El programa %PROGRAM_PATH% ha sido permitido en dirección %DIR%.
    ) else (
        echo Error al permitir el programa %PROGRAM_PATH% en dirección %DIR%.
    )
) else if "%ACTION%"=="2" (
    netsh advfirewall firewall add rule name="Bloquear Programa %PROGRAM_PATH%" dir=%DIR% program="%PROGRAM_PATH%" action=block
    if %errorlevel% equ 0 (
        echo El programa %PROGRAM_PATH% ha sido bloqueado en dirección %DIR%.
    ) else (
        echo Error al bloquear el programa %PROGRAM_PATH% en dirección %DIR%.
    )
) else (
    echo Opción de acción no válida. Usa "1" para permitir o "2" para bloquear.
)

pause
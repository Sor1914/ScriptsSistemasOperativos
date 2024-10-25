@echo off
set /p "RULE_NAME=Ingresa el nombre de la regla de firewall: "
echo Selecciona la acción:
echo 1. Habilitar
echo 2. Deshabilitar
set /p "ACTION=Elige una opción (1 o 2): "

if "%ACTION%"=="1" (
    netsh advfirewall firewall set rule name="%RULE_NAME%" new enable=yes
    if %errorlevel% equ 0 (
        echo La regla %RULE_NAME% ha sido habilitada correctamente.
    ) else (
        echo Error al habilitar la regla %RULE_NAME%.
    )
) else if "%ACTION%"=="2" (
    netsh advfirewall firewall set rule name="%RULE_NAME%" new enable=no
    if %errorlevel% equ 0 (
        echo La regla %RULE_NAME% ha sido deshabilitada correctamente.
    ) else (
        echo Error al deshabilitar la regla %RULE_NAME%.
    )
) else (
    echo Opción no válida. Usa "1" para habilitar o "2" para deshabilitar.
)

pause

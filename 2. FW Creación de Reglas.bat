@echo off
echo == Script para Crear Reglas de Firewall ==
echo.

:tipo_regla
echo Seleccione el tipo de regla:
echo [1] Entrada
echo [2] Salida
set /p tipo_regla="Ingrese su selección (1 o 2): "

if "%tipo_regla%"=="1" (
    set directionType=in
) else if "%tipo_regla%"=="2" (
    set directionType=out
) else (
    echo Selección inválida. Por favor, ingrese 1 o 2.
    goto tipo_regla
)

:tipo_accion
echo Seleccione la acción de la regla:
echo [1] Permitir
echo [2] Bloquear
set /p tipo_accion="Ingrese su selección (1 o 2): "

if "%tipo_accion%"=="1" (
    set actionType=allow
) else if "%tipo_accion%"=="2" (
    set actionType=block
) else (
    echo Selección inválida. Por favor, ingrese 1 o 2.
    goto tipo_accion
)

set /p ruleName="Ingrese el nombre para la regla de firewall: "
set /p ipAddress="Ingrese la dirección IP a aplicar en la regla: "

echo Configurando la regla de firewall...
netsh advfirewall firewall add rule name="%ruleName%" ^
    dir=%directionType% ^
    action=%actionType% ^
    remoteip=%ipAddress% ^
    protocol=any ^
    profile=any

echo La regla de firewall ha sido creada con éxito.
pause

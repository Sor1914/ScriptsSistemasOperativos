@echo off
echo == Script para Modificar IP de una Regla de Firewall ==
echo.

set /p ruleName="Ingrese el nombre de la regla que desea modificar: "

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

set /p newIpAddress="Ingrese la nueva dirección IP para la regla: "

echo Modificando la regla de firewall...
netsh advfirewall firewall set rule name="%ruleName%" ^
    dir=%directionType% ^
    new remoteip=%newIpAddress%

echo La IP de la regla de firewall ha sido modificada con éxito.
pause

@echo off
setlocal enabledelayedexpansion

set "ODOO_PATH=C:\Program Files\Odoo 17.0.20240822"
set "ODOO_BIN=%ODOO_PATH%\python\python.exe"
set "ODOO_SCRIPT=%ODOO_PATH%\server\odoo-bin"
set "DB_NAME=Odoo"
set "LOG_FILE=C:\OdooBackups\logs\update_module_%date:~10,4%-%date:~7,2%-%date:~4,2%.log"
set "SUCCESSFUL_MODULES="
set "FAILED_MODULES="

if not exist "C:\OdooBackups\logs" mkdir "C:\OdooBackups\logs"

set /p "MODULE=Por favor, ingresa el nombre del módulo a actualizar (ej. sale_management para Ventas): "

echo Actualizando el módulo %MODULE%...
"%ODOO_BIN%" "%ODOO_SCRIPT%" -d %DB_NAME% -u %MODULE% --stop-after-init --logfile="%LOG_FILE%" --db-filter=^%DB_NAME%$

if %errorlevel% neq 0 (
    echo El módulo %MODULE% ha generado un error durante la actualización.
    set "FAILED_MODULES=%MODULE%"
) else (
    echo El módulo %MODULE% se ha actualizado correctamente.
    set "SUCCESSFUL_MODULES=%MODULE%"
)

echo.
echo Actualización completa.
echo Módulo actualizado correctamente:
echo !SUCCESSFUL_MODULES!
echo.
echo Módulo que generó errores:
echo !FAILED_MODULES!

pause


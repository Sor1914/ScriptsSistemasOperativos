@echo off
REM Definir la ruta de la carpeta de respaldo
set BACKUP_DIR=C:\Program Files\Backup Firewall

REM Crear la carpeta si no existe
if not exist "%BACKUP_DIR%" (
    mkdir "%BACKUP_DIR%"
    echo Carpeta creada: %BACKUP_DIR%
) else (
    echo Carpeta ya existe: %BACKUP_DIR%
)

REM Definir la ruta para el archivo de respaldo y el archivo de registro
set BACKUP_FILE=%BACKUP_DIR%\firewall_backup.wfw
set LOG_FILE=%BACKUP_DIR%\backup_log.txt

REM Hacer backup de la configuración del firewall
echo Haciendo backup de la configuración del firewall...
netsh advfirewall export "%BACKUP_FILE%" > "%LOG_FILE%" 2>&1

REM Comprobar si la copia de seguridad fue exitosa
if %errorlevel% equ 0 (
    echo Backup completado exitosamente. >> "%LOG_FILE%"
) else (
    echo Ha ocurrido un error al hacer el backup. >> "%LOG_FILE%"
)

pause
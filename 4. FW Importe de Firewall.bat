@echo off
set BACKUP_DIR=C:\Program Files\Backup Firewall
set BACKUP_FILE=%BACKUP_DIR%\firewall_backup.wfw
set LOG_FILE=%BACKUP_DIR%\import_log.txt

if not exist "%BACKUP_FILE%" (
    echo No se encontró el archivo de respaldo en %BACKUP_FILE%.
    echo No se encontró el archivo de respaldo en %BACKUP_FILE%. >> "%LOG_FILE%"
    pause
    exit /b 1
)

echo Importando la configuración del firewall desde %BACKUP_FILE%...
netsh advfirewall import "%BACKUP_FILE%" > "%LOG_FILE%" 2>&1

if %errorlevel% equ 0 (
    echo Importación completada exitosamente. >> "%LOG_FILE%"
    echo Importación completada exitosamente.
) else (
    echo Ha ocurrido un error al importar la configuración del firewall. >> "%LOG_FILE%"
    echo Ha ocurrido un error al importar la configuración del firewall.
)

pause

@echo off
setlocal enabledelayedexpansion

:: Configuración de Variables
set "PG_DUMP_PATH=C:\Program Files\Odoo 17.0.20240822\PostgreSQL\bin\pg_dump.exe"
set "BACKUP_DIR=C:\OdooBackups\central"
set "DB_USER=openpg"
set "DB_PASSWORD=openpgpwd"
set "DB_NAME=Odoo"
set "DATE=%date:~10,4%-%date:~7,2%-%date:~4,2%"

:: Crear el directorio de backup si no existe
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

:: Realizar el backup
echo Haciendo backup de la base de datos %DB_NAME%...
set "BACKUP_FILE=%BACKUP_DIR%\%DB_NAME%_backup_%DATE%.backup"
"%PG_DUMP_PATH%" -U %DB_USER% -d %DB_NAME% -F c -f "%BACKUP_FILE%"
echo Backup completado en: %BACKUP_FILE%

pause

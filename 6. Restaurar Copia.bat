@echo off
setlocal enabledelayedexpansion
set "ODOO_PATH=C:\Program Files\Odoo 17.0.20240822"
set "PG_RESTORE_PATH=%ODOO_PATH%\PostgreSQL\bin\pg_restore.exe"
set "DB_NAME=Odoo"
set "DB_USER=openpg"
set "DB_PASSWORD=openpgpwd"
set "DB_HOST=localhost"
set "DB_PORT=5432"
set "BACKUP_DIR=C:\OdooBackups\central"

set /p "BACKUP_NAME=Por favor, ingresa el nombre del archivo de respaldo (sin la ruta completa, por ejemplo: Odoo_data_backup_2024-10-22.backup): "
set "BACKUP_FILE=%BACKUP_DIR%\%BACKUP_NAME%"

if not exist "%BACKUP_FILE%" (
    echo El archivo de respaldo %BACKUP_FILE% no existe.
    pause
    exit /b 1
)

set PGPASSWORD=%DB_PASSWORD%

echo Se va a restaurar el archivo de respaldo %BACKUP_FILE% en la base de datos %DB_NAME%.
set /p "CONFIRM=¿Deseas continuar? (S/N): "

if /I not "%CONFIRM%"=="S" (
    echo Restauración cancelada.
    pause
    exit /b 0
)

echo Iniciando la restauración...
pause

echo Restaurando la base de datos %DB_NAME% desde el archivo %BACKUP_FILE%...
"%PG_RESTORE_PATH%" -U %DB_USER% -h %DB_HOST% -p %DB_PORT% -d %DB_NAME% --clean --if-exists --no-owner "%BACKUP_FILE%"

if %errorlevel% neq 0 (
    echo Error al restaurar la base de datos desde el archivo %BACKUP_FILE%.
    pause
    exit /b 1
) else (
    echo Restauración completada exitosamente.
    pause
)

@echo off
setlocal enabledelayedexpansion
set "PG_DUMP_PATH=C:\Program Files\Odoo 17.0.20240822\PostgreSQL\bin\pg_dump.exe"
set "BACKUP_DIR=C:\OdooBackups\central"
set "DB_USER=openpg"
set "DB_PASSWORD=openpgpwd"
set "DB_NAME=Odoo"
set "PGHOST=localhost"
set "PGPORT=5432"
set "DATE=%date:~10,4%-%date:~7,2%-%date:~4,2%"
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"
echo Haciendo backup de la base de datos %DB_NAME%...
set "BACKUP_FILE=%BACKUP_DIR%\%DB_NAME%_backup_%DATE%.backup"
"%PG_DUMP_PATH%" -U %DB_USER% -h %PGHOST% -p %PGPORT% -d %DB_NAME% -F c -f "%BACKUP_FILE%" -t sale_order -t sale_order_line -t sale_report -t product_product -t product_template -t res_partner -t account_invoice -t account_move -t account_move_line -t stock_picking -t stock_move -t stock_quant
if %errorlevel% neq 0 (
    echo Error durante el backup. Revisa el archivo de log: C:\backups\backup_error.log
) else (
    echo Backup completado exitosamente en: %BACKUP_FILE%
)

pause
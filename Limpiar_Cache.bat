@echo off
REM Limpiar la caché de Odoo

REM Cambiar al directorio de instalación de Odoo
cd "C:\Program Files\Odoo 17.0.20241006\server"

REM Activar el entorno virtual si es necesario
call venv\Scripts\activate

REM Eliminar caché de Odoo
del /s /q "C:\Program Files\Odoo 17.0.20241006\server\*.pyc" 2>nul
rd /s /q "C:\Program Files\Odoo 17.0.20241006\server\_pycache_" 2>nul

REM Limpiar caché de módulos
rd /s /q "C:\Program Files\Odoo 17.0.20241006\server\addons\." 2>nul

REM Mensaje de éxito
echo Caché de Odoo limpiada con éxito.

pause
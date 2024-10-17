@echo off
REM Iniciar el servicio Odoo
net start odoo-server-17.0

REM Verificar el estado del servicio
sc query odoo-server-17.0

pause
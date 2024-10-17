@echo off
REM Detener el servicio Odoo
net stop odoo-server-17.0

REM Verificar el estado del servicio
sc query odoo-server-17.0

pause
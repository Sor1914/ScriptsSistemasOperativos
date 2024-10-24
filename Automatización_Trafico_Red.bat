@echo off

echo Creando reglas de firewall...

:: Permitir tráfico en el puerto 80 (HTTP)
netsh advfirewall firewall add rule name="Permitir HTTP" protocol=TCP dir=in localport=80 action=allow

:: Bloquear tráfico en el puerto 21 (FTP)
netsh advfirewall firewall add rule name="Bloquear FTP" protocol=TCP dir=in localport=21 action=block

:: Permitir tráfico en el puerto 443 (HTTPS)
netsh advfirewall firewall add rule name="Permitir HTTPS" protocol=TCP dir=in localport=443 action=allow

echo Reglas de firewall creadas con éxito.

pause
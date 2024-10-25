@echo off
:: Script para agregar nuevas reglas de firewall

echo Configurando reglas del firewall...

:: Permitir conexiones en el puerto 22 (SSH)
netsh advfirewall firewall add rule name="Permitir SSH" protocol=TCP dir=in localport=22 action=allow

:: Bloquear conexiones entrantes en el puerto 3389 (Escritorio Remoto)
netsh advfirewall firewall add rule name="Bloquear Escritorio Remoto" protocol=TCP dir=in localport=3389 action=block

:: Permitir tráfico saliente para el puerto 53 (DNS)
netsh advfirewall firewall add rule name="Permitir DNS" protocol=UDP dir=out localport=53 action=allow

:: Denegar tráfico entrante para cualquier puerto desde una IP específica
netsh advfirewall firewall add rule name="Bloquear IP Maliciosa" dir=in action=block remoteip=192.168.1.100

:: Permitir todo el tráfico en el puerto 443 (HTTPS) solo desde una IP específica
netsh advfirewall firewall add rule name="Permitir HTTPS desde IP" protocol=TCP dir=in localport=443 remoteip=192.168.1.101 action=allow

echo Reglas de firewall aplicadas correctamente.

pause

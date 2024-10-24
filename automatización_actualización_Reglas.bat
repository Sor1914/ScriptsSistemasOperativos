@echo off

echo Iniciando actualización de reglas de firewall...

:: Verificar si la máquina está conectada a una red específica (por ejemplo, por IP)
ping -n 1 192.168.1.1 >nul
if %errorlevel%==0 (
    echo Conectado a la red interna.
    
    :: Si está conectado a la red interna, permitir acceso en el puerto 445 (compartición de archivos)
    netsh advfirewall firewall add rule name="Permitir SMB en red interna" protocol=TCP dir=in localport=445 action=allow
) else (
    echo No conectado a la red interna.
    
    :: Si no está conectado a la red interna, bloquear acceso en el puerto 445
    netsh advfirewall firewall delete rule name="Permitir SMB en red interna"
    netsh advfirewall firewall add rule name="Bloquear SMB fuera de red interna" protocol=TCP dir=in localport=445 action=block
)

:: Verificar si la dirección IP del equipo está dentro de un rango específico (para conexiones externas seguras)
for /f "tokens=3 delims=: " %%i in ('ipconfig ^| find "IPv4"') do set myip=%%i

echo Detectando IP actual: %myip%

:: Si la IP es una IP local (192.168.x.x), permitir tráfico HTTPS
if "%myip:~0,7%"=="192.168" (
    echo IP local detectada. Permitiendo tráfico HTTPS...
    netsh advfirewall firewall add rule name="Permitir HTTPS local" protocol=TCP dir=in localport=443 action=allow
) else (
    echo IP externa detectada. Restricción HTTPS...
    netsh advfirewall firewall add rule name="Restringir HTTPS externo" protocol=TCP dir=in localport=443 action=block
)

:: Actualizar reglas de acuerdo a políticas de seguridad basadas en una condición horaria (por ejemplo, restringir tráfico en horas no laborables)
for /f "tokens=1-4 delims=: " %%a in ("%time%") do (
    if %%a lss 08 (
        echo Fuera del horario laboral, bloqueando puertos no esenciales...
        netsh advfirewall firewall add rule name="Bloquear tráfico no esencial fuera de horario" protocol=TCP dir=in localport=8080 action=block
    ) else if %%a geq 18 (
        echo Fuera del horario laboral, bloqueando puertos no esenciales...
        netsh advfirewall firewall add rule name="Bloquear tráfico no esencial fuera de horario" protocol=TCP dir=in localport=8080 action=block
    ) else (
        echo En horario laboral, permitiendo acceso.
        netsh advfirewall firewall delete rule name="Bloquear tráfico no esencial fuera de horario"
    )
)

echo Reglas de firewall actualizadas correctamente.

pause

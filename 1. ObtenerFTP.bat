@echo off
:: Variables
set ftp_server=192.168.1.16
set ftp_directory=/
set local_directory=C:\Odoo

set /p ftp_username=Ingresa Usuario:
set /p ftp_password=Ingresa Contrasenia:

:: Cambiar a la carpeta local
cd %local_directory%

:: Crear un archivo temporal con los comandos FTP
echo open %ftp_server%> ftp_commands.txt
echo %ftp_username%>> ftp_commands.txt
echo %ftp_password%>> ftp_commands.txt
echo binary>> ftp_commands.txt
echo cd %ftp_directory%>> ftp_commands.txt
echo mget *>> ftp_commands.txt
echo y>> ftp_commands.txt
echo bye>> ftp_commands.txt
notepad ftp_commands.txt
:: Ejecutar el cliente FTP usando el archivo de comandos
ftp -s:ftp_commands.txt

echo Descarga completada
pause
:: Eliminar el archivo temporal
del ftp_commands.txt


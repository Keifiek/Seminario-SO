@echo off
echo Creando archivo mytext.txt

echo Hola Mundo > mytext.txt
echo Contenido Agregado

echo Mostrando contenido de mytext.txt:
type mytext.txt

echo.
echo Creando backup
mkdir backup

copy mytext.txt backup\

echo Contenido del subdirectorio backup:
dir backup

echo Eliminando archivo y subdirectorio backup
del backup\mytext.txt
rmdir backup

pause

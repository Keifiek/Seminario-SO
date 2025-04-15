@echo off
setlocal enabledelayedexpansion

if "%~7"=="" (
    echo Uso: crear_vm.bat NOMBRE_VM TIPO_SO NUM_CPUS RAM_GB VRAM_MB TAM_DISCO_GB NOMBRE_CONTROLADOR_SATA NOMBRE_CONTROLADOR_IDE
    exit /b 1
)

set "VM_NAME=%~1"
set "OS_TYPE=%~2"
set "NUM_CPUS=%~3"
set "RAM_GB=%~4"
set "VRAM_MB=%~5"
set "DISK_GB=%~6"
set "SATA_CONTROLLER=%~7"
set "IDE_CONTROLLER=%~8"

set /a RAM_MB=%RAM_GB% * 1024
set "DISK_PATH=%cd%\%VM_NAME%_disk.vdi"

echo ==============================
echo Creando VM: %VM_NAME%
echo Tipo de SO: %OS_TYPE%
echo CPUs: %NUM_CPUS%
echo RAM: %RAM_MB% MB
echo VRAM: %VRAM_MB% MB
echo Disco: %DISK_PATH% (%DISK_GB% GB)
echo SATA: %SATA_CONTROLLER%
echo IDE: %IDE_CONTROLLER%
echo ==============================

VBoxManage createvm --name "%VM_NAME%" --ostype "%OS_TYPE%" --register

VBoxManage modifyvm "%VM_NAME%" --cpus %NUM_CPUS% --memory %RAM_MB% --vram %VRAM_MB%

VBoxManage createmedium disk --filename "%DISK_PATH%" --size %DISK_GB%000 --format VDI

VBoxManage storagectl "%VM_NAME%" --name "%SATA_CONTROLLER%" --add sata --controller IntelAHCI
VBoxManage storageattach "%VM_NAME%" --storagectl "%SATA_CONTROLLER%" --port 0 --device 0 --type hdd --medium "%DISK_PATH%"

VBoxManage storagectl "%VM_NAME%" --name "%IDE_CONTROLLER%" --add ide --controller PIIX4

echo.
echo Configuracion final de la VM:
VBoxManage showvminfo "%VM_NAME%"
@echo off

rem Download ImDisk Toolkit files for Sandboxie installer

set "imdisk_url=https://github.com/sandboxie-plus/Sandboxie/releases/download/v1.17.2/imdisk_files.cab"
set "imdisk_bat_url=https://github.com/sandboxie-plus/Sandboxie/releases/download/v1.17.2/imdisk_install.bat"

echo Downloading ImDisk files...

curl -L -o "%~dp0imdisk_files.cab" "%imdisk_url%" 2>nul
if errorlevel 1 (
    echo Warning: Failed to download imdisk_files.cab
    echo Creating empty placeholder file...
    type nul > "%~dp0imdisk_files.cab"
)

curl -L -o "%~dp0imdisk_install.bat" "%imdisk_bat_url%" 2>nul
if errorlevel 1 (
    echo Warning: Failed to download imdisk_install.bat
    echo Creating empty placeholder file...
    type nul > "%~dp0imdisk_install.bat"
)

echo ImDisk files download completed.

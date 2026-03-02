@echo off
if exist %~dp0\7-Zip\7z.exe (
    echo 7-Zip already exists, skipping download
    goto done
)

echo Downloading 7-Zip...
mkdir %~dp0\7-Zip
curl -L --url https://github.com/DavidXanatos/7z/releases/download/23.01/7z2301.zip -o %~dp0\7-Zip\7z2301.zip --ssl-no-revoke
"C:\Program Files\7-Zip\7z.exe" x -aoa -bd -o%~dp0\7-Zip\ %~dp0\7-Zip\7z2301.zip

:done

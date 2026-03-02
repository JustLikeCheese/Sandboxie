@echo off
if exist %~dp0..\..\Qt\Tools\QtCreator\bin\jom.exe (
    echo Jom already exists, skipping download
    goto done
)

echo Downloading Jom...
curl -LsSO --output-dir %~dp0..\..\ https://download.qt.io/official_releases/jom/jom_1_1_4.zip
"C:\Program Files\7-Zip\7z.exe" x -aoa -o%~dp0..\..\Qt\Tools\QtCreator\bin\ %~dp0..\..\jom_1_1_4.zip

:done

REM dir %~dp0..\..\
REM dir %~dp0..\..\Qt
REM dir %~dp0..\..\Qt\Tools

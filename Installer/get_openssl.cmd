@echo off
call "%~dp0..\Installer\buildVariables.cmd" %*

REM Check if OpenSSL already exists
if exist %~dp0\OpenSSL\x64\bin\libcrypto-3-x64.dll (
    echo OpenSSL already exists, skipping download
    goto done
)

REM echo %*
REM IF "%~3" == "" ( set "ghSsl_repo=openssl-builds" ) ELSE ( set "ghSsl_repo=%~3" )
REM IF "%~2" == "" ( set "ghSsl_user=xanasoft" ) ELSE ( set "ghSsl_user=%~2" )
REM IF "%~1" == "" ( set "openssl_version=3.4.0" ) ELSE ( set "openssl_version=%~1" )

echo Downloading OpenSSL...
set "openssl_version_underscore=%openssl_version:.=_%"

mkdir %~dp0\OpenSSL

rem https://github.com/<repo>/openssl/releases/download/OpenSSL_1_1_1p/OpenSSL-1_1_1p.zip
rem https://github.com/<repo>/openssl/releases/download/openssl-3.3.0/openssl-3.3.0.zip
curl -L -f --url https://github.com/%ghSsl_user%/%ghSsl_repo%/releases/download/OpenSSL_%openssl_version_underscore%/OpenSSL-%openssl_version_underscore%.zip -o %~dp0\OpenSSL\OpenSSL-%openssl_version%.zip --ssl-no-revoke
IF %ERRORLEVEL% EQU 0 goto extract
curl -L -f --url https://github.com/%ghSsl_user%/%ghSsl_repo%/releases/download/openssl-%openssl_version%/openssl-%openssl_version%.zip -o %~dp0\OpenSSL\OpenSSL-%openssl_version%.zip --ssl-no-revoke
IF %ERRORLEVEL% EQU 0 goto extract

:urlfallback
setlocal enabledelayedexpansion
set "opensslFolders=openssl- openssl_ OpenSSL- OpenSSL_"
set "opensslFiles=openssl- openssl_ OpenSSL- OpenSSL_"
set "opensslVersions=%openssl_version% %openssl_version_underscore%"
for %%i in (%opensslFolders%) do (
 	echo 1=%%i
	for %%j in (%opensslFiles%) do (
		echo 2=%%j
		for %%k in (%opensslVersions%) do (
 			echo 3=%%k
			for %%l in (%opensslVersions%) do (
				echo 4=%%l
				timeout 2 >nul
				curl -L -f --url https://github.com/%ghSsl_user%/%ghSsl_repo%/releases/download/%%i%%k/%%j%%l.zip -o %~dp0\OpenSSL\OpenSSL-%openssl_version%.zip --ssl-no-revoke
				IF !ERRORLEVEL! EQU 0 goto extract
			)
		)
	)
)
echo No valid URL found.
if %ERRORLEVEL% NEQ 0 exit /b 404
endlocal

:extract
"C:\Program Files\7-Zip\7z.exe" x -aoa -bd -o%~dp0\OpenSSL\ %~dp0\OpenSSL\OpenSSL-%openssl_version%.zip

:done


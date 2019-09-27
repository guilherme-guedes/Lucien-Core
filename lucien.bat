@echo off

set lucy=%cd%"\Form.ps1"

echo.
echo inicializando lucien...
wmic process get executablepath | find /i %lucy%
set result=%ERRORLEVEL%
if "%result%"=="1" powershell -windowstyle hidden Start-Process powershell -windowstyle hidden %lucy% -verb RunAs
if "%result%"=="0" echo lucien ja esta em execucao

#timeout /t 5
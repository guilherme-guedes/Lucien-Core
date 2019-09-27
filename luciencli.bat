@echo off

set lucy="C:\DevUtils\_Programas\Lucien\Main.ps1"
set argumento=%*
shift

echo.
echo inicializando lucien...
wmic process get executablepath | find /i %lucy%
set result=%ERRORLEVEL%
echo %argumento%
if "%result%"=="1" powershell -windowstyle hidden -File "%lucy%" "%argumento%"
rem -File "%lucy%" "%argumento%"
if "%result%"=="0" echo lucien ja esta em execucao
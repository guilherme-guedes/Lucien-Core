@echo off

set lucien="C:\DevUtils\_Programas\Lucien\Main.ps1"
set argumento=%*
shift

echo.
echo inicializando lucien...
wmic process get executablepath | find /i %lucien%
set result=%ERRORLEVEL%
echo %argumento%
if "%result%"=="1" powershell -windowstyle hidden -File "%lucien%" "%argumento%"
rem -File "%lucien%" "%argumento%"
if "%result%"=="0" echo lucien ja esta em execucao
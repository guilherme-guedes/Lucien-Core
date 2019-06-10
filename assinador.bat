@echo off

set signer="C:\DevUtils\_Programas\Lucien\Assinador.ps1"

echo.
echo assinando arquivos
wmic process get executablepath | find /i %signer%
set result=%ERRORLEVEL%
if "%result%"=="1" powershell -windowstyle hidden %signer% 
if "%result%"=="0" echo assinador ja esta em execucao

#timeout /t 5
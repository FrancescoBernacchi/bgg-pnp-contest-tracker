@echo off
setlocal
title PnP Collection
cd /d "%~dp0.."

set "PNP_PYTHON="
if exist "%USERPROFILE%\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe" set "PNP_PYTHON=%USERPROFILE%\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe"

if not defined PNP_PYTHON (
    for /f "delims=" %%P in ('where python.exe 2^>nul') do if not defined PNP_PYTHON set "PNP_PYTHON=%%P"
)

if not defined PNP_PYTHON (
    echo Python non e stato trovato.
    echo Consulta app\README.md per le istruzioni di avvio.
    pause
    exit /b 1
)

echo Avvio di PnP Collection...
"%PNP_PYTHON%" app\server.py --open-browser

if errorlevel 1 (
    echo.
    echo L'applicazione non e stata avviata. Controlla il messaggio qui sopra.
    pause
)

@echo off
chcp 65001 >nul
title SETUP - N8N Book Translator (FLAT MODE)
color 0B
setlocal enabledelayedexpansion

:: --- 1. TU DONG XIN QUYEN ADMIN ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Chuong trinh can quyen Admin.
    echo [i] Dang khoi dong lai voi quyen Admin...
    :: Dung /k de giu cua so neu co loi
    set "batchPath=%~f0"
    set "batchDir=%~dp0"
    powershell -Command "Start-Process -FilePath '%batchPath%' -WorkingDirectory '%batchDir%' -Verb RunAs"
    exit
)

:: --- 2. THIET LAP MOI TRUONG ---
cd /d "%~dp0"

echo ========================================================
echo   CAI DAT MOI TRUONG - N8N BOOK TRANSLATOR
echo   Author: d-init-d (Flat Structure - Stable)
echo ========================================================
echo.
echo [i] Dang chay voi quyen Administrator.
echo.

:: ========================================================
:: BUOC 1: KIEM TRA NODE.JS
:: ========================================================
echo [1/5] Kiem tra Node.js...
where node >nul 2>nul
if %errorlevel% equ 0 goto :NODE_OK

echo    [!] May tinh chua co Node.js.
set /p "choice=   > Ban co muon cai dat Node.js ngay khong? (y/n): "
if /i not "!choice!"=="y" goto :NODE_SKIP

echo       Dang cai dat Node.js qua Winget...
winget install OpenJS.NodeJS -e --silent --accept-package-agreements --accept-source-agreements

if %errorlevel% neq 0 (
    color 0C
    echo       [LOI] Cai dat Node.js that bai. Hay cai thu cong tai nodejs.org
    pause
    exit
)
echo       [OK] Da cai xong Node.js.
echo.
echo       ========================================================
echo       YEU CAU KHOI DONG LAI
echo       ========================================================
echo       Do vua cai Node.js, ban BAT BUOC phai tat cua so nay
echo       va chay lai file setup de Windows nhan dien lenh 'npm'.
echo       ========================================================
pause
exit

:NODE_SKIP
echo       [!] Da bo qua Node.js.
goto :STEP_2

:NODE_OK
echo    [OK] Node.js da san sang.

:: ========================================================
:: BUOC 2: KIEM TRA PANDOC
:: ========================================================
:STEP_2
echo.
echo [2/5] Kiem tra Pandoc...
where pandoc >nul 2>nul
if %errorlevel% equ 0 goto :PANDOC_OK

echo    [!] May tinh chua co Pandoc.
set /p "choice=   > Ban co muon cai dat Pandoc khong? (y/n): "
if /i not "!choice!"=="y" goto :PANDOC_SKIP

echo       Dang cai dat Pandoc...
winget install JohnMacFarlane.Pandoc -e --silent --accept-package-agreements --accept-source-agreements
echo       [OK] Da cai xong Pandoc.
goto :STEP_3

:PANDOC_SKIP
echo       [!] Da bo qua Pandoc.
goto :STEP_3

:PANDOC_OK
echo    [OK] Pandoc da san sang.

:: ========================================================
:: BUOC 3: KIEM TRA OLLAMA
:: ========================================================
:STEP_3
echo.
echo [3/5] Kiem tra Ollama...
where ollama >nul 2>nul
if %errorlevel% equ 0 goto :OLLAMA_OK

echo    [!] May tinh chua co Ollama.
set /p "choice=   > Ban co muon cai dat Ollama khong? (y/n): "
if /i not "!choice!"=="y" goto :OLLAMA_SKIP

echo       Dang cai dat Ollama...
winget install Ollama.Ollama -e --silent --accept-package-agreements --accept-source-agreements
echo       [OK] Da cai xong Ollama.
goto :STEP_4

:OLLAMA_SKIP
echo       [!] Da bo qua Ollama.
goto :STEP_4

:OLLAMA_OK
echo    [OK] Ollama da san sang.

:: ========================================================
:: BUOC 4: KIEM TRA N8N
:: ========================================================
:STEP_4
echo.
echo [4/5] Kiem tra n8n...

:: Kiem tra npm truoc xem co ton tai khong
where npm >nul 2>nul
if %errorlevel% neq 0 goto :NPM_MISSING

:: Neu co npm, kiem tra n8n
where n8n >nul 2>nul
if %errorlevel% equ 0 goto :N8N_OK

echo    [!] May tinh chua co n8n.
set /p "choice=   > Ban co muon cai dat n8n khong? (y/n): "
if /i not "!choice!"=="y" goto :N8N_SKIP

echo       Dang cai dat n8n (Server)...
call npm install -g n8n
echo       [OK] Da cai xong n8n.
goto :STEP_5

:NPM_MISSING
echo    [LOI] Khong tim thay lenh 'npm'.
echo    Nguyen nhan: Ban chua cai Node.js hoac chua khoi dong lai sau khi cai.
echo    Giai phap: Cai dat Node.js o Buoc 1 roi chay lai tool.
goto :STEP_5

:N8N_SKIP
echo       [!] Da bo qua n8n.
goto :STEP_5

:N8N_OK
echo    [OK] n8n da san sang.

:: ========================================================
:: BUOC 5: TAI MODEL AI
:: ========================================================
:STEP_5
echo.
echo [5/5] Tai Model AI (qwen3:14b)...
where ollama >nul 2>nul
if %errorlevel% neq 0 goto :MODEL_NO_OLLAMA

echo    [i] Kiem tra model AI...
ollama list | findstr "qwen3:14b" >nul
if %errorlevel% equ 0 goto :MODEL_OK

echo    [!] Chua tim thay model "qwen3:14b".
echo        Model nay nang khoang 9GB.
set /p "choice=   > Ban co muon tai ve ngay bay gio khong? (y/n): "
if /i not "!choice!"=="y" goto :MODEL_SKIP

echo       Dang tai model (Vui long khong tat mang)...
:: Start serve ngam neu can
start /b ollama serve >nul 2>nul
timeout /t 5 >nul
call ollama pull qwen3:14b
echo       [OK] Da tai xong model.
goto :FINISH

:MODEL_NO_OLLAMA
echo    [!] Khong tim thay Ollama de tai model.
goto :FINISH

:MODEL_SKIP
echo    [!] Da bo qua tai model.
goto :FINISH

:MODEL_OK
echo    [OK] Model qwen3:14b da co san.

:: ========================================================
:: THONG BAO HOAN TAT
:: ========================================================
:FINISH
color 0A
echo.
echo ========================================================
echo   DA SETUP XONG! (SUCCESS)
echo ========================================================
echo.
echo   [OK] Tat ca cac buoc da hoan thanh.
echo   [OK] Ban co the tat cua so nay ngay bay gio.
echo.
echo   Nhan phim bat ky de thoat...
pause >nul
exit
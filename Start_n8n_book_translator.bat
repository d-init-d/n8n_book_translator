@echo off
chcp 65001 >nul
title Launcher - N8N Book Translator (d-init-d)
:: Mau chu TRANG nen DEN (07)
color 07

echo ========================================================
echo   N8N BOOK TRANSLATOR - LAUNCHER
echo   Author: d-init-d
echo ========================================================
echo.

:: --- 1. KIEM TRA FILE CAU HINH ---
if exist "settings.ini" (
    echo [i] Phat hien cau hinh cu. Dang tai cai dat...
    < settings.ini (
        set /p INPUT=
        set /p OUTPUT=
    )
    goto :CHECK_PATH
)

:: --- 2. CHON THU MUC (CHI CHAY KHI CHUA CO CAU HINH) ---
:SELECT_FOLDER
echo [+] Chuan bi thu muc lam viec (Thiet lap lan dau)...

:: Chon Input
echo     - Vui long chon thu muc INPUT (Chua file sach)...
echo       (Cua so chon thu muc dang hien ra...)
set "PS_CMD=Add-Type -AssemblyName System.Windows.Forms; $f = New-Object System.Windows.Forms.FolderBrowserDialog; $f.Description = 'CHON THU MUC CHUA SACH GOC (INPUT)'; $f.ShowNewFolderButton = $true; if($f.ShowDialog() -eq 'OK'){Write-Host $f.SelectedPath}"
for /f "usebackq delims=" %%I in (`powershell -NoProfile -Command "%PS_CMD%"`) do set "INPUT=%%I"

:: Neu huy chon -> Dung mac dinh
if "%INPUT%"=="" set "INPUT=%~dp0Input"

:: Chon Output
echo     - Vui long chon thu muc OUTPUT (Luu ket qua)...
set "PS_CMD=Add-Type -AssemblyName System.Windows.Forms; $f = New-Object System.Windows.Forms.FolderBrowserDialog; $f.Description = 'CHON THU MUC LUU KET QUA (OUTPUT)'; $f.ShowNewFolderButton = $true; if($f.ShowDialog() -eq 'OK'){Write-Host $f.SelectedPath}"
for /f "usebackq delims=" %%I in (`powershell -NoProfile -Command "%PS_CMD%"`) do set "OUTPUT=%%I"

:: Neu huy chon -> Dung mac dinh
if "%OUTPUT%"=="" set "OUTPUT=%~dp0Output"

:: Tao thu muc neu chua co
if not exist "%INPUT%" mkdir "%INPUT%"
if not exist "%OUTPUT%" mkdir "%OUTPUT%"

:: --- 3. LUU CAU HINH ---
echo %INPUT%> settings.ini
echo %OUTPUT%>> settings.ini
echo [OK] Da luu cai dat. Lan sau se khong hoi lai nua.
echo.

:CHECK_PATH
echo     [>] INPUT:  %INPUT%
echo     [>] OUTPUT: %OUTPUT%
echo.

:: --- 4. THIET LAP MOI TRUONG ---
echo [+] Thiet lap cau hinh he thong...
echo     (Luu y: Cac thiet lap duoi day chi co tac dung trong cua so nay,)
echo     (hoan toan KHONG anh huong den cai dat goc cua may tinh ban.)

set N8N_HTTP_REQUEST_TIMEOUT=28800
set EXECUTIONS_TIMEOUT=-1
set OLLAMA_KEEP_ALIVE=-1
set OLLAMA_NUM_PARALLEL=1
echo     - Cau hinh Timeout & AI: OK

:: --- 5. KIEM TRA VA BAT OLLAMA ---
echo [+] Dang kiem tra ket noi AI (Ollama)...
tasklist /FI "IMAGENAME eq ollama_app.exe" 2>NUL | find /I /N "ollama_app.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo     - Ollama App dang chay.
) else (
    tasklist /FI "IMAGENAME eq ollama.exe" 2>NUL | find /I /N "ollama.exe">NUL
    if "%ERRORLEVEL%"=="0" (
        echo     - Ollama Service dang chay.
    ) else (
        echo     - Dang khoi dong Ollama...
        if exist "C:\Users\%USERNAME%\AppData\Local\Programs\Ollama\Ollama.exe" (
            start "" "C:\Users\%USERNAME%\AppData\Local\Programs\Ollama\Ollama.exe"
        ) else (
            start "" ollama serve
        )
        timeout /t 5 >nul
    )
)

echo.
echo ========================================================
echo   QUAN TRONG: KHONG DUOC TAT CUA SO NAY!
echo   (Ban chi duoc thu nho no xuong Taskbar)
echo   ------------------------------------------------
echo   De thay doi thu muc Input/Output:
echo   Hay chay file "Reset-Settings.bat"
echo ========================================================
echo.

where n8n >nul 2>nul
if %errorlevel% neq 0 (
    echo [LOI] Chua cai n8n. Vui long chay file Setup truoc.
    pause
    exit
)

:: Lenh nay se treo cua so o day mai mai de n8n chay
n8n start

pause
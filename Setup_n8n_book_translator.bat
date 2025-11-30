@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title SETUP - N8N Book Translator (Interactive)
color 0B

echo ========================================================
echo   CAI DAT MOI TRUONG - N8N BOOK TRANSLATOR
echo   Author: d-init-d
echo ========================================================
echo.
echo [i] Chuong trinh se kiem tra va HOI Y KIEN ban truoc khi cai dat.
echo.

:: --- 1. KIEM TRA NODE.JS ---
echo [1/5] Kiem tra Node.js...
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo    [!] May tinh chua co Node.js (Bat buoc de chay n8n).
    set /p "choice=   > Ban co muon cai dat Node.js ngay khong? (y/n): "
    if /i "!choice!"=="y" (
        echo       Dang cai dat Node.js qua Winget...
        winget install OpenJS.NodeJS -e --silent --accept-package-agreements --accept-source-agreements
        if !errorlevel! neq 0 (
            color 0C
            echo       [LOI] Cai dat that bai. Vui long cai thu cong tai nodejs.org
            pause
            exit
        )
        echo       [OK] Da cai xong Node.js.
        echo       (!) Luu y: Can khoi dong lai CMD sau khi tool chay xong de nhan dien.
    ) else (
        echo       [!] Da bo qua Node.js. (Luu y: Tool co the khong chay duoc).
    )
) else (
    echo    [OK] Node.js da san sang.
)

:: --- 2. KIEM TRA PANDOC ---
echo.
echo [2/5] Kiem tra Pandoc...
where pandoc >nul 2>nul
if %errorlevel% neq 0 (
    echo    [!] May tinh chua co Pandoc (Can de doc file Word/Epub).
    set /p "choice=   > Ban co muon cai dat Pandoc khong? (y/n): "
    if /i "!choice!"=="y" (
        echo       Dang cai dat Pandoc...
        winget install JohnMacFarlane.Pandoc -e --silent --accept-package-agreements --accept-source-agreements
        echo       [OK] Da cai xong Pandoc.
    ) else (
        echo       [!] Da bo qua Pandoc. Chi co the dich file .txt.
    )
) else (
    echo    [OK] Pandoc da san sang.
)

:: --- 3. KIEM TRA OLLAMA ---
echo.
echo [3/5] Kiem tra Ollama...
where ollama >nul 2>nul
if %errorlevel% neq 0 (
    echo    [!] May tinh chua co Ollama (Can de chay AI).
    set /p "choice=   > Ban co muon cai dat Ollama khong? (y/n): "
    if /i "!choice!"=="y" (
        echo       Dang cai dat Ollama...
        winget install Ollama.Ollama -e --silent --accept-package-agreements --accept-source-agreements
        echo       [OK] Da cai xong Ollama.
    ) else (
        echo       [!] Da bo qua Ollama. Ban can cai thu cong tai ollama.com.
    )
) else (
    echo    [OK] Ollama da san sang.
)

:: --- 4. KIEM TRA N8N ---
echo.
echo [4/5] Kiem tra n8n...
where n8n >nul 2>nul
if %errorlevel% neq 0 (
    echo    [!] May tinh chua co n8n.
    set /p "choice=   > Ban co muon cai dat n8n khong? (y/n): "
    if /i "!choice!"=="y" (
        echo       Dang cai dat n8n (Server)...
        call npm install -g n8n
        echo       [OK] Da cai xong n8n.
    ) else (
        echo       [!] Da bo qua n8n.
    )
) else (
    echo    [OK] n8n da san sang.
)

:: --- 5. TAI MODEL AI ---
echo.
echo [5/5] Tai Model AI (qwen3:14b)...
echo    [i] Kiem tra model AI...
:: Kiem tra xem model da co chua (check so sai)
ollama list | findstr "qwen3:14b" >nul
if %errorlevel% neq 0 (
    echo    [!] Chua tim thay model "qwen3:14b".
    echo        Model nay nang khoang 9GB.
    set /p "choice=   > Ban co muon tai ve ngay bay gio khong? (y/n): "
    if /i "!choice!"=="y" (
        echo       Dang tai model (Vui long khong tat mang)...
        call ollama pull qwen3:14b
        echo       [OK] Da tai xong model.
    ) else (
        echo       [!] Da bo qua tai model.
    )
) else (
    echo    [OK] Model qwen3:14b da co san.
)

echo.
echo ========================================================
echo   CAI DAT HOAN TAT!
echo   Bam phim bat ky de thoat...
echo ========================================================
pause >nul
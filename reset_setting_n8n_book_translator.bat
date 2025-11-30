@echo off
chcp 65001 >nul
title Reset Settings - N8N Book Translator (d-init-d)
color 07

echo ========================================================
echo   KHOI PHUC CAI DAT GOC (RESET)
echo   N8N BOOK TRANSLATOR
echo ========================================================
echo.

echo [+] Dang kiem tra file cau hinh cu...

if exist "settings.ini" (
    del "settings.ini"
    echo.
    echo [OK] Da xoa file cau hinh cu (settings.ini).
    echo.
    echo ------------------------------------------------
    echo Lan toi ban chay file "Start-Translator.bat",
    echo chuong trinh se hoi lai thu muc Input va Output moi.
    echo ------------------------------------------------
) else (
    echo.
    echo [!] Khong tim thay file cau hinh nao.
    echo (Ban chua tung chay tool hoac da xoa no roi).
)

echo.
pause
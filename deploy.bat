@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo [1/4] Sync latest game and art from the parent folder...
copy /y "..\chuqi-leitai.html" "index.html" >nul
if exist "..\chuqi-bg" robocopy "..\chuqi-bg" "chuqi-bg" /e /njh /njs /ndl /nfl /np >nul
if exist "..\chuqi-art" robocopy "..\chuqi-art" "chuqi-art" /e /njh /njs /ndl /nfl /np >nul

echo [2/4] Prepare git repo...
if not exist ".git" (
  git init -b main
  git remote add origin https://github.com/qooqqoor/HittingTheVillain.git
)

echo [3/4] Commit...
git add -A
git commit -m "Update game and art"

echo [4/4] Push to GitHub (main + gh-pages)...
git push -u origin main
if errorlevel 1 goto :fail
git push origin main:gh-pages --force
if errorlevel 1 goto :fail

echo.
echo Done. Site: https://qooqqoor.github.io/HittingTheVillain/
echo (first deploy takes 1-2 minutes)
pause
exit /b 0

:fail
echo.
echo Push failed. Read the git message above.
pause
exit /b 1

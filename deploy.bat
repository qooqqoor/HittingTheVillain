@echo off
chcp 65001 >nul
cd /d "%~dp0"

set "OLD=E:\CODEX\discord-gpt-bot\discord-gpt-bot\activity\design\nightcity-scratch\nightcity-scratch-claude-20261002\Claude outputs"
if exist "%OLD%\chuqi-art" (
  echo [0/3] Picking up art still being generated in the old folder...
  robocopy "%OLD%\chuqi-bg" "chuqi-bg" /e /xo /njh /njs /ndl /nfl /np >nul
  robocopy "%OLD%\chuqi-art" "chuqi-art" /e /xo /njh /njs /ndl /nfl /np >nul
)

echo [1/3] Prepare git repo...
if not exist ".git" (
  git init -b main
  git remote add origin https://github.com/qooqqoor/HittingTheVillain.git
)

echo [2/3] Commit...
git add -A
git commit -m "Update game and art"

echo [3/3] Push to GitHub (main + gh-pages)...
git push -u origin main
if errorlevel 1 goto :fail
git push origin main:gh-pages --force
if errorlevel 1 goto :fail

echo.
echo Done. Site: https://qooqqoor.github.io/HittingTheVillain/
echo (deploy takes 1-2 minutes)
pause
exit /b 0

:fail
echo.
echo Push failed. Read the git message above.
pause
exit /b 1

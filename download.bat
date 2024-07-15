@echo off

git --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Git is not installed. Installing Git...
    echo Downloading Git installer...
    powershell -Command "Start-BitsTransfer -Source https://github.com/git-for-windows/git/releases/download/v2.41.0.windows.1/MinGit-2.41.0-busybox-64-bit.zip -Destination %TEMP%\git.zip"
    echo Installing Git...
    powershell -Command "Expand-Archive -Path %TEMP%\git.zip -DestinationPath C:\MinGit"
    setx PATH "C:\MinGit\cmd;%PATH%"
    echo Git installed successfully.
) else (
    echo Git is already installed.
)

if not exist "C:\LuaLibraries" mkdir "C:\LuaLibraries"

cd /d C:\LuaLibraries

echo Cloning LuaSocket repository...
git clone https://github.com/diegonehab/luasocket.git

echo Cloning lua-cjson repository...
git clone https://github.com/mpx/lua-cjson.git

echo All libraries downloaded successfully.

pause

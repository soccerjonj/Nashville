@echo off
cd /d "%~dp0"

REM Copy data files to cities\data\BNA
set "TARGET=%~dp0..\..\cities\data\BNA"
echo [Nashville Mod] Copying data files to cities\data\BNA...
if not exist "%TARGET%" mkdir "%TARGET%"
xcopy /E /Y "%~dp0data\BNA\*" "%TARGET%\" >nul
echo [Nashville Mod] Data files copied successfully.

REM Check pmtiles exe
if not exist "pmtiles.exe" (
    echo [Nashville Mod] 'pmtiles.exe' not found. Checking for download tools...

    REM Check curl 
    where curl >nul 2>nul
    if %errorlevel% neq 0 (
        echo [Nashville Mod] Error: 'curl' tool not found.
        echo Please manually download pmtiles.exe from:
        echo https://github.com/protomaps/go-pmtiles/releases
        pause
        exit /b 1
    )

    echo [Nashville Mod] Downloading pmtiles.exe...
    curl -L -o pmtiles.zip "https://github.com/protomaps/go-pmtiles/releases/download/v1.30.0/go-pmtiles_1.30.0_Windows_x86_64.zip"

    REM Check tar
    where tar >nul 2>nul
    if %errorlevel% neq 0 (
        echo [Nashville Mod] Error: 'tar' extraction tool not found.
        echo Please manually extract pmtiles.zip.
        pause
        exit /b 1
    )

    echo [Nashville Mod] Extracting pmtiles.exe...
    tar -xf pmtiles.zip pmtiles.exe
    
    REM Clean up zip
    if exist "pmtiles.zip" del "pmtiles.zip"

    REM Verify extraction
    if not exist "pmtiles.exe" (
        echo [Nashville Mod] Error: Extraction failed or pmtiles.exe not found.
        pause
        exit /b 1
    )
    
    echo [Nashville Mod] pmtiles.exe installed successfully.
)

REM Start tile server
echo [Nashville Mod] Starting tile server on port 8080...
pmtiles.exe serve . --port 8080 --cors=*
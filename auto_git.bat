@echo off
setlocal

:: Default values
set "COMMIT_MSG=Auto-sync: %DATE% %TIME%"
set "FORCE_PUSH=false"

:parse_args
if "%~1"=="" goto step1

:: Case: -m (Custom Message)
if /i "%~1"=="-m" (
    if "%~2"=="" (
        echo Error: Option -m requires an argument.
        goto usage
    )
    set "COMMIT_MSG=%~2"
    shift
    shift
    goto parse_args
)

:: Case: -f (Force Push)
if /i "%~1"=="-f" (
    set "FORCE_PUSH=true"
    shift
    goto parse_args
)

:: Case: -h (Help)
if /i "%~1"=="-h" (
    goto usage
)

:: Invalid Option
echo Error: Invalid option %~1
goto usage

::Helper: Usage
:usage
echo.
echo Usage: %~nx0 [-m "commit_message"] [-f] [-h]
echo   -m  : Specify a custom commit message
echo   -f  : Force push (use with caution!)
echo   -h  : Show this help message
echo.
pause
exit /b 1


:step1
echo ==========================================
echo        STEP 1: PULL FROM REMOTE
echo ==========================================
echo.

git pull

:: Check exit code
if %errorlevel% neq 0 (
    echo.
    echo {ERROR}: Pull failed. Please resolve conflicts manually.
    pause
    exit /b 1
)

echo.
echo ==========================================
echo        STEP 2: PUSH TO REMOTE
echo ==========================================
echo.

:: Check for changes
:: We use a "for" loop to see if git status returns any lines
set "CHANGES_DETECTED="
for /f "delims=" %%i in ('git status --porcelain') do set CHANGES_DETECTED=1

if defined CHANGES_DETECTED (
    echo [STATUS] Changes detected. Processing...

    echo [ACTION] Adding files...
    git add .

    echo [ACTION] Committing...
    git commit -m "%COMMIT_MSG%"

    if %errorlevel% neq 0 (
        echo {ERROR}: Commit failed. Please check the error message above.
        pause
        exit /b 1
    )

    echo.
    echo [ACTION] Pushing to GitHub...

    if "%FORCE_PUSH%"=="true" (
        echo [WARN] Force push enabled!
        git push origin main --force
    ) else (
        git push origin main
    )

    echo [SUCCESS] Local changes pushed to remote.

) else (
    echo [STATUS] No local changes found.
    echo [RESULT] Nothing to commit or push.
)

echo.
echo ==========================================
echo             SYNC FINISHED
echo ==========================================
pause
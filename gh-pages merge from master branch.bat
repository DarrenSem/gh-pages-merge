@echo off

CLS

SET "CD_OLD=%CD%"

echo.
echo +++ gh-pages merge from master branch

IF "%~1"=="" (
  echo.
  echo.Folder with git repo MUST be provided as 1st arg!
  goto aborted
)

echo.
echo.Launched from path:

echo.
echo.%CD_OLD%

rem Navigate to directory provided as argument
echo.
echo.cd "%~1"
cd "%~1"

IF ERRORLEVEL 1 (
  goto aborted
)

echo.
echo.Switched to path:

echo.
echo.%CD%

rem Ensure Git commands are accessible from cmd
rem set PATH=%PATH%;C:/Program Files/Git/cmd

rem Fetch all branches and commit information from remote repository
echo.
echo.git fetch origin
git fetch origin

IF ERRORLEVEL 1 (
  goto aborted
)

rem Display current branches and highlight the current branch
echo.
echo.git branch
git branch

echo.
echo +++ LAST CHANCE TO ABORT!

echo.
echo.Press CTRL+C to exit now, or any other key to proceed . . .
pause>NUL

rem Switch to gh-pages branch
echo.
echo.git checkout gh-pages
git checkout gh-pages

IF ERRORLEVEL 1 (
  goto aborted
)

rem Merge changes from the master branch
echo.
echo.git merge master
git merge master

IF ERRORLEVEL 1 (
  goto aborted
)

rem Push merged changes to remote repository
echo.
echo.git push origin gh-pages
git push origin gh-pages

IF ERRORLEVEL 1 (
  goto aborted
)

rem Switch back to master
echo.
echo.git checkout master
git checkout master

IF ERRORLEVEL 1 (
  goto aborted
)

echo.
echo.DONE. Press any key to exit . . .
goto pausequit



:aborted
  echo.
  echo.ABORTED. Press any key to exit . . .



:pausequit
  cd "%CD_OLD%"
  pause>NUL
  exit /b

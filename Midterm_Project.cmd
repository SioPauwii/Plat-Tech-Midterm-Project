@echo off
cls
:Menu 
echo.
echo.
echo *********************************************
echo *                                           *
echo *                                           *
echo *          Welcome to the Menu              *
echo *                                           *
echo *                                           *
echo *********************************************
echo.
echo.
echo 1. Calculator
echo 2. File Sorter
echo 3. File Mover
echo 4. File/Folder Renamer
echo 5. Text File Creator
echo 6. PC Shutdown/Restart Timer
echo 7. Exit
echo.

set /p pick=Enter your choice: 

if "%pick%"=="1" goto case1
if "%pick%"=="2" goto case2
if "%pick%"=="3" goto case3
if "%pick%"=="4" goto case4
if "%pick%"=="5" goto case5
if "%pick%"=="6" goto case6
if "%pick%"=="7" goto case7
goto default

::calculator
:case1
cls
echo *********************************************
echo *              Calculator                   *
echo *********************************************
set /p int1=Enter your first number: 
set /p int2=Enter your second number: 
set /a num1=%int1%
set /a num2=%int2%
echo.

:operations
echo Select operation:
echo 1. Addition
echo 2. Subtraction
echo 3. Multiplication
echo 4. Division
echo.

set /p opChoice=Enter your choice: 

if "%opChoice%"=="1" goto  add
if "%opChoice%"=="2" goto  sub
if "%opChoice%"=="3" goto  mul
if "%opChoice%"=="4" goto  div
goto invalid_op_choice

:add
set /a sum=%num1%+%num2%
echo The sum is %sum%
goto afterOp

:sub
set /a diff=%num1%-%num2%
echo The difference is %diff%
goto afterOp

:mul
set /a prod=%num1%*%num2%
echo The product is %prod%
goto afterOp

:div
if "%num2%"=="0" (
    echo Division by zero is not allowed.
    goto operations
) else (
    set /a quo=%num1%/%num2%
    call echo The quotient is %%quo%%
)
goto afterOp

:invalid_op_choice
echo Invalid choice. Please choose a valid operation.
goto operations

:afterOp
echo.

echo 1. Use calculator again
echo 2. Use different operation
echo 3. Return to menu
echo.

set /p afterPick=Enter your choice: 

if "%afterPick%"=="1" goto case1
if "%afterPick%"=="2" goto operations
if "%afterPick%"=="3" goto Menu
goto invalid_afterPick

:invalid_afterPick
echo Invalid choice. Please choose a valid option.
goto afterOp

::file sorter
:case2
cls
echo *******************************************
echo *               File Sorter                 *
echo *******************************************
echo.

:: confirmation before proceeding
set /p choice=This will sort your files to a Folder, do you want to proceed (type yes or no)? 

if /I "%choice%"=="yes" (
    goto set_directory
) else if /I "%choice%"=="no" (
    echo Going back to the Menu...
    timeout /t 2 >nul
    goto Menu
) else (
    echo Invalid choice. Please type "yes" or "no".
    pause
    goto case2
)

:set_directory
:: Ask the user to input the source directory
set /p source_dir=Please enter the source directory path (e.g., C:\Users\new_user\Desktop): 

if not exist "%source_dir%" (
    echo Source directory does not exist. Please check the path and try again.
    pause
    goto set_directory
)

set "target_dir=%source_dir%\Sorted"

if not exist "%target_dir%" (
    mkdir "%target_dir%"
)

setlocal enabledelayedexpansion

::iterating through all files
for %%a in ("%source_dir%\*.*") do (
    set "ext=%%~xa"
    set "name=%%~na"

    if not "!ext!"=="" if /I "!name!" NEQ "Midterm_Project" (
        set "ext=!ext:~1!"

        if not exist "%target_dir%\!ext!\" (
            mkdir "%target_dir%\!ext!"
        )

        ::sorts or moves files to their respecting
        move "%%a" "%target_dir%\!ext!\" >nul
        echo Moved: %%a to %target_dir%\!ext!\
    )
)

echo.
echo Sorting complete.
pause
goto Menu


::file mover
:case3
cls
echo *********************************************
echo *               File Mover                  *
echo *********************************************
echo.

:directories
:: Get source directory
echo (Directory where the files are collected)
echo Example: C:\User\Desktop\...
set /p sourceDir=Enter your source directory: 


:: Check directory existence
if not exist "%sourceDir%" (
    echo Directory doesn't exist. Please try again.
    goto directories
)

echo.
:: Set target directory
set /p targetDir=Enter your target directory:
echo Example: C:\User\Desktop\...

:: Check directory existence
if not exist "%targetDir%" (
    mkdir "%targetDir%"
    echo Directory created: %targetDir%
)

setlocal enabledelayedexpansion

:: Move files from source dir to target dir
for %%f in ("%sourceDir%\*.*") do (
    move "%%f" "%targetDir%" >nul
    echo Moved: %%f
)

echo.
echo Files moved successfully.
pause
goto Menu

::File or Folder Renamer
:case4
cls
echo *********************************************
echo *            File/Folder Renamer            *
echo *********************************************
echo.

echo Set the folder directory (e.g. C:\User\Desktop\...).
set /p renameDir=directory: 

if not exist "%renameDir%" (
    echo The directory set does not exist. Please check and try again.
    pause
    goto case4
)

echo.
echo Choose what to rename:
echo 1. File
echo 2. Folder

set /p renameChoice=Type:

if "%renameChoice%"=="1" goto renameFile
if "%renameChoice%"=="2" goto renameFolder
goto invalid_choice

:renameFile
cls
echo File Renamer
echo.

set /p oldNameFile=Enter the file name to rename (with extension):
set /p newNameFile=Enter the new file name (with extension):

if exist "%renameDir%\%oldNameFile%" (
    ren "%renameDir%\%oldNameFile%" "%newNameFile%"
    echo File renamed successfully from %oldNameFile% to %newNameFile%.
) else (
    echo File %oldNameFile% does not exist in the directory.
)

echo.
pause
goto Menu

:renameFolder
cls
echo Folder Renamer
echo.

set /p oldNameFolder=Enter the folder name to rename:
set /p newNameFolder=Enter the new folder name:

if exist "%renameDir%\%oldNameFolder%" (
    ren "%renameDir%\%oldNameFolder%" "%newNameFolder%"
    echo Folder renamed successfully from %oldNameFolder% to %newNameFolder%.
) else (
    echo Folder %oldNameFolder% does not exist in the directory.
)

echo.
pause
goto Menu

:invalid_choice
echo Invalid choice. Please try again.
pause
goto Menu

::file creator
:case5
::file name, dir kung san masesave, content if ever(w/ or w/o content)
cls
echo *********************************************
echo *              File Creator                 *
echo *********************************************
echo.
echo Set the directory where the text (.txt) will be saved
set  /p saveDir=Directory: 

if not exist "%saveDir%" (
    echo The directory set does not exist. Please check and try again.
    pause
    goto case5
)

echo.
echo Set the filename:
set /p filename=
set fullFileName=%filename%.txt
echo %fullFileName%

:fileState
echo.
echo Is this file empty or not?
echo 1. Yes (Empty file)
echo 2. No (Write content)

set /p fileStat=Enter your pick:

if "%fileStat%"=="1" goto blankFile
if "%fileStat%"=="2" goto notBlankFile
goto case5_default

:blankFile
type nul > "%saveDir%\%fullFileName%"
echo Text file created successfully
pause
goto Menu

:notBlankFile
echo Enter text for the file (Press CTRL+Z then Enter to save and exit):
copy con "%saveDir%\%fullFileName%.txt"

echo Text file created with content at "%saveDir%\%fullFileName%"
pause
goto Menu

:case5_default
echo Invalid choice. Please try again.
goto fileState

::PC shutdown or restart
:case6
echo *********************************************
echo *        PC Shutdown/Restart Timer          *
echo *********************************************
echo.
echo 1. Shutdown
echo 2. Restart
echo 3. Return to menu
set /p action=Choose your action:


if "%action%"=="1" goto shutdownFunc
if "%action%"=="2" goto restartFunc
if  "%action%"=="3" goto Menu

goto case6_default

:shutdownFunc
echo.
echo Enter the time, in seconds, before Shutdown:
set /p shutdownTime=Second/s:

for /L %%x in (0,1,300) do if "%shutdownTime%"=="%%x" goto mainShutdown

echo Invalid input. Please enter a valid number.
pause
goto shutdownFunc

:mainShutdown
shutdown -s -t %shutdownTime%

echo Your devicce will shutdown in %shutdownTime% second/s.
echo To cancel, enter 'shutdown -a' in another command prompt window.
pause
goto Menu

:restartFunc
echo.
echo Enter the time, in seconds, before Shutdown:
set /p restartTime=Second/s:

for /L %%x in (0,1,300) do if "%restartTime%"=="%%x" goto mainRestart

echo Invalid input. Please enter a valid number.
pause
goto restartFunc

:mainRestart
shutdown -r -t %restartTime%

echo Your devicce will restart in %restartTime% second/s.
echo To cancel, enter 'shutdown -a' in another command prompt window.
pause
goto Menu

:case6_default
echo Invalid choice. Please try again.
goto case6

:case7
exit

:default
echo Invalid choice. Please try again.
goto Menu
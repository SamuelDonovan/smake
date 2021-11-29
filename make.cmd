;: This is just a little something to get makefiles to work on windows

goto(){
# Linux code here
uname -o
echo This file is meant to be run by a windows machine. What are you doing here. Stop it.

}

goto $@
exit

:(){
echo off
cls

rem Windows script here
echo %OS%

rem where choco
rem IF %ERRORLEVEL% NEQ 0 ( goto install_package )

goto install_choco

:install_choco
	echo Performing one time setup to allow for use of makefiles
	powershell -nop -c "& {sleep 2}"

	rem Should be able to use powershell -command but this shell is still not happy with the syntax so I echo it to a file to be run 
	echo Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser; $env:chocolateyUseWindowsCompression='true'; $env:ChocolateyInstall="$home\choco"; iwr https://chocolatey.org/install.ps1 -UseBasicParsing ^| iex  ; $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") ; choco --version > choco_install.ps1
	powershell -ExecutionPolicy Bypass -File choco_install.ps1

	rem cleanup
	DEL choco_install.ps1

rem Refresh the environment variables to call choco 
rem Taken straight from chocos method to do so
::
:: RefreshEnv.cmd
::
:: Batch file to read environment variables from registry and
:: set session variables to these values.
::
:: With this batch file, there should be no need to reload command
:: environment every time you want environment changes to propagate

::echo "RefreshEnv.cmd only works from cmd.exe, please install the Chocolatey Profile to take advantage of refreshenv from PowerShell"
echo | set /p dummy="Refreshing environment variables from registry for cmd.exe. Please wait..."

goto main

:: Set one environment variable from registry key
:SetFromReg
    "%WinDir%\System32\Reg" QUERY "%~1" /v "%~2" > "%TEMP%\_envset.tmp" 2>NUL
    for /f "usebackq skip=2 tokens=2,*" %%A IN ("%TEMP%\_envset.tmp") do (
        echo/set "%~3=%%B"
    )
    goto :EOF

:: Get a list of environment variables from registry
:GetRegEnv
    "%WinDir%\System32\Reg" QUERY "%~1" > "%TEMP%\_envget.tmp"
    for /f "usebackq skip=2" %%A IN ("%TEMP%\_envget.tmp") do (
        if /I not "%%~A"=="Path" (
            call :SetFromReg "%~1" "%%~A" "%%~A"
        )
    )
    goto :EOF

:main
    echo/@echo off >"%TEMP%\_env.cmd"

    :: Slowly generating final file
    call :GetRegEnv "HKLM\System\CurrentControlSet\Control\Session Manager\Environment" >> "%TEMP%\_env.cmd"
    call :GetRegEnv "HKCU\Environment">>"%TEMP%\_env.cmd" >> "%TEMP%\_env.cmd"

    :: Special handling for PATH - mix both User and System
    call :SetFromReg "HKLM\System\CurrentControlSet\Control\Session Manager\Environment" Path Path_HKLM >> "%TEMP%\_env.cmd"
    call :SetFromReg "HKCU\Environment" Path Path_HKCU >> "%TEMP%\_env.cmd"

    :: Caution: do not insert space-chars before >> redirection sign
    echo/set "Path=%%Path_HKLM%%;%%Path_HKCU%%" >> "%TEMP%\_env.cmd"

    :: Cleanup
    del /f /q "%TEMP%\_envset.tmp" 2>nul
    del /f /q "%TEMP%\_envget.tmp" 2>nul

    :: capture user / architecture
    SET "OriginalUserName=%USERNAME%"
    SET "OriginalArchitecture=%PROCESSOR_ARCHITECTURE%"

    :: Set these variables
    call "%TEMP%\_env.cmd"

    :: Cleanup
    del /f /q "%TEMP%\_env.cmd" 2>nul

    :: reset user / architecture
    SET "USERNAME=%OriginalUserName%"
    SET "PROCESSOR_ARCHITECTURE=%OriginalArchitecture%"

    echo | set /p dummy="Finished."
    echo .

rem Install your packages
:install_package
	rem Install make, can be used to install other choco packages
	echo Y| choco install make 2> nul
	rem echo Y| choco install python3 2> nul

rem Once run move so we don't accidentally call this rather than make again

move make.cmd make_installer.cmd

exit
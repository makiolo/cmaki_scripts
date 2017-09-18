@echo off

setlocal enableextensions
set CMAKI_PWD=%CMAKI_PWD%

if "%Configuration%" == "Release" (
    set MODE=Release
) else (
    set MODE=Debug
)

if "%Platform%" == "x64" (
    set GENERATOR=Visual Studio 14 2015 Win64
) else (
    set GENERATOR=Visual Studio 14 2015
)

echo running in mode %MODE% ...
if exist %MODE% (rmdir /s /q %MODE%)
md %MODE%

:: setup
cd %MODE%
IF DEFINED Configuration OR DEFINED Platform (
    cmake .. -DCMAKE_BUILD_TYPE=%MODE% -G"%GENERATOR%"
) ELSE (
    cmake .. -DCMAKE_BUILD_TYPE=%MODE%
)

set lasterror=%errorlevel%
cd ..

if %lasterror% neq 0 exit /b %lasterror%

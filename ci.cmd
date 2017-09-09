@echo off

echo [0/3] preinstall
set PATH=%CMAKI_PWD%\node_modules\cmaki_scripts;%PATH%
env | sort

pip install pyyaml
if %errorlevel% neq 0 exit /b %errorlevel%

pip install poster
if %errorlevel% neq 0 exit /b %errorlevel%

if exist package.json (
  
  echo [1/3] prepare
  :: npm install -g npm-check-updates
  :: call ncu -u
  
  echo [2/3] compile
  npm install
  if %errorlevel% neq 0 exit /b %errorlevel%
  
  echo [3/3] run tests
  npm test
  if %errorlevel% neq 0 exit /b %errorlevel%

) else (

  echo [1/3] prepare
  if exist node_modules\cmaki_scripts (rmdir /s /q node_modules\cmaki_scripts)
  powershell -c "$source = 'https://raw.githubusercontent.com/makiolo/cmaki_scripts/master/bootstrap.cmd'; $dest = $env:TEMP + '\bootstrap.cmd'; $WebClient = New-Object System.Net.WebClient; $WebClient.DownloadFile($source,$dest); Invoke-Expression $dest"
  if %errorlevel% neq 0 exit /b %errorlevel%

  echo [2/3] compile
  call node_modules\cmaki_scripts\install.cmd
  if %errorlevel% neq 0 exit /b %errorlevel%

  echo [3/3] run tests
  call node_modules\cmaki_scripts\tests.cmd
  if %errorlevel% neq 0 exit /b %errorlevel%

)

if exist "cmaki.yml" (
  echo [4/3] upload artifact
  # IDEA: interesting autogenerate cmaki.yml from package.json
  echo TODO: generate artifact and upload with cmaki_generator
)

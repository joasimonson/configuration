## settings
Set-Executionpolicy -Scope CurrentUser -ExecutionPolicy UnRestricted
Set-ExecutionPolicy Bypass -Scope Process -Force
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

## windows settings
powercfg -h on
powercfg -x -monitor-timeout-ac 30
powercfg -x -monitor-timeout-dc 10
powercfg -x -disk-timeout-ac 0
powercfg -x -disk-timeout-dc 0
powercfg -x -standby-timeout-ac 0
powercfg -x -standby-timeout-dc 0
powercfg -x -hibernate-timeout-ac 0
powercfg -x -hibernate-timeout-dc 0

Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0

# winget source add --accept-source-agreements --name msstore https://storeedgefd.dsx.mp.microsoft.com/v9.0
winget source add --accept-source-agreements --name msstore https://winget.azureedge.net/msstore
winget source add --accept-source-agreements --name winget https://winget.azureedge.net/cache

winget uninstall cortana
winget uninstall --id Microsoft.OneDrive
winget uninstall --id Microsoft.OneDriveSync_8wekyb3d8bbwe
winget uninstall --id Microsoft.Messaging_8wekyb3d8bbwe
winget uninstall --id Microsoft.BingNews_8wekyb3d8bbwe
winget uninstall --id Microsoft.BingWeather_8wekyb3d8bbwe
winget uninstall --id Microsoft.GamingApp_8wekyb3d8bbwe
winget uninstall --id Microsoft.GetHelp_8wekyb3d8bbwe
winget uninstall --id Microsoft.Getstarted_8wekyb3d8bbwe
winget uninstall --id Microsoft.MicrosoftOfficeHub_8wekyb3d8bbwe
winget uninstall --id Microsoft.MicrosoftSolitaireCollection_8wekyb3d8bbwe
winget uninstall --id Microsoft.MicrosoftStickyNotes_8wekyb3d8bbwe
winget uninstall --id Microsoft.People_8wekyb3d8bbwe
winget uninstall --id Microsoft.PowerAutomateDesktop_8wekyb3d8bbwe
winget uninstall --id Microsoft.Todos_8wekyb3d8bbwe
winget uninstall --id Microsoft.WindowsAlarms_8wekyb3d8bbwe
winget uninstall --id Microsoft.WindowsFeedbackHub_8wekyb3d8bbwe
winget uninstall --id Microsoft.WindowsMaps_8wekyb3d8bbwe
winget uninstall --id Microsoft.WindowsNotepad_8wekyb3d8bbwe
winget uninstall --id Microsoft.Xbox.TCUI_8wekyb3d8bbwe
winget uninstall --id Microsoft.XboxIdentityProvider_8wekyb3d8bbwe
winget uninstall --id Microsoft.XboxSpeechToTextOverlay_8wekyb3d8bbwe
winget uninstall --id Microsoft.ZuneMusic_8wekyb3d8bbwe
winget uninstall --id Microsoft.ZuneVideo_8wekyb3d8bbwe
winget uninstall --id microsoft.windowscommunicationsapps_8wekyb3d8bbwe

del "$env:SystemRoot\notepad.exe"
del "$env:SystemRoot\System32\notepad.exe" # permissions needed

## chocolatey
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

## hardare
winget install -e --id Lenovo.SystemUpdate --silent
winget install -e --id Logitech.Options --silent

## terminal
mkdir -p c:\dev

winget install --id Microsoft.Powershell --silent

# run pwsh core
powershell -Command "Start-Process pwsh -Verb RunAs"

# completions
Install-Module DockerCompletion -Scope CurrentUser -Force

# posh
choco install cascadiacodepl -y

Install-Module posh-git -Scope CurrentUser -Force
Install-Module oh-my-posh -Scope CurrentUser -Force
Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck

# profiles
$windowsTerminalProfilePath = Resolve-Path -Path "$home\AppData\Local\Packages\Microsoft.WindowsTerminal*\LocalState"
curl -o $windowsTerminalProfilePath\settings.json https://raw.githubusercontent.com/joasimonson/configuration/main/terminal/settings.json

curl -o $PROFILE https://raw.githubusercontent.com/joasimonson/configuration/main/terminal/Microsoft.PowerShell_profile.ps1

$terminalConfigPath = "$home\.config\terminal"
mkdir -p $terminalConfigPath
curl -o $terminalConfigPath\pwsh.png https://raw.githubusercontent.com/joasimonson/configuration/main/terminal/pwsh.png
curl -o $terminalConfigPath\powershell.png https://raw.githubusercontent.com/joasimonson/configuration/main/terminal/powershell.png
curl -o $terminalConfigPath\ubuntu.png https://raw.githubusercontent.com/joasimonson/configuration/main/terminal/ubuntu.png
curl -o $terminalConfigPath\azure.png https://raw.githubusercontent.com/joasimonson/configuration/main/terminal/azure.png
curl -o $terminalConfigPath\cmd.png https://raw.githubusercontent.com/joasimonson/configuration/main/terminal/cmd.png

## node - npm
choco install nvm -y
nvm install lts
nvm use lts

npm i -g iisexpress-proxy
npm i -g rimraf

## git
winget install -e --id Git.Git --silent

$username = "joasimonson"
$email = "joasimonson@hotmail.com"
git config --global user.name $username
git config --global user.email $email

# git linux tools
$linuxTools = "$env:programfiles\Git\usr\bin"
[Environment]::SetEnvironmentVariable("Path", "$env:Path;$linuxTools", [System.EnvironmentVariableTarget]::Machine)

# git aliases
git config --global alias.rprune "remote prune origin"

# git gpg - assign commits
winget install -e --id GnuPG.GnuPG --silent

gpg --full-generate-key
gpg --list-secret-keys --keyid-format LONG $email
$secretKey = gpg --list-secret-keys --keyid-format LONG $email | grep sec | cut -c 15-30
# $secretKey = gpg --list-secret-keys --keyid-format LONG $email | grep -A1 sec | sed '1d' | xargs
gpg --armor --export $secretKey

git config --global user.signingkey $secretKey
git config --global gpg.program ($pathGpg + "\gpg.exe")
git config --global commit.gpgsign true

rv secretKey

# gitk dracula
$gitkConfigPath = "$home/.config/git"
mkdir -p $gitkConfigPath
curl -o $gitkConfigPath/gitk https://raw.githubusercontent.com/dracula/gitk/master/gitk

## notepad
winget install -e --id Notepad++.Notepad++ --silent

$notepad = "$env:programfiles\Notepad++"
[Environment]::SetEnvironmentVariable("Path", "$env:Path;$notepad", [System.EnvironmentVariableTarget]::Machine)

# set notepad++ to default
$scriptShell = New-Object -comObject WScript.Shell
$shortcut = $scriptShell.CreateShortcut("$env:SystemRoot\notepad.lnk")
$shortcut.TargetPath = "$notepad\notepad++.exe"
$shortcut.Save()
rv scriptShell
rv shortcut

# notepad++ dracula
curl -o $env:AppData\Notepad++\themes\Dracula.xml https://raw.githubusercontent.com/dracula/notepad-plus-plus/master/Dracula.xml
#(Manual) > Settings > Style Configurator

# zip
winget install 7zip.7zip --silent
$path7zip = "$env:programfiles\7-Zip"
[Environment]::SetEnvironmentVariable("Path", "$env:Path;$path7zip", [System.EnvironmentVariableTarget]::Machine)

# capitaine cursors
$mainPath = "$pwd"
$capitaineUrl = 'https://api.github.com/repos/keeferrourke/capitaine-cursors/contents/.windows?ref=master'
$capitainePath = "capitaine-cursors"
mkdir -p $capitainePath

curl $capitaineUrl | json | % { curl -o ($capitainePath + "\" + $_.name) $_.download_url }

cd $env:SystemRoot\System32
InfDefaultInstall ("$mainPath\$capitainePath\install.inf")

cd $mainPath
rimraf $capitainePath
#(Manual) > Mouse Properties > Aditional mouse settings > Pointers > Set "Capitaine Cursors"

## dev tools
winget install -e --id ScooterSoftware.BeyondCompare4 --silent
winget install --id Microsoft.VisualStudioCode --silent
winget install --id Microsoft.VisualStudio.2022.Professional --silent
winget install --id Microsoft.dotnet --silent

winget install -e --id Docker.DockerDesktop --silent
choco install dive -y

# optional
winget install -e --id Postman.Postman --silent
winget install -e --id icsharpcode.ILSpy --silent

## tools
winget install -e --id Foxit.FoxitReader --silent
winget install -e --id VideoLAN.VLC --silent

# optional
winget install -e --id WinDirStat.WinDirStat --silent
winget install -e --id CPUID.CPU-Z --silent
winget install -e --id qBittorrent.qBittorrent --silent

# work
winget install -e --id Microsoft.Teams --silent

## features

# telnet
Enable-WIndowsOptionalFeature -Online -FeatureName TelnetClient

## WSL configuration - https://docs.microsoft.com/en-US/windows/wsl/install-win10
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

wsl --install

sudo mkdir dev

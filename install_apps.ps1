## settings
Set-Executionpolicy -Scope CurrentUser -ExecutionPolicy UnRestricted
Set-ExecutionPolicy Bypass -Scope Process -Force
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

## chocolatey
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

## hardare
winget install -e --id Lenovo.SystemUpdate --accept-package-agreements --accept-source-agreements
winget install -e --id Logitech.Options --accept-package-agreements --accept-source-agreements

## terminal
mkdir -p c:\dev

winget install --id Microsoft.Powershell --accept-package-agreements --accept-source-agreements

# run pwsh core
powershell -Command "Start-Process pwsh -Verb RunAs"

# completions
Install-Module DockerCompletion -Scope CurrentUser -Force

# posh
choco install cascadiacodepl -y

Install-Module posh-git -Scope CurrentUser -Force
Install-Module oh-my-posh -Scope CurrentUser -Force
Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck # powershell core

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
winget install -e --id Git.Git --accept-package-agreements --accept-source-agreements

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
winget install -e --id GnuPG.GnuPG --accept-package-agreements --accept-source-agreements

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
choco install notepadplusplus -y

$notepad = "$env:programfiles\Notepad++"
[Environment]::SetEnvironmentVariable("Path", "$env:Path;$notepad", [System.EnvironmentVariableTarget]::Machine)

# notepad++ dracula
curl -o $env:AppData\Notepad++\themes\Dracula.xml https://raw.githubusercontent.com/dracula/notepad-plus-plus/master/Dracula.xml
#(Manual) > Settings > Style Configurator

# zip
choco install 7zip -y
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
#(Manual) > Mouse Properties > Pointers > Set "Capitaine Cursors"

## dev tools
choco install vscode -y
choco install visualstudio2022community-preview --pre
choco install dotnetcore-sdk -y

choco install docker-desktop -y
choco install dive -y

# optional
choco install postman -y
choco install ilspy -y
winget install -e --id ScooterSoftware.BeyondCompare4 --accept-package-agreements --accept-source-agreements

## tools
choco install foxitreader -y
choco install vlc -y

# optional
choco install windirstat -y
choco install procexp -y
choco install cpu-z -y
choco install qbittorrent -y

# work
winget install -e --id Microsoft.Teams --accept-package-agreements --accept-source-agreements

## features

# telnet
Enable-WIndowsOptionalFeature -Online -FeatureName TelnetClient

## WSL configuration
winget install -e --id Canonical.Ubuntu --accept-package-agreements --accept-source-agreements

# activation WSL 2 - https://docs.microsoft.com/en-US/windows/wsl/install-win10
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
#(Manual) > linux kernel update package
wsl --set-default-version 2
#(Manual) > install linux distro

## settings
Set-Executionpolicy -Scope CurrentUser -ExecutionPolicy UnRestricted
Set-ExecutionPolicy Bypass -Scope Process -Force
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

## chocolatey
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

## dev tools
mkdir c:\dev

choco install visualstudio2022community-preview --pre
choco install dotnetcore-sdk -y
choco install vscode -y
choco install postman -y
choco install ilspy -y

choco install docker-desktop -y
choco install dive -y


## terminal
choco install powershell-core -y

# posh
choco install cascadiacodepl -y

Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck # powershell core

curl -o $PROFILE https://raw.githubusercontent.com/joasimonson/configuration/main/terminal/Microsoft.PowerShell_profile.ps1

$terminalConfigFolder = "~/.config/terminal"
mkdir -p $terminalConfigFolder
curl -o $terminalConfigFolder/pwsh.png https://raw.githubusercontent.com/joasimonson/configuration/main/terminal/pwsh.png
curl -o $terminalConfigFolder/powershell.png https://raw.githubusercontent.com/joasimonson/configuration/main/terminal/powershell.png
curl -o $terminalConfigFolder/ubuntu.png https://raw.githubusercontent.com/joasimonson/configuration/main/terminal/ubuntu.png
curl -o $terminalConfigFolder/azure.png https://raw.githubusercontent.com/joasimonson/configuration/main/terminal/azure.png
curl -o $terminalConfigFolder/cmd.png https://raw.githubusercontent.com/joasimonson/configuration/main/terminal/cmd.png

refreshenv

## node - npm
choco install nvm -y
choco install nodejs -y

npm i -g iisexpress-proxy
npm i -g rimraf

## git
choco install git -y

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
choco install gnupg -y
$pathGpg = "${env:programfiles(x86)}\GnuPG\bin"
[Environment]::SetEnvironmentVariable("Path", "$env:Path;$pathGpg", [System.EnvironmentVariableTarget]::Machine)

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
$gitkConfigFolder = "~/.config/git"
mkdir -p $gitkConfigFolder
curl -o $gitkConfigFolder/gitk https://raw.githubusercontent.com/dracula/gitk/master/gitk

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
$capitaine_url = 'https://api.github.com/repos/keeferrourke/capitaine-cursors/contents/.windows?ref=master'
$capitaine_folder = "capitaine-cursors"
mkdir -p $capitaine_folder

curl $capitaine_url | json | % { curl -o ($capitaine_folder + "\" + $_.name) $_.download_url }

cd $env:SystemRoot\System32
InfDefaultInstall ("$mainPath\$capitaine_folder\install.inf")

cd $mainPath
rimraf $capitaine_folder
#(Manual) > Mouse Properties > Pointers > Set "Capitaine Cursors"

## tools
choco install powertoys -y
choco install foxitreader -y
choco install vlc -y

# optional
choco install windirstat -y
choco install procexp -y
choco install cpu-z -y
choco install qbittorrent -y

# hardare
choco install logitech-options -y

# work
choco install microsoft-teams -y


## features

# telnet
Enable-WIndowsOptionalFeature -Online -FeatureName TelnetClient

# WSL 2 - https://docs.microsoft.com/en-US/windows/wsl/install-win10
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
#(Manual) > linux kernel update package
wsl --set-default-version 2
#(Manual) > install linux distro


# remove windows programs default
remove-AppxPackage Microsoft.ZuneMusic_10.19031.11411.0_x64__8wekyb3d8bbwe
remove-AppxPackage Microsoft.WindowsMaps_5.1906.1972.0_x64__8wekyb3d8bbwe
remove-AppxPackage Microsoft.Messaging_4.1901.10241.1000_x64__8wekyb3d8bbwe
remove-AppxPackage Microsoft.People_10.1902.633.0_x64__8wekyb3d8bbwe
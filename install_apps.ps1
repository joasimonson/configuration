# ExecutionPolicy
Set-Executionpolicy -Scope CurrentUser -ExecutionPolicy UnRestricted

# Chocolatey Install
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Dev
choco install powershell-core -y
choco install vscode -y
choco install ilspy -y
choco install postman -y
choco install azure-data-studio -y

choco install docker-desktop -y
choco install dive -y

choco install git -y
choco install poshgit -y

choco install yarn -y

choco install nodejs -y
choco install nvm -y

choco install dotnetcore-sdk -y

# Aux
choco install powertoys -y
choco install notepadplusplus -y
choco install foxitreader -y
choco install 7zip -y
choco install paint.net -y
choco install windirstat -y
choco install procexp -y
choco install cpu-z -y
choco install qbittorrent


# Hardare
choco install logitech-options -y


# Work
choco install microsoft-teams -y


# NPM
npm i -g iisexpress-proxy


# Remove windows programs default
remove-AppxPackage Microsoft.ZuneMusic_10.19031.11411.0_x64__8wekyb3d8bbwe
remove-AppxPackage Microsoft.WindowsMaps_5.1906.1972.0_x64__8wekyb3d8bbwe
remove-AppxPackage Microsoft.Messaging_4.1901.10241.1000_x64__8wekyb3d8bbwe
remove-AppxPackage Microsoft.People_10.1902.633.0_x64__8wekyb3d8bbwe


## Features

# Telnet
Enable-WIndowsOptionalFeature -Online -FeatureName TelnetClient

# WSL 2 - https://docs.microsoft.com/en-US/windows/wsl/install-win10
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
# Linux kernel update package
wsl --set-default-version 2
# Install linux distro


# gitk dark-mode
mkdir -p ~/.config/git
curl -o ~/.config/git/gitk https://raw.githubusercontent.com/dracula/gitk/master/gitk

# Assign git commits
choco install gnupg -y

[Environment]::SetEnvironmentVariable("Path", $env:Path + ${env:programfiles(x86)} + "\GnuPG\bin", [System.EnvironmentVariableTarget]::Machine)

gpg --full-generate-key
gpg --list-secret-keys --keyid-format LONG joasimonson@hotmail.com
gpg --armor --export [Secret Key]

git config --global user.name "joasimonson"
git config --global user.email joasimonson@hotmail.com
git config --global user.signingkey [Secret Key]
git config --global gpg.program (${env:programfiles(x86)} + "\GnuPG\bin\gpg.exe")
git config --global commit.gpgsign true

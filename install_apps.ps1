# Settings
Set-Executionpolicy -Scope CurrentUser -ExecutionPolicy UnRestricted
Set-ExecutionPolicy Bypass -Scope Process -Force
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Chocolatey Install
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Dev
mkdir c:\dev

choco install vscode -y
choco install ilspy -y
choco install postman -y
choco install azure-data-studio -y

choco install docker-desktop -y
choco install dive -y

choco install git -y
choco install nodejs -y
choco install nvm -y
choco install dotnetcore-sdk -y
choco install powershell-core -y


# posh terminal
choco install cascadiacodepl -y
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck # Powershell core
curl -o $PROFILE https://raw.githubusercontent.com/joasimonson/configuration/main/terminal/Microsoft.PowerShell_profile.ps1

$terminalConfigFolder = "~/.config/terminal"
mkdir -p $terminalConfigFolder
curl -o $terminalConfigFolder/pwsh.png https://raw.githubusercontent.com/joasimonson/configuration/main/terminal/pwsh.png
curl -o $terminalConfigFolder/ubuntu.png https://raw.githubusercontent.com/joasimonson/configuration/main/terminal/ubuntu.png

# git aliases
git config --global alias.rprune "remote prune origin"

# git linux tools
$linuxTools = "$env:programfiles\Git\usr\bin"
[Environment]::SetEnvironmentVariable("Path", "$env:Path;$linuxTools", [System.EnvironmentVariableTarget]::Machine)

# gitk dracula
$gitkConfigFolder = "~/.config/git"
mkdir -p $gitkConfigFolder
curl -o $gitkConfigFolder/gitk https://raw.githubusercontent.com/dracula/gitk/master/gitk

# notepad++ dracula
choco install notepadplusplus -y
curl -o $env:AppData\Notepad++\themes\Dracula.xml https://raw.githubusercontent.com/dracula/notepad-plus-plus/master/Dracula.xml
# Settings > Style Configurator

# Zip
choco install 7zip -y
$path7zip = "$env:programfiles\7-Zip"
[Environment]::SetEnvironmentVariable("Path", "$env:Path;$path7zip", [System.EnvironmentVariableTarget]::Machine)

# Capitaine cursors
$capitaine_folder = "capitaine-cursors"
mkdir -p $capitaine_folder
$capitaine_files = Invoke-WebRequest 'https://api.github.com/repos/keeferrourke/capitaine-cursors/contents/.windows?ref=master' | ConvertFrom-Json
foreach ($file in $capitaine_files) {
    curl -o ($capitaine_folder + "\" + {$file.name}) $file.download_url
}
$mainPath = (Get-Location).ToString()
cd $env:SystemRoot\System32
InfDefaultInstall ("$mainPath\$capitaine_folder\install.inf")
cd $mainPath
rmdir -r -Force $capitaine_folder
# Mouse Properties > Pointers > Set "Capitaine Cursors"

# Tools
choco install powertoys -y
choco install foxitreader -y
choco install vlc -y
choco install paint.net -y
choco install windirstat -y
choco install procexp -y
choco install cpu-z -y
choco install qbittorrent -y

# Hardare
choco install logitech-options -y

# Work
choco install microsoft-teams -y

# NPM
npm i -g iisexpress-proxy


## Features

# Telnet
Enable-WIndowsOptionalFeature -Online -FeatureName TelnetClient

# WSL 2 - https://docs.microsoft.com/en-US/windows/wsl/install-win10
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
# Linux kernel update package
wsl --set-default-version 2
# Install linux distro


# Assign git commits
$username = "joasimonson"
$email = "joasimonson@hotmail.com"

choco install gnupg -y
$pathGpg = ${env:programfiles(x86)} + "\GnuPG\bin"
[Environment]::SetEnvironmentVariable("Path", $env:Path + $pathGpg, [System.EnvironmentVariableTarget]::Machine)

gpg --full-generate-key
gpg --list-secret-keys --keyid-format LONG $email
$secretKey = (gpg --list-secret-keys --keyid-format LONG $email | findstr sec).SubString(14, 16)
# $secretKey = gpg --list-secret-keys --keyid-format LONG $email | Select-String -Pattern sec -Context 0,1 | ForEach-Object { $_.Context.PostContext.Trim() } (Get full key)
gpg --armor --export $secretKey

git config --global user.name $username
git config --global user.email $email
git config --global user.signingkey $secretKey
git config --global gpg.program ($pathGpg + "\gpg.exe")
git config --global commit.gpgsign true

Remove-Variable secretKey

# Remove windows programs default
remove-AppxPackage Microsoft.ZuneMusic_10.19031.11411.0_x64__8wekyb3d8bbwe
remove-AppxPackage Microsoft.WindowsMaps_5.1906.1972.0_x64__8wekyb3d8bbwe
remove-AppxPackage Microsoft.Messaging_4.1901.10241.1000_x64__8wekyb3d8bbwe
remove-AppxPackage Microsoft.People_10.1902.633.0_x64__8wekyb3d8bbwe

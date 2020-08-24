# Dev

# ExecutionPolicy
Set-Executionpolicy -Scope CurrentUser -ExecutionPolicy UnRestricted

# Chocolatey Install
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install vscode -y
choco install vscode-gitlens

choco install ilspy -y

choco install azure-data-studio

choco install docker-desktop --version=2.0.0.3

choco install git -y
choco install poshgit -y

choco install nodejs -y

choco install postman -y

# Aux

choco install notepadplusplus -y
choco install foxitreader -y
choco install 7zip -y
choco install paint.net -y
choco install windirstat -y # WindirStat (Análise de arquivos)
choco install procexp -y # Process explorer
choco install qbittorrent

# Remove windows programs default
remove-AppxPackage Microsoft.ZuneMusic_10.19031.11411.0_x64__8wekyb3d8bbwe
remove-AppxPackage Microsoft.WindowsMaps_5.1906.1972.0_x64__8wekyb3d8bbwe
remove-AppxPackage Microsoft.Messaging_4.1901.10241.1000_x64__8wekyb3d8bbwe
remove-AppxPackage Microsoft.People_10.1902.633.0_x64__8wekyb3d8bbwe

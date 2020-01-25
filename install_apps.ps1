#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
# Script de instalação de programas	#
# script by Araújo, Jo				#
# v0.0.1 22/10/2019					#
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

#---------------------
# Development
#---------------------

# Visual Studio Code
choco install vscode -y
choco install vscode-gitlens

# ILSPY
choco install ilspy -y

# SQL Management Studio
choco install sql-server-management-studio -y

# Git
choco install git -y
choco install poshgit -y

# Node js
choco install nodejs -y

# Postman
choco install postman -y

#-----------------------
# Auxiliar
#-----------------------

# Notepad++
choco install notepadplusplus -y

# Foxit reader
choco install foxitreader -y

# 7 zip
choco install 7zip -y

# Google Chrome
choco install googlechrome -y

# Paint.net
choco install paint.net -y

# WindirStat (Análise de arquivos)
choco install windirstat -y

# Process explorer
choco install procexp -y


# Programas inutilizados Windows
remove-AppxPackage Microsoft.ZuneMusic_10.19031.11411.0_x64__8wekyb3d8bbwe
remove-AppxPackage Microsoft.WindowsMaps_5.1906.1972.0_x64__8wekyb3d8bbwe
remove-AppxPackage Microsoft.Messaging_4.1901.10241.1000_x64__8wekyb3d8bbwe
remove-AppxPackage Microsoft.People_10.1902.633.0_x64__8wekyb3d8bbwe

# ExecutionPolicy
Set-Executionpolicy -Scope CurrentUser -ExecutionPolicy UnRestricted

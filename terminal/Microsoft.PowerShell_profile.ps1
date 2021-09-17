Import-Module posh-git
Import-Module oh-my-posh
#Set-PoshPrompt -Theme agnoster

function DeleteAllGoneBranches() {
	git branch --list --format "%(if:equals=[gone])%(upstream:track)%(then)%(refname:short)%(end)" | grep -v -e '^[[:space:]]*$' | tr '[:space:]' ' ' | xargs git branch -D
}
Set-Alias git-rgb DeleteAllGoneBranches

function DeleteAllBranches() {
	git branch | grep -v ^* | grep -v main | tr '[:space:]' ' ' | xargs git branch -D
}
Set-Alias git-rga DeleteAllBranches

function GetAllHistory() {
    start ~/AppData/Roaming/Microsoft/Windows/PowerShell/PSReadline/ConsoleHost_history.txt
}
Set-Alias get-hist GetAllHistory
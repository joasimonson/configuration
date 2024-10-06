Import-Module posh-git

## completions
# Import-Module DockerCompletion

function DeleteAllGoneBranches() {
	git rprune
	git branch --list --format "%(if:equals=[gone])%(upstream:track)%(then)%(refname:short)%(end)" | tr '[:space:]' ' ' | xargs git branch -D
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

function PullProfile() {
	curl -o $PROFILE https://raw.githubusercontent.com/joasimonson/configuration/main/terminal/Microsoft.PowerShell_profile.ps1
}
Set-Alias set-profile PullProfile

function DeepCleanProject() {
	rimraf --glob ./**/bin
	rimraf --glob ./**/obj
	rimraf --glob ./**/.vs
}
Set-Alias deep-clean-project DeepCleanProject

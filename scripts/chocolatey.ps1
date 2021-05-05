[CmdletBinding()]
param (
    [ValidateNotNullOrEmpty()]
    [String]$DownloadUrl = 'https://chocolatey.org/install.ps1',
    [ValidateNotNullOrEmpty()]
    [String]$RepoName = $Env:RepoName,
    [ValidateNotNullOrEmpty()]
    [String]$RepoURL = $Env:RepoURL,
    [ValidateNotNullOrEmpty()]
    [String]$RepoUsername = $Env:RepoUsername,
    [ValidateNotNullOrEmpty()]
    [String]$RepoToken = $Env:RepoToken
)

Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($DownloadUrl))

$validExitCodes = @(0, 3010)

$command = "choco.exe source add -n=${RepoName} -s=""${RepoURL}"" -u=""${RepoUsername}"" -p=""${RepoToken}"""

Invoke-Expression -Command $command

if ($LASTEXITCODE -notin $validExitCodes) {
    throw 'Chocolatey source(s) addition failed'
}
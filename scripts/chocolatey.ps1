[CmdletBinding()]
param (
    [ValidateNotNullOrEmpty()]
    [String]$Url = 'https://chocolatey.org/install.ps1'
)

Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($Url))
[CmdletBinding()]
param (
    [ValidateNotNullOrEmpty()]
    [String[]]$Services = @('RdAgent','WindowsAzureGuestAgent')
)

foreach ($Service in $Services) {
    while ((Get-Service $Service -ErrorAction SilentlyContinue).Status -ne 'Running') {
        Write-Verbose "Waiting on service: ${Service}"
        Start-Sleep -s 5
    }
}
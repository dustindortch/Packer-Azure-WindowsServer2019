[CmdletBinding()]
param (
    [ValidateNotNullOrEmpty()]
    [String]$EndState = 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE'
)

Write-Verbose 'Performing sysprep'
& "${Env:SystemRoot}\System32\Sysprep\Sysprep.exe" /oobe /generalize /quiet /quit /mode:vm

while ($true) {
    $imageState = Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup\State | Select-Object -ExpandProperty ImageState
    Write-Output $imageState
    if ($imageState -eq $EndState) {
        Write-Verbose 'Done.  Shutting down.'
        break
    }
    Start-Sleep -s 10
}
[CmdletBinding()]
param (
    [ValidateNotNullOrEmpty()]
    $Packages = @(
        @{name = 'powershell-core'}
        @{name = 'git'}
        @{name = 'putty.install'}
        @{name = 'terraform'}
    )
)

$validExitCodes = @(0, 3010)

foreach ($package in $Packages) {
    $command = "choco.exe upgrade $($package.name) -y --no-progress"

    if ($package.ContainsKey('args')) {
        $command += " $($package.args)"
    }

    Invoke-Expression -Command $command

    if ($LASTEXITCODE -notin $validExitCodes) {
        throw 'Chocolatey package(s) installation failed'
    }
}
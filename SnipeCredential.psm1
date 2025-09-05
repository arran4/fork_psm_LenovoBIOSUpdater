function Save-SnipeApiKey {
    [CmdletBinding()]
    param(
        [string]$Path = "$env:APPDATA\LenovoBIOSUpdater\snipeApiKey.xml"
    )
    $credential = Get-Credential -Message 'Enter Snipe API key as the password.' -UserName 'SnipeAPI'
    $directory = Split-Path $Path
    if (-not (Test-Path $directory)) {
        New-Item -ItemType Directory -Path $directory | Out-Null
    }
    $credential | Export-Clixml -Path $Path
}

function Get-SnipeApiKey {
    [CmdletBinding()]
    param(
        [string]$Path = "$env:APPDATA\LenovoBIOSUpdater\snipeApiKey.xml"
    )
    if (Test-Path $Path) {
        (Import-Clixml -Path $Path).GetNetworkCredential().Password
    }
    else {
        throw "Snipe API key credential not found. Run Save-SnipeApiKey to create it."
    }
}

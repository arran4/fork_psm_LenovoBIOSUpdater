Import-Module PSScriptAnalyzer -ErrorAction Stop
$settings = Join-Path $PSScriptRoot 'psscriptanalyzer.settings.psd1'
$results = Invoke-ScriptAnalyzer -Path $PSScriptRoot -Recurse -Settings $settings
if ($results) {
    $results | Format-Table
    exit 1
}


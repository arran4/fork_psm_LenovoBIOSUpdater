BeforeAll {
    $scriptPath = Join-Path $PSScriptRoot '..' 'BIOSData.ps1'
    $ast = [System.Management.Automation.Language.Parser]::ParseFile($scriptPath, [ref]$null, [ref]$null)
    $funcAsts = $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $true)
    foreach ($funcAst in $funcAsts) {
        # Replace exit with throw so tests can capture failures without terminating PowerShell
        $funcText = $funcAst.Extent.Text -replace '\bexit\b', 'throw'
        Invoke-Expression $funcText
    }
}

describe 'Set-ImageData' {
    BeforeEach {
        Set-Variable -Name biosDetails -Value @{ 'PRELOADPROFILE.IMAGE'=''; 'PRELOADPROFILE.IMAGEDATE'='' } -Scope Global
        if (Get-PSDrive -Name TSEnv -ErrorAction SilentlyContinue) { Remove-PSDrive -Name TSEnv -Force }
        New-PSDrive -Name TSEnv -PSProvider Variable -Root '' | Out-Null
        Set-Item TSEnv:TASKSEQUENCEID 'TS123'
    }
    it 'sets image and date based on task sequence' {
        Set-ImageData
        $global:biosDetails.'PRELOADPROFILE.IMAGE' | Should -Be 'TS123'
        $global:biosDetails.'PRELOADPROFILE.IMAGEDATE' | Should -Match '^\d{8}$'
    }
}

describe 'Get-SnipeData' {
    BeforeEach {
        Set-Variable -Name biosDetails -Value @{} -Scope Global
        Set-Variable -Name snipeResult -Value $null -Scope Global
        Set-Variable -Name snipeURL -Value 'https://snipe.example.com' -Scope Global
        Set-Variable -Name snipeAPIKey -Value 'token' -Scope Global
        Set-Variable -Name deviceSerial -Value 'ABC123' -Scope Global
        Set-Variable -Name logPath -Value '' -Scope Global
        Mock Write-Log {}
    }
    it 'populates bios details when request succeeds' {
        Mock Test-Connection { $true }
        $response = [pscustomobject]@{ StatusCode = 200; Content = '{"total":1,"rows":[{"asset_tag":"TAG1","Purchase_Date":{"date":"2020-01-01"},"Warranty_Expires":{"date":"2025-01-01"},"purchase_cost":1000,"Warranty_Months":"12 months","name":"Device1"}]}' }
        Mock Invoke-WebRequest { $response }
        Get-SnipeData
        $global:biosDetails.'USERASSETDATA.ASSET_NUMBER' | Should -Be 'TAG1'
        $global:biosDetails.'NETWORKCONNECTION.SYSTEMNAME' | Should -Be 'Device1'
    }
    it 'throws when Snipe server cannot be reached' {
        Mock Test-Connection { $false }
        { Get-SnipeData } | Should -Throw
    }
}

describe 'Set-BIOSData' {
     BeforeEach {
         Push-Location $TestDrive
         Set-Variable -Name dryRun -Value $true -Scope Global
         Set-Variable -Name logPath -Value '' -Scope Global
         Set-Variable -Name biosDetails -Value @{ 'USERASSETDATA.ASSET_NUMBER' = 'TAG1' } -Scope Global
         Set-Variable -Name biosCurrent -Value @{} -Scope Global
         Set-Content -Path 'WinAIA64.exe' -Value "#!/bin/sh`necho called > run.log" -NoNewline
         chmod +x 'WinAIA64.exe'
         Mock Write-Log {}
     }
     it 'does not call WinAIA64.exe when dry run is enabled' {
         Set-BIOSData
         Test-Path 'run.log' | Should -BeFalse
         Assert-MockCalled Write-Log -ParameterFilter { $logMessage -eq 'Setting BIOS Data - Dry Run' } -Times 1
     }
     AfterEach {
         Pop-Location
     }
 }

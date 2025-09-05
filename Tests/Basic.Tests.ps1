Describe "Repository tests" {
    It "contains BIOSData script" {
        Test-Path "$PSScriptRoot/../BIOSData.ps1" | Should -BeTrue
    }
}

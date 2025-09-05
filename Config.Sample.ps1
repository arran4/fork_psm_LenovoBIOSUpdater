#Snipe Data
Import-Module "$PSScriptRoot\SnipeCredential.psm1" -ErrorAction Stop
$snipeAPIKey = Get-SnipeApiKey
$snipeURL = "https://my.snipe.url" #No trailing /

#WinAIACache
$winAIACache = "" #No trailing \ - null or blank will not instigate this check, please use UNC variable for network paths

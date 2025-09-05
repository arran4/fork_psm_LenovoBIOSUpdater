# psm_LenovoBIOSUpdater
This module uses the Lenovo BIOS Utility (WinAIA) to read and where required update the user-settable BIOS fields such as Asset ID, this data is pulled from SNIPE-IT or can simply be set using defaults

## Dry run

Use the `-dryRun` switch to simulate BIOS updates without committing any changes.

```powershell
# Preview operations without writing to BIOS
./BIOSData.ps1 -dryRun

# Equivalent explicit invocation
./BIOSData.ps1 -dryRun:$true
```

In Addition to the licence conditions spelled out in the attached licence, the Victorian Department of Education is prohibited from utilising this resource until they treat their technicians like people and not second-class people and are prohibited from using it in any way to support SCL or SID initiatives, permanently for the former, and until there is full public disclosure including the PIA to all staff with no reservations or NDA's on the later, this is not to say that individual schools cannot use the resource, they are most welcome to, DET themselves, however, cannot.

# Sample configuration for BIOSData.ps1

# Snipe-IT connection details used to look up asset information
$snipeAPIKey = "my.snipe.APIKey"      # API key used for authentication against Snipe-IT
$snipeURL    = "https://my.snipe.url" # Base URL of Snipe-IT instance (no trailing /)

# Optional network cache for the WinAIA package.
# Leave blank to download from Lenovo, or provide a UNC path without a trailing \\.
$winAIACache = ""

# BIOS field defaults
# ---------------------------------------------------------------------------
# These keys map to the user-settable fields within the Lenovo BIOS.
# Set a value to have it written to the BIOS. Leave as "" to preserve the
# current BIOS value. Set to the string "BLANK" to clear an existing value.
#
# Key                                   Default  Allowed format / description
$biosFields = @{
    'NETWORKCONNECTION.NUMNICS'       = "" # Integer count of installed NICs (e.g. 1)
    'NETWORKCONNECTION.GATEWAY'       = "" # Default gateway IPv4 address (e.g. 192.168.0.1)
    'NETWORKCONNECTION.IPADDRESS'     = "" # Primary IPv4 address (e.g. 192.168.0.10)
    'NETWORKCONNECTION.SUBNETMASK'    = "" # Subnet mask in IPv4 format (e.g. 255.255.255.0)
    'NETWORKCONNECTION.SYSTEMNAME'    = "" # Hostname of the device (up to 15 characters)
    'NETWORKCONNECTION.LOGINNAME'     = "" # Last logged-on user (domain\\username)
    'PRELOADPROFILE.IMAGEDATE'        = "" # Imaging date in yyyyMMdd format
    'PRELOADPROFILE.IMAGE'            = "" # Image name or task sequence ID
    'OWNERDATA.OWNERNAME'             = "" # Full name of assigned user
    'OWNERDATA.DEPARTMENT'            = "" # Department name
    'OWNERDATA.LOCATION'              = "" # Physical location or site
    'OWNERDATA.PHONE_NUMBER'          = "" # Contact phone number (digits only)
    'OWNERDATA.OWNERPOSITION'         = "" # Job title or position
    'LEASEDATA.LEASE_START_DATE'      = "" # Lease start date in yyyyMMdd format
    'LEASEDATA.LEASE_END_DATE'        = "" # Lease end date in yyyyMMdd format
    'LEASEDATA.LEASE_TERM'            = "" # Lease term in months (integer)
    'LEASEDATA.LEASE_AMOUNT'          = "" # Total lease amount (currency, e.g. $1000)
    'LEASEDATA.LESSOR'                = "" # Leasing company name
    'USERASSETDATA.PURCHASE_DATE'     = "" # Purchase date in yyyyMMdd format
    'USERASSETDATA.LAST_INVENTORIED'  = "" # Last inventory date in yyyyMMdd format
    'USERASSETDATA.WARRANTY_END'      = "" # Warranty expiry date in yyyyMMdd format
    'USERASSETDATA.WARRANTY_DURATION' = "" # Warranty duration in months (integer)
    'USERASSETDATA.AMOUNT'            = "" # Purchase cost (currency, e.g. $999)
    'USERASSETDATA.ASSET_NUMBER'      = "" # Asset tag or inventory number
}


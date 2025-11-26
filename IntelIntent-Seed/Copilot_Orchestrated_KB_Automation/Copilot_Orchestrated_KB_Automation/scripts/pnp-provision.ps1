
param(
  [Parameter(Mandatory=$true)][string]$SiteUrl,
  [Parameter(Mandatory=$true)][string]$Title
)
# Requires: PnP.PowerShell module
Connect-PnPOnline -Url $SiteUrl -Interactive
try {
  New-PnPSite -Type CommunicationSite -Title $Title -Url $SiteUrl -SiteDesign Topic -ErrorAction SilentlyContinue
} catch {}
# Libraries
New-PnPList -Title 'Docs' -Template DocumentLibrary -ErrorAction SilentlyContinue | Out-Null
New-PnPList -Title 'Modules' -Template DocumentLibrary -ErrorAction SilentlyContinue | Out-Null
New-PnPList -Title 'Agents' -Template DocumentLibrary -ErrorAction SilentlyContinue | Out-Null
# Columns
Add-PnPField -List 'Docs' -DisplayName 'Domain' -InternalName 'Domain' -Type Choice -AddToDefaultView -Choices 'personal','family','business','shared-platform' -ErrorAction SilentlyContinue
Add-PnPField -List 'Docs' -DisplayName 'Portfolio' -InternalName 'Portfolio' -Type Text -AddToDefaultView -ErrorAction SilentlyContinue
Add-PnPField -List 'Docs' -DisplayName 'Module' -InternalName 'Module' -Type Text -AddToDefaultView -ErrorAction SilentlyContinue
Add-PnPField -List 'Docs' -DisplayName 'Status' -InternalName 'Status' -Type Choice -AddToDefaultView -Choices 'Draft','In Review','Published' -ErrorAction SilentlyContinue
Disconnect-PnPOnline

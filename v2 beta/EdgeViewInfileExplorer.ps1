 # Version:        0.2
 # Author:         simislearning
 # Creation Date:  12/29/2023
 
#based on https://learn.microsoft.com/en-us/sharepoint/sharepoint-view-in-edge 
#CABURL
#found on https://www.microsoft.com/edge/business/download
$URL = "https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/ae978a62-edd6-4461-adf3-4f517e276bac/MicrosoftEdgePolicyTemplates.cab"
#SharepointURL

#Please note if you like you can just have sharepoint.com which will allow any sharepoint site to work however don't recommend it
#please specefy the sharepoint domain itself
$SharePointDomainName= "sim"
#define language
$EdgeLNG = "en-US"
###############################
###############################
###############################
####Do Not Edit Below##########
###############################
###############################
###############################
$edgeExecutablePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$edgeFileVersion = (Get-Command $edgeExecutablePath).FileVersionInfo.FileVersion
Write-Host "Current Microsoft Edge Version: $edgeFileVersion"
$EdgeSettings = "edge://settings/help"
Start-Process -FilePath $edgeExecutablePath
Start-Sleep -Seconds 5
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.SendKeys]::SendWait("^l")  
Start-Sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait($EdgeSettings + "{ENTER}")
Start-Sleep -Seconds 5
$Office = "Office.com"
Start-Process -FilePath $edgeExecutablePath
Start-Sleep -Seconds 5
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.SendKeys]::SendWait("^l") 
Start-Sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait($Office + "{ENTER}")
$edgeFileVersion = (Get-Command $edgeExecutablePath).FileVersionInfo.FileVersion
Write-Host "New Microsoft Edge Version: $edgeFileVersion"
$FileName = "MicrosoftEdgePolicyTemplates.cab"
$Path = "C:\TEMP\Sim\"
$localFilePath = Join-Path -Path $Path -ChildPath $FileName
if (!(Test-Path -Path $Path)) {
  New-Item -Path $Path -ItemType Directory | Out-Null
}
if (!(Test-Path -Path $localFilePath)) {
  Write-Host "Downloading file..."
  Invoke-WebRequest -Uri $URL -OutFile $localFilePath
  Write-Host "Download completed!"
} else {
  Write-Host "The file $localFilePath already exists."
}
New-Item -ItemType Directory -Path "$Path\ZIP\"
Expand "$Path\MicrosoftEdgePolicyTemplates.cab" "$Path\ZIP\MicrosoftEdgePolicyTemplates.zip"
New-Item -ItemType Directory -Path "$Path\ExtractedFiles\"
Expand-Archive -Path "$Path\ZIP\MicrosoftEdgePolicyTemplates.zip" -DestinationPath "$Path\ExtractedFiles\"
$EdgeADMXPath = "C:\Windows\PolicyDefinitions\"
Write-Host "Copying ADMX Files"
Copy-Item "$Path\ExtractedFiles\windows\admx\msedge.admx" "$EdgeADMXPath"
Copy-Item "$Path\ExtractedFiles\windows\admx\msedgeupdate.admx" "$EdgeADMXPath"
Copy-Item "$Path\ExtractedFiles\windows\admx\msedgewebview2.admx" "$EdgeADMXPath"
Write-Host "Copying ADML Language Files"
Copy-Item "$Path\ExtractedFiles\windows\admx\$EdgeLNG\msedge.adml" "$EdgeADMXPath\$EdgeLNG\"
Copy-Item "$Path\ExtractedFiles\windows\admx\$EdgeLNG\msedgeupdate.adml" "$EdgeADMXPath\$EdgeLNG\"
Copy-Item "$Path\ExtractedFiles\windows\admx\$EdgeLNG\msedgewebview2.adml" "$EdgeADMXPath\$EdgeLNG\"
$jsonValue = '[{"cookies": ["rtFa", "FedAuth"], "domain": "$SharePointDomainName.$SharePointDomain"}]'
$registryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
$registryValueName = "ConfigureViewInFileExplorer"
if (-not (Test-Path $registryKeyPath)) {
    New-Item -Path $registryKeyPath -Force
}
Set-ItemProperty -Path $registryKeyPath -Name $registryValueName -Value $jsonValue
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains"
$SharePointDomainFiles = "$SharePointDomainName -files.sharepoint.com"
New-Item -Path "$registryPath\$($SharePointDomain -replace 'https://|http://','')" -Force
New-ItemProperty -Path "$registryPath\$($SharePointDomain -replace 'https://|http://','')" -Name "https" -Value 2 -PropertyType DWORD -Force
New-Item -Path "$registryPath\$($SharePointDomainFiles -replace 'https://|http://','')" -Force
New-ItemProperty -Path "$registryPath\$($SharePointDomainFiles -replace 'https://|http://','')" -Name "https" -Value 2 -PropertyType DWORD -Force
Write-Host "Site '$SharePointDomain' added to Trusted Sites zone."
gpupdate /force
$EdgePolicy = "edge://policy"
Start-Process -FilePath $edgeExecutablePath
Start-Sleep -Seconds 5
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.SendKeys]::SendWait("^l") 
Start-Sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait($EgeSettings + "{ENTER}")
Remove-Item -Path $Path -Force

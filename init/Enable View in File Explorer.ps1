#Connect to SharePoint Online Management Shell by running:
#requeires SPOService Module 
#https://learn.microsoft.com/en-us/powershell/sharepoint/sharepoint-online/connect-sharepoint-online?view=sharepoint-ps
#log into tenant as Global Admin using powershell
Connect-SPOService -Url https://contoso-admin.sharepoint.com

# Enable View in File Explorer for Edge
Set-SPOTenant -ViewInFileExplorerEnabled $True

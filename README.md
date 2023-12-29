# EdgeViewInfileExplorer

Document Link:

https://learn.microsoft.com/en-us/sharepoint/sharepoint-view-in-edge#configure-view-in-file-explorer-with-edge


I don't recommend this option please try to work on splitting the sharepoint libraries  since i had worked on the code for on of the client who didn't want to redo sharepoint this is for for those clients.
#

using this method it works with SSO through EDGE it self, long the computer is joined to Azure AD 

#Please note this is works on Windows only once you havent it 

#
Please note you do have it enable feature first as it's mentioend on Microsoft's official document 
As a tenant administrator, update your SharePoint Online tenant configuration via SharePoint Online Management Shell to allow the "View in File Explorer" option to be visible in the Microsoft Edge Browser interface with these steps:

Connect to SharePoint Online Management Shell by running:


Connect-SPOService -Url https://contoso-admin.sharepoint.com

Set-SPOTenant -ViewInFileExplorerEnabled $True

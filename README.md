# EdgeViewInfileExplorer

Document Link:

https://learn.microsoft.com/en-us/sharepoint/sharepoint-view-in-edge#configure-view-in-file-explorer-with-edge


I don't recommend this option please try to work on splitting the sharepoint libraries  since i had worked on the code for one of the client who didn't want to redo sharepoint this is for for those clients although ZeeDrive was an option i had read it does run into some issues so i had re-visit.

Prior to Sharepoint sync if you recall it this used to worked based on IE recenlty i had revist saw Microsoft has been updating the docs for Edge so decided to retry and had deployed it for one of the clients since it can be useful but i still recommend if you are trying to use sharepoint as file storage just don't please use third party services.
#

using this method it works with SSO through EDGE it self, long the computer is joined to Azure AD 

#Please note this is works on Windows only once you havent it 

#
Please note you do have it enable feature first as it's mentioend on Microsoft's official document 

As a tenant administrator, update your SharePoint Online tenant configuration via SharePoint Online Management Shell to allow the "View in File Explorer" option to be visible in the Microsoft Edge Browser interface with these steps:

Connect to SharePoint Online Management Shell by running:


Connect-SPOService -Url https://contoso-admin.sharepoint.com

Set-SPOTenant -ViewInFileExplorerEnabled $True


Once you do have the sharepoint library in user's File explorer at this stage you can map the path on as Network Drive just like the way it used to work in IE

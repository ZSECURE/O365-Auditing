







#===========================
# Exchange Online 
#===========================

# Install the powershell module for Exchange Online
Install-Module -Name ExchangeOnlineManagement

# This example connects to Exchange Online PowerShell in a Microsoft 365 or Microsoft 365 GCC organization:
Connect-ExchangeOnline -UserPrincipalName navin@contoso.com -ShowProgress $true

# Verify that Modern Authentication is configured by running the following:
Get-OrganizationConfig | Format-Table -Auto Name,OAuth*
# Verify that OAuth2ClientProfileEnabled value returned is True




#===========================
# SharePoint Online 
#===========================

# Install the powershell module for SharePoint Online
Install-Module -Name Microsoft.Online.SharePoint.PowerShell

#Connection to SharePoint Online
$adminUPN="<the full email address of a SharePoint administrator account, example: jdoe@contosotoycompany.onmicrosoft.com>"
$orgName="<name of your Office 365 organization, example: contosotoycompany>"
$userCredential = Get-Credential -UserName $adminUPN -Message "Type the password."
Connect-SPOService -Url https://$orgName-admin.sharepoint.com -Credential $userCredential

# To connect with multifactor authentication (MFA)
#$orgName="<name of your Office 365 organization, example: contosotoycompany>"
#Connect-SPOService -Url https://$orgName-admin.sharepoint.com

# Verify that Modern Authentication is configured by running the following: 
(Get-SPOTenant).LegacyAuthProtocolsEnabled
# If the returned value is False, then only Modern Authentication is enabled for SharePoint


#===========================
# Skype for Business Online 
#===========================

# Install the powershell module for Teams
Install-Module -Name MicrosoftTeams

# Get the credenmtial for the Tenancy
$credential = Get-Credential

#Connect to Microsoft Teams
Connect-MicrosoftTeams -Credential $credential

#Connection to Skype for Business Online and import into Ps session
$session = New-CsOnlineSession -Credential $credential
Import-PsSession $session

# Verify that Modern Authentication is configured by running the following: 
(Get-CsOAuthConfiguration).ClientAdalAuthOverride
# If the returned value is Allowed, then Modern Authentication is configured
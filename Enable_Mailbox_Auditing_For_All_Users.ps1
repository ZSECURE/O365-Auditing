#=========================================
# Enable mailbox auditing for all users
#=========================================

#=========================================
# Connect to Exchange Online 
#=========================================

# Install the powershell module for Exchange Online
Install-Module -Name ExchangeOnlineManagement

# This example connects to Exchange Online PowerShell in a Microsoft 365 or Microsoft 365 GCC organization:
Connect-ExchangeOnline -UserPrincipalName navin@contoso.com -ShowProgress $true

# Verify that all users have mailbox auditing enabled by running the following:
Get-Mailbox -ResultSize Unlimited | Select Name, AuditEnabled,AuditLogAgeLimit | Out-Gridview
# Verify that AuditEnabled value returned is True
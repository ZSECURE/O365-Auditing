#===============================
# Enable audit data recording
#===============================

#==============================
# Connect to Exchange Online 
#==============================

# Install the powershell module for Exchange Online
Install-Module -Name ExchangeOnlineManagement

# This example connects to Exchange Online PowerShell in a Microsoft 365 or Microsoft 365 GCC organization:
Connect-ExchangeOnline -UserPrincipalName navin@contoso.com -ShowProgress $true

# Verify that audit data recording is enabled by running the following:
Get-AdminAuditLogConfig | FL UnifiedAuditLogIngestionEnabled
# Verify that UnifiedAuditLogIngestionEnabled value returned is True
# ===============================================================================
# File Name: Get-M365ReviewDetails.ps1
# ===============================================================================
# Name: M365 Review Script
# Author: Zak Clifford 
# Contact:  zak.clifford[at]cognisys.co.uk
# Version 1.0
# Created: 26 May 2022
# Updated: N/A
# Description: Dump the EOL 365 configuration for review inline with our report
# SHA256 HASH: 
# ===============================================================================
# Function Change Log
# v1.0 - Creation of script
# ===============================================================================
$ver = "1.0"

# ===============================================================================
# START OF CODE
# ===============================================================================


##Start of Script

# If not already imported connect to the MsolService
# Connect-MsolService

# If not already imported connect to the ExchangeOnline
# Connect-ExchangeOnline

#Get Unified log status
Get-AdminAuditLogConfig | FL UnifiedAuditLogIngestionEnabled | Out-File - FilePath UnifiedAuditLog.txt

# Block Basic Auth 
$OrgConfig = Get-OrganizationConfig ; $OrgConfig.OAuth2ClientProfileEnabled | Out-File -FilePath BlockBasicAuth.txt
$blockbasicauth = Get-AuthenticationPolicy | Where-Object {$_.Name -contains "Block Basic Auth"} ; $blockbasicauth | Out-File -Append -FilePath BlockBasicAuth.txt


# Block sign-on for all shared mailboxes
$SharedMailboxes = Get-Mailbox -ResultSize Unlimited -Filter {RecipientTypeDetails -Eq "SharedMailbox"}; $smbx = foreach ($user in $SharedMailboxes) { Get-MsolUser -UserPrincipalName $user.UserPrincipalName | select UserPrincipalName,DisplayName,BlockCredential} ; $smbx | Out-File -FilePath BlockSharedMailboxSignIn.txt

# Disable automatic forwarding to remote domains
Get-RemoteDomain Default | select Name,AutoForwardEnabled | Out-File -FilePath AutoForwardEnabled.txt


# Modify the default value for Retain Deleted Items
(Get-Mailbox -ResultSize Unlimited).RetainDeletedItemsFor | group | select name, count | ft | Out-File -FilePath RetainDeletedItems.txt


# Disable consumer storage locations in Outlook on the Web
Get-OwaMailboxPolicy -Identity OwaMailboxPolicy-Default | select Identity, AdditionalStorageProvidersAvailable | Out-File -FilePath ConsumerStorageLocations.txt


# Modify the default audit log age limit
(Get-Mailbox -ResultSize Unlimited).AuditLogAgeLimit | group | select name, count | ft | Out-File -FilePath DefaultAuditLogLimitAge.txt


# Conditional Access (block attachment download)
Get-OwaMailboxPolicy -Identity OwaMailboxPolicy-Default  | select Identity,ConditionalAccessPolicy | Out-File -FilePath BlockAttachmentDownload.txt


# Enable Auto-Expanding Archive
(Get-OrganizationConfig).AutoExpandingArchiveEnabled | Out-File -FilePath AutoExpandingArchive.txt


# Enable the Personal Archive mailbox
Get-Mailbox -ResultSize Unlimited -Filter {ArchiveStatus -Eq "None" -AND RecipientTypeDetails -eq "UserMailbox"} | Out-File -FilePath PersonalArchiveMailbox.txt


# Enable Litigation hold
Get-Mailbox -ResultSize Unlimited -Filter {LitigationHoldEnabled -Eq "False" -AND RecipientTypeDetails -ne "DiscoveryMailbox"} | Out-File -FilePath LitigationHold.txt

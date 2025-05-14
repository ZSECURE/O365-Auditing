# =============================================================================
# File Name: Get-SharedMailboxSignOnStatus.ps1
# =============================================================================
# Name: Get The Shared Mailbox Sign On Status
# Author: Zak Clifford 
# Contact:  zak.clifford[at]cognisys.co.uk
# Version 1.0
# Created: 01 Apr 2022
# Updated: N/A
# Description: Checks all Office 365 Shared mail boxes for the Sign On status
# SHA256 HASH: 
# =============================================================================
# Function Change Log
# v1.0 - Creation of script
# =============================================================================
$ver = "1.0"

# =============================================================================
# START OF CODE
# =============================================================================


##Start of Script

# If not already imported connect to the MsolService
# Connect-MsolService

# If not already imported connect to the ExchangeOnline
# Connect-ExchangeOnline


$SharedMailboxes = Get-Mailbox -ResultSize Unlimited -Filter {RecipientTypeDetails -Eq "SharedMailbox"}

Foreach ($user in $SharedMailboxes) {

Get-MsolUser -UserPrincipalName $user.UserPrincipalName | select UserPrincipalName,DisplayName,BlockCredential 

}

# ===============================================================================
# File Name: Get-ReportPluginStatus.ps1
# ===============================================================================
# Name: Get The Report Plugin Status
# Author: Zak Clifford 
# Contact:  zak.clifford[at]cognisys.co.uk
# Version 1.0
# Created: 01 Apr 2022
# Updated: N/A
# Description: Checks the default policy and checks whether the plugin is enabled
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

 Get-OwaMailboxPolicy -Identity OwaMailboxPolicy-Default | select Name,ReportJunkEmailEnabled

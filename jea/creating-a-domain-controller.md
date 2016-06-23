---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet,jea
ms.date:  2016-06-22
title:  creating a domain controller
ms.technology:  powershell
---

### Creating a Domain Controller

This document assumes that your machine is domain joined.
If you currently don't have a domain to join, this section can help you quickly stand up a domain controller using DSC.

#### Prerequisites

1.	The machine is on an internal network
2.	The machine is not joined to an existing domain
3.	The machine is running Windows Server 2016 or has WMF 5.0 installed

#### Install xActiveDirectory
If your machine has an active internet connection, run the following command in an elevated PowerShell window:
```PowerShell
Install-Module xActiveDirectory -Force
```
If you do not have an internet connection, install xActiveDirectory to another machine and then copy the xActiveDirectory folder to the "C:\Program Files\WindowsPowerShell\Modules" folder on your machine.

To confirm the installation succeeded, run the following command:
```PowerShell
Get-Module xActiveDirectory -ListAvailable
```

#### Set up a domain with DSC
Copy the following script in PowerShell to make your machine a Domain Controller in a new domain.
**AUTHOR'S NOTE: THERE IS A KNOWN ISSUE WITH THE CREDENTIALS PROVIDED NOT BEING USED.  TO BE SAFE, DON'T FORGET YOUR LOCAL ADMIN PASSWORD.**

```PowerShell
Set-Item WSMan:\localhost\Client\TrustedHosts -Value $env:COMPUTERNAME -Force

# This "MetaConfiguration" sets the DSC Engine to automatically reboot if required
[DscLocalConfigurationManager()]
Configuration MetaConfiguration
{
    Node $env:Computername
    {
        Settings
        {
            RebootNodeIfNeeded = $true
        }
    }

}

MetaConfiguration
# Apply the MetaConfiguration
Set-DscLocalConfigurationManager .\MetaConfiguration

# Configure a domain controller of a new "Contoso" domain
configuration DomainController
{
    param
    (
        $node,
        $cred
    )
    Import-DscResource -ModuleName xActiveDirectory

    Node $node
    {
        WindowsFeature ADDS
        {
            Ensure = 'Present'
            Name = 'AD-Domain-Services'
        }

        xADDomain Contoso
        {
            DomainName = 'contoso.com'
            DomainAdministratorCredential = $cred
            SafemodeAdministratorPassword = $cred
            DependsOn = '[WindowsFeature]ADDS'
        }

        file temp
        {
            DestinationPath = 'C:\temp.txt'
            Contents = 'Domain has been created'
            DependsOn = '[xADDomain]Contoso'
        }
    }
}

$ConfigData = @{
    AllNodes = @(
        @{
            NodeName = $env:Computername
            PSDscAllowPlainTextPassword = $true
        }
    )
}

# Enter your desired password for the domain administrator (note, this will be stored as plain text)
DomainController -cred (Get-Credential -Message "Enter desired credential for domain administrator") -node $env:Computername -configurationData $ConfigData

# Apply the configuration to create the domain controller
Start-DSCConfiguration -path .\DomainController -ComputerName $env:Computername -Wait -Force -Verbose
```
Your machine will restart a few times.
You will know the process is complete once you see a file called "C:\temp.txt" containing "Domain has been created."

#### Set up Users and Groups
The following commands will set up an Operator and Helpdesk group in your domain and a corresponding non-administrator user who is a member of that group.
```PowerShell
# Make Groups
$NonAdminOperatorGroup = New-ADGroup -Name "JEA_NonAdmin_Operator" -GroupScope DomainLocal -PassThru
$NonAdminHelpDeskGroup = New-ADGroup -Name "JEA_NonAdmin_HelpDesk" -GroupScope DomainLocal -PassThru
$TestGroup = New-ADGroup -Name "Test_Group" -GroupScope DomainLocal -PassThru

# Make Users
$OperatorUser = New-ADUser -Name "OperatorUser" -AccountPassword (ConvertTo-SecureString "pa`$`$w0rd" -AsPlainText -Force) -PassThru
Enable-ADAccount -Identity $OperatorUser

$HelpDeskUser = New-ADUser -name "HelpDeskUser" -AccountPassword (ConvertTo-SecureString "pa`$`$w0rd" -AsPlainText -Force) -PassThru
Enable-ADAccount -Identity $HelpDeskUser

# Add Users to Groups
Add-ADGroupMember -Identity $NonAdminOperatorGroup -Members $OperatorUser
Add-ADGroupMember -Identity $NonAdminHelpDeskGroup -Members $HelpDeskUser
```


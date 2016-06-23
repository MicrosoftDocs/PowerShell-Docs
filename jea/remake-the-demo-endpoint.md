---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet,jea
ms.date:  2016-06-22
title:  remake the demo endpoint
ms.technology:  powershell
---

# Remake the Demo Endpoint
In this section, you will learn how to generate an exact replica of the demo endpoint you used in the above section.
This will introduce core concepts that are necessary to understand JEA, including PowerShell Session Configurations and Role Capabilities.

## PowerShell Session Configurations
When you used JEA in the above section, you started by running the following command:

```PowerShell
Enter-PSSession -ComputerName . -ConfigurationName JEA_Demo -Credential $NonAdminCred
```

While most of the parameters are self-explanatory, the *ConfigurationName* parameter may seem confusing at first.
That parameter specified the PowerShell Session Configuration to which you were connecting.

*PowerShell Session Configuration* is a fancy term for a PowerShell endpoint.
It is the figurative "place" where users connect and get access to PowerShell functionality.
Based on how you set up a Session Configuration, it can provide different functionality to connecting users.
For JEA, we use Session Configurations to restrict PowerShell to a limited set of functionality and to run as a privileged virtual account.

You already have several registered PowerShell Session Configurations on your machine, each set up slightly differently.
Most of them come with Windows, but the "JEA_Demo" Session Configuration was set up in the [prerequisites](prerequisites.md) section.
You can see all registered Session Configurations by running the following command in an Administrator PowerShell prompt:

```PowerShell
Get-PSSessionConfiguration
```

## PowerShell Session Configuration Files
You can make new Session Configurations by registering new *PowerShell Session Configuration Files*.
Session Configuration Files have ".pssc" file extensions.
You can generate Session Configuration Files with the New-PSSessionConfigurationFile cmdlet.

Next, you are going to create and register a new Session Configuration for JEA.

## Generate and Modify your PowerShell Session Configuration
Run the following command to generate a PowerShell Session Configuration "skeleton" file.

```PowerShell
New-PSSessionConfigurationFile -Path "$env:ProgramData\JEAConfiguration\JEADemo2.pssc"
```

> **TIP:** Only the most common configuration settings are included in the skeleton file by default.
> Use the `-Full` parameter to include all applicable settings in the generated PSSC.

Open the file in PowerShell ISE, or your favorite text editor.

```PowerShell
ise "$env:ProgramData\JEAConfiguration\JEADemo2.pssc"
```

Update the following fields in the file with the values below (remember to substitue in your own non-administrator security group):

```PowerShell
# OLD: SessionType = 'Default'
SessionType = 'RestrictedRemoteServer'

# OLD: TranscriptDirectory = 'C:\Transcripts\'
TranscriptDirectory = "C:\ProgramData\JEAConfiguration\Transcripts"

# OLD: # RunAsVirtualAccount = $true
RunAsVirtualAccount = $true

# OLD: RoleDefinitions = @{ 'CONTOSO\SqlAdmins' = @{ RoleCapabilities = 'SqlAdministration' }; 'CONTOSO\ServerMonitors' = @{ VisibleCmdlets = 'Get-Process' } }
RoleDefinitions = @{'CONTOSO\JEA_NonAdmin_Operator' = @{ RoleCapabilities =  'Maintenance' }}
```

Here is what each of those entries mean:

1.	The *SessionType* field defines preset default settings to use with this endpoint.
*RestrictedRemoteServer* defines the minimal settings necessary for remote management.
By default, a *RestrictedRemoteServer* endpoint will expose Get-Command, Get-FormatData, Select-Object, Get-Help, Measure-Object, Exit-PSSession, Clear-Host, and Out-Default.
It will set the *ExecutionPolicy* to *RemoteSigned*, and the *LanguageMode* to *NoLanguage*.
The net effect of these settings is a secure and minimal starting point for configuring your endpoint.

2.	The *RoleDefinitions* field assigns Role Capabilities to specific groups.
It defines who can do what as a privileged account.
With this field, you can specify the functionality available to any connecting user based on group membership.
This is the core of JEA's RBAC functionality.
In this example, you are exposing the pre-made "Demo" RoleCapability to members of the "Contoso\JEA_NonAdmin_Operator" group.

3.	The *RunAsVirtualAccount* field indicates that PowerShell should "run as" a Virtual Account at this endpoint.
By default, the Virtual Account is a member of the built in Administrators group.
On a domain controller, it is also a member of the Domain Administrators group by default.
Later in this guide, you will learn how to customize the privileges of the Virtual Account.

4.	The *TranscriptDirectory* field defines where "over-the-shoulder" PowerShell transcripts are saved after each remote session.
These transcripts allow you to inspect the actions taken in each session in a readable way.
For more information about PowerShell transcripts, check out this [blog post](http://blogs.msdn.com/b/powershell/archive/2015/06/09/powershell-the-blue-team.aspx).
Note: regular Windows Eventing also captures information about what each user ran with PowerShell.
Transcripts are just a bit more readable.

Finally, save your changes to *JEADemo2.pssc*.

## Apply the PowerShell Session Configuration

To create an endpoint from a Session Configuration file, you need to register the file.
This requires a few pieces of information:

1. The path to the Session Configuration file.
2. The name of your registered Session Configuration. This is the same name users provide to the "ConfigurationName" parameter when they connect to your endpoint with `Enter-PSSession` or `New-PSSession`.

To register the Session Configuration on your local machine, run the following command:

```PowerShell
Register-PSSessionConfiguration -Name 'JEADemo2' -Path "$env:ProgramData\JEAConfiguration\JEADemo2.pssc"
```

Congratulations! You have set up your JEA endpoint.

## Test Out Your Endpoint
Re-run the steps listed in the [Using JEA](using-jea.md) section against your new endpoint to confirm it is operating as intended.
Be sure to use the new endpoint name (JEADemo2) when providing the configuration name to Enter-PSSession.

```PowerShell
Enter-PSSession -ComputerName . -ConfigurationName JEADemo2 -Credential $NonAdminCred
```

## Key Concepts
**PowerShell Session Configuration**:
Sometimes referred to as *PowerShell Endpoint*, this is the figurative "place" where users connect and get access to PowerShell functionality.
You can list the registered Session Configurations on your system by running `Get-PSSessionConfiguration`.
When configured in a specific way, a PowerShell Session Configuration can be called a *JEA Endpoint*.

**PowerShell Session Configuration File (.pssc)**:
A file that, when registered, defines settings for a PowerShell Session Configuration.
It contains specifications for user roles that can connect to the endpoint, the "run as" Virtual Account, and more.     

**Role Definitions**:
The field in a Session Configuration File that defines the Role Capabilities granted to connecting users.
It defines *who* can do *what* as a privileged account.
This is the core of JEA's RBAC capabilities.

**SessionType**:
A field in a Session Configuration File that represents default settings for a Session Configuration.
For JEA endpoints, this must be set to RestrictedRemoteServer.

**PowerShell Transcript**:
A file containing an "over-the-shoulder" view of a PowerShell session.
You can set PowerShell to generate transcripts for JEA sessions using the TranscriptDirectory field.
For more information on transcripts, check out this [blog post](https://technet.microsoft.com/en-us/magazine/ff687007.aspx).


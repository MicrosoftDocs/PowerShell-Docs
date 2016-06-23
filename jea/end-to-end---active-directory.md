---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet,jea
ms.date:  2016-06-22
title:  end to end   active directory
ms.technology:  powershell
---

# End to End - Active Directory
Imagine the scope of your program has increased.
You are now responsible for adding JEA to Domain Controllers to perform Active Directory actions.
The help desk people are going to use JEA to unlock accounts, reset passwords, and do other similar actions.

You need to expose a completely new set of commands to a different group of people.
On top of that, you have a bunch of existing Active Directory scripts you need to expose.
This section will walk through authoring a Session Configuration and Role Capability for this task.

## Prerequisites
To follow this section step-by-step, you'll need to be operating on a domain controller.
If you don't have access to your domain controller, don't worry.
Try to follow along with by working against some other scenario or role with which you are familiar.
If you want to quickly set up a new domain controller, check out the [Creating a Domain Controller appendix](#creating-a-domain-controller).

## Steps to Make a new Role Capability and Session Configuration

Making a new role capability can seem daunting at first, but it can be broken into fairly simple steps:

1.	Identify the tasks you need to enable
2.	Restrict those tasks as necessary
3.	Confirm they work with JEA
4.	Put them in a Role Capability file
5.	Register a Session Configuration that exposes that Role Capability

## Step 1: Identify What Needs to Be Exposed
Before you make a new Role Capability or Session Configuration, you need to identify all of the things users will need to do through the JEA endpoint, as well as how to do them through PowerShell.
This will involve a fair amount of requirement gathering and research.
How you go about this process will depend on your organization and goals.
It is important to call out requirement gathering and research as a critical part of the real world process.
This may be the most difficult step in the process of adopting JEA.

### Find Resources
Here is a set of online resources that might have come up in your research on creating an Active Directory management endpoint:
-	[Active Directory PowerShell Overview](http://blogs.msdn.com/b/adpowershell/archive/2009/03/05/active-directory-powershell-overview.aspx)
-	[CMD to PowerShell Guide for Active Directory](http://blogs.technet.com/b/ashleymcglone/archive/2013/01/02/free-download-cmd-to-powershell-guide-for-ad.aspx)

### Make a List
Here is a set of ten actions that you will be working from in the remainder of this section.
Keep in mind this is simply an example, your organizations requirements may be different:

|Action                                                         |PowerShell Command                                             |
|---------------------------------------------------------------|---------------------------------------------------------------|
|Account Unlock                                                 |`Unlock-ADAccount`                                             |
|Password Reset                                                 |`Set-ADAccountPassword` and `Set-ADUser -ChangePasswordAtLogon`|
|Change a User's Title                                          |`Set-ADUser -Title`                                            |  
|Find AD Accounts that are locked out, disabled, inactive, etc. |`Search-ADAccount`                                             |
|Add User to Group                                              |`Add-ADGroupMember -Identity (with whitelist) -Members`        |
|Remove User from Group                                         |`Remove-ADGroupMember -Identity (with whitelist) -Members`     |
|Enable a user account                                          |`Enable-ADAccount`                                             |
|Disable a user account                                         |`Disable-ADAccount`                                            |

## Step 2: Restrict Tasks as Necessary

Now that you have your list of actions, you need to think through the capabilities of each command.
There are two important reasons to do this:

1.	It is easy to expose give users more capabilities than you intend.
For example, `Set-ADUser` is an incredibly powerful and flexible command.
You may not want to expose everything it can do to help desk users.  

2.	Even worse, it's possible to expose commands that allow users to escape JEA's restrictions.
If this happens, JEA ceases to function as a security boundary.
Please be careful when selecting commands.
For example, Invoke-Expression will allow users to run unrestricted code.
For more discussion on this topic, check out the Considerations When Restricting Commands section.

After reviewing each command, you decide to restrict the following:

1.	`Set-ADUser` should only be allowed to run with the "-Title" parameter

2.	`Add-ADGroupMember` and `Remove-ADGroupMember` should only work with certain groups

### Step 3: Confirm the Tasks Work with JEA
Actually using those cmdlets may not be straightforward in the restricted JEA environment.
JEA runs in *No Language* mode which, among other things, prevents users from using variables.
In order to ensure that end users have a smooth experience, it's important to check for a few things.

As an example, consider `Set-ADAccountPassword`.
The "-NewPassword" parameter requires a secure string.
Often, users create a secure string and pass it in as a variable (as below):

```PowerShell
$newPassword = (Read-Host -Prompt "Specify a new password" -AsSecureString)
Set-ADAccountPassword -Identity mollyd -NewPassword $newPassword -Reset
```

However, No Language mode prevents the usage of variables.
You can get around this restriction in two ways:

1.	You can require users run the command without assigning variables.
This is easy to configure, but can be painful for the operators using the endpoint.
Who wants to type this out every time you reset a password?
```PowerShell
Set-ADAccountPassword -Identity mollyd -NewPassword (Read-Host -Prompt "Specify a new password" -AsSecureString) -Reset
```

2.	You can wrap the complexity in a script or a function that you expose to end users.
Scripts and functions that you expose run in an unrestricted context; you can write functions that use variables and call other commands without any issue.
This approach simplifies the end user experience, prevents errors, reduces required PowerShell knowledge, and reduces unintentionally exposing excess functionality.
The only downside is the cost of authoring and maintaining the function.

### Aside: Adding a Function to your Module
Taking approach #2, you are going to write a PowerShell function called `Reset-ContosoUserPassword`.
This function is going to do everything that needs to happen when you reset a user's password.
In your organization, this may involve doing fancy and complicated things.
Because this is just an example, your command will just reset the password and require the user change the password at logon.
We will put it in the Contoso_AD_Module module you made in the last section.

1. In PowerShell ISE, open "Contoso_AD_Module.psm1"
```PowerShell
ISE 'C:\Program Files\WindowsPowerShell\Modules\Contoso_AD_Module\Contoso_AD_Module.psm1'
```

2. Press Crtl+J to open the snippets menu.

3. Key down until you find "function" and press enter.
This puts up a super basic skeleton of a function.

4. Rename the function "Reset-ContosoUserPassword".  

5. Rename one of the parameters "Identity" and delete the second.

6. Copy the following into the body of the function.
```PowerShell
# Get the new password
$NewPassword = Read-Host -Prompt "Enter a new password" -AsSecureString
# Reset the password
Set-ADAccountPassword -Identity $Identity -NewPassword $NewPassword -Reset
# Require the user to reset at next logon
Set-ADUser -Identity $Identity -ChangePasswordAtLogon
```

7. Save the file.
You should end up with something that looks like this:
```PowerShell
function Reset-ContosoUserPassword ($Identity)
{
# Get the new password
$NewPassword = Read-Host -Prompt "Enter a new password" -AsSecureString
# Reset the password
Set-ADAccountPassword -Identity $Identity -NewPassword $NewPassword -Reset
# Require the user to reset at next logon
Set-ADUser -Identity $Identity -ChangePasswordAtLogon
}
```
Now, your users can simply call `Reset-ContosoUserPassword` and not have to remember the syntax to create a secure string inline.

## Step 4: Edit the Role Capability File
In the [Role Capability Creation](#role-capability-creation) section, you created a blank Role Capability file.
In this section, you will fill in the values in that file.

Start by opening the role capability file in ISE.
```PowerShell
ise 'C:\Program Files\WindowsPowerShell\Modules\Contoso_AD_Module\RoleCapabilities\ADHelpDesk.psrc'
```
Update the file with the following changes:
```PowerShell
# OLD: VisibleCmdlets = 'Invoke-Cmdlet1', @{ Name = 'Invoke-Cmdlet2'; Parameters = @{ Name = 'Parameter1'; ValidateSet = 'Item1', 'Item2' }, @{ Name = 'Parameter2'; ValidatePattern = 'L*' } }
VisibleCmdlets =
    'Unlock-ADAccount',
    'Search-ADAccount',
    'Enable-ADAccount',
    'Disable-ADAccount',
    @{ Name = 'Set-ADUser'; Parameters = @{ Name = 'Title'; ValidateSet = 'Manager', 'Engineer' }},
    @{ Name = 'Add-ADGroupMember'; Parameters =
        @{Name = 'Identity'; ValidateSet = 'TestGroup'},
        @{Name = 'Members'}},
    @{ Name = 'Remove-ADGroupMember'; Parameters =
        @{Name = 'Identity'; ValidateSet = 'TestGroup'},
        @{Name = 'Members'}}

# OLD: VisibleFunctions = 'Invoke-Function1', @{ Name = 'Invoke-Function2'; Parameters = @{ Name = 'Parameter1'; ValidateSet = 'Item1', 'Item2' }, @{ Name = 'Parameter2'; ValidatePattern = 'L*' } }
VisibleFunctions = 'Reset-ContosoUserPassword'
```

There are a few things to note about the above:
1.	PowerShell will attempt to auto-load the modules needed for your Role Capability.
You may need to explicitly list module names in the "ModulesToImport" field if you notice problems with a module not being autoloaded.

2.	If you aren't sure if a command is a cmdlet or a function, run `Get-Command` and look at the "CommandType"

3.	The ValidatePattern allows you to use a regular expression to restrict parameter arguments if it is not easy to define a set of allowable values.
You cannot define both a ValidatePattern and ValidateSet for a single parameter.

## Step 5: Register a new Session Configuration
Next, you will create a new session configuration file that will expose your Role Capability to members of the "JEA_NonAdmin_HelpDesk" AD group.

Start by creating and opening a new blank Session Configuration file in PowerShell ISE.
```PowerShell
New-PSSessionConfigurationFile -Path "$env:ProgramData\JEAConfiguration\HelpDeskDemo.pssc"
ise "$env:ProgramData\JEAConfiguration\HelpDeskDemo.pssc"
```
Modify the following fields in the PSSC file.
If you are working in your own environment, you should replace "CONTOSO\JEA_NonAdmins_Helpdesk" with your own non-administrator user or group.
```PowerShell
# OLD: Description = ''
Description = 'An endpoint for active directory tasks.'

# OLD: SessionType = 'Default'
SessionType = 'RestrictedRemoteServer'

# OLD: TranscriptDirectory = 'C:\Transcripts\'
TranscriptDirectory = "C:\ProgramData\JEAConfiguration\Transcripts"

# OLD: RunAsVirtualAccount = $true
RunAsVirtualAccount = $true

# OLD: RoleDefinitions = @{ 'CONTOSO\SqlAdmins' = @{ RoleCapabilities = 'SqlAdministration' }; 'CONTOSO\ServerMonitors' = @{ VisibleCmdlets = 'Get-Process' } }
RoleDefinitions = @{ 'CONTOSO\JEA_NonAdmin_HelpDesk' = @{ RoleCapabilities =  'ADHelpDesk' }}
```
Save and register the Session Configuration
```PowerShell
Register-PSSessionConfiguration -Name ADHelpDesk -Path "$env:ProgramData\JEAConfiguration\HelpDeskDemo.pssc"
```
## Test It Out!
Get your non-administrator user credentials:
```PowerShell
$HelpDeskCred = Get-Credential
```
If you followed the [Set Up Users and Groups](creating-a-domain-controller.md#set-up-users-and-groups) section, the credentials will be:
-	Username = "HelpDeskUser"
-	Password = "pa$$w0rd"

Remote into the AD Helpdesk endpoint using the non-admin credential:
```PowerShell
Enter-PSSession -ComputerName . -ConfigurationName ADHelpDesk -Credential $HelpDeskCred
```
Use Set-ADUser to reset a user's title.
```PowerShell
Set-ADUser -Identity OperatorUser -Title Engineer
```
Verify that the title has changed.
```PowerShell
Get-ADUser -Identity OperatorUser -Property Title
```
Now, use Add-ADGroupMember to add a user to the TestGroup.
Note: make sure you've created the TestGroup beforehand.
```PowerShell
Add-ADGroupMember TestGroup -Member OperatorUser -Verbose
```
Exit the session:
```PowerShell
Exit-PSSession
```
## Key Concepts
**NoLanguage Mode**:
When PowerShell is in "NoLanguage" mode, users may only run commands; they cannot use any language elements.
For more information, run `Get-Help about_Language_Modes`.

**PowerShell Functions**:
PowerShell functions are bits of PowerShell code that you can call by name.
For more information, run `Get-Help about_Functions`.

**ValidateSet/ValidatePattern**:
When exposing a command, you can restrict valid arguments for specific parameters.
A ValidateSet is a specific list of valid commands.
A ValidatePattern is a regular expression that the arguments for that parameter must match.


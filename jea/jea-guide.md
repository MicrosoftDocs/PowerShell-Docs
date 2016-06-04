# Just Enough Administration (JEA): An Introduction

## Table of Contents
After reading this document, you should be able to author, deploy, use, maintain, and audit a Just Enough Administration (JEA) deployment.
Here are the topics covered in this introductory guide:

1.	[Introduction](#introduction): Briefly review why you should care about JEA

2.	[Prerequisites](#prerequisites): Set up your environment

3.	[Using JEA](#using-jea): Start by understanding the operator experience of using JEA

4.	[Remake the Demo](#remake-the-demo-endpoint): Create a JEA Session Configuration from scratch

5.	[Role Capabilities](#role-capabilities): Learn about how to customize JEA capabilities with Role Capability Files

6.	[End to End - Active Directory](#end-to-end---active-directory): Make a whole new endpoint for managing Active Directory

7.	[Multi-machine Deployment and Maintenance](#multi-machine-deployment-and-maintenance): Discover how deployment and authoring changes with scale

8.	[Reporting on JEA](#reporting-on-jea): Discover how to audit and report on all JEA actions and infrastructure

9.	[Appendix](#appendix): Important skills and discussion points

## Introduction

### Motivation
When you grant someone privileged access to your systems, you extend your trust boundary to that person.
This is a risk -- administrators are an attack surface.
Insider attacks and stolen credentials are both real and common.

This is not a new problem.
You are probably very familiar with the principle of least privilege, and you might use some form of role based access control (RBAC) with applications that provide it.
However, the effectiveness and manageability of these solutions are often limited by their broad scope and imprecision.
Furthermore, there are gaps in RBAC coverage.
For example, in Windows, privileged access is largely a binary switch, forcing you to give unnecessary permissions when adding users to the Administrators group.

Just Enough Administration (JEA) provides a RBAC platform through PowerShell Remoting.
*It allows specific users to perform specific administrative tasks on servers without giving them administrator rights.*
This allows you to fill in the gaps between your existing RBAC solutions, and simplifies management of those settings.

## Prerequisites

### Initial State
Before starting this section, please ensure the following:

1. JEA is available on your system. Check out the [README](./README.md) for the current supported operating systems and required downloads.
2. You have administrative rights on the computer where you are trying out JEA.
3. The computer is domain joined.
See the [Creating a Domain Controller](#creating-a-domain-controller) section to quickly set up a new domain on a server if you don't already have one.

### Enable PowerShell Remoting
Management with JEA occurs through PowerShell Remoting.
Run the following in an Administrator PowerShell window to ensure that this is enabled and configured properly:

```PowerShell
Enable-PSRemoting 
```

If you are unfamiliar with PowerShell remoting, it would be a good idea to run `Get-Help about_Remote` to learn about this important foundational concept.

### Identify Your Users or Groups
To show JEA in action, you need to identify the non-administrator users and groups you are going to use throughout this guide.
  
If you're using an existing domain, please identify or create some unprivileged users and groups.
You will give these non-administrators access to JEA.
Anytime you see the `$NonAdministrator` variable in a top of a script, assign it to your selected non-administrator users or groups. 

If you created a new domain from scratch, it's much easier.
Please use the [Set Up Users and Groups](#set-up-users-and-groups) section in the appendix to create a non-administrator users and groups.
The default values of `$NonAdministrator` will be the groups created in that section.

### Set Up Maintenance Role Capability File
Run the following commands in PowerShell to create the demo Role Capability file we will be using for the next section.
Later in this guide, you will learn about what this file does.

```PowerShell
# Fields in the role capability
$MaintenanceRoleCapabilityCreationParams = @{
    Author = 'Contoso Admin'
    CompanyName = 'Contoso'
    VisibleCmdlets = 'Restart-Service'
    FunctionDefinitions = 
            @{ Name = 'Get-UserInfo'; ScriptBlock = { $PSSenderInfo } }
}

# Create the demo module, which will contain the maintenance Role Capability File
New-Item -Path "$env:ProgramFiles\WindowsPowerShell\Modules\Demo_Module" -ItemType Directory
New-ModuleManifest -Path "$env:ProgramFiles\WindowsPowerShell\Modules\Demo_Module\Demo_Module.psd1"
New-Item -Path "$env:ProgramFiles\WindowsPowerShell\Modules\Demo_Module\RoleCapabilities" -ItemType Directory 

# Create the Role Capability file
New-PSRoleCapabilityFile -Path "$env:ProgramFiles\WindowsPowerShell\Modules\Demo_Module\RoleCapabilities\Maintenance.psrc" @MaintenanceRoleCapabilityCreationParams 
```
  
### Create and Register Demo Session Configuration File
Run the following commands to create and register the demo Session Configuration file we will be using for the next section.
Later in this guide, you will learn about what this file does.

```PowerShell
# Determine domain
$domain = (Get-CimInstance -ClassName Win32_ComputerSystem).Domain

# Replace with your non-admin group name
$NonAdministrator = "$domain\JEA_NonAdmin_Operator"

# Specify the settings for this JEA endpoint
# Note: You will not be able to use a virtual account if you are using WMF 5.0 on Windows 7 or Windows Server 2008 R2
$JEAConfigParams = @{
    SessionType = 'RestrictedRemoteServer'
    RunAsVirtualAccount = $true
    RoleDefinitions = @{
        $NonAdministrator = @{ RoleCapabilities = 'Maintenance' }
    }
    TranscriptDirectory = "$env:ProgramData\JEAConfiguration\Transcripts"
}

# Set up a folder for the Session Configuration files
if (-not (Test-Path "$env:ProgramData\JEAConfiguration"))
{
    New-Item -Path "$env:ProgramData\JEAConfiguration" -ItemType Directory
}

# Specify the name of the JEA endpoint
$sessionName = 'JEA_Demo'

if (Get-PSSessionConfiguration -Name $sessionName -ErrorAction SilentlyContinue)
{
    Unregister-PSSessionConfiguration -Name $sessionName -ErrorAction Stop
}

New-PSSessionConfigurationFile -Path "$env:ProgramData\JEAConfiguration\JEADemo.pssc" @JEAConfigParams

# Register the session configuration
Register-PSSessionConfiguration -Name $sessionName -Path "$env:ProgramData\JEAConfiguration\JEADemo.pssc"
```
 
### Enable PowerShell Module Logging (Optional)
The following steps enable logging for all PowerShell actions on your system.
You don't need to enable this for JEA to work, but it will be useful in the [Reporting on JEA](#reporting-on-jea) section.

1. Open the Local Group Policy Editor
2. Navigate to "Computer Configuration\Administrative Templates\Windows Components\Windows PowerShell"
3. Double Click on "Turn on Module Logging"
4. Click "Enabled"
5. In the Options section, click on "Show" next to Module Names
6. Type "*" in the pop up window. This means PowerShell will log commands from all modules.
7. Click OK and apply the policy

Note: you can also enable system-wide PowerShell transcription through Group Policy.

**Congratulations, you have now configured your computer with the demo endpoint and are ready to get started with JEA!**

## Using JEA
This section focuses on understanding the end user experience of *using JEA*.
In the prerequisites section, you created a demo JEA endpoint.
We will use this demo to show JEA in action.
In later sections, the guide will work backwards -- introducing the actions and files that made that end-user experience possible.

### Using JEA as a Non-Administrator
To show JEA in action, you will need to use PowerShell remoting as though you were a non-administrator user.
Run the following command in a new PowerShell window:   

```PowerShell
$NonAdminCred = Get-Credential
```

Enter the credentials for your non-administrator account when prompted.
If you followed the [Set Up Users and Groups](#set-up-users-and-groups) section, they will be:
-	Username = "OperatorUser"
-	Password = "pa$$w0rd"

Next, run the following command to connect to the demo endpoint using the credentials you provided:

```PowerShell
Enter-PSSession -ComputerName . -ConfigurationName JEA_Demo -Credential $NonAdminCred 
```

You have now entered an interactive remote PowerShell session on the local machine. 
By using the "Credential" parameter, you have connected *as though you were* OperatorUser (or whichever account you used).
The change in the prompt to `[localhost]: PS>` indicates that you are operating against a remote session.  

Run the following in your remote command prompt to show the commands available to you:

```PowerShell
Get-Command 
```

As you can tell, this is a very limited subset of the commands available in a normal PowerShell window (which can often include several thousand commands).
Specifically, it only shows the 7 default JEA cmdlets (Clear-Host, Exit-PSSession, Get-Command, Get-FormatData, Get-Help, Measure-Object, Out-Default, Select-Object) and the two commands explicitly included in the maintenance Role Capability file.

Next, let's take a look at the user context this session is operating under by invoking the custom function included in the maintenance Role Capability file:

```PowerShell
Get-UserInfo
```
 
The output of this function shows the "ConnectedUser" as well as the "RunAsUser."
The connected user is the account that connected to the remote session (e.g. your account).
The connected user does not need to have administrator privileges.
The "Run As" account is the account actually performing the privileged actions.
By connecting as one user, and running as a privileged user, we allow non-privileged users to preform specific administrative tasks without giving them administrative rights.

To demonstrate this in action, run the following command:

```PowerShell
Restart-Service -Name Spooler -Verbose
```

Normally, Restart-Service requires administrator privileges to be run.
With the JEA virtual account, however, we're able to run it using non-privileged credentials.

So, JEA lets you get your job done using the commands you already use.
But what about commands you *shouldn't* be allowed to use?
Try running a different command in the JEA session, like `Restart-Computer`, and notice that JEA prevents such commands from being executed.

```PowerShell
[localhost]: PS> Restart-Computer
The term 'Restart-Computer' is not recognized as the name of a cmdlet, function, script file, or
operable program. Check the spelling of the name, or if a path was included, verify that the path
is correct and try again.
    + CategoryInfo          : ObjectNotFound: (Restart-Computer:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException 
```

Finally, to leave the constrained JEA endpoint, run the following command:

```PowerShell
Exit-PSSession
```

This disconnects you from the remote PowerShell session.

## Remake the Demo Endpoint
In this section, you will learn how to generate an exact replica of the demo endpoint you used in the above section.
This will introduce core concepts that are necessary to understand JEA, including PowerShell Session Configurations and Role Capabilities. 

### PowerShell Session Configurations
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
Most of them come with Windows, but the "JEA_Demo" Session Configuration was set up in the [prerequisites](#prerequisites) section.
You can see all registered Session Configurations by running the following command in an Administrator PowerShell prompt:

```PowerShell
Get-PSSessionConfiguration
```

### PowerShell Session Configuration Files
You can make new Session Configurations by registering new *PowerShell Session Configuration Files*.
Session Configuration Files have ".pssc" file extensions.
You can generate Session Configuration Files with the New-PSSessionConfigurationFile cmdlet.

Next, you are going to create and register a new Session Configuration for JEA. 

### Generate and Modify your PowerShell Session Configuration
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

### Apply the PowerShell Session Configuration 

To create an endpoint from a Session Configuration file, you need to register the file.
This requires a few pieces of information:

1. The path to the Session Configuration file.
2. The name of your registered Session Configuration. This is the same name users provide to the "ConfigurationName" parameter when they connect to your endpoint with `Enter-PSSession` or `New-PSSession`.

To register the Session Configuration on your local machine, run the following command:

```PowerShell
Register-PSSessionConfiguration -Name 'JEADemo2' -Path "$env:ProgramData\JEAConfiguration\JEADemo2.pssc"
```

Congratulations! You have set up your JEA endpoint.

### Test Out Your Endpoint
Re-run the steps listed in the [Using JEA](#using-jea) section against your new endpoint to confirm it is operating as intended.
Be sure to use the new endpoint name (JEADemo2) when providing the configuration name to Enter-PSSession.

```PowerShell
Enter-PSSession -ComputerName . -ConfigurationName JEADemo2 -Credential $NonAdminCred
```

### Key Concepts
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

## Role Capabilities

### Overview
In the above section, you learned that the "RoleDefinitions" field defined which groups had access to which Role Capabilities.
You may have wondered, "What are Role Capabilities?"
This section will answer that question.  

## Introducing PowerShell Role Capabilities
PowerShell Role Capabilities define "what" a user can do at a JEA endpoint.
They detail a whitelist of things like visible commands, visible applications, and more.
Role Capabilities are defined by files with a ".psrc" extension.

## Role Capability Contents
We will start by examining and modifying the demo Role Capability file you used before.
Imagine you have deployed your Session Configuration across your environment, but you have gotten feedback that you need to change the capabilities exposed to users.
Operators need the ability to restart machines, and they also want to be able to get information about network settings.
In addition, the security team has told you that allowing users to run "Restart-Service" without any restrictions is not acceptable.
You need to restrict the services that operators can restart.

To make these changes, start by running PowerShell ISE as an Administrator and open the following file:

```
C:\Program Files\WindowsPowerShell\Modules\Demo_Module\RoleCapabilities\Maintenance.psrc
```

Now find and update the following lines in the file: 

```PowerShell
# OLD: VisibleCmdlets = 'Restart-Service'
VisibleCmdlets = 'Restart-Computer',
                 @{
                     Name = 'Restart-Service'
                     Parameters = @{ Name = 'Name'; ValidateSet = 'Spooler' }
                 },
                 'NetTCPIP\Get-*'

# OLD: VisibleExternalCommands = 'Item1', 'Item2'
VisibleExternalCommands = 'C:\Windows\system32\ipconfig.exe'
```

This contains a few interesting examples:

1.	You have restricted Restart-Service such that operators will only be able to use Restart-Service with the -Name parameter, and they will only be allowed to provide "Spooler" as an argument to that parameter.
If you wanted to, you could also restrict the arguments using a regular expression using "ValidatePattern" instead of "ValidateSet".

2.	You have exposed all commands with the "Get" verb from the NetTCPIP module.
Because "Get" commands typically don't change system state, this is a relatively safe action.
That being said, it is strongly encouraged to closely examinine every command you expose through JEA.

3.	You have expose an executable (ipconfig) using VisibleExternalCommands.
You can also expose full PowerShell scripts with this field.
It is important to always provide the full path to external commands to ensure a similarly named (and potentially malicous) program placed in the user's path does not get executed instead.

Save the file, then connect to the demo endpoint again to confirm the changes worked.

```PowerShell
Enter-PSSession -ComputerName . -ConfigurationName JEADemo2 -Credential $NonAdminCred
Get-Command
```
Because you only modified the Role Capability file, you do not need to re-register the Session Configuration.
PowerShell will automatically find your updated Role Capability when a user connects.
Since Role Capabilities are loaded when the session starts, existing sessions are not affected by updates to Role Capability files.

Now, confirm that you can restart the computer by running Restart-Computer with the -WhatIf parameter (unless you actually want to restart the computer).

```PowerShell
Restart-Computer -WhatIf 
```

Confirm that you can run "ipconfig"

```PowerShell
ipconfig
```

And finally, confirm that Restart-Service only works for the Spooler service.

```PowerShell
Restart-Service Spooler # This should work
Restart-Service WSearch # This should fail 
```

Exit the session when you are finished.

```PowerShell
Exit-PSSession 
```

### Role Capability Creation
In the next section, you will create a JEA endpoint for AD help desk users.
To prepare, we will create a blank Role Capability file to fill in for that section.
Role Capabilities must be created inside a "RoleCapabilities" folder inside a valid PowerShell module in order to be resolved when a session starts.

PowerShell Modules are essentially packages of PowerShell functionality.
They can contain PowerShell functions, cmdlets, DSC Resources, Role Capabilities, and more.
You can find information about modules by running `Get-Help about_Modules` in a PowerShell console.

To create a new PowerShell module with a blank Role Capability file, run the following commands:  

```PowerShell
# Create a new folder for the module.
New-Item -Path 'C:\Program Files\WindowsPowerShell\Modules\Contoso_AD_Module' -ItemType Directory

# Add a module manifest to contain metadata for this module.
New-ModuleManifest -Path 'C:\Program Files\WindowsPowerShell\Modules\Contoso_AD_Module\Contoso_AD_Module.psd1' -RootModule Contoso_AD_Module.psm1

# Create a blank script module. You'll use this for custom functions in the next section.
New-Item -Path 'C:\Program Files\WindowsPowerShell\Modules\Contoso_AD_Module\Contoso_AD_Module.psm1' -ItemType File 

# Create a RoleCapabilities folder in the AD_Module folder. PowerShell expects Role Capabilities to be located in a "RoleCapabilities" folder within a module.
New-Item -Path 'C:\Program Files\WindowsPowerShell\Modules\Contoso_AD_Module\RoleCapabilities' -ItemType Directory

# Create a blank Role Capability in your RoleCapabilities folder. Running this command without any additional parameters just creates a blank template.
New-PSRoleCapabilityFile -Path 'C:\Program Files\WindowsPowerShell\Modules\Contoso_AD_Module\RoleCapabilities\ADHelpDesk.psrc' 
```

Congratulations, you have created a blank Role Capability File.
It will be used in the next section.

### Key Concepts
**Role Capability (.psrc)**:
A file that define "what" a user can do at a JEA endpoint.
It details a whitelist of things like visible commands, visible console applications, and more.
In order for PowerShell to detect Role Capabilities, you must put them in a "RoleCapabilities" folder in a valid PowerShell module.

**PowerShell Module**:
A package of PowerShell functionality.
It can contain PowerShell functions, cmdlets, DSC Resources, Role Capabilities, and more.
In order to be automatically loaded, PowerShell modules must be located under a path in `$env:PSModulePath`. 

## End to End - Active Directory
Imagine the scope of your program has increased.
You are now responsible for adding JEA to Domain Controllers to perform Active Directory actions.
The help desk people are going to use JEA to unlock accounts, reset passwords, and do other similar actions.

You need to expose a completely new set of commands to a different group of people.
On top of that, you have a bunch of existing Active Directory scripts you need to expose.
This section will walk through authoring a Session Configuration and Role Capability for this task.

### Prerequisites
To follow this section step-by-step, you'll need to be operating on a domain controller.
If you don't have access to your domain controller, don't worry.
Try to follow along with by working against some other scenario or role with which you are familiar.
If you want to quickly set up a new domain controller, check out the [Creating a Domain Controller appendix](#creating-a-domain-controller).

### Steps to Make a new Role Capability and Session Configuration

Making a new role capability can seem daunting at first, but it can be broken into fairly simple steps:

1.	Identify the tasks you need to enable
2.	Restrict those tasks as necessary
3.	Confirm they work with JEA
4.	Put them in a Role Capability file
5.	Register a Session Configuration that exposes that Role Capability

### Step 1: Identify What Needs to Be Exposed
Before you make a new Role Capability or Session Configuration, you need to identify all of the things users will need to do through the JEA endpoint, as well as how to do them through PowerShell.
This will involve a fair amount of requirement gathering and research.
How you go about this process will depend on your organization and goals.
It is important to call out requirement gathering and research as a critical part of the real world process.
This may be the most difficult step in the process of adopting JEA.

#### Find Resources
Here is a set of online resources that might have come up in your research on creating an Active Directory management endpoint:
-	[Active Directory PowerShell Overview](http://blogs.msdn.com/b/adpowershell/archive/2009/03/05/active-directory-powershell-overview.aspx) 
-	[CMD to PowerShell Guide for Active Directory](http://blogs.technet.com/b/ashleymcglone/archive/2013/01/02/free-download-cmd-to-powershell-guide-for-ad.aspx)

#### Make a List
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

### Step 2: Restrict Tasks as Necessary

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

#### Aside: Adding a Function to your Module
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

### Step 4: Edit the Role Capability File
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

### Step 5: Register a new Session Configuration
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
### Test It Out!
Get your non-administrator user credentials:
```PowerShell
$HelpDeskCred = Get-Credential
```
If you followed the Set Up Users and Groups section, the credentials will be:
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
### Key Concepts
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

## Multi-machine Deployment and Maintenance
At this point, you have deployed JEA to local systems several times.
Because your production environment probably consists of more than one machine, it's important to walk through the critical steps in the deployment process that must be repeated on each machine.

### High Level Steps:
1.	Copy your modules (with Role Capabilities) to each node.
2.	Copy your session configuration files to each node.
3.	Run `Register-PSSessionConfiguration` with your session configuration.
4.	Keep a copy of your session configuration and toolkits in a secure location.
As you make modifications, it's good to have a "single source of truth."

### Example Script
Here's an example script for deployment.
To use it in your environment, you'll have to use the names/paths of real file shares and modules.
```PowerShell
# First, copy the session configuration and modules (containing role capability files) onto a file share you have access to.
Copy-Item -Path 'C:\Demo\Demo.pssc' -Destination '\\FileShare\JEA\Demo.pssc'
Copy-Item -Path 'C:\Program Files\WindowsPowerShell\Modules\SomeModule\' -Recurse -Destination '\\FileShare\JEA\SomeModule'

# Next, author a setup script (C:\JEA\Deploy.ps1) to run on each individual node
    # Contents of C:\JEA\Deploy.ps1
    New-Item -ItemType Directory -Path C:\JEADeploy
    Copy-Item -Path '\\FileShare\JEA\Demo.pssc' -Destination 'C:\JEADeploy\'
    Copy-Item -Path '\\FileShare\JEA\SomeModule' -Recurse -Destination 'C:\Program Files\WindowsPowerShell\Modules' # Remember, Role Capability Files are found in modules
    if (Get-PSSessionConfiguration -Name JEADemo -ErrorAction SilentlyContinue)
    {
        Unregister-PSSessionConfiguration -Name JEADemo -ErrorAction Stop
    }

    Register-PSSessionConfiguration -Name JEADemo -Path 'C:\JEADeploy\Demo.pssc'
    Remove-Item -Path 'C:\JEADeploy' # Don't forget to clean up!

# Now, invoke the script on all of the target machines.
# Note: this requires PowerShell Remoting be enabled on each machine. Enabling PowerShell remoting is a requirement to use JEA as well.
# You may need to provide the "-Credential" parameter if your current user account does not have admin permissions on these machines.
Invoke-Command –ComputerName 'Node1', 'Node2', 'Node3', 'NodeN' -FilePath 'C:\JEA\Deploy.ps1'

# Finally, delete the session configuration and role capability files from the file share.
Remove-Item -Path '\\FileShare\JEA\Demo.pssc'
Remove-Item -Path '\\FileShare\JEA\SomeModule' -Recurse
```
### Modifying Capabilities
When dealing with many machines, it's important that modifications are rolled out in a consistent manner.
Once JEA has a DSC Resource, this will help ensure your environment is in sync.
Until that time, we highly recommend you keep a master copy of your session configurations and re-deploy each time you make a modification.

### Removing Capabilities
To remove your JEA configuration from your systems, use the following command on each machine:
```PowerShell
Unregister-PSSessionConfiguration -Name JEADemo 
```
## Reporting on JEA
Because JEA allows non-privileged users to run in a privileged context, logging and auditing are extremely important.
In this section, we'll run through the tools you can use to help you with logging and reporting.

### Reporting on JEA Actions
#### Over-the-Shoulder Transcription
One of the quickest ways to get a summary of what's happening in a PowerShell session is to look over the shoulder of the person typing.
You see their commands, the output of those commands, and all is well.
Or it's not, but at least you'll know.
PowerShell transcription is designed to give you a similar view after the fact.

When using the "TranscriptDirectory" field in your Session Configuration, PowerShell will automatically record a transcript of all actions taken in a given session.
You can find transcripts from your sessions in this document here: "$env:ProgramData\JEAConfiguration\Transcripts"

As you can tell, the transcript records information about the "Connected" user, the "Run As" user, the commands run in the session, and more.
For more information about PowerShell transcription, check out [this blog post](http://blogs.msdn.com/b/powershell/archive/2015/06/09/powershell-the-blue-team.aspx).

#### PowerShell Event Logs
When you have module logging turned on, all PowerShell actions are also recorded in regular Windows Event logs.
This is slightly messier to deal with when compared to transcripts, but the level of detail it gives you can be useful.

In the "PowerShell" operational log, Event ID 4104 will record each command invoked if you have enabled module logging.

#### Other Event Logs
Unlike PowerShell logs and transcripts, other logging mechanisms will not capture the "Connected User".
You will need to do some correlation between other logs and PowerShell logs to match up actions taken.

In the "Windows Remote Management" operational log, Event ID 193 will record the Connecting User's SID and Name, as well as the RunAs Virtual Account's SID to assist with this correlation.
You may have also noticed that the name of the RunAs Virtual Account includes the connecting user's domain and username at the end.

### Reporting on JEA Configuration
#### Get-PSSessionConfiguration
In order to accurately report on the state of your environment, it's important to know how many JEA endpoints you have set up on your machine.
`Get-PSSessionConfiguration` does just that.
 
#### Get-PSSessionCapability
Manually reporting on the capabilities of any given user through a JEA endpoint can be quite complex.
You would potentially need to inspect several role capabilities.
Fortunately, the "Get-PSSessionCapability" cmdlet does this.

To test this out, run the following command from an administrator PowerShell prompt:
```PowerShell
Get-PSSessionCapability -Username 'CONTOSO\OperatorUser' -ConfigurationName JEADemo
```
## Conclusion 
After completing this guide, you should have the tools and vocabulary to create your own JEA endpoint. Thanks for reading!

## Appendix

## Key Concepts Used Throughout This Guide
**PowerShell Remoting**:
PowerShell remoting allows you to run PowerShell commands against remote machines.
You can operate against one or many computers, and use either temporary or persistent connections.
In this demo, you remoted into your local machine with an interactive session.
JEA restricts the functionality available through PowerShell remoting.
For more information about PowerShell remoting, run `Get-Help about_Remote`.

**"RunAs" User**:
When using JEA, a non-administrator "runs as" a privileged "Virtual Account."
The Virtual Account only lasts the duration of the remote session.
That is to say, it is created when a user connects to the endpoint, and destroyed when the user ends the session.
By default, the Virtual Account is a member of the local Administrators group.
On a domain controller, it is a member of Domain Admins.
Virtual Accounts are local to the machine on which they are created, and do not have permissions outside of that machine.
This means that they are not registered in Active Directory (no RID is assigned).
Additionally, if an allowed command/script tries to access resources outside of the local machine, it will be accessing those resources under the machine's identity, not the Virtual Account identity.

**"Connected" User**:
The non-administrator user who connects to the JEA endpoint and to whom roles are assigned.
Any commands this user runs are run under the context of the RunAs User or virtual account.


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

### On Blacklisting
After playing around with JEA, you may be wondering if it is possible to blacklist commands.
This is an understandable request, but it is not currently planned for JEA for the following reasons:

1.	We designed JEA to limit operators to only the actions they need to do.
A blacklist is the opposite.

2.	PowerShell command authors did not design PowerShell commands with the JEA in mind.
On a fresh install of Windows Server 2016, there are about 1520 commands immediately available.
The threat models for these commands did not include the possibility that a user would be running commands as a more privileged account.
For example, certain commands allow for code injection by design (e.g. Add-Type and Invoke-Command in the core PowerShell module).
JEA can warn you when you expose the specific commands we know about, but we have not re-assessed every other command in Windows based on the new threat model.
You must understand the capabilities of the commands you exposing through JEA.  

3.	Furthermore, even if JEA blocked all commands with code-injection vulnerabilities, there is no guarantee that a malicious user would not be able to carry out a blacklisted action with another related command.
Unless you understand all of the commands that you are exposing, it is impossible for you to guarantee that a certain action is not possible.
The burden is on you to understand what commands you are exposing, whether they are using a whitelist or a blacklist.
The number of commands a blacklist would expose is unmanageable, so JEA is implemented using whitelists instead.

### Considerations When Limiting Commands
There is one important point to make about this step.
It is critical that all capabilities exposed through JEA are located in administrator-restricted areas.
Non-administrator users should not have the capability to modify the scripts used through JEA endpoints.

On a related note, it is critical that you do not give JEA users the ability to overwrite JEA configurations and whitelisted scripts within their JEA sessions.
Be extremely careful when exposing commands like `Copy-Item`!

### Common Role Capability Pitfalls
You may run into a few common pitfalls into you go through this process yourself.
Here is a quick guide explaining how to identify and remediate these issues when modifying or creating a new endpoint:

#### Functions vs. Cmdlets
PowerShell commands written in PowerShell are PowerShell Functions.
PowerShell commands written as specialized .NET classes are PowerShell Cmdlets.
You can check the command type by running `Get-Command`.

#### VisibleProviders 
You will need to expose any providers your commands need.
The most common is the FileSystem provider, but you may also need to expose others, like the Registry provider.
For an introduction to providers, check out this [Hey, Scripting Guy blog post](http://blogs.technet.com/b/heyscriptingguy/archive/2015/04/20/find-and-use-windows-powershell-providers.aspx).
Be careful when exposing providers -- often, it is better to define your own function that works with the underlying providers than to directly expose the provider in a JEA session.
This way, you can still allow users to work with files, registry keys, etc. but retain control over **which* files and registry keys they can work with using custom validation logic.
---
ms.date:  2017-06-12
author:  rpsqrd
ms.topic:  conceptual
keywords:  jea,powershell,security
title:  Using JEA
---

# Using JEA

> Applies to: Windows PowerShell 5.0

This topic describes the various ways you can connect to and use a JEA endpoint.

## Using JEA interactively

If you are testing your JEA configuration or have simple tasks for users to perform, you can use JEA the same way you would a regular PowerShell remoting session.
For complex remoting tasks, it is recommended to use [implicit remoting](#using-jea-with-implicit-remoting) instead to make it easier for your users by allowing users to operate with the data objects locally.

To use JEA interactively, you will need:
- The name of the computer you are connecting to (can be the local machine)
- The name of the JEA endpoint registered on that computer
- Credentials for the computer that have access to the JEA endpoint

With that information in hand, you can start a JEA session using [New-PSSession](https://msdn.microsoft.com/powershell/reference/5.1/microsoft.powershell.core/New-PSSession) or [Enter-PSSession](https://msdn.microsoft.com/powershell/reference/5.1/microsoft.powershell.core/enter-pssession).

```powershell
$nonAdminCred = Get-Credential
Enter-PSSession -ComputerName localhost -ConfigurationName JEAMaintenance -Credential $nonAdminCred
```

If the account you're currently logged in as has access to the JEA endpoint, you can omit the `-Credential` parameter.

When the PowerShell prompt changes to `[localhost]: PS>` you will know that you are now interacting with the remote JEA session.
You can run `Get-Command` to check which commands are available.
You will need to consult with your administrator to learn if there are any restrictions on the available parameters or allowable parameter values.

As a reminder, JEA sessions operate in NoLanguage mode, so some of the ways you typically use PowerShell may not be available.
For instance, you cannot use variables to store data or inspect the properties on objects returned from cmdlets.
The below example shows an example of how you may be using PowerShell today, and two approaches to get the same command working in NoLanguage mode.

```powershell
# Using variables in NoLanguage mode is disallowed, so the following will not work
# $vm = Get-VM -Name 'SQL01'
# Start-VM -VM $vm

# You can use pipes to pass data through to commands that accept input from the pipeline
Get-VM -Name 'SQL01' | Start-VM

# You can also wrap subcommands in parentheses and enter them inline as arguments
Start-VM -VM (Get-VM -Name 'SQL01')

# Better yet, use parameter sets that don't require extra data to be passed in when possible
Start-VM -VMName 'SQL01'
```

For more complex command invocations that make this approach difficult, consider using [implicit remoting](#using-jea-with-implicit-remoting) or [creating custom functions](role-capabilities.md#creating-custom-functions) that wrap the functionality you desire.

## Using JEA with implicit remoting

PowerShell supports an alternative remoting model where you can import proxy cmdlets from a remote machine on your local computer and interact with them as if they were local commands.
This is called implicit remoting, and is explained well in [this *Hey, Scripting Guy!* blog post](https://blogs.technet.microsoft.com/heyscriptingguy/2013/09/08/remoting-the-implicit-way/).
Implicit remoting is particularly useful when working with JEA because it allows you to work with JEA cmdlets in a full language mode.
This means you can use tab completion, variables, manipulate objects, and even use local scripts to more easily automate against a JEA endpoint.
Anytime you invoke a proxy command, the data will be sent to the JEA endpoint on the remote machine and executed there.

Implicit remoting works by importing cmdlets from an existing PowerShell session.
You can optionally choose to prefix the nouns of each proxy cmdlet with a string of your choosing to distinguish which commands are for the remote system.
A temporary script module containing all of the proxy commands will be created and can be used for the duration of your local PowerShell session.

```powershell
# Create a new PSSession to your JEA endpoint
$jeasession = New-PSSession -ComputerName 'SERVER01' -ConfigurationName 'JEAMaintenance'

# Import the entire PSSession and prefix each imported cmdlet with "JEA"
Import-PSSession -Session $jeasession -Prefix 'JEA'

# Invoke "Get-Command" on the remote JEA endpoint using the proxy cmdlet
Get-JEACommand
```

> [!IMPORTANT]
> Some systems may not be able to import an entire JEA session due to constraints in the default JEA cmdlets.
> To get around this, only import the commands you need from the JEA session by explicitly providing their names to the `-CommandName` parameter.
> A future update will address the issue with importing entire JEA sessions on affected systems.

If you are unable to import a JEA session due to constraints on the default JEA parameters, you can follow the steps below to filter out the default commands from the imported set.
You will still be able to use commands like `Select-Object` -- you'll just use the local version installed on your computer instead of the remote one in the JEA session.

```powershell
# Create a new PSSession to your JEA endpoint
$jeasession = New-PSSession -ComputerName 'SERVER01' -ConfigurationName 'JEAMaintenance'

# Get a list of all the commands on the JEA endpoint
$commands = Invoke-Command -Session $jeasession -ScriptBlock { Get-Command }

# Filter out the default cmdlets
$jeaDefaultCmdlets = 'Clear-Host', 'Exit-PSSession', 'Get-Command', 'Get-FormatData', 'Get-Help', 'Measure-Object', 'Out-Default', 'Select-Object'
$filteredCommands = $commands.Name | Where-Object { $jeaDefaultCmdlets -notcontains $_ }

# Import only commands explicitly added in role capabilities and prefix each imported cmdlet with "JEA"
Import-PSSession -Session $jeasession -Prefix 'JEA' -CommandName $filteredCommands 
```

You can also persist the proxied cmdlets from implicit remoting using [Export-PSSession](https://msdn.microsoft.com/powershell/reference/5.1/microsoft.powershell.utility/Export-PSSession).
For more information about implicit remoting, check out the help documentation for [Import-PSSession](https://msdn.microsoft.com/powershell/reference/5.1/microsoft.powershell.utility/import-pssession) and [Import-Module](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/import-module).

## Using JEA programatically

JEA can also be used in automation systems and in user applications, such as in-house helpdesk apps and web sites.
The approach is the same as that for building apps that talk to unconstrained PowerShell endpoints, with the caveat that the program should be aware that JEA is limiting the commands that can be run in the remote session.

For simple, one-off tasks, you can use [Invoke-Command](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/invoke-command) to run a set of commands using JEA.

```powershell
Invoke-Command -ComputerName 'SERVER01' -ConfigurationName 'JEAMaintenance' -ScriptBlock { Get-Process; Get-Service }
```

To check which commands are available for use when you connect to a JEA session, run `Get-Command` and iterate through the results to check for the allowed parameters.

```powershell
$allowedCommands = Invoke-Command -ComputerName 'SERVER01' -ConfigurationName 'JEAMaintenance' -ScriptBlock { Get-Command }
$allowedCommands | Where-Object { $_.CommandType -in 'Function', 'Cmdlet' } | Format-Table Name, Parameters
```

If you are building a C# app, you can create a PowerShell runspace that connects to a JEA session by specifying the configuration name in a [WSManConnectionInfo](https://msdn.microsoft.com/en-us/library/system.management.automation.runspaces.wsmanconnectioninfo(v=vs.85).aspx) object.

```csharp

// using System.Management.Automation;
var computerName = "SERVER01";
var configName   = "JEAMaintenance";
var creds        = // create a PSCredential object here (https://msdn.microsoft.com/en-us/library/system.management.automation.pscredential(v=vs.85).aspx)

WSManConnectionInfo connectionInfo = new WSManConnectionInfo(
                    false,                 // Use SSL
                    computerName,          // Computer name
                    5985,                  // WSMan Port
                    "/wsman",              // WSMan Path
                    string.Format(CultureInfo.InvariantCulture, "http://schemas.microsoft.com/powershell/{0}", configName),  // Connection URI with config name
                    creds);                // Credentials
// Now, use the connection info to create a runspace where you can run the commands
using (Runspace runspace = RunspaceFactory.CreateRunspace(connectionInfo))
{
    // Open the runspace
    runspace.Open();

    using (PowerShell ps = PowerShell.Create())
    {
        // Set the PowerShell object to use the JEA runspace
        ps.Runspace = runspace;

        // Now you can add and invoke commands
        ps.AddCommand("Get-Command");
        foreach (var result in ps.Invoke())
        {
            Console.WriteLine(result);
        }
    }

    // Close the runspace
    runspace.Close();
}
```

## Using JEA with PowerShell Direct

Hyper-V in Windows 10 and Windows Server 2016 offers [PowerShell Direct](https://msdn.microsoft.com/en-us/virtualization/hyperv_on_windows/user_guide/vmsession), a feature which allows Hyper-V administrators to manage virtual machines with PowerShell regardless of the network configuration or remote management settings on the virtual machine.

You can use PowerShell Direct with JEA to give a Hyper-V administrator limited access to your VM, which can be useful if you lose network connectivity to your VM and need a datacenter admin to fix the network settings.

No additional configuration is required to use JEA over PowerShell Direct, however the operating system running inside the virtual machine must be Windows 10 or Windows Server 2016.
The Hyper-V admin can connect to the JEA endpoint by using the `-VMName` or `-VMId` parameters on PSRemoting cmdlets:

```powershell
# Entering a JEA session using PowerShell Direct when the VM name is unique
Enter-PSSession -VMName 'SQL01' -ConfigurationName 'NICMaintenance' -Credential 'localhost\JEAformyHoster'

# Entering a JEA session using PowerShell Direct using VM ids
$vm = Get-VM -VMName 'MyVM' | Select-Object -First 1
Enter-PSSession -VMId $vm.VMId -ConfigurationName 'NICMaintenance' -Credential 'localhost\JEAformyHoster'
```

It is strongly recommended that you create a dedicated local user with no other rights to manage the system for your Hyper-V administrators to use.
Remember that even an unprivileged user can still log into a Windows machine by default, including using unconstrained PowerShell.
That will allow them to browse (some of) the file system and learn more about your OS environment.
To lock down a Hyper-V administrator to only access a VM using PowerShell Direct with JEA, you will need to deny local logon rights to the Hyper-V admin's JEA account.


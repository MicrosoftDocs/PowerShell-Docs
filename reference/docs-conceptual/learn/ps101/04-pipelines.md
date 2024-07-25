---
description: A PowerShell one-liner is one continuous pipeline, containing multiple commands, to accomplish a single task.
ms.custom: Contributor-mikefrobbins
ms.date: 12/08/2022
ms.reviewer: mirobb
title: One-liners and the pipeline
---
# Chapter 4 - One-liners and the pipeline

When I first started learning PowerShell, if I couldn't accomplish a task with a PowerShell
one-liner, I went back to the GUI. Over time, I built my skills up to writing scripts, functions,
and modules. Don't allow yourself to become overwhelmed by some of the more advanced examples you
may see on the internet. No one is a natural expert with PowerShell. We were all beginners at
one time.

I have a bit of advice to offer those of you who are still using the GUI for administration:
install the management tools on your admin workstation and manage your servers remotely. This way it
won't matter if the server is running a GUI or Server Core installation of the operating system.
It's going to help prepare you for managing servers remotely with PowerShell.

As with previous chapters, be sure to follow along on your Windows 10 lab environment computer.

## One-Liners

A PowerShell one-liner is one continuous pipeline and not necessarily a command that's on one
physical line. Not all commands that are on one physical line are one-liners.

Even though the following command is on multiple physical lines, it's a PowerShell one-liner because
it's one continuous pipeline. It could be written on one physical line, but I've chosen to line
break at the pipe symbol. The pipe symbol is one of the characters where a natural line break is
allowed in PowerShell.

```powershell
Get-Service |
  Where-Object CanPauseAndContinue -eq $true |
    Select-Object -Property *
```

```Output
Name                : LanmanWorkstation
RequiredServices    : {NSI, MRxSmb20, Bowser}
CanPauseAndContinue : True
CanShutdown         : False
CanStop             : True
DisplayName         : Workstation
DependentServices   : {SessionEnv, Netlogon, Browser}
MachineName         : .
ServiceName         : LanmanWorkstation
ServicesDependedOn  : {NSI, MRxSmb20, Bowser}
ServiceHandle       : SafeServiceHandle
Status              : Running
ServiceType         : Win32ShareProcess
StartType           : Automatic
Site                :
Container           :

Name                : Netlogon
RequiredServices    : {LanmanWorkstation}
CanPauseAndContinue : True
CanShutdown         : False
CanStop             : True
DisplayName         : Netlogon
DependentServices   : {}
MachineName         : .
ServiceName         : Netlogon
ServicesDependedOn  : {LanmanWorkstation}
ServiceHandle       : SafeServiceHandle
Status              : Running
ServiceType         : Win32ShareProcess
StartType           : Automatic
Site                :
Container           :

Name                : vmicheartbeat
RequiredServices    : {}
CanPauseAndContinue : True
CanShutdown         : False
CanStop             : True
DisplayName         : Hyper-V Heartbeat Service
DependentServices   : {}
MachineName         : .
ServiceName         : vmicheartbeat
ServicesDependedOn  : {}
ServiceHandle       : SafeServiceHandle
Status              : Running
ServiceType         : Win32ShareProcess
StartType           : Manual
Site                :
Container           :

Name                : vmickvpexchange
RequiredServices    : {}
CanPauseAndContinue : True
CanShutdown         : False
CanStop             : True
DisplayName         : Hyper-V Data Exchange Service
DependentServices   : {}
MachineName         : .
ServiceName         : vmickvpexchange
ServicesDependedOn  : {}
ServiceHandle       : SafeServiceHandle
Status              : Running
ServiceType         : Win32ShareProcess
StartType           : Manual
Site                :
Container           :

Name                : vmicrdv
RequiredServices    : {}
CanPauseAndContinue : True
CanShutdown         : False
CanStop             : True
DisplayName         : Hyper-V Remote Desktop Virtualization Service
DependentServices   : {}
MachineName         : .
ServiceName         : vmicrdv
ServicesDependedOn  : {}
ServiceHandle       : SafeServiceHandle
Status              : Running
ServiceType         : Win32ShareProcess
StartType           : Manual
Site                :
Container           :

Name                : vmicshutdown
RequiredServices    : {}
CanPauseAndContinue : True
CanShutdown         : False
CanStop             : True
DisplayName         : Hyper-V Guest Shutdown Service
DependentServices   : {}
MachineName         : .
ServiceName         : vmicshutdown
ServicesDependedOn  : {}
ServiceHandle       : SafeServiceHandle
Status              : Running
ServiceType         : Win32ShareProcess
StartType           : Manual
Site                :
Container           :

Name                : vmictimesync
RequiredServices    : {VmGid}
CanPauseAndContinue : True
CanShutdown         : False
CanStop             : True
DisplayName         : Hyper-V Time Synchronization Service
DependentServices   : {}
MachineName         : .
ServiceName         : vmictimesync
ServicesDependedOn  : {VmGid}
ServiceHandle       : SafeServiceHandle
Status              : Running
ServiceType         : Win32ShareProcess
StartType           : Manual
Site                :
Container           :

Name                : vmicvss
RequiredServices    : {}
CanPauseAndContinue : True
CanShutdown         : False
CanStop             : True
DisplayName         : Hyper-V Volume Shadow Copy Requestor
DependentServices   : {}
MachineName         : .
ServiceName         : vmicvss
ServicesDependedOn  : {}
ServiceHandle       : SafeServiceHandle
Status              : Running
ServiceType         : Win32ShareProcess
StartType           : Manual
Site                :
Container           :

Name                : Winmgmt
RequiredServices    : {RPCSS}
CanPauseAndContinue : True
CanShutdown         : True
CanStop             : True
DisplayName         : Windows Management Instrumentation
DependentServices   : {wscsvc, NcaSvc, iphlpsvc}
MachineName         : .
ServiceName         : Winmgmt
ServicesDependedOn  : {RPCSS}
ServiceHandle       : SafeServiceHandle
Status              : Running
ServiceType         : Win32ShareProcess
StartType           : Automatic
Site                :
Container           :
```

Natural line breaks can occur at commonly used characters including comma (`,`) and opening brackets
(`[`), braces (`{`), and parenthesis (`(`). Others that aren't so common include the semicolon
(`;`), equals sign (`=`), and both opening single and double quotes (`'`,`"`).

Using the backtick (`` ` ``) or grave accent character as a line continuation character is a
controversial topic. My recommendation is to try to avoid it if at all possible. I often see
PowerShell commands written using a backtick immediately after a natural line break character.
There's no reason for it to be there.

```powershell
Get-Service -Name w32time |
>> Select-Object -Property *
```

```Output
Name                : w32time
RequiredServices    : {}
CanPauseAndContinue : False
CanShutdown         : True
CanStop             : True
DisplayName         : Windows Time
DependentServices   : {}
MachineName         : .
ServiceName         : w32time
ServicesDependedOn  : {}
ServiceHandle       : SafeServiceHandle
Status              : Running
ServiceType         : Win32ShareProcess
StartType           : Manual
Site                :
Container           :
```

The commands shown in the previous two examples work fine in the PowerShell console. But if you try
to run them in the console pane of the PowerShell ISE, they'll generate an error. The console pane
of the PowerShell ISE doesn't wait for the rest of the command to be entered on the next line like
the PowerShell console does. To avoid this problem in the console pane of the PowerShell ISE, use
<kbd>Shift</kbd>+<kbd>Enter</kbd> instead of just pressing <kbd>Enter</kbd> when continuing a
command on another line.

This next example isn't a PowerShell one-liner because it's not one continuous pipeline. It's two
separate commands on one line, separated by a semicolon.

```powershell
$Service = 'w32time'; Get-Service -Name $Service
```

```Output
Status   Name               DisplayName
------   ----               -----------
Running  w32time            Windows Time
```

Many programming and scripting languages require a semicolon at the end of each line. While they can
be used that way in PowerShell, it's not recommended because they're not needed.

## Filtering Left

The results of the commands shown in this chapter have been filtered down to a subset. For example,
`Get-Service` was used with the **Name** parameter to filter the list of services that were returned
to only the Windows Time service.

In the pipeline, you always want to filter the results down to what you're looking for as early as
possible. This is accomplished using parameters on the first command or, the one to the far left.
This is sometimes called _filtering left_.

The following example uses the **Name** parameter of `Get-Service` to immediately filter the results
to the Windows Time service only.

```powershell
Get-Service -Name w32time
```

```Output
Status   Name               DisplayName
------   ----               -----------
Running  w32time            Windows Time
```

It's not uncommon to see examples where the command is piped to `Where-Object` to perform the
filtering.

```powershell
Get-Service | Where-Object Name -eq w32time
```

```Output
Status   Name               DisplayName
------   ----               -----------
Running  W32Time            Windows Time
```

The first example filters at the source and only returns the results for the Windows Time service.
The second example returns all the services then pipes them to another command to perform the
filtering. While this may not seem like a big deal in this example, imagine if you were querying a
list of Active Directory users. Do you really want to return the information for many thousands of
user accounts from Active Directory only to pipe them to another command that filters them down to a
tiny subset? My recommendation is to always filter left even when it doesn't seem to matter. You'll
be so use to it that you'll automatically filter left when it really does matter.

I once had someone tell me that the order you specify the commands in doesn't matter. That couldn't
be further from the truth. The order that the commands are specified in does indeed matter when
performing filtering. For example, consider the scenario where you are using `Select-Object` to
select only a few properties and `Where-Object` to filter on properties that won't be in the
selection. In that scenario, the filtering must occur first, otherwise the property won't exist
in the pipeline when try to perform the filtering.

```powershell
Get-Service |
Select-Object -Property DisplayName, Running, Status |
Where-Object CanPauseAndContinue
```

The command in the previous example doesn't return any results because the **CanPauseAndContinue**
property doesn't exist when the results of `Select-Object` are piped to `Where-Object`. That
particular property wasn't "selected". In essence, it was filtered out. Reversing the order of
`Select-Object` and `Where-Object` produces the desired results.

```powershell
Get-Service |
Where-Object CanPauseAndContinue |
Select-Object -Property DisplayName, Status
```

```Output
DisplayName                                    Status
-----------                                    ------
Workstation                                    Running
Netlogon                                       Running
Hyper-V Heartbeat Service                      Running
Hyper-V Data Exchange Service                  Running
Hyper-V Remote Desktop Virtualization Service  Running
Hyper-V Guest Shutdown Service                 Running
Hyper-V Time Synchronization Service           Running
Hyper-V Volume Shadow Copy Requestor           Running
Windows Management Instrumentation             Running
```

## The Pipeline

As you've seen in many of the examples shown so far throughout this book, many times the output of
one command can be used as input for another command. In Chapter 3, `Get-Member` was used to
determine what type of object a command produces. Chapter 3 also showed using the **ParameterType**
parameter of `Get-Command` to determine what commands accepted that type of input, although not
necessarily by pipeline input.

Depending on how thorough a commands help is, it may include an **INPUTS** and **OUTPUTS** section.

```powershell
help Stop-Service -Full
```

```Output
...
INPUTS
    System.ServiceProcess.ServiceController, System.String
        You can pipe a service object or a string that contains the name of a service
        to this cmdlet.

OUTPUTS
    None, System.ServiceProcess.ServiceController
        This cmdlet generates a System.ServiceProcess.ServiceController object that
        represents the service, if you use the PassThru parameter. Otherwise, this
        cmdlet does not generate any output.
...
```

Only the relevant section of the help is shown in the previous results. As you can see, the
**INPUTS** section states that a **ServiceController** or a **String** object can be piped to the
`Stop-Service` cmdlet. It doesn't tell you which parameters accept that type of input. One of the
easiest ways to determine that information is to look through the different parameters in the full
version of the help for the `Stop-Service` cmdlet.

```powershell
help Stop-Service -Full
```

```Output
...
-DisplayName <String[]>
    Specifies the display names of the services to stop. Wildcard characters are
    permitted.

    Required?                    true
    Position?                    named
    Default value                None
    Accept pipeline input?       False
    Accept wildcard characters?  false

-InputObject <ServiceController[]>
    Specifies ServiceController objects that represent the services to stop. Enter a
    variable that contains the objects, or type a command or expression that gets the
    objects.

    Required?                    true
    Position?                    0
    Default value                None
    Accept pipeline input?       True (ByValue)
    Accept wildcard characters?  false

-Name <String[]>
    Specifies the service names of the services to stop. Wildcard characters are
    permitted.

    Required?                    true
    Position?                    0
    Default value                None
    Accept pipeline input?       True (ByPropertyName, ByValue)
    Accept wildcard characters?  false
...
```

Once again, I've only shown the relevant portion of the help in the previous set of results. Notice
that the **DisplayName** parameter doesn't accept pipeline input, the **InputObject** parameter
accepts pipeline input **by value** for **ServiceController** objects, and the **Name** parameter
accepts pipeline input **by value** for **string** objects. It also accepts pipeline input **by
property name**.

When a parameter accepts pipeline input by both property name and by value, it always tries **by
value** first. If **by value** fails, then it tries **by property name**. **By value** is a little
misleading. I prefer to call it **by type**. This means if you pipe the results of a command that
produces a **ServiceController** object type to `Stop-Service`, it binds that input to the
**InputObject** parameter. But if you pipe the results of a command that produces **String** output
to `Stop-Service`, it binds it to the **Name** parameter. If you pipe the results of a command that
doesn't produce a **ServiceController** or **String** object to `Stop-Service`, but it does produce
output containing a property called **Name**, then it binds the **Name** property from the output to
the **Name** parameter of `Stop-Service`.

Determine what type of output the `Get-Service` command produces.

```powershell
Get-Service -Name w32time | Get-Member
```

```Output
   TypeName: System.ServiceProcess.ServiceController
```

`Get-Service` produces a ServiceController object type.

As you previously saw in the help, the **InputObject** parameter of `Stop-Service` accepts
**ServiceController** objects via the pipeline **by value** (by type). This means that when the
results of the `Get-Service` cmdlet are piped to `Stop-Service`, they bind to the **InputObject**
parameter of `Stop-Service`.

```powershell
Get-Service -Name w32time | Stop-Service
```

Now to try string input. Pipe `w32time` to `Get-Member` just to confirm that it's a string.

```powershell
'w32time' | Get-Member
```

```Output
   TypeName: System.String
```

As previously shown in the help, piping a string to `Stop-Service` binds it **by value** to the
**Name** parameter of `Stop-Service`. Test this by piping `w32time` to `Stop-Service`.

```powershell
'w32time' | Stop-Service
```

Notice that in the previous example, I used single quotes around the string `w32time`. In
PowerShell, you should always use single quotes instead of double quotes unless the contents of the
quoted string contains a variable that needs to be expanded to its actual value. By using single
quotes, PowerShell doesn't have to parse the contents contained within the quotes so your code runs
a little faster.

Create a custom object to test pipeline input by property name for the **Name** parameter of
`Stop-Service`.

```powershell
$CustomObject = [pscustomobject]@{
 Name = 'w32time'
 }
```

The contents of the **CustomObject** variable is a **PSCustomObject** object type and it contains a
property named **Name**.

```powershell
$CustomObject | Get-Member
```

```Output
   TypeName: System.Management.Automation.PSCustomObject

Name        MemberType   Definition
----        ----------   ----------
Equals      Method       bool Equals(System.Object obj)
GetHashCode Method       int GetHashCode()
GetType     Method       type GetType()
ToString    Method       string ToString()
Name        NoteProperty string Name=w32time
```

If you were to surround the `$CustomObject` variable with quotes, you want to use double quotes.
Otherwise, using single quotes, the literal string `$CustomObject` is piped to `Get-Member` instead
of the value contained by the variable.

Although piping the contents of `$CustomObject` to `Stop-Service` cmdlet binds to the **Name**
parameter, this time it binds **by property name** instead of **by value** because the contents of
`$CustomObject` is an object that has a property named **Name**.

In this example, I create another custom object using a different property name, such as
**Service**.

```powershell
$CustomObject = [pscustomobject]@{
  Service = 'w32time'
}
```

An error is generated when trying to pipe `$CustomObject` to `Stop-Service` because it doesn't
produce a **ServiceController** or **String** object, and it doesn't have a property named **Name**.

```powershell
$CustomObject | Stop-Service
```

```Output
Stop-Service : Cannot find any service with service name '@{Service=w32time}'.
At line:1 char:17
+ $CustomObject | Stop-Service
+
    + CategoryInfo          : ObjectNotFound: (@{Service=w32time}:String) [Stop-Service]
   , ServiceCommandException
    + FullyQualifiedErrorId : NoServiceFoundForGivenName,Microsoft.PowerShell.Commands.S
   topServiceCommand
```

If the output of one command doesn't line up with the pipeline input options for another command,
`Select-Object` can be used to rename the property so that the properties lineup correctly.

```powershell
$CustomObject |
  Select-Object -Property @{name='Name';expression={$_.Service}} |
    Stop-Service
```

In this example, `Select-Object` was used to rename the **Service** property to a property named
**Name**.

The syntax this example may seem a little complicated at first. What I have learned is that you'll
never learn the syntax by copy and pasting code. Take the time to type the code in. After a few
times, it becomes second nature. Having multiple monitors is a huge benefit because you can display
the example code on one screen and type it in on another one.

Occasionally, you may want to use a parameter that doesn't accept pipeline input. The following
example demonstrates using the output of one command as input for another. First save the display
name for a couple of Windows services into a text file.

```powershell
'Background Intelligent Transfer Service', 'Windows Time' |
Out-File -FilePath $env:TEMP\services.txt
```

You can run the command that provides the needed output within parentheses as the value for the
parameter of the command requiring the input.

```powershell
Stop-Service -DisplayName (Get-Content -Path $env:TEMP\services.txt)
```

This is just like order of operations in Algebra for those of you who remember how it works. The
command within parentheses always runs prior to the outer portion of the command.

## PowerShellGet

PowerShellGet is a PowerShell module that contains commands for discovering, installing, publishing,
and updating PowerShell modules (and other artifacts) to or from a NuGet repository. PowerShellGet
ships with PowerShell version 5.0 and higher. It is available as a separate download for PowerShell
version 3.0 and higher.

Microsoft hosts an online NuGet repository called the [PowerShell Gallery][PowerShell Gallery].
Although this repository is hosted by Microsoft, the majority of the modules contained within the
repository aren't written by Microsoft. Any code obtain from the PowerShell Gallery should be
thoroughly reviewed in an isolated test environment before being considered suitable for use in a
production environment.

Most companies will want to host their own internal private NuGet repository where they can post
their internal use only modules as well as modules that they've downloaded from other sources once
they've validated them as being non-malicious.

Use the `Find-Module` cmdlet that's part of the PowerShellGet module to find a module in the
PowerShell Gallery that I wrote named MrToolkit.

```powershell
Find-Module -Name MrToolkit
```

```Output
NuGet provider is required to continue
PowerShellGet requires NuGet provider version '2.8.5.201' or newer to interact with
NuGet-based repositories. The NuGet provider must be available in 'C:\Program
Files\PackageManagement\ProviderAssemblies' or
'C:\Users\MrAdmin\AppData\Local\PackageManagement\ProviderAssemblies'. You can also
install the NuGet provider by running 'Install-PackageProvider -Name NuGet
-MinimumVersion 2.8.5.201 -Force'. Do you want PowerShellGet to install and import the
NuGet provider now?
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"):

Version    Name                                Repository           Description
-------    ----                                ----------           -----------
1.1        MrToolkit                           PSGallery            Misc PowerShell Tools
```

The first time you use one of the commands from the PowerShellGet module, you'll be prompted to
install the NuGet provider.

To install the MrToolkit module, pipe the previous command to `Install-Module`.

```powershell
Find-Module -Name MrToolkit | Install-Module
```

```Output
Untrusted repository
You are installing the modules from an untrusted repository. If you trust this
repository, change its InstallationPolicy value by running the Set-PSRepository cmdlet.
Are you sure you want to install the modules from
'https://www.powershellgallery.com/api/v2/'?
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"): y
```

Since the PowerShell Gallery is an untrusted repository, it prompts you to approve the installation
of the module.

## Finding pipeline input the easy way

The MrToolkit module contains a function named `Get-MrPipelineInput`. This cmdlet can be used to
easily determine which parameters of a command accept pipeline input, what type of object they
accept, and if they accept pipeline input **by value** or **by property name**.

```powershell
Get-MrPipelineInput -Name Stop-Service
```

```Output
ParameterName ParameterType                             ValueFromPipeline ValueFromPipelineByPropertyName
------------- -------------                             ----------------- ---------------
InputObject   System.ServiceProcess.ServiceController[]              True           False
Name          System.String[]                                        True            True
```

As you can see, the same information we previously determined by sifting through the help can easily
be determined with this function.

## Summary

In this chapter, you've learned about PowerShell one-liners. You've learned that the number of
physical lines that a command is on has nothing to do with whether or not it's a PowerShell
one-liner. You've also learned about filtering left, the pipeline, and PowerShellGet.

## Review

1. What is a PowerShell one-liner?
1. What are some of the characters where natural line breaks can occur in PowerShell?
1. Why should you filter left?
1. What are the two ways that a PowerShell command can accept pipeline input?
1. Why shouldn't you trust commands found in the PowerShell Gallery?

## Recommended Reading

- [about_Pipelines][about_Pipelines]
- [about_Command_Syntax][about_Command_Syntax]
- [about_Parameters][about_Parameters]
- [PowerShellGet: The BIG EASY way to discover, install, and update PowerShell modules][psget]

<!-- link references-->
[about_Pipelines]: /powershell/module/microsoft.powershell.core/about/about_pipelines
[about_Command_Syntax]: /powershell/module/microsoft.powershell.core/about/about_command_syntax
[about_Parameters]: /powershell/module/microsoft.powershell.core/about/about_parameters
[psget]: https://mikefrobbins.com/2015/04/23/powershellget-the-big-easy-way-to-discover-install-and-update-powershell-modules/
[PowerShell Gallery]: https://www.powershellgallery.com/

---
description: A PowerShell one-liner is one continuous pipeline, containing multiple commands, to accomplish a single task.
ms.custom: Contributor-mikefrobbins
ms.date: 01/08/2025
ms.reviewer: mirobb
title: One-liners and the pipeline
---

# Chapter 4 - One-Liners and the pipeline

When I started learning PowerShell, I initially relied on the Graphical User Interface (GUI) for
tasks that seemed too complex for simple PowerShell commands. However, as I continued to learn, I
improved my skills and moved from basic one-liners to creating scripts, functions, and modules. It's
important to remember that feeling overwhelmed by advanced examples online is normal. No one starts
as an expert in PowerShell; we all start as beginners.

For those who primarily use the GUI for administrative tasks, install the management tools on your
administrative workstation to remotely manage your servers. Whether your server uses a GUI or the
Server Core OS installation, this approach is beneficial. It's a practical way to familiarize
yourself with remote server management in preparation for performing administrative tasks with
PowerShell.

As with the previous chapters, try these concepts in your lab environment.

## One-Liners

A PowerShell one-liner is one continuous pipeline. It's a common misconception that a command on one
physical line is a PowerShell one-liner, but this isn't always true.

For instance, consider the following example: the command extends over multiple physical lines, yet
it's a PowerShell one-liner because it forms a continuous pipeline. Line-breaking a lengthy
one-liner at the pipe symbol, a natural breaking point in PowerShell, is recommended to enhance
readability and clarity. This strategic use of line breaks improves readability without disrupting
the flow of the pipeline.

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
DependentServices   : {SessionEnv, Netlogon}
MachineName         : .
ServiceName         : LanmanWorkstation
ServicesDependedOn  : {NSI, MRxSmb20, Bowser}
ServiceHandle       :
Status              : Running
ServiceType         : Win32OwnProcess, Win32ShareProcess
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
ServiceHandle       :
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
ServiceHandle       :
Status              : Running
ServiceType         : Win32OwnProcess, Win32ShareProcess
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
ServiceHandle       :
Status              : Running
ServiceType         : Win32OwnProcess, Win32ShareProcess
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
ServiceHandle       :
Status              : Running
ServiceType         : Win32OwnProcess, Win32ShareProcess
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
ServiceHandle       :
Status              : Running
ServiceType         : Win32OwnProcess, Win32ShareProcess
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
ServiceHandle       :
Status              : Running
ServiceType         : Win32OwnProcess, Win32ShareProcess
StartType           : Manual
Site                :
Container           :

Name                : webthreatdefsvc
RequiredServices    : {RpcSs, wtd}
CanPauseAndContinue : True
CanShutdown         : True
CanStop             : True
DisplayName         : Web Threat Defense Service
DependentServices   : {}
MachineName         : .
ServiceName         : webthreatdefsvc
ServicesDependedOn  : {RpcSs, wtd}
ServiceHandle       :
Status              : Running
ServiceType         : Win32OwnProcess, Win32ShareProcess
StartType           : Manual
Site                :
Container           :

Name                : webthreatdefusersvc_644de
RequiredServices    : {}
CanPauseAndContinue : True
CanShutdown         : True
CanStop             : True
DisplayName         : Web Threat Defense User Service_644de
DependentServices   : {}
MachineName         : .
ServiceName         : webthreatdefusersvc_644de
ServicesDependedOn  : {}
ServiceHandle       :
Status              : Running
ServiceType         : 240
StartType           : Automatic
Site                :
Container           :

Name                : Winmgmt
RequiredServices    : {RPCSS}
CanPauseAndContinue : True
CanShutdown         : True
CanStop             : True
DisplayName         : Windows Management Instrumentation
DependentServices   : {}
MachineName         : .
ServiceName         : Winmgmt
ServicesDependedOn  : {RPCSS}
ServiceHandle       :
Status              : Running
ServiceType         : Win32OwnProcess, Win32ShareProcess
StartType           : Automatic
Site                :
Container           :
```

Natural line breaks can occur at commonly used characters, including comma (`,`) and opening
brackets (`[`), braces (`{`), and parenthesis (`(`). Others that aren't so common include the
semicolon (`;`), equals sign (`=`), and both opening single and double quotes (`'`,`"`).

Using the backtick (`` ` ``) or grave accent character as a line continuation is controversial. It's
best to avoid it if possible. Using a backtick following a natural line break character is a common
mistake. This redundancy is unnecessary and can clutter the code.

The commands in the following example execute correctly from the PowerShell console. However,
attempting to run them in the console pane of the PowerShell Integrated Scripting Environment (ISE)
results in an error. This difference occurs because, unlike the PowerShell console, the console pane
of the ISE doesn't automatically anticipate the continuation of a command onto the next line. To
prevent this issue, press <kbd>Shift</kbd>+<kbd>Enter</kbd> in the console pane of the ISE instead
of <kbd>Enter</kbd> when you need to extend a command across multiple lines. This key combination
signals to the ISE that the command is continuing on the following line, preventing the execution
that leads to errors.

```powershell
Get-Service -Name w32time |
    Select-Object -Property *
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
ServiceHandle       :
Status              : Running
ServiceType         : Win32OwnProcess, Win32ShareProcess
StartType           : Manual
Site                :
Container           :
```

This next example doesn't qualify as a PowerShell one-liner because it's not one continuous
pipeline. Instead, it's two separate commands placed on a single line, separated by a semicolon.
This semicolon indicates the end of one command and the beginning of another.

```powershell
$Service = 'w32time'; Get-Service -Name $Service
```

```Output
Status   Name               DisplayName
------   ----               -----------
Running  w32time            Windows Time
```

Many programming and scripting languages require a semicolon at the end of each line. However, in
PowerShell, semicolons at the end of lines are unnecessary and not recommended. You should avoid
them for cleaner and more readable code.

## Filter Left

This chapter demonstrates how to filter the results of various commands.

It's a best practice in PowerShell to filter the results as early as possible in the pipeline.
Achieving this involves applying filters using parameters on the initial command, usually at the
beginning of the pipeline. This is commonly referred to as _filtering left_.

To illustrate this concept, consider the following example: Use the **Name** parameter of
`Get-Service` to filter the results at the beginning of the pipeline, returning only the details for
the Windows Time service. This method demonstrates efficient data retrieval, ensuring you only
return the necessary and relevant information.

```powershell
Get-Service -Name w32time
```

```Output
Status   Name               DisplayName
------   ----               -----------
Running  w32time            Windows Time
```

It's common to see online examples of a PowerShell command being piped to the `Where-Object` cmdlet
to filter its results. This technique is inefficient if an earlier command in the pipeline has a
parameter to perform the filtering.

```powershell
Get-Service | Where-Object Name -eq w32time
```

```Output
Status   Name               DisplayName
------   ----               -----------
Running  W32Time            Windows Time
```

The first example demonstrates filtering directly at the source, returning results specifically for
the Windows Time service. In contrast, the second example retrieves all services and then uses
another command to filter the results. This might seem insignificant in small-scale scenarios, but
consider a situation involving a large dataset, like Active Directory. It's inefficient to retrieve
details for thousands of user accounts only to narrow them down to a small subset. Practice
_filtering left_ — applying filters as early as possible in the command sequence — even in seemingly
trivial cases. This habit ensures efficiency in more complex scenarios where it becomes more
important.

### Command sequencing for effective filtering

There's a misconception that the order of commands in PowerShell is inconsequential, but this is a
misunderstanding. The sequence in which you arrange commands, particularly when filtering, is
important. For example, suppose you're using `Select-Object` to choose specific properties and
`Where-Object` to filter. In that case, it's essential to apply the filtering first. Failing to do
so means the necessary properties might not be available in the pipeline for filtering, leading to
ineffective or erroneous results.

The following example fails to produce results because the **CanPauseAndContinue** property is
absent when `Select-Object` is piped to `Where-Object`. This is because the **CanPauseAndContinue**
property wasn't included in the selection made by `Select-Object`. Effectively, it's excluded or
filtered out.

```powershell
Get-Service |
    Select-Object -Property DisplayName, Running, Status |
    Where-Object CanPauseAndContinue
```

Reversing the order of `Select-Object` and `Where-Object` produces the desired results.

```powershell
Get-Service |
    Where-Object CanPauseAndContinue |
    Select-Object -Property DisplayName, Status
```

```Output
DisplayName                                    Status
-----------                                    ------
Workstation                                   Running
Netlogon                                      Running
Hyper-V Heartbeat Service                     Running
Hyper-V Data Exchange Service                 Running
Hyper-V Remote Desktop Virtualization Service Running
Hyper-V Guest Shutdown Service                Running
Hyper-V Volume Shadow Copy Requestor          Running
Web Threat Defense Service                    Running
Web Threat Defense User Service_644de         Running
Windows Management Instrumentation            Running
```

## The Pipeline

As seen in many examples throughout this book, you can often use the output of one command as input
for another command. In Chapter 3, `Get-Member` was used to determine what type of object a command
produces.

Chapter 3 also showed using the **ParameterType** parameter of `Get-Command` to determine what
commands accepted that type of input. Depending on how thorough help for a command is, it might
include an **INPUTS** and **OUTPUTS** section.

The **INPUTS** section indicates that you can pipe a **ServiceController** or a **String** object to
the `Stop-Service` cmdlet.

```powershell
help Stop-Service -Full
```

The following output is abbreviated to show the relevant portion of the help.

```Output
...
INPUTS
    System.ServiceProcess.ServiceController
        You can pipe a service object to this cmdlet.

    System.String
        You can pipe a string that contains the name of a service to this
        cmdlet.


OUTPUTS
    None
        By default, this cmdlet returns no output.

    System.ServiceProcess.ServiceController
        When you use the PassThru parameter, this cmdlet returns a
        ServiceController object representing the service.
...
```

However, it doesn't specify which parameters accept this type of input. You can determine that
information by checking the different parameters in the full version of the help for the
`Stop-Service` cmdlet.

```powershell
help Stop-Service -Full
```

Once again, only the relevant help is shown in the following results. Notice that the
**DisplayName** parameter doesn't accept pipeline input. The **InputObject** parameter accepts
pipeline input by value for **ServiceController** objects. The Name parameter accepts pipeline input
by value for **String** objects and pipeline input **by property name**.

```Output
...
-DisplayName <System.String[]>
    Specifies the display names of the services to stop. Wildcard
    characters are permitted.

    Required?                    true
    Position?                    named
    Default value                None
    Accept pipeline input?       False
    Accept wildcard characters?  true

-InputObject <System.ServiceProcess.ServiceController[]>
    Specifies ServiceController objects that represent the services to
    stop. Enter a variable that contains the objects, or type a command
    or expression that gets the objects.

    Required?                    true
    Position?                    0
    Default value                None
    Accept pipeline input?       True (ByValue)
    Accept wildcard characters?  false

-Name <System.String[]>
    Specifies the service names of the services to stop. Wildcard
    characters are permitted.

    Required?                    true
    Position?                    0
    Default value                None
    Accept pipeline input?       True (ByPropertyName, ByValue)
    Accept wildcard characters?  true
...
```

When handling pipeline input, a parameter that accepts pipeline input both **by property name** and
**by value** prioritizes **by value** binding first. If this method fails, it attempts to process
pipeline input **by property name**. However, the term **by value** can be misleading. A more
accurate description is **by type**.

For instance, if you pipe the output of a command that generates a **ServiceController** object to
`Stop-Service`, this output is bound to the **InputObject** parameter. If the piped command produces
a **String** object, it associates the output with the **Name** parameter. If you pipe output from a
command that doesn't produce a **ServiceController** or **String** object, but does include a
property named **Name**, `Stop-Service` binds the value of the **Name** property to its **Name**
parameter.

Determine what type of output the `Get-Service` command produces.

```powershell
Get-Service -Name w32time | Get-Member
```

`Get-Service` produces a **ServiceController** object type.

```Output
   TypeName: System.ServiceProcess.ServiceController
```

As shown in the help for `Stop-Service` cmdlet, the **InputObject** parameter accepts
**ServiceController** objects through the pipeline **by value**. This implies that when you pipe the
output of the `Get-Service` cmdlet to `Stop-Service`, the **ServiceController** objects produced by
`Get-Service` bind to the **InputObject** parameter of `Stop-Service`.

```powershell
Get-Service -Name w32time | Stop-Service
```

Now try string input. Pipe `w32time` to `Get-Member` to confirm that it's a string.

```powershell
'w32time' | Get-Member
```

```Output
   TypeName: System.String
```

The PowerShell help documentation illustrates that when you pipe a string to `Stop-Service`, it
binds to the **Name** parameter **by value**. Conduct a practical test to see this in action: pipe
the string `w32time` to `Stop-Service`. This example demonstrates how `Stop-Service` processes the
string `w32time` as the name of the service to stop. Execute the following command to observe this
binding and command execution in action.

Notice that `w32time` is enclosed in single quotes. In PowerShell, it's a best practice to use
single quotes for static strings, reserving double quotes for situations where the string contains
variables that require expansion. Single quotes tell PowerShell to treat the content literally
without parsing for variables. This approach not only ensures accuracy in how your script interprets
the string but also enhances performance, as PowerShell expends less processing effort on strings
within single quotes.

```powershell
'w32time' | Stop-Service
```

Create a custom object to test pipeline input by property name for the **Name** parameter of
`Stop-Service`.

```powershell
$customObject = [pscustomobject]@{
    Name = 'w32time'
}
```

The contents of the **CustomObject** variable is a **PSCustomObject** object type and it contains a
property named **Name**.

```powershell
$customObject | Get-Member
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

When working with variables in PowerShell, such as `$customObject` in this example, it's important
to use double quotes if you need to enclose the variable in quotes. Double quotes allow for variable
expansion — PowerShell evaluates the variable and uses its value. For example, if you enclose
`$customObject` in double quotes and pipe it to `Get-Member`, PowerShell processes the value of
`$customObject`. In contrast, using single quotes would result in piping the literal string
`$customObject` to `Get-Member`, not the value of the variable. This distinction is important for
scenarios where you need to evaluate the value of variables.

When piping the contents of the `$customObject` variable to the `Stop-Service` cmdlet, the binding
to the **Name** parameter occurs by **property name** rather than **by value**. This is because
`$customObject` is an object that contains a property named **Name**. In this scenario, PowerShell
identifies the **Name** property within `$customObject` and uses its value for the **Name**
parameter of `Stop-Service`.

Create another custom object using a different property name, such as **Service**.

```powershell
$customObject = [pscustomobject]@{
    Service = 'w32time'
}
```

An error occurs while trying to stop the `w32time` service by piping `$customObject` to
`Stop-Service`. The pipeline binding fails because `$customObject` doesn't produce a
**ServiceController** or **String** object and doesn't contain a **Name** property.

```powershell
$customObject | Stop-Service
```

```Output
Stop-Service : Cannot find any service with service name
'@{Service=w32time}'.
At line:1 char:17
+ $customObject | Stop-Service
+                 ~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (@{Service=w32time}:String) [
   Stop-Service], ServiceCommandException
    + FullyQualifiedErrorId : NoServiceFoundForGivenName,Microsoft.PowerShe
   ll.Commands.StopServiceCommand
```

When the output property names of one command don't match the pipeline input requirements of another
command, you can use `Select-Object` to rename the property names so they line up correctly.

In the following example, use `Select-Object` to rename the **Service** property to a property named
**Name**.

At first glance, the syntax of this example might appear complex. However, it's essential to
understand that more than copying and pasting code is required to learn the syntax. Instead, take
the time to type out the code manually. This hands-on practice helps you remember the syntax, and it
becomes more intuitive with repeated effort. Utilizing multiple monitors or split screen can also
aid in the learning process. Display the example code on one screen while actively typing and
experimenting with it on another. This setup makes it easier to follow along and enhances your
understanding and retention of the syntax.

```powershell
$customObject |
    Select-Object -Property @{name='Name';expression={$_.Service}} |
    Stop-Service
```

There are instances where you might need to use a parameter that doesn't accept pipeline input. In
such cases, you can still use the output of one command as the input for another. First, capture and
save the display names of a few specific Windows services into a text file. This step allows you to
use the saved data as input for another command.

```powershell
'Background Intelligent Transfer Service', 'Windows Time' |
    Out-File -FilePath $env:TEMP\services.txt
```

You can use parentheses to pass the output of one command as input for a parameter to another
command.

```powershell
Stop-Service -DisplayName (Get-Content -Path $env:TEMP\services.txt)
```

This concept is like the order of operations in Algebra. Just as mathematical operations within
parentheses are computed first, the command enclosed in parentheses is executed before the outer
command.

## PowerShellGet

**PowerShellGet**, a module included with PowerShell version 5.0 and higher, provides commands to
discover, install, update, and publish PowerShell modules and other items in a NuGet repository. For
those using PowerShell version 3.0 and above, PowerShellGet is also available as a separate
download.

The [PowerShell Gallery][powerShell-gallery] is an online repository hosted by Microsoft, designed
as a central hub for sharing PowerShell modules, scripts, and other resources. While Microsoft hosts
the PowerShell Gallery, the PowerShell community contributes most of the available modules and
scripts. Given the source of these modules and scripts, exercise caution before integrating any code
from the PowerShell Gallery into your environment. Review and test downloads from the PowerShell
Gallery in an isolated test environment. This process ensures the code is secure and reliable, works
as expected, and safeguards your environment from potential issues or vulnerabilities arising from
unvetted code.

Many organizations opt to establish their own internal, private NuGet repository. This repository
serves a dual purpose. First, it acts as a secure location for storing modules developed in-house,
intended solely for internal use. Secondly, it provides a vetted collection of modules sourced
externally, including those from public repositories. Companies typically undertake a thorough
validation process before adding these external modules to the internal repository. This process is
important to ensure the modules are free from malicious content and align with the security and
operational standards of the company.

Use the `Find-Module` cmdlet that's part of the **PowerShellGet** module to find a module in the
PowerShell Gallery that I wrote named **MrToolkit**.

```powershell
Find-Module -Name MrToolkit
```

```Output
NuGet provider is required to continue
PowerShellGet requires NuGet provider version '2.8.5.201' or newer to
interact with NuGet-based repositories. The NuGet provider must be available
 in 'C:\Program Files\PackageManagement\ProviderAssemblies' or
'C:\Users\mikefrobbins\AppData\Local\PackageManagement\ProviderAssemblies'.
You can also install the NuGet provider by running 'Install-PackageProvider
-Name NuGet -MinimumVersion 2.8.5.201 -Force'. Do you want PowerShellGet to
install and import the NuGet provider now?
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"):

Version    Name                      Repository        Description
-------    ----                      ----------        -----------
1.3        MrToolkit                 PSGallery         Misc PowerShell Tools
```

The first time you use one of the commands from the **PowerShellGet** module, you're prompted to
install the NuGet provider.

To install the **MrToolkit** module, pipe the previous command to `Install-Module`.

```powershell
Find-Module -Name MrToolkit | Install-Module -Scope CurrentUser
```

```Output
Untrusted repository
You are installing the modules from an untrusted repository. If you trust
this repository, change its InstallationPolicy value by running the
Set-PSRepository cmdlet. Are you sure you want to install the modules from
'https://www.powershellgallery.com/api/v2'?
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help
(default is "N"):y
```

Since the PowerShell Gallery is an untrusted repository, it prompts you to approve the installation
of the module.

## Finding pipeline input the easy way

The **MrToolkit** module includes a function named `Get-MrPipelineInput`. This cmdlet is designed to
provide users with a convenient method for identifying the parameters of a command capable of
accepting pipeline input. Specifically, it reveals three key aspects:

- Which parameters of a command can receive pipeline input
- The type of object each parameter accepts
- Whether they accept pipeline input **by value** or **by property name**

This capability dramatically simplifies the process of understanding and utilizing the pipeline
capabilities of PowerShell commands.

The information previously obtained by analyzing the help documentation can be determined using this
function.

```powershell
Get-MrPipelineInput -Name Stop-Service | Format-List
```

```Output
ParameterName                   : InputObject
ParameterType                   : System.ServiceProcess.ServiceController[]
ValueFromPipeline               : True
ValueFromPipelineByPropertyName : False

ParameterName                   : Name
ParameterType                   : System.String[]
ValueFromPipeline               : True
ValueFromPipelineByPropertyName : True
```

## Summary

In this chapter, you learned about the intricacies of PowerShell one-liners. You also learned that
the physical line count of a command is irrelevant to its classification as a PowerShell one-liner.
Additionally, you learned about key concepts such as filtering left, the pipeline, and
**PowerShellGet**.

## Review

1. What's a PowerShell one-liner?
1. What are some characters where natural line breaks can occur in PowerShell?
1. Why should you filter left?
1. What are the two ways that a PowerShell command can accept pipeline input?
1. Why shouldn't you trust commands found in the PowerShell Gallery?

## References

- [about_Pipelines][about-pipelines]
- [about_Command_Syntax][about-command-syntax]
- [about_Parameters][about-parameters]
- [PowerShellGet: The BIG EASY way to discover, install, and update PowerShell modules][psget]

## Next steps

In the next chapter, you'll learn about formatting, aliases, providers, and comparison operators.

<!-- link references-->

[about-pipelines]: /powershell/module/microsoft.powershell.core/about/about_pipelines
[about-command-syntax]: /powershell/module/microsoft.powershell.core/about/about_command_syntax
[about-parameters]: /powershell/module/microsoft.powershell.core/about/about_parameters
[psget]: https://mikefrobbins.com/2015/04/23/powershellget-the-big-easy-way-to-discover-install-and-update-powershell-modules/
[powerShell-gallery]: https://www.powershellgallery.com/

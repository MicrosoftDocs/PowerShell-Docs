# Chapter 4 - One-Liners and the Pipeline

When I first started learning PowerShell, if I couldn't accomplish a task with a PowerShell
one-liner, I went back to the GUI and used it. Over time, I built my skills up to writing scripts,
functions, and modules. Don't allow yourself to become overwhelmed with some of the more advanced
examples you may see on the Internet because no one is a natural expert with PowerShell. We were all
beginners at one point in time.

One bit of advice that I'll offer to those of you who are still using the GUI for some of your
administration, as I was when I first started learning PowerShell, is to install the management
tools on your workstation or a jump server and manage your servers remotely. This way it won't
matter if the server is running a GUI or the server core installation of the operating system. It's
going to help prepare you for managing servers remotely with PowerShell.

As with previous chapters, be sure to follow along on your Windows 10 lab environment computer.

## One-Liners

A PowerShell one-liner is one continuous pipeline and not necessarily a command that’s on one
physical line. Not all commands that are on one physical line are one-liners.

Even though the following command is on more than one physical line, it's a PowerShell one-liner
because it's one continuous pipeline. It could be written on one physical line, but I've chosen to
line break at the pipe symbol which is one of the characters in PowerShell where a natural line
break can occur.

```powershell
Get-Service |
>> Where-Object CanPauseAndContinue -eq $true |
>> Select-Object -Property *
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

Other characters where natural line breaks can occur that are commonly used include the comma, and
opening brackets, braces, and parenthesis. Others that aren't so common include the semicolon,
equals sign, and both opening single quotes and double quotes.

Using the backtick or grave accent character as a line continuation character is a controversial
topic, but my recommendation is to try to avoid it if at all possible. I see PowerShell commands
written all the time where a backtick is used immediately after a natural line break character and
there's simply no reason for it to be there.

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

The commands shown in the previous two examples work fine in the PowerShell console, but if you try
to run them in the console pane of the PowerShell ISE, they'll generate an error. This is because
the console pane of the PowerShell ISE doesn't wait for the remainder of the command to be entered
on the next line like the PowerShell console does. To alleviate this problem, use shift + enter
instead of just pressing enter when continuing a command on another line in the console pane of the
PowerShell ISE.

Now for an example of a command that's on one physical line, but not a PowerShell one-liner because
it's not one continuous pipeline. It's two separate commands placed on one line and separated by a
semicolon.

```powershell
$Service = 'w32time'; Get-Service -Name $Service
```

```powershell
Status   Name               DisplayName
------   ----               -----------
Running  w32time            Windows Time
```

Many programming and scripting languages require a semicolon at the end of each line and while they
can be used that way in PowerShell, it's not recommended because they're simply not needed.

## Filtering Left

The results of the commands shown in this chapter have been filtered down to a subset. For example,
Get-Service was used with the Name parameter to filter the list of services that were returned to
only the Windows Time service.

You always want to filter the results down to what you're looking for as early as possible in the
pipeline. Best case scenario, this is accomplished by using parameters of the first command that's
specified or the one to the far left which is why it's sometimes called filtering left.

The following example uses the Name parameter of Get-Service to immediately filter down the results
to only the Windows Time service.

```powershell
Get-Service -Name w32time
```

```Output
Status   Name               DisplayName
------   ----               -----------
Running  w32time            Windows Time
```

It's not uncommon to see examples where the command is piped to Where-Object to perform the
filtering.

```powershell
Get-Service | Where-Object Name -eq w32time
```

```Output
Status   Name               DisplayName
------   ----               -----------
Running  W32Time            Windows Time
```

The first option performs the filtering at the source and only returns the results for the Windows
Time service. The second option returns all of the services only to pipe them to another command to
perform the filtering. While this may not seem like a big deal in this example, imagine if you were
querying a list of Active Directory users. Do you really want to pull the information for thousands,
tens of thousand, or possibly hundreds of thousands of user accounts from Active Directory only to
pipe them to another command which filters them down to a subset? My recommendation is to always
filter left even when it doesn't seem to matter and you'll be so use to it that you'll automatically
filter left when it really does matter.

I once had someone tell me that the order you specify the commands in doesn't matter. That couldn't
be further from the truth. The order that the commands are specified in does indeed matter when
performing filtering. For example, if you're using Select-Object to select only a few properties,
but need to perform filtering with Where-Object on properties that won't be in the selection. In
that scenario, the filtering must occur first, otherwise the property wouldn't exist in the pipeline
when trying to perform the filtering.

```powershell
Get-Service |
Select-Object -Property DisplayName, Running, Status |
Where-Object CanPauseAndContinue
```

The command in the previous example won't return any results because the CanStopAndContinue property
doesn't exist when the results of Select-Object are piped to Where-Object. That particular property
wasn't "selected" and in essence, it was filtered out. Reversing the order of Select-Object and
Where-Object produces the desired results.

```powershell
Get-Service |
Where-Object CanPauseAndContinue |
Select-Object -Property DisplayName, Running, Status
```

```Output
DisplayName                                   Running  Status
-----------                                   -------  ------
Workstation                                           Running
Netlogon                                              Running
Hyper-V Heartbeat Service                             Running
Hyper-V Data Exchange Service                         Running
Hyper-V Remote Desktop Virtualization Service         Running
Hyper-V Guest Shutdown Service                        Running
Hyper-V Time Synchronization Service                  Running
Hyper-V Volume Shadow Copy Requestor                  Running
Windows Management Instrumentation                    Running
```

## The Pipeline

As you've seen in many of the examples shown so far throughout this book, many times the output of
one command can be used as input for another command. In chapter 3, Get-Member was used to determine
what type of object a command produces. Chapter 3 also showed using the ParameterType parameter of
Get-Command to determine what commands accepted that type of input, although not necessarily by
pipeline input.

Depending on how thorough a commands help is, it may include an INPUTS and OUTPUTS section.

```powershell
help Stop-Service -Full
```

```Output
INPUTS
    System.ServiceProcess.ServiceController, System.String
        You can pipe a service object or a string that contains the name of a service
        to this cmdlet.

OUTPUTS
    None, System.ServiceProcess.ServiceController
        This cmdlet generates a System.ServiceProcess.ServiceController object that
        represents the service, if you use the PassThru parameter. Otherwise, this
        cmdlet does not generate any output.
```

Only the relevant section of the help is shown in the previous results. As you can see, the INPUTS
section states that a ServiceController or a String object can be piped to the Stop-Service cmdlet.
It doesn't tell you which parameters accept that type of input. One of the easiest ways to determine
that information is to look through the different parameters in the full version of the help for the
Stop-Service cmdlet.

```powershell
help Stop-Service -Full
```

```powershell
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
```

Once again, I've only shown the relevant portion of the help in the previous set of results. Notice
that the DisplayName parameter doesn't accept pipeline input, the InputObject parameter accepts
pipeline input by value for ServiceController objects, and the Name parameter accepts pipeline input
by value for string objects. It also accepts pipeline input by property name.

When a parameter accepts pipeline input by both property name and by value, it always tries by value
first and if by value fails, then and only then does it try by property name. By value is a little
misleading. I prefer to call by value "by type." This means if you pipe the results of a command
that produces a ServiceController object type to Stop-Service, it will bind that input to the
InputObject parameter, but if you pipe the results of a command that produces string output to
Stop-Service, it will bind it to the Name parameter. If you pipe the results of a command that
doesn't produce a ServiceController or String object to Stop-Service, but it does produce output
that contains a property called "Name", then and only then will it bind the Name property from the
output to the Name parameter as input for the Stop-Service command.

Determine what type of output the Get-Service command produces.

```powershell
Get-Service -Name w32time | Get-Member
```

```Output
   TypeName: System.ServiceProcess.ServiceController
```

Get-Service produces a ServiceController object type.

As you previously saw in the help, the InputObject parameter of Stop-Service accepts
ServiceController objects via the pipeline by value (by type). This means that when the results of
the Get-Service cmdlet are piped to Stop-Service, they bind to the InputObject parameter of
Stop-Service.

```powershell
Get-Service -Name w32time | Stop-Service
```

Now to try string input. Pipe w32time to Get-Member just to confirm that it's a string.

```powershell
'w32time' | Get-Member
```

```Output
   TypeName: System.String
```

As previously shown in the help, piping a string to Stop-Service will bind it to the Name parameter
of Stop-Service by value (by type). Test this by piping w32time to Stop-Service.

```powershell
'w32time' | Stop-Service
```

Notice that in the previous example, I used single quotes around the string "w32time." You should
always use single quotes instead of double quotes unless the contents of the quoted items contain a
variable which needs to be expanded to its actual value. By using single quotes, PowerShell doesn't
have to parse the contents contained within the quotes so your code will run a little faster.

Create a custom object to test pipeline input by property name for the Name parameter of Stop-Service.

```powershell
$CustomObject = [pscustomobject]@{
>> Name = 'w32time'
>> }
```

The contents of the CustomObject variable is a PSCustomObject object type and it contains a property
named "Name".

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

If you were to surround the CustomObject variable with quotes in the previous example, you would
want to use double quotes otherwise if single quotes were used, the literal $CustomObject would be
piped to Get-Member instead of the value it contains.

Although piping the contents of the CustomObject variable to Stop-Service cmdlet binds to the Name
parameter, this time it binds by property name instead of by value because the contents of the
CustomObject variable aren't a string, but they do contain a property named "Name".

Create another custom object except this time use another name such as "service".

```powershell
$CustomObject = [pscustomobject]@{
>> Service = 'w32time'
>> }
```

An error is generated when trying to pipe the contents of this updated CustomObject variable to
Stop-Service because it doesn't produce a ServiceController or String object and it doesn't have a
property named "Name".

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

If the output of one command doesn't line up with the pipeline input options for another command as
shown in the previous example, Select-Object can be used to rename the property to make the
properties lineup correctly.

```powershell
$CustomObject |
>> Select-Object -Property @{label='Name';Expression={$_.Service}} |
>> Stop-Service```

In the previous example, Select-Object was used to rename the Service property to a property named
"Name" so that it could be accepted via pipeline input by the Stop-Service cmdlet.

The syntax of the previous example may seem a little complicated at first. What I have learned is
that you'll never learn the syntax by copy and pasting code. If you take the time to type the code
in, after a few times it will become second nature. Having multiple monitors is a huge benefit
because you can display the example code on one screen and type it in on another one.

If for some reason a command doesn't accept pipeline input on a parameter that you want to provide
input on from the output of another command, you can always use parameter input.

To demonstrate using the output of one command as parameter input for another, first save the
display name for a couple of Windows services into a text file.

```powershell
'Background Intelligent Transfer Service', 'Windows Time' |
Out-File -FilePath $env:TEMP\services.txt
```

Simple run the command that you want to provide the output from within parenthesis as the value for
the parameter of the command to provide the input for, or Stop-Service in this scenario as shown in
the following example.

```powershell
Stop-Service -DisplayName (Get-Content -Path $env:TEMP\services.txt)
```

This is just like order of operations in Algebra for those of you who remember how it works. The
portion of the command within parenthesis will always run prior to the outer portion of the command.

## PowerShellGet

PowerShellGet is a PowerShell module that contains commands for discovering, installing, publishing,
and updating PowerShell modules and other artifacts to/from a NuGet repository. PowerShellGet ships
with PowerShell version 5.0 and higher. It is available as a separate download for PowerShell
version 3.0 and higher.

Microsoft hosts an online NuGet repository called the
[PowerShell Gallery](https://www.powershellgallery.com/). Although this repository is hosted by
Microsoft, the majority of the PowerShell modules and code contained within the repository isn't
written by Microsoft and should be thoroughly reviewed in an isolated test environment before being
considered suitable for use in a production environment.

Most companies will want to host their own internal private NuGet repository where they can post
their internal use only modules as well as modules that they've downloaded from other sources once
they've validated them as being non-malicious.

Use the Find-Module cmdlet that's part of the PowerShellGet module to find a module in the
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

As shown in the previous example, the first time you use one of the commands from the PowerShellGet
module, you'll be prompted to install the NuGet provider.

To install the MrToolkit module, simply pipe the previous command to Install-Module.

```powershell
Find-Module -Name MrToolkit | Install-Module
```

```Output
Untrusted repository
You are installing the modules from an untrusted repository. If you trust this
repository, change its InstallationPolicy value by running the Set-PSRepository cmdlet.
Are you sure you want to install the modules from
'https://www.powershellgallery.com/api/v2/'?
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"): y```

Since the PowerShell Gallery is an untrusted repository, it prompts you to approve the installation
of the module.

## Finding Pipeline Input - The Easy Way

The MrToolkit module contains a function named Get-MrPipelineInput that can be used to easily
determine what parameters of a command accept pipeline input and what type of object they accept as
well as if they accept pipeline input by value or by property name.

```powershell
Get-MrPipelineInput -Name Stop-Service
```

```Output
ParameterName ParameterType                             ValueFromPipeline ValueFromPipelineByPropertyName
------------- -------------                             ----------------- ---------------
InputObject   System.ServiceProcess.ServiceController[]              True           False
Name          System.String[]                                        True            True
```

As you can see in the previous set of results, the same information we previously determined by
sifting through the help can easily be determined with this function.

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

- [about_Pipelines](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_pipelines)
- [about_Command_Syntax](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_command_syntax)
- [about_Parameters](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_parameters)
- [PowerShellGet: The BIG EASY way to discover, install, and update PowerShell modules](http://mikefrobbins.com/2015/04/23/powershellget-the-big-easy-way-to-discover-install-and-update-powershell-modules/)

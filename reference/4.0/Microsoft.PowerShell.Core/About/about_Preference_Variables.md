---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Preference_Variables
---

# About Preference Variables

## SHORT DESCRIPTION

Variables that customize the behavior of PowerShell

## LONG DESCRIPTION

PowerShell includes a set of variables that enable you to customize its
behavior. These "preference variables" work like the options in GUI-based
systems.

The preference variables affect the PowerShell operating environment and all
commands run in the environment. In many cases, the cmdlets have parameters
that you can use to override the preference behavior for a specific command.

The following table lists the preference variables and their default values.

Variable                      = Default Value

- \$ConfirmPreference            = High
- \$DebugPreference              = SilentlyContinue
- \$ErrorActionPreference        = Continue
- \$ErrorView                    = NormalView
- \$FormatEnumerationLimit       = 4
- \$InformationPreference        = SilentlyContinue
- \$LogCommandHealthEvent        = False (not logged)
- \$LogCommandLifecycleEvent     = False (not logged)
- \$LogEngineHealthEvent         = True (logged)
- \$LogEngineLifecycleEvent      = True (logged)
- \$LogProviderLifecycleEvent    = True (logged)
- \$LogProviderHealthEvent       = True (logged)
- \$MaximumAliasCount            = 4096
- \$MaximumDriveCount            = 4096
- \$MaximumErrorCount            = 256
- \$MaximumFunctionCount         = 4096
- \$MaximumHistoryCount          = 4096
- \$MaximumVariableCount         = 4096
- \$OFS                          = (Space character (" "))
- \$OutputEncoding               = ASCIIEncoding object
- \$ProgressPreference           = Continue
- \$PSDefaultParameterValues     = (None - empty hash table)
- \$PSEmailServer                = (None)
- \$PSModuleAutoLoadingPreference= All
- \$PSSessionApplicationName     = WSMAN
- \$PSSessionConfigurationName   =
  http://schemas.microsoft.com/PowerShell/microsoft.PowerShell
- \$PSSessionOption              = (See below)
- \$VerbosePreference            = SilentlyContinue
- \$WarningPreference            = Continue
- \$WhatIfPreference             = 0

PowerShell also includes the following environment variables that store user
preferences. For more information about these environment variables, see
[about_Environment_Variables](about_Environment_Variables.md).

- PSExecutionPolicyPreference
- PSModulePath

### WORKING WITH PREFERENCE VARIABLES

This document describes each of the preference variables.

To display the current value of a specific preference variable, type the name
of the variable. In response, PowerShell provides the value. For example, the
following command displays the value of the \$ConfirmPreference variable.

```powershell
PS> $ConfirmPreference
High
```

To change the value of a variable, use an assignment statement. For example,
the following statement assigns the value "Medium" to the \$ConfirmPreference
variable.

```powershell
PS> $ConfirmPreference = "Medium"
```

Like all variables, the values that you set are specific to the current
PowerShell session. To make them effective in all Windows PowerShell session,
add them to your PowerShell profile. For more information, see about_Profiles.

### WORKING REMOTELY

When you run commands on a remote computer, the remote commands are subject
only to the preferences set in the PowerShell client on the remote computer.
For example, when you run a remote command, the value of the \$DebugPreference
variable on remote computer determines how Windows PowerShell responds to
debugging messages.

For more information about remote commands, see
[about_remote](about_Remote.md).

#### \$ConfirmPreference

Determines whether PowerShell automatically prompts you for confirmation
before running a cmdlet or function.

When the value of the \$ConfirmPreference variable (High, Medium, Low) is less
than or equal to the risk assigned to the cmdlet or function (High, Medium,
Low), PowerShell automatically prompts you for confirmation before running the
cmdlet or function.

If the value of the \$ConfirmPreference variable is None, PowerShell never
automatically prompts you before running a cmdlet or function.

To change the confirming behavior for all cmdlets and functions in the
session, change the value of the \$ConfirmPreference variable.

To override the \$ConfirmPreference for a single command, use the Confirm
parameter of the cmdlet or function. To request confirmation, use -Confirm. To
suppress confirmation, use -Confirm:\$false

Valid values of \$ConfirmPreference:

- None: PowerShell does not prompt automatically. To request confirmation
  of a particular command, use the Confirm parameter of the cmdlet or
  function.
- Low: PowerShell prompts for confirmation before running cmdlets or
  functions with a low, medium, or high risk.
- Medium: PowerShell prompts for confirmation before running cmdlets or
  functions with a medium, or high risk.
- High: PowerShell prompts for confirmation before running cmdlets or
  functions with a high risk.

##### DETAILED EXPLANATION

When the actions of a cmdlet or function significantly affect the system, such
as those that delete data or use a significant amount of system resources,
PowerShell can automatically prompt you for confirmation before performing the
action.

For example,

```powershell
PS> remove-item file.txt

Confirm
Are you sure you want to perform this action?
Performing operation "Remove File" on Target "C:\file.txt".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend
[?] Help (default is "Y"):
```

The estimate of the risk is an attribute of the cmdlet or function known as
its "ConfirmImpact". Users cannot change it.

Cmdlets and functions that might pose a risk to the system have a Confirm
parameter that you can use to request or suppress confirmation for a single
command.

Because most cmdlets and functions use the default risk value (ConfirmImpact)
of Medium, and the default value of \$ConfirmPreference is High, automatic
confirmation rarely occurs. However, you can activate automatic confirmation
by changing the value of \$ConfirmPreference to Medium or Low.

##### EXAMPLES

This example shows the effect of the default value of \$ConfirmPreference. The
High value only confirms high-risk cmdlets and functions. Since most cmdlets
and functions are medium risk, they are not automatically confirmed.

```powershell
PS> $confirmpreference              #Get the current value of the variable
High

PS> remove-item temp1.txt           #Delete a file
PS>                                 #Deleted without confirmation

PS> remove-item temp2.txt -confirm  #Use to request confirmation

Confirm
Are you sure you want to perform this action?
Performing operation "Remove File" on Target "C:\temp2.txt".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend
[?] Help (default is "Y"):
```

The following example shows the effect of changing the value of
\$ConfirmPreference to Medium. Because most cmdlets and function are
medium-risk, they are automatically confirmed. To suppress the confirmation
prompt for a single command, use the Confirm parameter with a value of \$false

```powershell
PS> $confirmpreference = "Medium"  #Change the value of $ConfirmPreference
PS> remove-item temp2.txt          #Deleting a file triggers confirmation

Confirm
Are you sure you want to perform this action?
Performing operation "Remove File" on Target "C:\temp2.txt".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend
[?] Help (default is "Y"):

PS> remove-item temp3.txt -confirm:$false   #Use to suppress confirmation
PS>
```

#### \$DebugPreference
Determines how PowerShell responds to debugging messages generated by a
script, cmdlet or provider, or by a Write-Debug command at the command
line.

Some cmdlets display debugging messages, which are typically very technical
messages designed for programmers and technical support professionals. By
default, debugging messages are not displayed, but you can display
debugging messages by changing the value of \$DebugPreference.

You can also use the Debug common parameter of a cmdlet to display or hide
the debugging messages for a specific command. For more information, type:
`get-help about_commonparameters`.

Valid values:

- Stop: Displays the debug message and stops executing. Writes an error to
  the console.

- Inquire: Displays the debug message and asks you whether you want to
  continue. Note that adding the Debug common parameter to a command--when
  the command is configured to generate a debugging message--changes the
  value of the \$DebugPreference variable to Inquire.

- Continue: Displays the debug message and continues with execution.

- SilentlyContinue: No effect. The debug message is not (Default) displayed
  and execution continues without interruption.

##### EXAMPLES

The following examples show the effect of changing the values of
\$DebugPreference when a Write-Debug command is entered at the command line.
The change affects all debugging messages, including those generated by
cmdlets and scripts. The examples also show the use of the Debug common
parameter, which displays or hides the debugging messages related to a
single command.

This example shows the effect of the default value, "SilentlyContinue." The
debug message is not displayed and processing continues. The final command
uses the Debug parameter to override the preference for a single command.

```powershell
PS> $debugpreference    # Get the current value of \$DebugPreference
SilentlyContinue

PS> write-debug "Hello, World"
PS> # The debug message is not displayed.

PS> # Use the Debug parameter to display message and request confirmation
PS> write-debug "Hello, World" -Debug
DEBUG: Hello, World
Confirm
Continue with this operation?
[Y] Yes  [A] Yes to All  [H] Halt Command  [S] Suspend
[?] Help (default is "Y"):
```

This example shows the effect of the "Continue" value. The final command
uses the Debug parameter with a value of \$false to suppress the message for
a single command.

```powershell
PS> $debugpreference = "Continue"   # Change the value to "Continue"

PS> write-debug "Hello, World"
DEBUG: Hello, World  # Display message and continue processing.

PS> # Use the Debug parameter with false.
PS> write-debug "Hello, World" -Debug:$false
PS> # The debug message is not displayed.
```

This example shows the effect of the "Stop" value. The final command uses
the Debug parameter with a value of \$false to suppress the message for a
single command.

```powershell
PS> $debugpreference = "Stop"       #Change the value to "Stop"
PS> write-debug "Hello, World"
DEBUG: Hello, World
Write-Debug : Command execution stopped because the shell variable "Debug
Preference" is set to Stop.
At line:1 char:12
+ write-debug  <<<< "Hello, World"

PS> # Use the Debug parameter with $false
PS> write-debug "Hello, World" -Debug:$false
PS> # The debug message is not displayed and processing is not stopped.
```

This example shows the effect of the "Inquire" value. The final command
uses the Debug parameter with a value of \$false to suppress the message for
a single command.

```powershell
PS> \$debugpreference = "Inquire"
PS> write-debug "Hello, World"
DEBUG: Hello, World

Confirm
Continue with this operation?
[Y] Yes  [A] Yes to All  [H] Halt Command  [S] Suspend
[?] Help (default is "Y"):

PS> # Use the Debug parameter with $false
PS> write-debug "Hello, World" -Debug:$false
PS> # The debug message is not displayed and processing continues.
```

#### \$ErrorActionPreference

Determines how PowerShell responds to a non-terminating error (an error that
does not stop the cmdlet processing) at the command line or in a script,
cmdlet, or provider, such as the errors generated by the Write-Error cmdlet.

You can also use the ErrorAction common parameter of a cmdlet to override the
preference for a specific command.

Valid values:

- Stop: Displays the error message and stops executing.
- Inquire: Displays the error message and asks you whether you want to
  continue.
- Continue: Displays the error message and continues (Default) executing.
- Suspend: Automatically suspends a workflow job to allow for further
  investigation. After investigation, the workflow can be resumed.
- SilentlyContinue: No effect. The error message is not displayed and
  execution continues without interruption.

NOTE: The Ignore value of the ErrorAction common parameter is not a valid
value of the \$ErrorActionPreference variable. The Ignore value is intended
for per-command use, not for use as saved preference.

Neither \$ErrorActionPreference nor the ErrorAction common parameter affect
how PowerShell responds to terminating errors (those that stop cmdlet
processing).

For more information about the ErrorAction common parameter, see
[about_CommonParameters](about_CommonParameters.md).

##### EXAMPLES

These examples show the effect of the different values of
\$ErrorActionPreference and the use of the ErrorAction common parameter to
override the preference for a single command. The ErrorAction parameter has
the same valid values as the \$ErrorActionPreference variable.

This example shows the effect of the Continue value, which is the default.

```powershell
PS> # Display the value of the preference.
PS> $erroractionpreference
Continue

PS> # Generate a non-terminating error.
PS> write-error "Hello, World"

PS> # The error message is displayed and execution continues.
PS> write-error "Hello, World" : Hello, World

PS> # Use the ErrorAction parameter with a value of "SilentlyContinue".
PS> write-error "Hello, World" -ErrorAction:SilentlyContinue
PS>          # The error message is not displayed and execution continues.
```

This example shows the effect of the SilentlyContinue value.

```powershell
PS> # Change the value of the preference.
PS> \$ErrorActionPreference = "SilentlyContinue"

PS> # Generate an error message.
PS> write-error "Hello, World"
PS> # Error message is suppressed.

PS> # Use the ErrorAction parameter with a value of "Continue".
PS> write-error "Hello, World" -erroraction:continue

PS> # The error message is displayed and execution continues.
write-error "Hello, World" -erroraction:continue : Hello, World
```

This example shows the effect of a real error. In this case, the command gets
a non-existent file, nofile.txt. The example also uses the ErrorAction common
parameter to override the preference.

```powershell
PS> \$erroractionpreference
SilentlyContinue        # Display the value of the preference.

PS> get-childitem -path nofile.txt
PS>                     # Error message is suppressed.

PS> # Change the value to Continue.
PS> \$ErrorActionPreference = "Continue"

PS> get-childitem -path nofile.txt
Get-ChildItem : Cannot find path 'C:\nofile.txt' because it does not exist.
At line:1 char:4
+ get-childitem  <<<< nofile.txt

PS> # Use the ErrorAction parameter
PS> get-childitem -path nofile.txt -erroraction SilentlyContinue
PS> # Error message is suppressed.

PS> # Change the value to Inquire.
PS> \$ErrorActionPreference = "Inquire"
PS> get-childitem -path nofile.txt

Confirm
Cannot find path 'C:\nofile.txt' because it does not exist.
[Y] Yes  [A] Yes to All  [H] Halt Command  [S] Suspend
[?] Help (default is "Y"): y

Get-ChildItem : Cannot find path 'C:\nofile.txt' because it does not exist.
At line:1 char:4
+ get-childitem  <<<< nofile.txt

PS> # Change the value to Continue.
PS> \$ErrorActionPreference = "Continue"
PS> Get-Childitem nofile.txt -erroraction "Inquire"
PS> # Use the ErrorAction parameter to override the preference value.

Confirm
Cannot find path 'C:\nofile.txt' because it does not exist.
[Y] Yes  [A] Yes to All  [H] Halt Command  [S] Suspend
[?] Help (default is "Y"):
```

#### \$ErrorView

Determines the display format of error messages in PowerShell.

Valid values:

- NormalView: A detailed view designed for most users. (default) Consists
  of a description of the error, the name of the object involved in the
  error, and arrows (<<<<) that point to the words in the command that
  caused the error.
- CategoryView: A succinct, structured view designed for production
  environments. The format is:

  {Category}: ({TargetName}:{TargetType}):[{Activity}], {Reason}

For more information about the fields in CategoryView, see
"ErrorCategoryInfo class" in the PowerShell SDK.

##### EXAMPLES

These example show the effect of the ErrorView values.

This example shows how an error appears when the value of \$ErrorView is
NormalView. In this case, the Get-ChildItem command is used to find a
non-existent file.

```powershell
PS> \$ErrorView                         # Verify the value.
NormalView

PS> get-childitem nofile.txt           # Find a non-existent file.
Get-ChildItem : Cannot find path 'C:\nofile.txt' because it does not exist.
At line:1 char:14
+ get-childitem  <<<< nofile.txt
```

This example shows how the same error appears when the value of
\$ErrorView is CategoryView.

```powershell
PS> \$ErrorView = "CategoryView"        # Change the value to
CategoryView

PS> get-childitem nofile.txt
ObjectNotFound: (C:\nofile.txt:String) [Get-ChildItem], ItemNotFoundExcep
tion
```

This example demonstrates that the value of ErrorView only affects the error
display; it does not change the structure of the error object that is stored
in the \$error automatic variable. For information about the \$error automatic
variable, see [about_automatic_variables](about_Automatic_Variables.md).

This command takes the ErrorRecord object associated with the most recent
error in the error array (element 0) and formats all of the properties of the
error object in a list.

```powershell
PS> \$error[0] | format-list -property * -force

Exception    : System.Management.Automation.ItemNotFoundException: Cannot
find path 'C:\nofile.txt' because it does not exist.
at System.Management.Automation.SessionStateInternal.GetChildItems(String
path, Boolean recurse, CmdletProviderContext context)
at System.Management.Automation.ChildItemCmdletProviderIntrinsics.Get(Stri
ng path,Boolean recurse, CmdletProviderContext context)
at Microsoft.PowerShell.Commands.GetChildItemCommand.ProcessRecord()
TargetObject          : C:\nofile.txt
CategoryInfo          : ObjectNotFound: (C:\nofile.txt:String) [Get-ChildI
tem],ItemNotFoundException
FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.GetChil
dItemCommand
ErrorDetails          :
InvocationInfo        : System.Management.Automation.InvocationInfo
```

#### \$FormatEnumerationLimit

Determines how many enumerated items are included in a display. This
variable does not affect the underlying objects; just the display. When the
value of \$FormatEnumerationLimit is less than the number of enumerated
items, PowerShell adds an ellipsis (...) to indicate items not shown.

Valid values: Integers (Int32)

Default value: 4

##### EXAMPLES

This example shows how to use the \$FormatEnumerationLimit variable to
improve the display of enumerated items.

The command in this example generates a table that lists all of the services
running on the computer in two groups; one for running services and one for
stopped services. It uses a Get-Service command to get all of the services,
and then send the results through the pipeline to the Group-Object cmdlet,
which groups the results by the service status.

The resulting display is a table that lists the status in the Name column and
the processes with that status in the Group column. (To change the column
labels, use a hash table. For more information, see the examples in "get-help
format-table -examples".)

There are a maximum of 4 services listed in the Group column for each status.
To increase the number of items listed, increase the value of
\$FormatEnumerationLimit to 1000.

In the resulting display, the list in the Group column is now limited by the
line length. In the final command in the example, use the Wrap parameter of
Format-Table to display all of the processes in each Status group.

PS> \$formatenumerationlimit         # Find the current value
4

```powershell
PS> # List all services grouped by status
PS> get-service | group-object -property status

Count Name                      Group
----- ----                      -----
60 Running                   {AdtAgent, ALG, Ati HotKey Poller, AudioSrv...}
41 Stopped                   {Alerter, AppMgmt, aspnet_state, ATI Smart...}
PS> # The list is truncated after 4 items.

PS> # Increase the limit to 1000.
PS> \$formatenumerationlimit = 1000
PS> get-service | group-object -property status

Count Name     Group
----- ----     -----
60 Running  {AdtAgent, ALG, Ati HotKey Poller, AudioSrv, BITS, CcmExec...
41 Stopped  {Alerter, AppMgmt, aspnet_state, ATI Smart, Browser, CiSvc...

PS> # Add the Wrap parameter.
PS> get-service | group-object -property status | format-table -wrap

Count Name       Group
----- ----       -----
60 Running    {AdtAgent, ALG, Ati HotKey Poller, AudioSrv, BITS, CcmExec,
              Client for NFS, CryptSvc, DcomLaunch, Dhcp, dmserver,
              Dnscache, ERSvc, Eventlog, EventSystem, FwcAgent, helpsvc,
              HidServ, IISADMIN, InoRPC, InoRT, InoTask, lanmanserver,
              lanmanworkstation, LmHosts, MDM, Netlogon, Netman, Nla,
              NtLmSsp, PlugPlay, PolicyAgent, ProtectedStorage, RasMan,
              RemoteRegistry, RpcSs, SamSs, Schedule, seclogon, SENS,
              SharedAccess, ShellHWDetection, SMT PSVC, Spooler,
              srservice, SSDPSRV, stisvc, TapiSrv, TermService, Themes,
              TrkWks, UMWdf, W32Time, W3SVC, WebClient, winmgmt, wscsvc,
              wuauserv, WZCSVC, zzInterix}

41 Stopped    {Alerter, AppMgmt, aspnet_state, ATI Smart, Browser, CiSvc,
              ClipSrv, clr_optimization_v2.0.50727_32, COMSysApp,
              CronService, dmadmin, FastUserSwitchingCompatibility,
              HTTPFilter, ImapiService, Mapsvc, Messenger, mnmsrvc,
              MSDTC, MSIServer, msvsmon80, NetDDE, NetDDEdsdm, NtmsSvc,
              NVSvc, ose, RasAuto, RDSessMgr, RemoteAccess, RpcLocator,
              SCardSvr, SwPrv, SysmonLog, TlntSvr, upnphost, UPS, VSS,
              WmdmPmSN, Wmi, WmiApSrv, xmlprov}
```

#### \$InformationPreference

The \$InformationPreference variable lets you set information stream
preferences (specifically, informational messages that you have added to
commands or scripts by adding the Write-Information cmdlet, and want displayed
to users) for a PowerShell session. The value of the -InformationAction
parameter, if used, overrides the current value of the \$InformationPreference
variable.

Valid values:

- Stop: Stops a command or script at an occurrence of the Write-Information
  command.
- Inquire: Displays the informational message that you specify in a
  Write-Information command, then asks whether you want to continue.
- Continue: Displays the informational message, and continues running.
- Suspend: Automatically suspends a workflow job after a Write-Information
  command is carried out, to allow users to see the messages before
  continuing. The workflow can be resumed at the user’s discretion.
- SilentlyContinue: No effect. The informational messages are not (Default)
  displayed, and the script continues without interruption.


#### \$Log*Event

The Log*Event preference variables determine which types of events are written
to the PowerShell event log in Event Viewer. By default, only engine and
provider events are logged, but you can use the Log*Event preference variables
to customize your log, such as logging events about commands.

The Log*Event preference variables are as follows:

- \$LogCommandHealthEvent: Logs errors and exceptions in command
  initialization and processing. Default = \$false (not logged).

- \$LogCommandLifecycleEvent: Logs the starting and stopping of commands and
  command pipelines and security exceptions in command discovery. Default =
  \$false (not logged).

- \$LogEngineHealthEvent: Logs errors and failures of sessions. Default =
  \$true (logged).

- \$LogEngineLifecycleEvent: Logs the opening and closing of sessions.
  Default = \$true (logged).

- \$LogProviderHealthEvent: Logs provider errors, such as read and write
  errors, lookup errors, and invocation errors. Default = \$true (logged).

- \$LogProviderLifecycleEvent: Logs adding and removing of PowerShell
  providers. Default = \$true (logged). (For information about PowerShell
  providers, type: "get-help about_provider".

To enable a Log*Event, type the variable with a value of \$true, for example:

```powershell
\$LogCommandLifeCycleEvent
```

- or -

```powershell
\$LogCommandLifeCycleEvent = \$true
```

To disable an event type, type the variable with a value of \$false, for
example:

```powershell
\$LogCommandLifeCycleEvent = \$false
```

The events that you enable are effective only for the current PowerShell
console. To apply the configuration to all consoles, save the variable
settings in your PowerShell profile.

#### \$MaximumAliasCount

Determines how many aliases are permitted in a PowerShell session. The default
value, 4096, should be sufficient for most uses, but you can adjust it to meet
your needs.

Valid values: 1024 - 32768 (Int32)

Default: 4096

To count the aliases on your system, type:

```powershell
(get-alias).count
```

#### \$MaximumDriveCount

Determines how many PowerShell drives are permitted in a given session. This
includes file system drives and data stores that are exposed by PowerShell
providers and appear as drives, such as the Alias: and HKLM: drives.

Valid values: 1024 - 32768 (Int32)

Default: 4096

To count the aliases on your system, type:

```powershell
(get-psdrive).count
```

#### \$MaximumErrorCount

Determines how many errors are saved in the error history for the session.

Valid values: 256 - 32768 (Int32)

Default: 256

Objects that represent each retained error are stored in the \$Error automatic
variable. This variable contains an array of error record objects, one for
each error. The most recent error is the first object in the array
(\$Error[0]).

To count the errors on your system, use the Count property of the \$Error
array. Type:

```powershell
\$Error.count
```

To display a specific error, use array notation to display the error. For
example, to see the most recent error, type:

```powershell
\$Error[0]
```

To display the oldest retained error, type:

```powershell
\$Error[(\$Error.Count -1]
```

To display the properties of the ErrorRecord object, type:

```powershell
\$Error[0] | format-list -property * -force
```

In this command, the Force parameter overrides the special formatting of
ErrorRecord objects and reverts to the conventional format.

To delete all errors from the error history, use the Clear method of the error
array.

```powershell
PS> \$Error.count
17
PS> \$Error.clear()
PS>
PS> \$Error.count
0
```

To find all properties and methods of an error array, use the Get-Member
cmdlet with its InputObject parameter. When you pipe a collection of objects
to Get-Member, Get-Member displays the properties and methods of the objects
in the collection. When you use the InputObject parameter of Get-Member,
Get-Member displays the properties and methods of the collection.

#### \$MaximumFunctionCount

Determines how many functions are permitted in a given session.

Valid values: 1024 - 32768 (Int32)

Default: 4096

To see the functions in your session, use the PowerShell Function: drive that
is exposed by the PowerShell Function provider. (For more information about
the Function provider, type "get-help function").

To list the functions in the current session, type:

```powershell
get-childitem function:
```

To count the functions in the current session, type:

```powershell
(get-childitem function:).count
```

#### \$MaximumHistoryCount

Determines how many commands are saved in the command history for the
current session.

Valid values: 1 - 32768 (Int32)

Default: 4096

To determine the number of commands current saved in the command
history, type:

```powershell
(get-history).count
```

To see the command saved in your session history, use the Get-History
cmdlet. For more information, see [about_History](about_History.md).

#### \$MaximumVariableCount

Determines how many variables are permitted in a given session, including
automatic variables, preference variables, and the variables that you create
in commands and scripts.

Valid values: 1024 - 32768 (Int32)

Default: 4096

To see the variables in your session, use the Get-Variable cmdlet and the
features of the PowerShell Variable: drive and the PowerShell Variable
provider. For information about the Variable provider, type "get-help
variable".

To find the current number of variables on the system, type:

```powershell
(get-variable).count
```

#### \$OFS

Output Field Separator. Specifies the character that separates the elements of
an array when the array is converted to a string.

Valid values: Any string.
Default: Space

By default, the \$OFS variable does not exist and the output file separator is
a space, but you can add this variable and set it to any string.

##### EXAMPLES

This example shows that a space is used to separate the values when an array
is converted to a string. In this case, an array of integers is stored in a
variable and then the variable is cast as a string.

```powershell
PS> \$array = 1,2,3                 # Store an array of integers.

PS> [string]\$array                 # Cast the array to a string.
1 2 3                              # Spaces separate the elements
```

To change the separator, add the \$OFS variable by assigning a value to it.
To work correctly, the variable must be named \$OFS.

```powershell
PS> \$OFS = "+"                     # Create \$OFS and assign a "+"

PS> [string]\$array                 # Repeat the command
1+2+3                              # Plus signs separate the elements
```

To restore the default behavior, you can assign a space (" ") to the value of
\$OFS or delete the variable. This command deletes the variable and then
verifies that the separator is a space.

```powershell
PS> Remove-Variable OFS            # Delete \$OFS
PS>

PS> [string]\$array                 # Repeat the command
1 2 3                              # Spaces separate the elements
```

#### \$OutputEncoding

Determines the character encoding method that PowerShell uses when it sends
text to other applications.

For example, if an application returns Unicode strings to PowerShell, you
might need to change the value to UnicodeEncoding to send the characters
correctly.

Valid values: Objects derived from an Encoding class, such as ASCIIEncoding,
SBCSCodePageEncoding, UTF7Encoding, UTF8Encoding, UTF32Encoding, and
UnicodeEncoding.

Default: ASCIIEncoding object (System.Text.ASCIIEncoding)

##### EXAMPLES

This example shows how to make the FINDSTR command in Windows work in
PowerShell on a computer that is localized for a language that uses Unicode
characters, such as Chinese.

The first command finds the value of \$OutputEncoding. Because the value is an
encoding object, display only its EncodingName property.

```powershell
PS> \$OutputEncoding.EncodingName # Find the current value US-ASCII
```

In this example, a FINDSTR command is used to search for two Chinese
characters that are present in the Test.txt file. When this FINDSTR command is
run in the Windows Command Prompt (Cmd.exe), FINDSTR finds the characters in
the text file. However, when you run the same FINDSTR command in PowerShell,
the characters are not found because the PowerShell sends them to FINDSTR in
ASCII text, instead of in Unicode text.

```powershell
PS> findstr <Unicode-characters>  # Use findstr to search.
PS>                               # None found.
```

To make the command work in PowerShell, set the value of \$OutputEncoding to
the value of the OutputEncoding property of the console, which is based on the
locale selected for Windows. Because OutputEncoding is a static property of
the console, use double-colons (::) in the command.

```powershell
PS> \$OutputEncoding = [console]::outputencoding
PS> # Set the value equal to the OutputEncoding property of the console.
PS> \$OutputEncoding.EncodingName
OEM United States
```
As a result of this change, the FINDSTR command finds the characters.

```powershell
PS> findstr <Unicode-characters>
test.txt:         <Unicode-characters>
```

#### \$ProgressPreference

Determines how PowerShell responds to progress updates generated by a script,
cmdlet or provider, such as the progress bars generated by the Write-Progress
cmdlet. The Write-Progress cmdlet creates progress bars that depict the status
of a command.

Valid values:

- Stop: Does not display the progress bar. Instead, it displays an error
  message and stops executing.
- Inquire: Does not display the progress bar. Prompts for permission to
  continue. If you reply with Y or A, it displays the progress bar.
- Continue: Displays the progress bar and continues with (Default)
  execution.
- SilentlyContinue: Executes the command, but does not display the progress
  bar.

#### \$PSEmailServer

Specifies the default e-mail server that is used to send e-mail messages. This
preference variable is used by cmdlets that send e-mail, such as the
Send-MailMessage cmdlet.

#### \$PSDefaultParameterValues

Specifies default values for the parameters of cmdlets and advanced functions.
The value of \$PSDefaultParameterValues is a hash table where the key consists
of the cmdlet name and parameter name separated by a colon (:) and the value
is a custom default value that you specify.

This variable was introduced in PowerShell 3.0

For more information about this preference variable, see
[about_Parameters_Default_Values](about_Parameters_Default_Values.md).

#### \$PSModuleAutoloadingPreference

Enables and disables automatic importing of modules in the session. "All" is
the default. Regardless of the value of this variable, you can use the
Import-Module cmdlet to import a module.

Valid values are:

- All: Modules are imported automatically on first-use. To import a module,
  get (Get-Command) or use any command in the module.
- ModuleQualified: Modules are imported automatically only when a user uses
  the module-qualified name of a command in the module. For example, if the
  user types "MyModule\MyCommand", PowerShell imports the MyModule module.
- None: Automatic importing of modules is disabled in the session. To import
  a module, use the Import-Module cmdlet.

For more information about automatic importing of modules, see
[about_Modules](about_Modules.md).

#### \$PSSessionApplicationName

Specifies the default application name for a remote command that uses
WS-Management technology.

The system default application name is WSMAN, but you can use this preference
variable to change the default.

The application name is the last node in a connection URI. For example, the
application name in the following sample URI is WSMAN.

http://Server01:8080/WSMAN

The default application name is used when the remote command does not specify
a connection URI or an application name.

The WinRM service uses the application name to select a listener to service
the connection request. The value of this parameter should match the value of
the URLPrefix property of a listener on the remote computer.

To override the system default and the value of this variable, and select a
different application name for a particular session, use the ConnectionURI or
ApplicationName parameters of the New-PSSession, Enter-PSSession or
Invoke-Command cmdlets.

This preference variable is set on the local computer, but it specifies a
listener on the remote computer. If the application name that you specify does
not exist on the remote computer, the command to establish the session fails.

#### \$PSSessionConfigurationName

Specifies the default session configuration that is used for PSSessions
created in the current session.

This preference variable is set on the local computer, but it specifies a
session configuration that is located on the remote computer.

The value of the \$PSSessionConfigurationName variable is a fully
qualified resource URI.

The default value:

http://schemas.microsoft.com/PowerShell/microsoft.PowerShell

indicates the Microsoft.PowerShell session configuration on the remote
computer.

If you specify only a configuration name, the following schema URI is
prepended:

http://schemas.microsoft.com/PowerShell/

You can override the default and select a different session configuration for
a particular session by using the ConfigurationName parameter of the
New-PSSession, `Enter-PSSession` or `Invoke-Command` cmdlets.

You can change the value of this variable at any time. When you do, remember
that the session configuration that you select must exist on the remote
computer. If it does not, the command to create a session that uses the
session configuration fails.

This preference variable does not determine which local session configurations
are used when remote users create a session that connects to this computer.
However, you can use the permissions for the local session configurations to
determine which users may use them.

#### \$PSSessionOption

Establishes the default values for advanced user options in a remote session.
These option preferences override the system default values for session
options.

The \$PSSessionOption variable contains a PSSessionOption object
(System.Management.Automation.Remoting.PSSessionObject). Each property of the
object represents a session option. For example, the NoCompression property
turns of data compression during the session.

By default, the \$PSSessionOption variable contains a PSSessionOption object
with the default values for all options, as shown below.

```output
MaximumConnectionRedirectionCount : 5
NoCompression                     : False
NoMachineProfile                  : False
ProxyAccessType                   : None
ProxyAuthentication               : Negotiate
ProxyCredential                   :
SkipCACheck                       : False
SkipCNCheck                       : False
SkipRevocationCheck               : False
OperationTimeout                  : 00:03:00
NoEncryption                      : False
UseUTF16                          : False
IncludePortInSPN                  : False
OutputBufferingMode               : None
Culture                           :
UICulture                         :
MaximumReceivedDataSizePerCommand :
MaximumReceivedObjectSize         : 209715200
ApplicationArguments              :
OpenTimeout                       : 00:03:00
CancelTimeout                     : 00:01:00
IdleTimeout                       : -00:00:00.0010000
```

For descriptions of these options, see the help topic for the
`New-PSSessionOption` cmdlet.

To change the value of the \$PSSessionOption preference variable, use the
New-PSSessionOption cmdlet to create a PSSessionOption object with the option
values you prefer. Save the output in a variable called \$PSSessionOption.

For example,

```powershell
\$PSSessionOption = New-PSSessionOption -NoCompression
```

To use the \$PSSessionOption preference variable in every PowerShell session,
add a New-PSSessionOption command that creates the \$PSSessionOption variable
to your Windows PowerShell profile.

You can also set custom options for a particular remote session. The options
that you set take precedence over the system defaults and the value of the
\$PSSessionOption preference variable.

To set custom session options, use the New-PSSessionOption cmdlet to create a
PSSessionOption object. Then, use the PSSessionOption object as the value of
the SessionOption parameter in cmdlets that create a session, such as
New-PSSession, Enter-PSSession, and Invoke-Command.

For more information about the New-PSSessionOption cmdlet, see the help topic
for `New-PSSessionOption`. For more information about remote commands and
sessions, see [about_Remote](about_Remote.md) and
[about_PSSessions](about_PSSessions.md). For more information about using a
profile, see [about_Profiles](about_Profiles.md).

#### \$VerbosePreference

Determines how PowerShell responds to verbose messages generated by a script,
cmdlet or provider, such as the messages generated by the Write-Verbose
cmdlet. Typically, verbose messages describe the actions performed to execute
a command.

By default, verbose messages are not displayed, but you can change this
behavior by changing the value of \$VerbosePreference.

You can also use the Verbose common parameter of a cmdlet to display or hide
the verbose messages for a specific command. For more information, type:
"get-help about_commonparameters".

Valid values:

- Stop: Displays the verbose message and an error message and then stops
  executing.
- Inquire: Displays the verbose message and then displays a prompt that asks
  you whether you want to continue.
- Continue: Displays the verbose message and then continues with execution.
- SilentlyContinue: Does not display the verbose message. Continues
  executing. (Default)

### EXAMPLES

These examples show the effect of the different values of \$VerbosePreference
and the use of the Verbose common parameter to override the preference value.

This example shows the effect of the SilentlyContinue value, which is the
default.

```powershell
PS> $VerbosePreference             # Find the current value.
SilentlyContinue

PS> # Write a verbose message.
PS> Write-Verbose "Verbose message test."
PS>                   # Message is not displayed.

PS> # Use the Verbose parameter.
PS> Write-Verbose "Verbose message test." -verbose
VERBOSE: Verbose message test.
```

This example shows the effect of the Continue value.

```powershell
PS> # Change the value to Continue.
PS> $VerbosePreference = "Continue"
PS> Write-Verbose "Verbose message test."
VERBOSE: Verbose message test.
PS> # Message is displayed.

PS> # Use the Verbose parameter with a value of $false.
PS> Write-Verbose "Verbose message test." -verbose:$false
PS> # Message is not displayed.
```

This example shows the effect of the Stop value.

```powershell
PS> # Change the value to Stop.
PS> $VerbosePreference = "Stop"
PS> Write-Verbose "Verbose message test."
VERBOSE: Verbose message test.
Write-Verbose : Command execution stopped because the shell variable
"VerbosePreference" is set to Stop.
At line:1 char:14
+ Write-Verbose  <<<< "Verbose message test."

PS> # Use the Verbose parameter with a value of $false
PS> Write-Verbose "Verbose message test." -verbose:$false
PS>                # Message is not displayed.
```

This example shows the effect of the Inquire value.

```powershell
PS> # Change the value to Inquire.
PS> \$VerbosePreference = "Inquire"
PS> Write-Verbose "Verbose message test."
VERBOSE: Verbose message test.
Confirm
Continue with this operation?
[Y] Yes  [A] Yes to All  [H] Halt Command  [S] Suspend
[?] Help (default is "Y"): y
PS>

PS> # Use the Verbose parameter.
PS> Write-Verbose "Verbose message test." -verbose:$false
PS>                #Message is not displayed.
```

#### \$WarningPreference

Determines how PowerShell responds to warning messages generated by a script,
cmdlet or provider, such as the messages generated by the Write-Warning
cmdlet.

By default, warning messages are displayed and execution continues, but you
can change this behavior by changing the value of \$WarningPreference.

You can also use the WarningAction common parameter of a cmdlet to determine
how PowerShell responds to warnings from a particular command. For more
information, type: "get-help about_commonparameters".

Valid values:

- Stop: Displays the warning message and an error message and then stops
  executing.
- Inquire: Displays the warning message and then prompts for permission to
  continue.
- Continue: Displays the warning message and then (Default) continues
  executing.
- SilentlyContinue: Does not display the warning message. Continues
  executing.

##### EXAMPLES

These examples show the effect of the different values of \$WarningPreference
and the use of the WarningAction common parameter to override the preference
value.

This example shows the effect of the Continue value, which is the default.

```powershell
PS> \$WarningPreference    # Find the current value.
Continue
PS> Write-Warning "This action can delete data."
WARNING: This action can delete data.

PS> # Use the WarningAction parameter to suppress the warning
PS> Write-Warning "This action can delete data." -warningaction `
 silentlycontinue
```

This example shows the effect of the SilentlyContinue value.

```powershell
PS> # Change the value to SilentlyContinue.
PS> \$WarningPreference = "SilentlyContinue"
PS> Write-Warning "This action can delete data."
PS>                        # Write a warning message.

PS> # Use the WarningAction to stop when a warning is generated.
PS> Write-Warning "This step can delete data." -warningaction stop
WARNING: This action can delete data.
Write-Warning : Command execution stopped because the shell variable
"WarningPreference" is set to Stop.
At line:1 char:14
+ Write-Warning <<<<  "This action can delete data." -warningaction stop
```

This example shows the effect of the Inquire value.

```powershell
PS> # Change the value to Inquire.
PS> \$WarningPreference = "Inquire"
PS> Write-Warning "This action can delete data."
WARNING: This action can delete data.

Confirm
Continue with this operation?
[Y] Yes  [A] Yes to All  [H] Halt Command  [S] Suspend
[?] Help (default is "Y"): y
PS>

PS> # Use the WarningAction to continue without stopping.
PS> Write-Warning "This step can delete data." -warningaction `
 silentlycontinue
```

This example shows the effect of the Stop value.

```powershell
PS> # Change the value to Stop.
PS> \$WarningPreference = "Stop"

PS> Write-Warning "This action can delete data."
WARNING: This action can delete data.
Write-Warning : Command execution stopped because the shell variable
"WarningPreference" is set to Stop.
At line:1 char:14
+ Write-Warning  <<<< "This action can delete data."

PS> # Use the WarningAction to ask when a warning occurs.
PS> Write-Warning "This action can delete data." -warningaction inquire
WARNING: This action can delete data.

Confirm
Continue with this operation?
[Y] Yes  [A] Yes to All  [H] Halt Command  [S] Suspend
[?] Help (default is "Y"):
```

#### \$WhatIfPreference

Determines whether WhatIf is automatically enabled for every command that
supports it. When WhatIf is enabled, the cmdlet reports the expected effect of
the command, but does not execute the command.

Valid values:

- 0: WhatIf is not automatically enabled. To (Default) enable it manually,
  use the WhatIf parameter of the command.
- 1: WhatIf is automatically enabled on any command that supports it. Users
  can use the WhatIf command with a value of False to disable it manually
  (WhatIf:\$false).

When a cmdlet supports WhatIf, the cmdlet reports the expected effect of the
command, instead of executing the command. For example, instead of deleting
the test.txt file in response to a `Remove-Item` command, PowerShell reports
what it would delete. A subsequent `Get-Childitem` command confirms that the
file was not deleted.

```powershell
PS> # What if: Performing "Remove-Item" on Target "Item: C:\test.txt"
PS> remove-item test.txt
PS> get-childitem test.txt

Directory: Microsoft.PowerShell.Core\FileSystem::C:

Mode                LastWriteTime     Length     Name
----                -------------     ------     ----
-a---         7/29/2006   7:15 PM         84     test.txt
```

##### EXAMPLES

These examples show the effect of the different values of \$WhatIfPreference.
They also show how to use the WhatIf cmdlet parameter to override the
preference value for a specific command.

This example shows the effect of the 0 (not enabled) value, which is the
default.

```powershell
PS> \$whatifpreference
0                         # Check the current value.

PS> # Verify that the file exists.
PS> get-childitem test.txt | format-list FullName
FullName : C:\test.txt

PS> remove-item test.txt
PS>                       # Delete the file.

PS> # Verify that the file is deleted.
PS> get-childitem test.txt | format-list -property FullName

Get-ChildItem : Cannot find path 'C:\test.txt' because it does not exist.
At line:1 char:14
+ get-childitem  <<<< test.txt | format-list fullname
```

This example shows the effect of using the WhatIf parameter when the value
of \$WhatIfPreference is 0.

```powershell
PS> # Verify that the file exists.
PS> get-childitem test2.txt | format-list -property FullName
FullName : C:\test2.txt

PS> # Use the WhatIf parameter
PS> remove-item test2.txt -whatif
What if: Performing operation "Remove File" on Target "C:\test2.txt".

PS> # Verify that the file was not deleted
PS> get-childitem test2.txt | format-list -property FullName
FullName : C:\test2.txt
```

This example shows the effect of the 1 (WhatIf enabled) value. When you use
Remove-Item to delete a cmdlet, Remove-Item displays the path to the file that
it would delete, but it does not delete the file.

```powershell
PS> \$whatifpreference = 1
PS> \$whatifpreference
1                        # Change the value.

PS> # Try to delete a file.
PS> remove-item test.txt
What if: Performing operation "Remove File" on Target "C:\test.txt".

PS> # Verify that the file exists.
PS> get-childitem test.txt | format-list FullName
FullName : C:\test.txt
```

This example shows how to delete a file when the value of \$WhatIfPreference
is 1. It uses the WhatIf parameter with a value of \$false.

```powershell
PS> # Use the WhatIf parameter with \$false.
PS> remove-item test.txt -whatif:\$false
```

This example demonstrates that some cmdlets support WhatIf behavior and others
do not. In this example, in which the value of \$WhatIfPreference is 1
(enabled), a Get-Process command, which does not support WhatIf, is executed,
but a Stop-Process command performs the WhatIf behavior. You can override the
WhatIf behavior of the Stop-Process command by using the WhatIf parameter with
a value of \$false.

```powershell
PS> # Change the value to 1.
PS> \$whatifpreference = 1

PS> get-process winword
A Get-Process command completes.

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
234       8     6324      15060   154     0.36   2312 WINWORD

PS> # A Stop-Process command uses WhatIf.
PS> stop-process -name winword
What if: Performing operation "Stop-Process" on Target "WINWORD (2312)".

PS> stop-process -name winword  -whatif:\$false
PS>                      # WhatIf:\$false overrides the preference.

PS> # Verify that the process is stopped.
PS> get-process winword
Get-Process : Cannot find a process with the name 'winword'. Verify the
process name and call the cmdlet again.
At line:1 char:12
+ get-process  <<<< winword
```

## SEE ALSO

- [about_Automatic_Variables](about_Automatic_Variables.md)
- [about_CommonParameters](about_CommonParameters.md)
- [about_Environment_Variables](about_Environment_Variables.md)
- [about_Profiles](about_Profiles.md)
- [about_Remote](about_Remote.md)
- [about_Scopes](about_Scopes.md)
- [about_Variables](about_Variables.md)

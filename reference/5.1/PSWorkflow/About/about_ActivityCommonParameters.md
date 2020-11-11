---
description:  Describes the parameters that Windows PowerShell Workflow adds to activities.
keywords: powershell,cmdlet
Locale: en-US
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/psworkflow/about/about_activitycommonparameters?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_ActivityCommonParameters
---
# About ActivityCommonParameters

## SHORT DESCRIPTION

Describes the parameters that Windows PowerShell Workflow adds to activities.

## LONG DESCRIPTION

Windows PowerShell Workflow adds the activity common parameters to activities
that are derived from the PSActivity base class. This category includes the
InlineScript activity and Windows PowerShell cmdlets that are implemented as
activities, such as Get-Process and Get-WinEvent.

The activity common parameters are not valid on the Suspend-Workflow and
Checkpoint-Workflow activities and they are not added to cmdlets or expressions
that Windows PowerShell Workflow automatically runs in an InlineScript script
block or similar activity. The activity common parameters are available on the
InlineScript activity, but not on commands in the InlineScript script block.

Several of the activity common parameters are also workflow common parameters
or Windows PowerShell common parameters. Other activity common parameters are
unique to activities.

For information about the workflow common parameters, see
about_WorkflowCommonParameters. For information about the Windows PowerShell
common parameters, see about_CommonParameters.

### LIST OF ACTIVITY COMMON PARAMETERS

```
AppendOutput                      PSDebug
Debug                             PSDisableSerialization
DisplayName                       PSDisableSerializationPreference
ErrorAction                       PSError
Input                             PSPersist
MergeErrorToOutput                PSPort
PSActionRetryCount                PSProgress
PSActionRetryIntervalSec          PSProgressMessage
PSActionRunningTimeoutSec         PSRemotingBehavior
PSApplicationName                 PSRequiredModules
PSAuthentication                  PSSessionOption
PSCertificateThumbprint           PSUseSSL
PSComputerName                    PSVerbose
PSConfigurationName               PSWarning
PSConnectionRetryCount            Result
PSConnectionRetryIntervalSec      UseDefaultInput
PSConnectionURI                   Verbose
PSCredential                      WarningAction
```

### PARAMETER DESCRIPTIONS

This section describes the activity common parameters.

#### AppendOutput \<Boolean\>

A value of `$True` adds the output of the activity to the value of the variable.
A value of `$False` has no effect. By default, assigning a value to a variable
replaces the variable value.

For example, the following commands add a process object to the service object
in the `$x` variable.

```powershell
Workflow Test-Workflow
{
    $x = Get-Service
    $x = Get-Process -AppendOutput $true
}
```

This parameter is designed for XAML-based workflows. In script workflows, you
can also use the += assignment operator to add output to the value of a
variable, as shown in the following example.

```powershell
Workflow Test-Workflow
{
    $x = Get-Service
    $x += Get-Process
}
```

#### Debug \<SwitchParameter\>

Displays programmer-level detail about the operation performed by the command.
The Debug parameter overrides the value of the $DebugPreference variable for
the current command. This parameter works only when the command generates
debugging messages. This parameter is also a Windows PowerShell common
parameter.

#### DisplayName \<String\>

Specifies a friendly name for the activity. The DisplayName value appears in
the progress bar while the workflow runs and in the value of the Progress
property of the workflow job. When the PSProgressMessage parameter is also
included in the command, the progress bar content appears in
\<DisplayName\>:\<PSProgressMessage\> format.

#### ErrorAction \<ActionPreference\>

Determines how the activity responds to a non-terminating error from the
command. It has no effect on termination errors. This parameter works only when
the command generates a non-terminating error, such as those from the
Write-Error cmdlet. The ErrorAction parameter overrides the value of the
$ErrorActionPreference variable for the current command. This parameter is also
a Windows PowerShell common parameter.

Valid values:

- Continue. Displays the error message and continues executing
  the command. "Continue" is the default value.

- Ignore. Suppresses the error message and continues executing the command.
  Unlike SilentlyContinue, Ignore does not add the error message to the $Error
  automatic variable. The Ignore value is introduced in Windows PowerShell 3.0.

- Inquire. Displays the error message and prompts you for confirmation before
  continuing execution. This value is rarely used.

- Suspend. Automatically suspends a workflow job to allow for further
  investigation. After investigation, the workflow can be resumed.

- SilentlyContinue. Suppresses the error message and continues executing the
  command.

- Stop. Displays the error message and stops executing the command.

#### Input \<Object[]\>

Submits a collection of objects to an activity. This is an alternative to
piping objects to the activity one at a time.

#### MergeErrorToOutput \<Boolean\>

A value of `$True` adds errors to the output stream. A value of `$False` has
not effect. Use this parameter with the Parallel and `ForEach -Parallel`
keywords to collect errors and output from multiple parallel commands
in a single collection.

#### PSActionRetryCount \<Int32\>

Tries repeatedly to run the activity if the first attempt fails. The default
value, 0, does not retry.

#### PSActionRetryIntervalSec \<Int32\>

Determines the interval between action retries in seconds. The default value,
0, retries the action immediately. This parameter is valid only when the
PSActionRetryCount parameter is also used in the command.

#### PSActionRunningTimeoutSec \<Int32\>

Determines how long the activity can run on each target computer. If the
activity does not complete before the timeout expires, Windows PowerShell
Workflow generates a terminating error and stops processing the workflow on the
affected target computer.

#### PSAllowRedirection \<Boolean\>

A value of $True allows redirection of the connection to the target computers.
A value of $False has no effect. This activity common parameter is also a
workflow common parameter.

When you use the PSConnectionURI parameter, the remote destination can return
an instruction to redirect to a different URI. By default, Windows PowerShell
does not redirect connections, but you can use the PSAllowRedirection parameter
with a value of $True to allow redirection of the connection to the target
computer.

You can also limit the number of times that the connection is redirected by
setting the MaximumConnectionRedirectionCount property of the `$PSSessionOption`
preference variable, or the MaximumConnectionRedirectionCount property of the
value of the SSessionOption parameter of cmdlets that create a session. The
default value is 5.

#### PSApplicationName \<String\>

Specifies the application name segment of the connection URI that is used to
connect to the target computers. Use this parameter to specify the application
name when you are not using the ConnectionURI parameter in the command. This
activity common parameter is also a workflow common parameter.

The default value is the value of the `$PSSessionApplicationName` preference
variable on the target computer. If this preference variable is not defined,
the default value is WSMAN. This value is appropriate for most uses. For more
information, see
[about_Preference_Variables](../../Microsoft.PowerShell.Core/About/about_Preference_Variables.md).

The WinRM service uses the application name to select a listener to service the
connection request. The value of this parameter should match the value of the
URLPrefix property of a listener on the remote computer.

#### PSAuthentication \<AuthenticationMechanism\>

Specifies the mechanism that is used to authenticate the user's credentials
when connecting to the target computers. Valid values are Default, Basic,
Credssp, Digest, Kerberos, Negotiate, and NegotiateWithImplicitCredential. The
default value is Default. This activity common parameter is also a workflow
common parameter.

For information about the values of this parameter, see the description of the
**System.Management.Automation.Runspaces.AuthenticationMechanism** enumeration in
the PowerShell SDK.

> [!WARNING]
> Credential Security Service Provider (CredSSP) authentication, in
> which the user's credentials are passed to a remote computer to be
> authenticated, is designed for commands that require authentication on more
> than one resource, such as accessing a remote network share. This mechanism
> increases the security risk of the remote operation. If the remote computer is
> compromised, the credentials that are passed to it can be used to control the
> network session.

#### PSCertificateThumbprint \<String\>

Specifies the digital public key certificate (X509) of a user account that has
permission to perform this action. Enter the certificate thumbprint of the
certificate. This activity common parameter is also a workflow common
parameter.

Certificates are used in client certificate-based authentication. They can only
be mapped to local user accounts; they do not work with domain accounts.

To get a certificate, use the [Get-Item](xref:Microsoft.PowerShell.Management.Get-Item)
or [Get-ChildItem](xref:Microsoft.PowerShell.Management.Get-ChildItem)
cmdlets in the Windows PowerShell Cert: drive.

#### PSComputerName \<String[]\>

Specifies the target computers on which the activity run. The default is the
local computer. This activity common parameter is also a workflow common
parameter.

Type the NETBIOS name, IP address, or fully-qualified domain name of one or
more computers in a comma-separated list. To specify the local computer, type
the computer name, "localhost", or a dot (.).

To include the local computer in the value of the PSComputerName parameter,
open Windows PowerShell with the "Run as administrator" option.

If this parameter is omitted from the command, or it value is $null or an empty
string, the workflow target is the local computer and Windows PowerShell
remoting is not used to run the command.

To use an IP address in the value of the ComputerName parameter, the command
must include the PSCredential parameter. Also, the computer must be configured
for HTTPS transport or the IP address of the remote computer must be included
in the WinRM TrustedHosts list on the local computer. For instructions for
adding a computer name to the TrustedHosts list, see "How to Add a Computer to
the Trusted Host List" in
[about_Remote_Troubleshooting](../../Microsoft.PowerShell.Core/About/about_Remote_Troubleshooting.md).

#### PSConfigurationName \<String\>

Specifies the session configurations that are used to create sessions on the
target computers. Enter the name of a session configuration on the target
computers (not on the computer that is running the workflow. The default is
Microsoft.PowerShell. This activity common parameter is also a workflow common
parameter.

#### PSConnectionRetryCount \<UInt\>

Specifies the maximum number of attempts to connect to each target computer if
the first connection attempt fails. Enter a number between 1 and 4,294,967,295
(UInt.MaxValue). The default value, zero (0), represents no retry attempts.
This activity common parameter is also a workflow common parameter.

#### PSConnectionRetryIntervalSec \<UInt\>

Specifies the delay between connection retry attempts in seconds. The default
value is zero (0). This parameter is valid only when the value of
PSConnectionRetryCount is at least 1. This activity common parameter is also a
workflow common parameter.

#### PSConnectionURI \<System.Uri\>

Specifies a Uniform Resource Identifier (URI) that defines the connection
endpoint for the activity on the target computer. The URI must be fully
qualified. This activity common parameter is also a workflow common parameter.

The format of this string is as follows:

```
<Transport>://<ComputerName>:<Port>/<ApplicationName>
```

The default value is `http://localhost:5985/WSMAN`.

If you do not specify a PSConnectionURI, you can use the PSUseSSL,
PSComputerName, PSPort, and PSApplicationName parameters to specify the
PSConnectionURI values.

Valid values for the Transport segment of the URI are HTTP and HTTPS. If you
specify a connection URI with a Transport segment, but do not specify a port,
the session is created with standards ports: 80 for HTTP and 443 for HTTPS. To
use the default ports for Windows PowerShell remoting, specify port 5985 for
HTTP or 5986 for HTTPS.

#### PSCredential \<PSCredential\>

Specifies a user account that has permission to run the activity on the target
computer. The default is the current user. This parameter is valid only when
the PSComputerName parameter is included in the command. This activity common
parameter is also a workflow common parameter.

Type a user name, such as "User01" or "Domain01\User01", or enter a variable
that contains a PSCredential object, such as one that the Get-Credential cmdlet
returns. If you enter only a user name, you will be prompted for a password.

#### PSDebug \<PSDataCollection[DebugRecord]\>

Adds debug messages from the activity to the specified debug record collection,
instead of writing the debug messages to the console or to the value of the
Debug property of the workflow job. You can add debug messages from multiple
activities to the same debug record collection object.

To use this activity common parameter, use the New-Object cmdlet to create a
PSDataCollection object with a type of DebugRecord and save the object in a
variable. Then, use the variable as the value of the PSDebug parameter of one
or more activities, as shown in the following example.

```powershell
Workflow Test-Workflow
{
    $debugCollection = New-Object -Type `
    System.Management.Automation.PSDataCollection[System.Management.Automation.DebugRecord]
    InlineScript {\Server01\Share01\Get-AssetData.ps1} -PSDebug $debugCollection -Debug $True
    InlineScript {\Server01\Share01\Set-AssetData.ps1} -PSDebug $debugCollection -Debug $True
    if ($debugCollection -like "Missing") { ...}
}
```

#### PSDisableSerialization \<Boolean\>

Directs the activity to return "live" (not serialized) objects to the workflow.
The resulting objects have methods, as well as properties, but they cannot be
saved when a checkpoint is taken.

#### PSDisableSerializationPreference \<Boolean\>

Applies the equivalent of the PSDisableSerialization parameter to the entire
workflow, not just the activity. Adding this parameter is generally not
recommended, because a workflow that doesn't serialize its objects cannot be
resumed or persisted.

Valid values:

- (Default) If omitted, and you have also not added the
  PSDisableSerialization parameter to an activity, objects are serialized.

- `$True`. Directs all activities within a workflow to return
  "live" (not serialized) objects. The resulting objects have methods, as well
  as properties, but they cannot be saved when a checkpoint is taken.
- `$False`. Workflow objects are serialized.

#### PSError \<PSDataCollection[ErrorRecord]\>

Adds error messages from the activity to the specified error record collection,
instead of writing the error messages to the console or to the value of the
Error property of the workflow job. You can add error messages from multiple
activities to the same error record collection object.

To use this activity common parameter, use the `New-Object` cmdlet to create a
PSDataCollection object with a type of ErrorRecord and save the object in a
variable. Then, use the variable as the value of the PSError parameter of one
or more activities, as shown in the following example.

```powershell
Workflow Test-Workflow
{
   $typeName = "System.Management.Automation.PSDataCollection"
   $typeName += '[System.Management.Automation.ErrorRecord]'
   $ec = New-Object $typeName
   InlineScript {\Server01\Share01\Get-AssetData.ps1} -PSError $ec
   InlineScript {\Server01\Share01\Set-AssetData.ps1} -PSError $ec
   if ($ec.Count -gt 2)
   {
      # Do Some Work.
   }
}
```

#### PSPersist \<Boolean\>

Takes a checkpoint after the activity. This checkpoint is in addition to any
checkpoints that are specified in the workflow. This activity common parameter
is also a workflow common parameter.

A "checkpoint" or "persistence point" is a snapshot of the workflow state and
data that is captured while the workflow runs and is saved to a persistence
store on disk. Windows PowerShell Workflow uses the saved data to resume a
suspended or interrupted workflow from the last persistence point, rather than
to restart the workflow.

Valid values:

- (Default) If you omit this parameter, no checkpoints are
  added. Checkpoints are taken based on the settings for the workflow.

- `$True`. Takes a checkpoint after the activity completes.
  This checkpoint is in addition to any checkpoints that are specified in
  the workflow.

- `$False`. No checkpoints are added. Checkpoints are taken only when
  specified in the workflow.

#### PSPort \<Int32\>

Specifies the network port on the target computers. The default ports are 5985
(the WinRM port for HTTP) and 5986 (the WinRM port for HTTPS). This activity
common parameter is also a workflow common parameter.

Do not use the PSPort parameter unless you must. The port set in the command
applies to all computers or sessions on which the command runs. An alternate
port setting might prevent the command from running on all computers. Before
using an alternate port, you must configure the WinRM listener on the remote
computer to listen at that port.

#### PSProgress \<PSDataCollection[ProgressRecord]\>

Adds progress messages from the activity to the specified progress record
collection, instead of writing the progress messages to the console or to the
value of the Progress property of the workflow job. You can add progress
messages from multiple activities to the same progress record collection
object.

#### PSProgressMessage \<String\>

Specifies a friendly description of the activity. The PSProgressMessage value
appears in the progress bar while the workflow runs. When the DisplayName is
also included in the command, the progress bar content appears in
\<DisplayName\>:\<PSProgressMessage\> format.

This parameter is particularly useful for identifying activities in a ForEach
-Parallel script block. Without this message, activities in all parallel
branches are identified by the same name.

#### PSRemotingBehavior \<RemotingBehavior\>

Specifies how remoting is managed when the activity is run on target computers.
PowerShell is the default.

Valid values are:

- None: The activity is not run on remote computers.

- PowerShell: Windows PowerShell remoting is used to run the activity on
  target computers.

- Custom: The activity supports its own type of remoting. This value is valid
  when the cmdlet that is being implemented as an activity sets the value of
  the RemotingCapability attribute to SupportedByCommand and the command
  includes the ComputerName parameter.

#### PSRequiredModules \<String[]\>

Imports the specified modules before running the command. Enter the module
names. The modules must be installed on the target computer.

Modules that are installed in a path specified in the PSModulePath environment
variable are automatically imported on first use of any command in the module.
Use this parameter to import modules that are not in a PSModulePath location.

Because each activity in a workflow runs in its own session, an Import-Module
command imports a module only into the session in which it runs. It does not
import the module into sessions in which other activities run.

#### PSSessionOption \<PSSessionOption\>

Sets advanced options for the sessions to the target computers. Enter a
PSSessionOption object, such as one that you create by using the
New-PSSessionOption cmdlet. This activity common parameter is also a workflow
common parameter.

The default values for the session options are determined by the value of the
`$PSSessionOption` preference variable, if it is set. Otherwise, the session
uses the values specified in the session configuration.

For a description of the session options, including the default values, see the
help topic for the New-PSSessionOption cmdlet
[New-PSSessionOption](xref:Microsoft.PowerShell.Core.New-PSSessionOption).

For more information about the $PSSessionOption preference variable, see
[about_Preference_Variables](../../Microsoft.PowerShell.Core/About/about_Preference_Variables.md).

#### PSUseSSL \<Boolean\>

A value of $True uses the Secure Sockets Layer (SSL) protocol to establish a
connection to the target computer. By default, SSL is not used. A value of
$False has no effect. This activity common parameter is also a workflow common
parameter.

WS-Management encrypts all Windows PowerShell content transmitted over the
network. UseSSL is an additional protection that sends the data across an
HTTPS, instead of HTTP. If you use this parameter, but SSL is not available on
the port used for the command, the command fails.

#### PSVerbose \<PSDataCollection[VerboseRecord]\>

Adds verbose messages from the activity to the specified verbose record
collection, instead of writing the verbose messages to the console or to the
value of the Verbose property of the workflow job. You can add verbose messages
from multiple activities to the same verbose record collection object.

#### PSWarning \<PSDataCollection[WarningRecord]\>

Adds warning messages from the activity to the specified warning record
collection, instead of writing the warning messages to the console or to the
value of the Warning property of the workflow job. You can add warning messages
from multiple activities to the same warning record collection object.

#### Result

This parameter is valid only in XAML workflows.

#### UseDefaultInput \<Boolean\>

Accepts all workflow input as input to the activity by value.

For example, the Get-Process activity in the following sample workflow uses the
UseDefaultInput activity common parameter to get input that is passed to the
workflow. When you run the workflow with input, that input is used by the
activity.

```powershell
workflow Test-Workflow
{
    Get-Service -UseDefaultInput $True
}

PS C:> Test-Workflow -InputObject WinRm
```

```output
Status   Name        DisplayName                            PSComputerName
------   ----        -----------                            --------------
Running  winrm       Windows Remote Management (WS-Manag... localhost
```

#### Verbose \<SwitchParameter\>

Displays detailed information about the operation performed by the command.
This information resembles the information in a trace or in a transaction log.
The Verbose parameter overrides the value of the $VerbosePreference variable
for the current command. This parameter works only when the command generates a
verbose message. This parameter is also a Windows PowerShell common parameter.

#### WarningAction \<ActionPreference\>

Determines how the activity responds to a warning. "Continue" is the default
value. The WarningAction parameter overrides the value of the
$WarningPreference variable for the current command. This parameter works only
when the command generates a warning message. This parameter is also a Windows
PowerShell common parameter.

Valid Values:

- SilentlyContinue. Suppresses the warning message and continues executing the
  command.

- Continue. Displays the warning message and continues executing the command.
  "Continue" is the default value.

- Inquire. Displays the warning message and prompts you for confirmation before
  continuing execution. This value is rarely used.

- Stop. Displays the warning message and stops executing the command.

> [!NOTE]
> The WarningAction parameter does not override
> the value of the $WarningAction preference variable
> when the parameter is used in a command to run a
> script or function.

### EXAMPLES

The activity common parameters are extremely useful. For example, you can use
the PSComputerName parameter to run particular activities on only a subset of
the target computers.

Or, you might use the PSConnectionRetryCount and PSConnectionRetryIntervalSec
parameters to adjust the retry values for particular activities.

The following example shows how to use the PSComputerName activity common
parameters to run a Get-EventLog activity only on computers it a particular
domain.

```powershell
Workflow Test-Workflow
{
    $UserDomain = Get-Content -Path '.\UserComputers.txt'
    $Log = (Get-EventLog -LogName "Windows PowerShell" `
      -PSComputerName $UserDomain)

    if ($Log)
    {
        # Do Work Here.
    }
}
```

<!--
# KEYWORDS
[about_Activity_Common_Parameters](about_Activity_Common_Parameters.md)
[about_Activity_Parameters](about_Activity_Parameters.md)
[about_ActivityParameters]()about_ActivityParameters.md) -->

## SEE ALSO

[about_Workflows](about_workflows.md)
[about_WorkflowCommonParameters](about_WorkflowCommonParameters.md)

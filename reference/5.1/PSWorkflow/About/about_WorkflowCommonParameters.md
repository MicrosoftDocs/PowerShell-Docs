---
description:  This topic describes the parameters that are valid on all Windows PowerShell workflow commands. Because the Windows PowerShell engine adds them to workflows, you can use these parameters on any workflow and they are automatically enabled on the workflows that you author.
keywords: powershell,cmdlet
Locale: en-US
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/psworkflow/about/about_workflowcommonparameters?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_WorkflowCommonParameters
---
# About WorkflowCommonParameters

## SHORT DESCRIPTION

This topic describes the parameters that are valid on all Windows PowerShell
workflow commands. Because the Windows PowerShell engine adds them to
workflows, you can use these parameters on any workflow and they are
automatically enabled on the workflows that you author.

## LONG DESCRIPTION

Windows PowerShell Workflow common parameters are a set of cmdlet parameters
that you can use with all Windows PowerShell workflows and activities. They are
added by the Windows PowerShell Workflow engine, not by the workflow author,
and they are automatically available on workflows and activities. However,
workflows that are nested three levels deep do not support any common
parameters, including workflow common parameters.

All workflow parameters are optional and named (not positional). They do not
take input from the pipeline.

Most of the workflow common parameters have a PS prefix, such as
`PSComputerName` and `PSCredential`. The PS-prefixed parameters configure the
connection and the execution environment for the target computers, also known
as "remote nodes."

Many of the workflow common parameters, such as `PSAllowRedirection` and
`AsJob`, have names that are similar to parameters used in Windows PowerShell
remoting and background jobs. These parameters work in the same way as the
similarly-named remoting and job parameters, so you can use the knowledge that
you developed in remoting and jobs to manage workflows.

Workflows are introduced in Windows PowerShell 3.0.

### PARAMETER DESCRIPTIONS

This section describes the workflow common parameters.

#### -AsJob \<SwitchParameter\>

Runs the workflow as a workflow job. The workflow command immediately returns
an object that represents a parent job. The parent job contains the child jobs
that are running on each of the target computers. To manage the job, use the
Job cmdlets. To get the job results, use
[Receive-Job](xref:Microsoft.PowerShell.Core.Receive-Job).

#### -JobName \<String\>

Specifies a friendly name for the workflow job. By default, jobs are named
"Job\<n\>", where \<n\> is an ordinal number.

If you use the JobName parameter in a workflow command, the workflow is run as
a job and the workflow command returns a job object, even if you do not include
the `AsJob` parameter in the command.

For more information about Windows PowerShell background jobs, see
[about_Jobs](../../Microsoft.PowerShell.Core/About/about_Jobs.md).

#### -PSAllowRedirection \<SwitchParameter\>

Allows redirection of the connection to the target computers.

When you use the `PSConnectionURI` parameter, the remote destination can return
an instruction to redirect to a different URI. By default, Windows PowerShell
does not redirect connections, but you can use the `PSAllowRedirection`
parameter to allow redirection of the connection to the target computer.

You can also limit the number of times that the connection is redirected by
setting the `MaximumConnectionRedirectionCount` property of the
`$PSSessionOption` preference variable, or the
`MaximumConnectionRedirectionCount` property of the value of the
`PSSessionOption parameter`. The default value is 5. For more information, see
the description of the `PSSessionOption` parameter and
[New-PSSessionOption](xref:Microsoft.PowerShell.Core.New-PSSessionOption).

#### -PSApplicationName \<String\>

Specifies the application name segment of the connection URI that is used to
connect to the target computers. Use this parameter to specify the application
name when you are not using the `ConnectionURI` parameter in the command.

The default value is the value of the `$PSSessionApplicationName` preference
variable on the local computer. If this preference variable is not defined, the
default value is WSMAN. This value is appropriate for most uses. For more
information, see
[about_Preference_Variables](../../Microsoft.PowerShell.Core/About/about_Preference_Variables.md).

The WinRM service uses the application name to select a listener to service the
connection request. The value of this parameter should match the value of the
`URLPrefix` property of a listener on the remote computer.

#### -PSAuthentication \<AuthenticationMechanism\>

Specifies the mechanism that is used to authenticate the user's credentials
when connecting to the target computers.

Valid values are:

- **Default**
- **Basic**
- **Credssp**
- **Digest**
- **Kerberos**
- **Negotiate**
- **NegotiateWithImplicitCredential**

The default value is **Default**.

For information about the values of this parameter, see the description of the
`System.Management.Automation.Runspaces.AuthenticationMechanism` enumeration in
the PowerShell SDK.

> [!WARNING]
> Credential Security Service Provider (CredSSP) authentication, in which the
> user's credentials are passed to a remote computer to be authenticated, is
> designed for commands that require authentication on more than one resource,
> such as accessing a remote network share. This mechanism increases the
> security risk of the remote operation. If the remote computer is compromised,
> the credentials that are passed to it can be used to control the network
> session.

#### -PSAuthenticationLevel \<AuthenticationLevel\>

Specifies the authentication level for the connections to the target computers.
The default value is **Default**.

Valid values are:

|Name |Description |
|---------|---------|
|**Unchanged** | The authentication level is the same as the previous command. |
|**Default** | Windows Authentication. |
|**None** | No COM authentication.   |
|**Connect** | Connect-level COM authentication.|
|**Call** | Call-level COM authentication.   |
|**Packet** | Packet-level COM authentication.|
|**PacketIntegrity** | Packet Integrity-level COM authentication.  |
|**PacketPrivacy** | Packet Privacy-level COM authentication. |

#### -PSCertificateThumbprint \<String\>

Specifies the digital public key certificate (X509) of a user account that has
permission to perform this action. Enter the certificate thumbprint of the
certificate.

Certificates are used in client certificate-based authentication. They can only
be mapped to local user accounts; they do not work with domain accounts.

To get a certificate, use the
[Get-Item](xref:Microsoft.PowerShell.Management.Get-Item) or [Get-ChildItem]
(../../Microsoft.PowerShell.Management/Get-Childitem.md) cmdlets in the Windows
PowerShell Cert: drive.

#### -PSComputerName \<String[]\>

Specifies the list of computers that are the target nodes of the workflow.
Commands or activities in a workflow are run on the computers that are
specified by using this parameter. The default is the local computer.

Type the NETBIOS name, IP address, or fully-qualified domain name of one or
more computers in a comma-separated list. To specify the local computer, type
the computer name, "localhost", or a dot (.).

To include the local computer in the value of the `PSComputerName` parameter,
open Windows PowerShell with the "Run as administrator" option.

If this parameter is omitted from the command, or it value is `$null` or an
empty string, the workflow target is the local computer and Windows
PowerShell remoting is not used to run the command.

To use an IP address in the value of the `ComputerName` parameter, the
command must include the `PSCredential` parameter. Also, the computer must be
configured for HTTPS transport or the IP address of the remote computer
must be included in the WinRM TrustedHosts list on the local computer. For
instructions for adding a computer name to the TrustedHosts list, see *"How
to Add a Computer to the Trusted Host List"* in [about_Remote_Troubleshooting](../../Microsoft.PowerShell.Core/About/about_Remote_Troubleshooting.md).

#### -PSConfigurationName \<String\>

Specifies the session configurations that are used to configure sessions on the
target computers. Enter a session configuration on the target computers (not
the workflow server computer). The default is `Microsoft.PowerShell.Workflow`.

#### -PSConnectionRetryCount \<UInt\>

Specifies the maximum number of attempts to connect to each target computer if
the first connection attempt fails. Enter a number between 1 and 4,294,967,295
(UInt.MaxValue). The default value, zero (0), represents no retry attempts.

#### -PSConnectionRetryIntervalSec \<UInt\>

Specifies the delay between connection retry attempts in seconds. The default
value is zero (0). This parameter is valid only when the value of
PSConnectionRetryCount is at least 1.

#### -PSConnectionURI \<System.Uri\>

Specifies a Uniform Resource Identifier (URI) that defines the connection
endpoint for the workflow on the target computer. The URI must be fully
qualified.

The format of this string is as follows:

`<Transport>://<ComputerName>:<Port>/<ApplicationName>`

The default value is `http://localhost:5985/WSMAN`.

If you do not specify a `PSConnectionURI`, you can use the `PSUseSSL`,
`PSComputerName`, `PSPort`, and `PSApplicationName` parameters to specify the
`PSConnectionURI` values.

Valid values for the Transport segment of the URI are **HTTP** and **HTTPS**.
If you specify a connection URI with a Transport segment, but do not specify a
port, the session is created with standards ports: 80 for HTTP and 443 for
HTTPS. To use the default ports for Windows PowerShell remoting, specify
port 5985 for HTTP or 5986 for HTTPS.

#### -PSCredential \<PSCredential\>

Specifies a user account that has permission to run a workflow on the target
computer. The default is the current user. This parameter is valid only when
the PSComputerName parameter is included in the command.

Type a user name, such as "User01" or "Domain01\User01", or enter a variable
that contains a `PSCredential` object, such as one that the `Get-Credential`
cmdlet returns. If you enter only a user name, you will be prompted for a
password.

#### -PSElapsedTimeoutSec \<UInt32\>

Determines how long the workflow and all related resources are maintained
in the system. When the timeout expires, the workflow is deleted, even if
it is still processing. Enter a value between 10 and 4,294,967,295. The
default value, 0 (zero), means that there is no elapsed timeout.

#### -PSParameterCollection \<Hashtable[]\>

Specifies different workflow common parameter values for different target
computers.

Enter a comma-separated list of hash tables with one hash table for each target
computer. In each hash table, the first key is `PSComputerName` and its value is
the name of the target computer. Wildcard characters are permitted in the
computer name. For the remaining keys in the hash table, the key is the
parameter name and the value is the parameter value.

For example:

```powershell
-PSParameterCollection @{PSComputerName="*"; PSElapsedTimeoutSec=20},
@{PSComputerName="Server02"},
@{PSComputerName="Server03"},
@{PSComputerName="Server01"; PSElapsedTimeoutSec=10}
```

In the above example, all connections will have a default PSElapsedTimeoutSec
of 20 seconds, except for Server01 which overrides the default value
by specifying its own timeout of 10 seconds.

#### -PSPersist \<Boolean\>

Adds checkpoints to the workflow, in addition to any checkpoints that are
specified in the workflow.

This parameter cannot suppress the checkpoints in a workflow, such as those
specified by using the `PSPersist` activity common parameter, the
`Checkpoint-Workflow` activity, or the `$PSPersistPreference` variable.

A "checkpoint" or "persistence point" is a snapshot of the workflow state and
data that is captured while the workflow runs and is saved to a persistence
store on disk or in a SQL database. Windows PowerShell Workflow uses the saved
data to resume a suspended or interrupted workflow from the last persistence
point, rather than to restart the workflow.

Valid values:

- (*Default*) If you omit this parameter, a checkpoint is added to the
  beginning and end of the workflow, in addition to any checkpoints that are
  specified in the workflow.

- `$True`. Adds a checkpoint to the beginning and end of the workflow and a
  checkpoint after each activity, in addition to any checkpoints that are
  specified in the workflow.

- `$False`. No checkpoints are added. Checkpoints are taken only when specified
  in the workflow.

#### -PSPort \<Int32\>

Specifies the network port on the target computers. The default ports are 5985
(the WinRM port for HTTP) and 5986 (the WinRM port for HTTPS).

Do not use the PSPort parameter unless you must. The port set in the command
applies to all computers or sessions on which the command runs. An alternate
port setting might prevent the command from running on all computers. Before
using an alternate port, you must configure the WinRM listener on the remote
computer to listen at that port.

#### -PSPrivateMetadata \<Hashtable\>

Provides customized information to workflow jobs. Enter a hash table. The keys
and values are customized for each workflow. For information about the private
metadata of a workflow, see the help topic for the workflow.

This parameter is not processed by the Windows PowerShell Workflow engine.
Instead, the engine passes the hash table directly to the workflow.

#### -PSRunningTimeoutSec \<UInt32\>

Specifies the running time of the workflow in seconds, excluding any time that
the workflow is suspended. If workflow execution is not complete when the time
expires, the Windows PowerShell Workflow engine forcibly stops the execution of
the workflow.

#### -PSSessionOption \<PSSessionOption\>

Sets advanced options for the sessions to the target computers. Enter a
`PSSessionOption` object, such as one that you create by using the
`New-PSSessionOption` cmdlet.

The default values for the session options are determined by the value of the
`$PSSessionOption` preference variable, if it is set. Otherwise, the session
uses the values specified in the session configuration.

For a description of the session options, including the default values, see the
help topic for the `New-PSSessionOption` cmdlet
(../../Microsoft.PowerShell.Core/New-PSSessionOption.md). For information about the
`$PSSessionOption` preference variable, see [about_Preference_Variables](../../Microsoft.PowerShell.Core/About/about_Preference_Variables.md).

#### -PSUseSSL \<SwitchParameter\>

Uses the Secure Sockets Layer (SSL) protocol to establish a connection to the
target computer. By default, SSL is not used.

WS-Management encrypts all Windows PowerShell content transmitted over the
network. UseSSL is an additional protection that sends the data across an
HTTPS, instead of HTTP. If you use this parameter, but SSL is not available on
the port used for the command, the command fails.

## SEE ALSO

- [about_ActivityCommonParameters](about_ActivityCommonParameters.md)
- [about_Workflows](about_Workflows.md)
- [Invoke-AsWorkflow](xref:PSWorkflowUtility.Invoke-AsWorkflow)
- [New-PSWorkflowExecutionOption](xref:PSWorkflow.New-PSWorkflowExecutionOption)
- [New-PSWorkflowSession](xref:PSWorkflow.New-PSWorkflowSession)

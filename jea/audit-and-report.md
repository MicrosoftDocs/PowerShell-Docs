---
ms.date:  2017-06-12
author:  rpsqrd
ms.topic:  conceptual
keywords:  jea,powershell,security
title:  Auditing and Reporting on JEA
---

# Auditing and Reporting on JEA

> Applies to: Windows PowerShell 5.0

After you've deployed JEA, you will want to regularly audit the JEA configuration.
This will help you assess if the correct people have access to the JEA endpoint and if their assigned roles are still appropriate.

This topic describes the various ways you can audit a JEA endpoint.

## Find registered JEA sessions on a machine

To check which JEA sessions are registered on a machine, use the [Get-PSSessionConfiguration](https://msdn.microsoft.com/powershell/reference/5.1/microsoft.powershell.core/get-pssessionconfiguration) cmdlet.

```powershell
# Filter for sessions that are configured as 'RestrictedRemoteServer' to find JEA-like session configurations
PS C:\> Get-PSSessionConfiguration | Where-Object { $_.SessionType -eq 'RestrictedRemoteServer' }


Name          : JEAMaintenance
PSVersion     : 5.1
StartupScript :
RunAsUser     :
Permission    : CONTOSO\JEA_DNS_ADMINS AccessAllowed, CONTOSO\JEA_DNS_OPERATORS AccessAllowed, CONTOSO\JEA_DNS_AUDITORS AccessAllowed
```

The effective rights for the endpoint are listed in the "Permission" property.
These users have the right to connect to the JEA endpoint, but which roles (and, by extension, commands) they have access to is determined by the "RoleDefinitions" field in the [session configuration file](session-configurations.md) that was used to register the endpoint.

You can evaluate the role mappings in a registered JEA endpoint by expanding the data in the "RoleDefinitions" property.

```powershell
# Get the desired session configuration
$jea = Get-PSSessionConfiguration -Name 'JEAMaintenance'

# Enumerate users/groups and which roles they have access to
$jea.RoleDefinitions.GetEnumerator() | Select-Object Name, @{ Name = 'Role Capabilities'; Expression = { $_.Value.RoleCapabilities } }
```

## Find available role capabilities on the machine

Role capability files will only be used by JEA if they are stored in a "RoleCapabilities" folder inside a valid PowerShell module.
You can find all role capabilities available on a computer by searching the list of available modules.

```powershell
function Find-LocalRoleCapability {
    $results = @()

    # Find modules with a "RoleCapabilities" subfolder and add any PSRC files to the result set
    Get-Module -ListAvailable | ForEach-Object {
        $psrcpath = Join-Path -Path $_.ModuleBase -ChildPath 'RoleCapabilities'
        if (Test-Path $psrcpath) {
            $results += Get-ChildItem -Path $psrcpath -Filter *.psrc
        }
    }

    # Format the results nicely to make it easier to read
    $results | Select-Object @{ Name = 'Name'; Expression = { $_.Name.TrimEnd('.psrc') }}, @{ Name = 'Path'; Expression = { $_.FullName }} | Sort-Object Name
}
```

> [!NOTE]
> The order of results from this function is not necessarily the order in which the role capabilities will be selected if multiple role capabilities share the same name.

## Check effective rights for a specific user

Once you have set up a JEA endpoint, you may want to check which commands are available to a specific user in a JEA session.
You can use [Get-PSSessionCapability](https://msdn.microsoft.com/powershell/reference/5.1/microsoft.powershell.core/Get-PSSessionCapability) to enumerate all of the commands applicable to a user if they were to start a JEA session with their current group memberships.
The output of `Get-PSSessionCapability` is identical to that of the specified user running `Get-Command -CommandType All` in a JEA session.

```powershell
Get-PSSessionCapability -ConfigurationName 'JEAMaintenance' -Username 'CONTOSO\Alice'
```

If your users are not permanent members of groups which would grant them additional JEA rights, this cmdlet may not reflect those extra permissions.
This is typically the case when using just-in-time privileged access management systems to allow users to temporarily belong to a security group.
Always carefully evaluate the mapping of users to roles and the contents of each role to ensure users are only getting access to the least amount of commands needed to do their jobs successfully.

## PowerShell event logs

If you enabled module and/or script block logging on the system, you will be able to find events in the Windows event logs for each command a user ran in their JEA sessions.
To find these events, open the Windows Event Viewer, navigate to the **Microsoft-Windows-PowerShell/Operational** event log, and look for events with event ID **4104**.

Each event log entry will include information about the session in which the command was run.
For JEA sessions, this includes important information about the **ConnectedUser**, which is the actual user who created the JEA session, as well as the **RunAsUser** which identifies the account JEA used to execute the command.
Application event logs will show changes being made by the RunAsUser, so having transcripts or module/script logging enabled is crucial to be able to trace a specific command invocation back to a user.

## Application event logs

When you run a command in a JEA session that interacts with an external application or service, those applications may log events to their own event logs.
Unlike PowerShell logs and transcripts, other logging mechanisms will not capture the connected user of the JEA session, and will instead only log the virtual run-as user or group managed service account.
In order to determine who ran the command, you will need to consult a [session transcript](#session-transcripts) or correlate PowerShell event logs with the time and user shown in the application event log.

The WinRM log can also help you correlate run as users in an application event log with the connecting user.
Event ID **193** in the **Microsoft-Windows-Windows Remote Management/Operational** log records the security identifier (SID) and account name for both the connecting user and run as user every time a JEA session is created.

## Session transcripts

If you configured JEA to create a transcript for each user session, a text copy of every user's actions will be stored in the specified folder.

To find all transcript directories, run the following command as an administrator on the computer configured with JEA:

```powershell
Get-PSSessionConfiguration | Where-Object { $_.TranscriptDirectory -ne $null } | Format-Table Name, TranscriptDirectory
```

Each transcript starts with information about the time the session started, which user connected to the session, and which JEA identity was assigned to them.

```
**********************
Windows PowerShell transcript start
Start time: 20160710144736
Username: CONTOSO\Alice
RunAs User: WinRM Virtual Users\WinRM VA_1_CONTOSO_Alice
Machine: SERVER01 (Microsoft Windows NT 10.0.14393.0)
[...]
```

In the body of the transcript, information is logged about each command the user invoked.
The exact syntax of the command the user ran is unavailable in JEA sessions due to the way commands are transformed for PowerShell remoting, however you can still determine the effective command that was executed.
Below is an example transcript snippet from a user running `Get-Service Dns` in a JEA session:

```
PS>CommandInvocation(Get-Service): "Get-Service"
>> ParameterBinding(Get-Service): name="Name"; value="Dns"
>> CommandInvocation(Out-Default): "Out-Default"
>> ParameterBinding(Out-Default): name="InputObject"; value="Dns"

Running  Dns                DNS Server
```

For each command a user runs, a "CommandInvocation" line will be written, describing the cmdlet or function the user invoked.
ParameterBindings follow each CommandInvocation to tell you about each parameter and value that was supplied with the command.
In the above example, you can see that the parameter "Name" was supplied the value "Dns" for the "Get-Service" cmdlet.

The output of each command will also trigger a CommandInvocation, usually to Out-Default. 
The InputObject of Out-Default is the PowerShell object returned from the command.
The details of that object are printed a few lines below, closely mimicking what the user would have seen.

## See also

- [Audit user actions in a JEA session](audit-and-report.md)
- [*PowerShell ♥ the Blue Team* blog post on security](https://blogs.msdn.microsoft.com/powershell/2015/06/09/powershell-the-blue-team/)


---
description: Describes the Group Policy settings for PowerShell
Locale: en-US
ms.date: 03/25/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_group_policy_settings?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Group_Policy_Settings
---
# About Group Policy Settings

## Short description
Describes the Group Policy settings for PowerShell

## Long description

PowerShell includes Group Policy settings to help you define consistent
configuration values for Windows computers in an enterprise environment.

The PowerShell Group Policy settings are in the following Group Policy paths:

```
Computer Configuration\
  Administrative Templates\
    PowerShell Core

User Configuration\
  Administrative Templates\
    PowerShell Core
```

Group policy settings in the User Configuration path take precedence over Group
Policy settings in the Computer Configuration path.

PowerShell 7 includes Group Policy templates and an installation script in
`$PSHOME`.

Group Policy tools use administrative template files (`.admx`, `.adml`) to
populate policy settings in the user interface. This allows administrators to
manage registry-based policy settings. The `InstallPSCorePolicyDefinitions.ps1`
script installs **PowerShell Core Administrative Templates** on the local
machine.

```powershell
Get-ChildItem -Path $PSHOME -Filter *Core*Policy*
```

```Output
    Directory: C:\Program Files\PowerShell\7

Mode       LastWriteTime         Length Name
----       -------------         ------ ----
-a---      2/27/2020 12:38 AM     15861 InstallPSCorePolicyDefinitions.ps1
-a---      2/27/2020 12:28 AM      9675 PowerShellCoreExecutionPolicy.adml
-a---      2/27/2020 12:28 AM      6201 PowerShellCoreExecutionPolicy.admx
```

After installing the templates, you can edit these settings in the Group Policy
editor (`gpedit.msc`).

The policies are as follows:

- Console session configuration: Sets a configuration endpoint in which
  PowerShell is run.
- Turn on Module Logging: Sets the **LogPipelineExecutionDetails** property of
  modules.
- Turn on PowerShell Script Block Logging: Enables detailed logging of all
  PowerShell scripts.
- Turn on Script Execution: Sets the PowerShell execution policy.
- Turn on PowerShell Transcription: enables capturing of input and output of
  PowerShell commands into text-based transcripts.
- Set the default source path for `Update-Help`: Sets the source for Updatable
  Help to a directory, not the Internet.

Each PowerShell Group Policy setting has an option ('Use Windows PowerShell
Policy setting' field) to use the value from a similar Windows PowerShell Group
Policy setting that is located in the following Group Policy paths:

```
Computer Configuration\
  Administrative Templates\
    Windows Components\
      Windows PowerShell

User Configuration\
  Administrative Templates\
    Windows Components\
      Windows PowerShell
```

> [!NOTE]
> These **PowerShell Core Administrative Templates** do not include settings
> for Windows PowerShell. For more information about acquiring other templates
> and configuring Group policy, see
> [How to create and manage the Central Store for Group Policy Administrative Templates in Windows][gpstore].

## Console session configuration

The **Console session configuration** policy setting specifies a configuration
endpoint in which PowerShell is run. This can be any endpoint registered on the
local machine including the default PowerShell remoting endpoints or a custom
endpoint having specific user role capabilities.

## Turn on module logging

The **Turn on Module Logging** policy setting turns on logging for selected
PowerShell modules. The setting is effective in all sessions on all affected
computers.

If you enable this policy setting and specify one or more modules, pipeline
execution events for the specified modules are recorded in the Windows
PowerShell log in Event Viewer.

If you disable this policy setting, logging of execution events is disabled for
all PowerShell modules.

If this policy setting is not configured, the **LogPipelineExecutionDetails**
property of each module determines whether the execution events of a module are
logged. By default, the **LogPipelineExecutionDetails** property of all modules
is set to False.

To turn on module logging for a module, use the following command format. The
module must be imported into the session and the setting is effective only in
the current session.

```powershell
Import-Module <Module-Name>
(Get-Module <Module-Name>).LogPipelineExecutionDetails = $true
```

To turn on module logging for all sessions on a particular computer, add the
previous commands to the 'All Users' PowerShell profile
(`$Profile.AllUsersAllHosts`).

For more information about module logging, see [about_Modules](about_Modules.md).

## Turn on PowerShell script block logging

The **Turn on PowerShell Script Block Logging** policy setting enables logging of
all PowerShell script input to the Microsoft-Windows-PowerShell/Operational
event log. If you enable this policy setting, PowerShell Core will log the
processing of commands, script blocks, functions, and scripts - whether invoked
interactively, or through automation.

If you disable this policy setting, logging of PowerShell script input is
disabled. If you enable the Script Block Invocation Logging, PowerShell
additionally logs events when invocation of a command, script block, function,
or script starts or stops. Enabling Invocation Logging generates a high volume
of event logs.

## Turn on script execution

The **Turn on Script Execution** policy setting sets the execution policy for
computers and users, which determines which scripts are permitted to run.

If you enable the policy setting, you can select from among the following
policy settings.

- **Allow only signed scripts** allows scripts to execute only if they are
  signed by a trusted publisher. This policy setting is equivalent to the
  AllSigned execution policy.

- **Allow local scripts and remote signed scripts** allows all local scripts to
  run. Scripts that originate from the Internet must be signed by a trusted
  publisher. This policy setting is equivalent to the RemoteSigned execution
  policy.

- **Allow all scripts** allows all scripts to run. This policy setting is
  equivalent to the Unrestricted execution policy.

If you disable this policy setting, no scripts are allowed to run. This policy
setting is equivalent to the Restricted execution policy.

If you disable or do not configure this policy setting, the execution policy
that is set for the computer or user by the `Set-ExecutionPolicy` cmdlet
determines whether scripts are permitted to run. The default value is
Restricted.

For more information, see [about_Execution_Policies](about_Execution_Policies.md).

## Turn on powershell transcription

The **Turn on PowerShell Transcription** policy setting lets you capture the
input and output of PowerShell Core commands into text-based transcripts. If
you enable this policy setting, PowerShell Core will enable transcription
logging for PowerShell Core and any other applications that leverage the
PowerShell Core engine. By default, PowerShell Core will record transcript
output to each users' My Documents directory, with a file name that includes
'PowerShell_transcript', along with the computer name and time started.
Enabling this policy is equivalent to calling the Start-Transcript cmdlet on
each PowerShell Core session.

If you disable this policy setting, transcription logging of PowerShell-based
applications is disabled by default, although transcripting can still be
enabled through the Start-Transcript cmdlet.

If you use the OutputDirectory setting to enable transcription logging to a
shared location, be sure to limit access to that directory to prevent users
from viewing the transcripts of other users or computers.

## Set the default source path for Update-Help

The **Set the Default Source Path for Update-Help** policy setting sets a
default value for the **SourcePath** parameter of the `Update-Help` cmdlet.
This setting prevents users from using the `Update-Help` cmdlet to download
help files from the Internet.

> [!NOTE]
> This Group Policy setting appears under **Computer Configuration** and **User
> Configuration**. However, only the Group Policy setting under **Computer
> Configuration** is effective. The Group Policy setting under **User
> Configuration** is ignored.

The `Update-Help` cmdlet downloads and installs the newest help files for
PowerShell modules and installs them on the computer. By default, `Update-Help`
downloads new help files from an Internet location specified by the module.

However, you can use the `Save-Help` cmdlet to download the newest help files
to a file system location, such as a network share, and then use the
`Update-Help` cmdlet to get the help files from the file system location and
install them on the computer. The **SourcePath** parameter of the `Update-Help`
cmdlet specifies the file system location.

By providing a default value for the **SourcePath** parameter, this Group
Policy setting implicitly adds the **SourcePath** parameter to all
`Update-Help` commands. Users can override the particular file system location
specified as the default value by entering a different file system location.
But they cannot remove the **SourcePath** parameter from the `Update-Help`
command.

If you enable this policy setting, you can specify a default value for the
**SourcePath** parameter. Enter a file system location.

If this policy setting is disabled or not configured, there is no default value
for the **SourcePath** parameter of the `Update-Help` cmdlet. Users can
download help from the Internet or from any file system location.

For more information, see [about_Updatable_Help](about_Updatable_Help.md).

## Keywords

about_Group_Policies
about_GroupPolicy

## See also

[PowerShell Core Policy RFC](https://github.com/PowerShell/PowerShell-RFC/blob/master/4-Experimental-Accepted/RFC0041-Policy.md)

[about_Execution_Policies](about_Execution_Policies.md)

[about_Modules](about_Modules.md)

[about_Updatable_Help](about_Updatable_Help.md)

[Get-ExecutionPolicy](xref:Microsoft.PowerShell.Security.Get-ExecutionPolicy)

[Set-ExecutionPolicy](xref:Microsoft.PowerShell.Security.Set-ExecutionPolicy)

[Get-Module](xref:Microsoft.PowerShell.Core.Get-Module)

[Update-Help](xref:Microsoft.PowerShell.Core.Update-Help)

[Save-Help](xref:Microsoft.PowerShell.Core.Save-Help)

<!-- link references -->
[gpstore]: https://support.microsoft.com/help/3087759


---
external help file: System.Management.Automation.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Core
ms.date: 03/26/2019
online version: http://go.microsoft.com/fwlink/p/?linkid=289597
schema: 2.0.0
title: New-PSSessionConfigurationFile
---
# New-PSSessionConfigurationFile

## SYNOPSIS
Creates a file that defines a session configuration.

## SYNTAX

```
New-PSSessionConfigurationFile [-Path] <String> [-SchemaVersion <Version>] [-Guid <Guid>] [-Author <String>]
 [-CompanyName <String>] [-Copyright <String>] [-Description <String>] [-PowerShellVersion <Version>]
 [-SessionType <SessionType>] [-ModulesToImport <Object[]>] [-AssembliesToLoad <String[]>]
 [-VisibleAliases <String[]>] [-VisibleCmdlets <String[]>] [-VisibleFunctions <String[]>]
 [-VisibleProviders <String[]>] [-AliasDefinitions <Hashtable[]>] [-FunctionDefinitions <Hashtable[]>]
 [-VariableDefinitions <Object>] [-EnvironmentVariables <Object>] [-TypesToProcess <String[]>]
 [-FormatsToProcess <String[]>] [-LanguageMode <PSLanguageMode>] [-ExecutionPolicy <ExecutionPolicy>]
 [-ScriptsToProcess <String[]>] [<CommonParameters>]
```

## DESCRIPTION

The `New-PSSessionConfigurationFile` cmdlet creates a file of settings that define a session
configuration and the environment of sessions that are created by using the session configuration.
To use the file in a session configuration, use the **Path** parameter of the
`Register-PSSessionConfiguration` or `Set-PSSessionConfiguration` cmdlets.

The session configuration file that `New-PSSessionConfigurationFile` creates is a human-readable
text file that contains a hash table of the session configuration properties and values. The file
has a `.pssc` filename extension.

All parameters of `New-PSSessionConfigurationFile` are optional, except for the **Path** parameter.
If you omit a parameter, the corresponding key in the session configuration file is commented-out,
except where noted in the parameter description.

A session configuration, also known as an endpoint, is a collection of settings on the local
computer that define the environment for PowerShell sessions (**PSSessions**) that connect to the
computer. All **PSSessions** use a session configuration. To specify a particular session
configuration, use the **ConfigurationName** parameter of cmdlets that create a session, such as the
`New-PSSession` cmdlet.

A session configuration file makes it easy to define a session configuration without complex scripts
or code assemblies. The settings in the file are used with the optional startup script and any
assemblies in the session configuration.

For more information about session configurations and session configuration files, see [about_Session_Configurations](About/about_Session_Configurations.md)
and [about_Session_Configuration_Files](About/about_Session_Configuration_Files.md).

This cmdlet was introduced in PowerShell 3.0.

## EXAMPLES

### Example 1: Creating and using a NoLanguage session

This example show how to create and the effects of using a no-language session.

The steps include:

1. Create a new configuration file.
1. Register the configuration.
1. Create a new session that uses the configuration.
1. Run commands in that new session.

To run the commands in this example, start PowerShell by using the Run as administrator
option. This option is required to run the `Register-PSSessionConfiguration` cmdlet.

```powershell
New-PSSessionConfigurationFile -Path .\NoLanguage.pssc -LanguageMode NoLanguage
Register-PSSessionConfiguration -Path .\NoLanguage.pssc -Name NoLanguage -Force
$NoLanguage = New-PSSession -ComputerName Srv01 -ConfigurationName NoLanguage
Invoke-Command -Session $NoLanguage -ScriptBlock { if ((Get-Date) -lt '1January2099') {'Before'} else {'After'} }
```

```Output
The syntax is not supported by this runspace. This might be because it is in no-language mode.
    + CategoryInfo          : ParserError: (if ((Get-Date) ...') {'Before'}  :String) [], ParseException
    + FullyQualifiedErrorId : ScriptsNotAllowed
    + PSComputerName        : localhost
```

In this example, the `Invoke-Command` fails because the **LanguageMode** is set to **NoLanguage**.

### Example 2: Creating and using a RestrictedLanguage session

This example show how to create and the effects of using a no-language session.

The steps include:

1. Create a new configuration file.
1. Register the configuration.
1. Create a new session that uses the configuration.
1. Run commands in that new session.

To run the commands in this example, start PowerShell by using the Run as administrator
option. This option is required to run the `Register-PSSessionConfiguration` cmdlet.

```powershell
New-PSSessionConfigurationFile -Path .\NoLanguage.pssc -LanguageMode RestrictedLanguage
Register-PSSessionConfiguration -Path .\NoLanguage.pssc -Name RestrictedLanguage -Force
$NoLanguage = New-PSSession -ComputerName Srv01 -ConfigurationName RestrictedLanguage
Invoke-Command -Session $NoLanguage -ScriptBlock { if ((Get-Date) -lt '1January2099') {'Before'} else {'After'} }
```

```Output
Before
```

In this example, the `Invoke-Command` succeeds because the **LanguageMode** is set to
**RestrictedLanguage**.

### Example 3: Changing a Session Configuration File

This example shows how to change the session configuration file that is used in an existing session
named "ITTasks". Previously, these sessions had only the core modules and an internal **ITTasks**
module. The administrator wants to add the **PSScheduledJob** module to sessions created by using
the ITTasks session configuration.

```powershell
New-PSSessionConfigurationFile -Path .\New-ITTasks.pssc -ModulesToImport Microsoft*, ITTasks, PSScheduledJob
Set-PSSessionConfiguration -Name ITTasks -Path .\New-ITTasks.pssc
```

The `New-PSSessionConfigurationFile` cmdlet to create a session configuration file that imports the
required modules. The `Set-PSSessionConfiguration` cmdlet replaces the current configuration file
with the new one. This new configuration only affects new sessions created after the change.
Existing "ITTasks" sessions are not affected.

### Example 4: Editing a Session Configuration File

This example shows how to change a session configuration by editing the active session configuration
copy of the configuration file. To modify the session configuration copy of the configuration file,
you must have full control access to the file. This may require you to change the permissions on the
file.

In this scenario, we want to add a new alias for the `Select-String` cmdlet by editing the active
configuration file.

The example code below performs the following steps to make this change:

1. Get the configuration file path for the ITConfig session.
1. The user edits the configuration file using **Notepad.exe** to change the **AliasDefinitions**
   value as follows: `AliasDefinitions = @(@{Name='slst';Value='Select-String'})`.
1. Test the updated configuration file.

```powershell
$ITConfig = Get-PSSessionConfiguration -Name ITConfig
notepad.exe $ITConfig.ConfigFilePath
Test-PSSessionConfigurationFile -Path $ITConfig.ConfigFilePath
```

```Output
True
```

Use the **Verbose** parameter with `Test-PSSessionConfigurationFile` to display any errors that are
detected. The cmdlet returns `$True` if no errors are detected in the file.

### Example 5: Create a sample configuration file

This example shows a `New-PSSessionConfigurationFile` command that uses all the cmdlet parameters.
It is included to show the correct input format for each parameter.

The resulting SampleFile.pssc is displayed in the output.
```powershell
$configSettings = @{
    Path = '.\SampleFile.pssc'
    SchemaVersion = '1.0.0.0'
    Author = 'User01'
    Copyright = '(c) Fabrikam Corporation. All rights reserved.'
    CompanyName = 'Fabrikam Corporation'
    Description = 'This is a sample file.'
    ExecutionPolicy = 'AllSigned'
    PowerShellVersion = '3.0'
    LanguageMode = 'FullLanguage'
    SessionType = 'Default'
    EnvironmentVariables = @{TESTSHARE='\\Test2\Test'}
    ModulesToImport = @{ModuleName='PSScheduledJob'; ModuleVersion='1.0.0.0'; GUID='50cdb55f-5ab7-489f-9e94-4ec21ff51e59'},'PSDiagnostics'
    AssembliesToLoad = 'System.Web.Services','FSharp.Compiler.CodeDom.dll'
    TypesToProcess = 'Types1.ps1xml','Types2.ps1xml'
    FormatsToProcess = 'CustomFormats.ps1xml'
    ScriptsToProcess = 'Get-Inputs.ps1'
    AliasDefinitions = @{Name='hlp';Value='Get-Help';Description='Gets help.';Options='AllScope'},@{Name='Update';Value='Update-Help';Description='Updates help';Options='ReadOnly'}
    FunctionDefinitions = @{Name='Get-Function';ScriptBlock={Get-Command -CommandType Function};Options='ReadOnly'}
    VariableDefinitions = @{Name='WarningPreference';Value='SilentlyContinue'}
    VisibleAliases = 'c*','g*','i*','s*'
    VisibleCmdlets = 'Get*'
    VisibleFunctions = 'Get*'
    VisibleProviders = 'FileSystem','Function','Variable'
}
New-PSSessionConfigurationFile @configSettings
Get-Content SampleFile.pssc
```

```Output
@{

# Version number of the schema used for this configuration file
SchemaVersion = '1.0.0.0'

# ID used to uniquely identify this session configuration
GUID = 'f7039ffa-7e54-4382-b358-a393c75c30d3'

# Specifies the execution policy for this session configuration
ExecutionPolicy = 'AllSigned'

# Specifies the language mode for this session configuration
LanguageMode = 'FullLanguage'

# Initial state of this session configuration
SessionType = 'Default'

# Environment variables defined in this session configuration
EnvironmentVariables = @{
    TESTSHARE='\\Test2\Test'
}

# Author of this session configuration
Author = 'User01'

# Company associated with this session configuration
CompanyName = 'Fabrikam Corporation'

# Copyright statement for this session configuration
Copyright = '(c) Fabrikam Corporation. All rights reserved.'

# Description of the functionality provided by this session configuration
Description = 'This is a sample file.'

# Version of the PowerShell engine used by this session configuration
PowerShellVersion = '3.0'

# Modules that will be imported
ModulesToImport = @{
    ModuleVersion='1.0.0.0'
    ModuleName='PSScheduledJob'
    GUID='50cdb55f-5ab7-489f-9e94-4ec21ff51e59'
}, 'PSDiagnostics'

# Assemblies that will be loaded in this session configuration
AssembliesToLoad = 'System.Web.Services', 'FSharp.Compiler.CodeDom.dll'

# Aliases visible in this session configuration
VisibleAliases = 'c*', 'g*', 'i*', 's*'

# Cmdlets visible in this session configuration
VisibleCmdlets = 'Get*'

# Functions visible in this session configuration
VisibleFunctions = 'Get*'

# Providers visible in this session configuration
VisibleProviders = 'FileSystem', 'Function', 'Variable'

# Aliases defined in this session configuration
AliasDefinitions = @(
@{
    Description='Gets help.'
    Name='hlp'
    Options='AllScope'
    Value='Get-Help'
},
@{
    Description='Updates help'
    Name='Update'
    Options='ReadOnly'
    Value='Update-Help'
}
)

# Functions defined in this session configuration
FunctionDefinitions = @(
@{
    Name='Get-Function'
    Options='ReadOnly'
    ScriptBlock={Get-Command -CommandType Function}
}
)

# Variables defined in this session configuration
VariableDefinitions = @(
@{
    Value='SilentlyContinue'
    Name='WarningPreference'

# Type files (.ps1xml) that will be loaded in this session configuration
TypesToProcess = 'C:\WINDOWS\System32\WindowsPowerShell\v1.0\SessionConfig\Types1.ps1xml', 'C:\WINDOWS\System32\WindowsPowerShell\v1.0\SessionConfig\Types2.ps1xml'

# Format files (.ps1xml) that will be loaded in this session configuration
FormatsToProcess = 'C:\WINDOWS\System32\WindowsPowerShell\v1.0\SessionConfig\CustomFormats.ps1xml'

# Specifies the scripts to execute after the session is configured
ScriptsToProcess = 'C:\WINDOWS\System32\WindowsPowerShell\v1.0\SessionConfig\Get-Inputs.ps1'
}
```

This example displays a **New-PSSessionConfigurationFile** command that uses all of the cmdlet parameters.
It is included to show the correct input format for each parameter.

The resulting SampleFile.pssc is displayed in the output.

## PARAMETERS

### -AliasDefinitions

Adds the specified aliases to sessions that use the session configuration. Enter a hash table with
the following keys:

- Name - Name of the alias. This key is required.
- Value - The command that the alias represents. This key is required.
- Description - A text string that describes the alias. This key is optional.
- Options - Alias options. This key is optional. The default value is **None**. The acceptable
  values for this parameter are: None, ReadOnly, Constant, Private, or AllScope.

For example: `@{Name='hlp';Value='Get-Help';Description='Gets help';Options='ReadOnly'}`

```yaml
Type: Hashtable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AssembliesToLoad

Specifies the assemblies to load into the sessions that use the session configuration.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Author

Specifies the author of the session configuration or the configuration file. The default is the
current user. The value of this parameter is visible in the session configuration file, but it is
not a property of the session configuration object.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompanyName

Specifies the company that created the session configuration or the configuration file. The default
value is **Unknown**. The value of this parameter is visible in the session configuration file, but
it is not a property of the session configuration object.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Unknown
Accept pipeline input: False
Accept wildcard characters: False
```

### -Copyright

Specifies a copyright the session configuration file. The value of this parameter is visible in the
session configuration file, but it is not a property of the session configuration object.

If you omit this parameter, `New-PSSessionConfigurationFile` generates a copyright statement by
using the value of the **Author** parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description

Specifies a description of the session configuration or the session configuration file. The value of
this parameter is visible in the session configuration file, but it is not a property of the session
configuration object.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnvironmentVariables

Adds environment variables to the session. Enter a hash table in which the keys are the environment
variable names and the values are the environment variable values.

For example: `EnvironmentVariables=@{TestShare='\\Server01\TestShare'}`

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExecutionPolicy

Specifies the execution policy of sessions that use the session configuration. If you omit this
parameter, the value of the **ExecutionPolicy** key in the session configuration file is
**Restricted**. For information about execution policies in PowerShell, see [about_Execution_Policies](about/about_Execution_Policies.md).

```yaml
Type: ExecutionPolicy
Parameter Sets: (All)
Aliases:
Accepted values: Unrestricted, RemoteSigned, AllSigned, Restricted, Default, Bypass, Undefined

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FormatsToProcess

Specifies the formatting files (.ps1xml) that run in sessions that use the session configuration.
The value of this parameter must be a full or absolute path of the formatting files.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FunctionDefinitions

Adds the specified functions to sessions that use the session configuration. Enter a hash table with
the following keys:

- Name - Name of the function. This key is required.
- ScriptBlock - Function body. Enter a script block. This key is required.
- Options - Function options. This key is optional. The default value is **None**. The acceptable
  values for this parameter are: None, ReadOnly, Constant, Private, or AllScope.

For example: `@{Name='Get-PowerShellProcess';ScriptBlock={Get-Process PowerShell};Options='AllScope'}`

```yaml
Type: Hashtable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Guid

Specifies a unique identifier for the session configuration file. If you omit this parameter,
`New-PSSessionConfigurationFile` generates a GUID for the file. To create a new GUID in PowerShell,
type `[guid]::NewGuid()`.

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LanguageMode

Determines which elements of the PowerShell language are permitted in sessions that use this session
configuration. You can use this parameter to restrict the commands that particular users can run on
the computer.

The acceptable values for this parameter are:

- FullLanguage - All language elements are permitted.
- ConstrainedLanguage - Commands that contain scripts to be evaluated are not allowed. The
  ConstrainedLanguage mode restricts user access to Microsoft .NET Framework types, objects, or
  methods.
- NoLanguage - Users may run cmdlets and functions, but are not permitted to use any language
  elements, such as script blocks, variables, or operators.
- RestrictedLanguage - Users may run cmdlets and functions, but are not permitted to use script
  blocks or variables except for the following permitted variables: `$PSCulture`, `$PSUICulture`,
  `$True`, `$False`, and `$Null`. Users may use only the basic comparison operators (`-eq`, `-gt`,
  `-lt`). Assignment statements, property references, and method calls are not permitted.

The default value of the **LanguageMode** parameter depends on the value of the **SessionType**
parameter.

- Empty - NoLanguage
- RestrictedRemoteServer - NoLanguage
- Default - FullLanguage

```yaml
Type: PSLanguageMode
Parameter Sets: (All)
Aliases:
Accepted values: FullLanguage, RestrictedLanguage, NoLanguage, ConstrainedLanguage

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ModulesToImport

Specifies the modules and snap-ins that are automatically imported into sessions that use the
session configuration.

By default, only the **Microsoft.PowerShell.Core** snap-in is imported into remote sessions, but
unless the cmdlets are excluded, users can use the `Import-Module` and `Add-PSSnapin` cmdlets to add
modules and snap-ins to the session.

Each module or snap-in in the value of this parameter can be represented by a string or as a hash
table. A module string consists only of the name of the module or snap-in. A module hash table can
include **ModuleName**, **ModuleVersion**, and **GUID** keys. Only the **ModuleName** key is
required.

For example, the following value consists of a string and a hash table. Any combination of strings
and hash tables, in any order, is valid.

`'TroubleshootingPack', @{ModuleName='PSDiagnostics'; ModuleVersion='1.0.0.0';GUID='c61d6278-02a3-4618-ae37-a524d40a7f44'}`

The value of the **ModulesToImport** parameter of the `Register-PSSessionConfiguration` cmdlet takes
precedence over the value of the **ModulesToImport** key in the session configuration file.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specifies the path and filename of the session configuration file. The file must have a `.pssc` file
name extension.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PowerShellVersion

Specifies the version of the PowerShell engine in sessions that use the session configuration. The
acceptable values for this parameter are: 2.0 and 3.0. If you omit this parameter, the
**PowerShellVersion** key is commented-out and newest version of PowerShell runs in the session.

The value of the **PSVersion** parameter of the `Register-PSSessionConfiguration` cmdlet takes
precedence over the value of the **PowerShellVersion** key in the session configuration file.

```yaml
Type: Version
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SchemaVersion

Specifies the version of the session configuration file schema. The default value is "1.0.0.0".

```yaml
Type: Version
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptsToProcess

Adds the specified scripts to sessions that use the session configuration. Enter the path and file
names of the scripts. The value of this parameter must be a full or absolute path of script file
names.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SessionType

Specifies the type of session that is created by using the session configuration. The default value
is Default. The acceptable values for this parameter are:

- Empty - No modules are added to session by default. Use the parameters of this cmdlet
  to add modules, functions, scripts, and other features to the session. This option is designed for
  you to create custom sessions by adding selected commands. If you do not add commands to an empty
  session, the session is limited to expressions and might not be usable.
- Default - Adds the Microsoft.PowerShell.Core module to the session. This module includes the
  `Import-Module` cmdlet that users can use to import other modules unless you explicitly prohibit
  this cmdlet.
- RestrictedRemoteServer. Includes only the following proxy functions: `Exit-PSSession`,
  `Get-Command`, `Get-FormatData`, `Get-Help`, `Measure-Object`, `Out-Default`, and `Select-Object`.
  Use the parameters of this cmdlet to add modules, functions, scripts, and other features to the
  session.

```yaml
Type: SessionType
Parameter Sets: (All)
Aliases:
Accepted values: Empty, RestrictedRemoteServer, Default

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TypesToProcess

Adds the specified `.ps1xml` type files to sessions that use the session configuration. Enter the
type filenames. The value of this parameter must be a full or absolute path to type filenames.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VariableDefinitions

Adds the specified variables to sessions that use the session configuration. Enter a hash table with
the following keys:

- Name - Name of the variable. This key is required.
- Value - Variable value. This key is required.
- Options - Variable options. This key is optional. The default value is **None**. The acceptable
  values for this parameter are: None, ReadOnly, Constant, Private, or AllScope.

For example: `@{Name='WarningPreference';Value='SilentlyContinue';Options='AllScope'}`

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VisibleAliases

Limits the aliases in the session to those specified in the value of this parameter, plus any
aliases that you define in the **AliasDefinition** parameter. Wildcard characters are supported. By
default, all aliases that are defined by the PowerShell engine and all aliases that modules
export are visible in the session.

For example: `VisibleAliases='gcm', 'gp'`

When any **Visible** parameter is included in the session configuration file, PowerShell
removes the `Import-Module` cmdlet and its ipmo alias from the session.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -VisibleCmdlets

Limits the cmdlets in the session to those specified in the value of this parameter. Wildcard
characters and Module Qualified Names are supported.

By default, all cmdlets that modules in the session export are visible in the session. Use the
**SessionType** and **ModulesToImport** parameters to determine which modules and snap-ins are imported
into the session. If no modules in **ModulesToImport** expose the cmdlet, the appropriate module will
attempt to be autoloaded.

When any **Visible** parameter is included in the session configuration file, PowerShell
removes the `Import-Module` cmdlet and its ipmo alias from the session.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -VisibleFunctions

Limits the functions in the session to those specified in the value of this parameter, plus any
functions that you define in the **FunctionDefinition** parameter. Wildcard characters are supported.

By default, all functions that modules in the session export are visible in the session. Use the
**SessionType** and **ModulesToImport** parameters to determine which modules and snap-ins are imported
into the session.

When any **Visible** parameter is included in the session configuration file, PowerShell
removes the `Import-Module` cmdlet and its ipmo alias from the session.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -VisibleProviders

Limits the PowerShell providers in the session to those specified in the value of this parameter.
Wildcard characters are supported.

By default, all providers that modules in the session export are visible in the session. Use the
**SessionType** and **ModulesToImport** parameters to determine which modules are imported into the
session.

When any **Visible** parameter is included in the session configuration file, PowerShell
removes the `Import-Module` cmdlet and its `ipmo` alias from the session.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe any objects to this cmdlet.

## OUTPUTS

### None

This cmdlet does not generate any output.

## NOTES

- Parameters, such as **VisibleCmdlets** and **VisibleProviders**, do not import items into the
  session. Instead, they select from among the items imported into the session. For example, if the
  value of the **VisibleProviders** parameter is the Certificate provider, but the
  **ModulesToImport** parameter does not specify the **Microsoft.PowerShell.Security** module that
  contains the Certificate provider, the Certificate provider is not visible in the session.
- `New-PSSessionConfigurationFile` creates a session configuration file that has a .pssc file name
  extension in the path that you specify in the **Path** parameter. When you use the session
  configuration file to create a session configuration, the `Register-PSSessionConfiguration` cmdlet
  copies the configuration file and saves an active copy of the file in the **SessionConfig**
  subdirectory of the `$PSHOME` directory.

  The **ConfigFilePath** property of the session configuration contains the fully qualified path of
  the active session configuration file. You can modify the active configuration file in the
  `$PSHOME` directory at any time using any text editor. The changes that you make affect all new
  sessions that use the session configuration, but not existing sessions.

  Before using an edited session configuration file, use the `Test-PSSessionConfigurationFile`
  cmdlet to verify that the configuration file entries are valid.

## RELATED LINKS

[Disable-PSSessionConfiguration](Disable-PSSessionConfiguration.md)

[Enable-PSSessionConfiguration](Enable-PSSessionConfiguration.md)

[Get-PSSessionConfiguration](Get-PSSessionConfiguration.md)

[Register-PSSessionConfiguration](Register-PSSessionConfiguration.md)

[Set-PSSessionConfiguration](Set-PSSessionConfiguration.md)

[Test-PSSessionConfigurationFile](Test-PSSessionConfigurationFile.md)

[Unregister-PSSessionConfiguration](Unregister-PSSessionConfiguration.md)

[WSMan Provider](../Microsoft.WsMan.Management/Providers/WSMan-Provider.md)

[about_Session_Configurations](About/about_Session_Configurations.md)

[about_Session_Configuration_Files](About/about_Session_Configuration_Files.md)

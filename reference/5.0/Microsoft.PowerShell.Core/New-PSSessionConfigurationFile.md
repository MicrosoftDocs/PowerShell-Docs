---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821499
external help file:  System.Management.Automation.dll-Help.xml
title:  New-PSSessionConfigurationFile
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
The **New-PSSessionConfigurationFile** cmdlet creates a file of settings that define a session configuration and the environment of sessions that are created by using the session configuration.
To use the file in a session configuration, use the *Path* parameter of the Register-PSSessionConfiguration or Set-PSSessionConfiguration cmdlets.

The session configuration file that **New-PSSessionConfigurationFile** creates is a human-readable text file that contains a hash table of the session configuration properties and values.
The file has a .pssc file name extension.

All parameters of **New-PSSessionConfigurationFile** are optional, except for the *Path* parameter.
If you omit a parameter, the corresponding key in the session configuration file is commented-out, except where noted in the parameter description.

A session configuration, also known as an endpoint, is a collection of settings on the local computer that define the environment for Windows PowerShell sessions (**PSSessions**) that connect to, or terminate at, the computer.
All **PSSessions** use a session configuration.
To specify a particular session configuration, use the *ConfigurationName* parameter of cmdlets that create a session, such as the New-PSSession cmdlet.

A session configuration file makes it easy to define a session configuration without complex scripts or code assemblies.
The settings in the file are used in addition to the optional startup script and any assemblies in the session configuration.

For more information about session configurations and session configuration files, see about_Session_Configurations (http://go.microsoft.com/fwlink/?LinkID=145152) and about_Session_Configuration_Files (http://go.microsoft.com/fwlink/?LinkID=236023).

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Designing a specialized session
```
PS C:\> New-PSSessionConfigurationFile -ModulesToImport DMSCmdlets, *Microsoft* -ScriptsToProcess \\Server01\Scripts\Get-DMSServers.ps1
```

The following command creates a session configuration file for IT technical sessions on a cloud-based document management server.

You can use the resulting file to create a customized session configuration on the server.
The ACLs on the session configuration determine who can use the session configuration to create a session on the server.

Customized sessions that include the cmdlets, functions and scripts that technical users need make it easier for those users to write scripts that automate common tasks.

### Example 2: Restricting Language in a Session
```
The first pair of commands uses the **New-PSSessionConfigurationFile** cmdlet to create two session configuration files. The first command creates a no-language file. The second command creates a restricted-language file. Other than the value of the *LanguageMode* parameter, the session configuration files are equivalent.
PS C:\> New-PSSessionConfigurationFile -Path .\NoLanguage.pssc -LanguageMode NoLanguage 
PS C:\> New-PSSessionConfigurationFile -Path .\RestrictedLanguage.pssc -LanguageMode RestrictedLanguage

The second pair of commands uses the configuration files to create session configurations on the local computer.
PS C:\> Register-PSSessionConfiguration -Path .\NoLanguage.pssc -Name NoLanguage -Force 
PS C:\> Register-PSSessionConfiguration -Path .\RestrictedLanguage.pssc -Name RestrictedLanguage -Force

The third pair of commands creates two sessions, each of which uses one of the session configurations that were created in the previous command pair.
PS C:\> $NoLanguage = New-PSSession -ComputerName Srv01 -ConfigurationName NoLanguage 
PS C:\> $RestrictedLanguage = New-PSSession -ComputerName Srv01 -ConfigurationName RestrictedLanguage

The seventh command uses the Invoke-Command cmdlet to run an If statement in the no-Language session. The command fails, because the language elements in the command are not permitted in a no-language session.
PS C:\> Invoke-Command -Session $NoLanguage {if ((Get-Date) -lt "1January2014") {"Before"} else {"After"} }
The syntax is not supported by this runspace. This might be because it is in no-language mode.
    + CategoryInfo          : ParserError: (if ((Get-Date) ...") {"Before"}  :String) [], ParseException
    + FullyQualifiedErrorId : ScriptsNotAllowed
    + PSComputerName        : localhost


The eighth command uses the **Invoke-Command** cmdlet to run the same If statement in the restricted-language session. Because these language elements are permitted in the restricted-language session, the command succeeds.
PS C:\> Invoke-Command -Session $RestrictedLanguage {if ((Get-Date) -lt "1January2014") {"Before"} else {"After"} }
Before
```

The commands in this example compare a no-language session to a restricted-language session.
The example shows the effect of using the *LanguageMode* parameter of **New-PSSessionConfigurationFile** to limit the types of commands and statements that users can run in a session that uses a custom session configuration.

To run the commands in this example, start Windows PowerShell by using the Run as administrator option.
This option is required to run the Register-PSSessionConfiguration cmdlet.

### Example 3: Changing a Session Configuration File
```
The first command uses the **New-PSSessionConfigurationFile** cmdlet to create a session configuration file that imports the required modules.
PS C:\> New-PSSessionConfigurationFile -Path .\New-ITTasks.pssc -ModulesToImport Microsoft*, ITTasks, PSScheduledJob

The second command uses the **Set-PSSessionConfiguration** cmdlet to replace the current .pssc file with the new one. Changes to the session configuration affects all sessions created after the change is completed.
PS C:\> Set-PSSessionConfiguration -Name ITTasks -Path .\New-ITTasks.pssc
```

This example shows how to change the session configuration file that is used in a session configuration.
In this scenario, the administrator wants to add the **PSScheduledJob** module to sessions created by using the ITTasks session configuration.
Previously, these sessions had only the core modules and an internal "ITTasks" module.

### Example 4: Editing a Session Configuration File
```
The first command uses the Get-PSSessionConfiguration command to get the path of the configuration file for the ITConfig session configuration. The path is stored in the **ConfigFilePath** property of the session configuration.
PS C:\> (Get-PSSessionConfiguration -Name ITConfig).ConfigFilePath
C:\WINDOWS\System32\WindowsPowerShell\v1.0\SessionConfig\ITConfig_1e9cb265-dae0-4bd3-89a9-8338a47698a1.pssc

To modify the session configuration copy of the configuration file, you might have to change the file permissions.In this case, the current user, who is a member of the Administrators group on the system, was explicitly granted full control of the file by using the following method: Right-click the file icon, and then click Properties. On the Security tab, click Edit, and then click Add. Add the user, and then, in the Full control column, click Allow.Now the user can modify the file. A new slst alias for the Select-String cmdlet is added to the file.
PS C:\> AliasDefinitions = @(@{Name='slst';Value='Select-String'})

The second command uses the Test-PSSessionConfigurationFile cmdlet to test the edited file. The command uses the *Verbose* parameter, which displays the file errors that the cmdlet detects, if any.In this case, the cmdlet returns $True, which indicates that it did not detect any errors in the file.
PS C:\> Test-PSSessionConfigurationFile -Path (Get-PSSessionConfiguration -Name ITConfig).ConfigFilePath
True
```

This example shows how to change a session configuration by editing the active session configuration copy of the configuration file.

### Example 5: Sample Configuration File
```
PS C:\> New-PSSessionConfigurationFile
-Path .\SampleFile.pssc
-Schema "1.0.0.0"
-Author "User01"
-Copyright "(c) Fabrikam Corporation. All rights reserved."
-CompanyName "Fabrikam Corporation"
-Description "This is a sample file."
-ExecutionPolicy AllSigned
-PowerShellVersion "3.0"
-LanguageMode FullLanguage
-SessionType Default
-EnvironmentVariables @{TESTSHARE="\\Test2\Test"}
-ModulesToImport @{ModuleName="PSScheduledJob"; ModuleVersion="1.0.0.0"; GUID="50cdb55f-5ab7-489f-9e94-4ec21ff51e59"}, PSDiagnostics
-AssembliesToLoad "System.Web.Services","FSharp.Compiler.CodeDom.dll"
-TypesToProcess "Types1.ps1xml","Types2.ps1xml"
-FormatsToProcess "CustomFormats.ps1xml"
-ScriptsToProcess "Get-Inputs.ps1"
-AliasDefinitions @{Name="hlp";Value="Get-Help";Description="Gets help.";Options="AllScope"},@{Name="Update";Value="Update-Help";Description="Updates help";Options="ReadOnly"}
-FunctionDefinitions @{Name="Get-Function";ScriptBlock={Get-Command -CommandType Function};Options="ReadOnly"}
-VariableDefinitions @{Name="WarningPreference";Value="SilentlyContinue"}
-VisibleAliases "c*","g*","i*","s*" 
-VisibleCmdlets "Get*"
-VisibleFunctions "Get*"
-VisibleProviders "FileSystem","Function","Variable"
-RunAsVirtualAccount
-RunAsVirtualAccountGroups "Backup Operators"

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

# Version of the Windows PowerShell engine used by this session configuration
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
Adds the specified aliases to sessions that use the session configuration.
Enter a hash table with the following keys: 

- Name.
Name of the alias.
This key is required. 
- Value.
The command that the alias represents.
This key is required. 
- Description.
A text string that describes the alias.
This key is optional. 
- Options.
Alias options.
This key is optional.
The default value is None.
The acceptable values for this parameter are: None, ReadOnly, Constant, Private, or AllScope.

For example: `@{Name="hlp";Value="Get-Help";Description="Gets help";Options="ReadOnly"}`

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
Specifies the author of the session configuration or the configuration file.
The default is the current user.
The value of this parameter is visible in the session configuration file, but it is not a property of the session configuration object.

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
Specifies the company that created the session configuration or the configuration file.
The default value is Unknown.
The value of this parameter is visible in the session configuration file, but it is not a property of the session configuration object.

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

### -Copyright
Specifies a copyright the session configuration file.
The value of this parameter is visible in the session configuration file, but it is not a property of the session configuration object.

If you omit this parameter, **New-PSSessionConfigurationFile** generates a copyright statement by using the value of the *Author* parameter.

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
Specifies a description of the session configuration or the session configuration file.
The value of this parameter is visible in the session configuration file, but it is not a property of the session configuration object.

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
Adds environment variables to the session.
Enter a hash table in which the keys are the environment variable names and the values are the environment variable values.

For example: `EnvironmentVariables=@{TestShare="\\\\Server01\TestShare"}`

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
Specifies the execution policy of sessions that use the session configuration.
If you omit this parameter, the value of the **ExecutionPolicy** key in the session configuration file is Restricted.
For information about execution policies in Windows PowerShell, see about_Execution_Policies (http://go.microsoft.com/fwlink/?LinkID=135170).

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
Adds the specified functions to sessions that use the session configuration.
Enter a hash table with the following keys: 

- Name.
Name of the function.
This key is required. 
- ScriptBlock.
Function body.
Enter a script block.
This key is required. 
- Options.
Function options.
This key is optional.
The default value is None.
The acceptable values for this parameter are: None, ReadOnly, Constant, Private, or AllScope.

For example: `@{Name="Get-PowerShellProcess";ScriptBlock={Get-Process PowerShell};Options="AllScope"}`

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
Specifies a unique identifier for the session configuration file.
If you omit this parameter, **New-PSSessionConfigurationFile** generates a GUID for the file.To create a new GUID in Windows PowerShell, type "`\[guid\]::NewGuid()`".

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
Determines which elements of the Windows PowerShell language are permitted in sessions that use this session configuration.
You can use this parameter to restrict the commands that particular users can run on the computer.

The acceptable values for this parameter are:

- FullLanguage.
All language elements are permitted. 
- ConstrainedLanguage.
Commands that contain scripts to be evaluated are not allowed.
The ConstrainedLanguage mode restricts user access to Microsoft .NET Framework types, objects, or methods. 
- NoLanguage.
Users may run cmdlets and functions, but are not permitted to use any language elements, such as script blocks, variables, or operators. 
- RestrictedLanguage.
Users may run cmdlets and functions, but are not permitted to use script blocks or variables except for the following permitted variables: $PSCulture, $PSUICulture, $True, $False, and $Null.
Users may use only the basic comparison operators (-eq, -gt, -lt).
Assignment statements, property references, and method calls are not permitted.

The default value of the *LanguageMode* parameter depends on the value of the *SessionType* parameter.

- Empty. NoLanguage
- RestrictedRemoteServer. NoLanguage
- Default. FullLanguage

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
Specifies the modules and snap-ins that are automatically imported into sessions that use the session configuration.

By default, only the **Microsoft.PowerShell.Core** snap-in is imported into remote sessions, but unless the cmdlets are excluded, users can use the Import-Module and Add-PSSnapin cmdlets to add modules and snap-ins to the session.

Each module or snap-in in the value of this parameter can be represented by a string or as a hash table.
A module string consists only of the name of the module or snap-in.
A module hash table can include **ModuleName**, **ModuleVersion**, and **GUID** keys.
Only the **ModuleName** key is required.

For example, the following value consists of a string and a hash table.
Any combination of strings and hash tables, in any order, is valid.

`"TroubleshootingPack", @{ModuleName="PSDiagnostics"; ModuleVersion="1.0.0.0";GUID="c61d6278-02a3-4618-ae37-a524d40a7f44"},`

The value of the *ModulesToImport* parameter of the Register-PSSessionConfiguration cmdlet takes precedence over the value of the **ModulesToImport** key in the session configuration file.

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
Specifies the path and file name of the session configuration file.
The file must have a .pssc file name extension.

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
Specifies the version of the Windows PowerShell engine in sessions that use the session configuration.
The acceptable values for this parameter are: 2.0 and 3.0.
If you omit this parameter, the **PowerShellVersion** key is commented-out and newest version of Windows PowerShell runs in the session.

The value of the *PSVersion* parameter of the Register-PSSessionConfiguration cmdlet takes precedence over the value of the **PowerShellVersion** key in the session configuration file.

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

### -RoleDefinitions
Specifies the mapping between security groups (or users) and role capabilities.
Users will be granted access to all role capabilities which apply to their group membership at the time the session is created.

Enter a hash table in which the keys are the name of the security group and the values are hash tables that contain a list of role capabilities that should be made available to the security group.

For example: `@{'Contoso\Level 2 Helpdesk Users' = @{ RoleCapabilities = 'Maintenance', 'ADHelpDesk' }}`

```yaml
Type: IDictionary
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RunAsVirtualAccount
Configures sessions using this session configuration to be run as the computer's (virtual) administrator account.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RunAsVirtualAccountGroups
Specifies the security groups to be associated with the virtual account when a session that uses the session configuration is run as a virtual account.
If omitted, the virtual account belongs to Domain Admins on domain controllers and Administrators on all other computers.

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

### -SchemaVersion
Specifies the version of the session configuration file schema.
The default value is "1.0.0.0".

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
Adds the specified scripts to sessions that use the session configuration.
Enter the path and file names of the scripts.
The value of this parameter must be a full or absolute path of script file names.

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
Specifies the type of session that is created by using the session configuration.
The default value is Default.
The acceptable values for this parameter are:

- Empty.
No modules or snap-ins are added to session by default.
Use the parameters of this cmdlet to add modules, functions, scripts, and other features to the session.
This option is designed for you to create custom sessions by adding selected command.
If you do not add commands to an empty session, the session is limited to expressions and might not be usable. 
- Default.
Adds the Microsoft.PowerShell.Core snap-in to the session.
This snap-in includes the Import-Module and Add-PSSnapin cmdlets that users can use to import other modules and snap-ins unless you explicitly prohibit the use of the cmdlets. 
- RestrictedRemoteServer.
Includes only the following proxy functions:  Exit-PSSession, Get-Command, Get-FormatData, Get-Help, Measure-Object, Out-Default, and Select-Object.
Use the parameters of this cmdlet to add modules, functions, scripts, and other features to the session.

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
Adds the specified type files (.ps1xml) to sessions that use the session configuration.
Enter the type file names.
The value of this parameter must be a full or absolute path of type file names.

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
Adds the specified variables to sessions that use the session configuration.
Enter a hash table with the following keys: 

- Name.
Name of the variable.
This key is required. 
- Value.
Variable value.
This key is required. 
- Options.
Variable options.
This key is optional.
The default value is None.
The acceptable values for this parameter are: None, ReadOnly, Constant, Private, or AllScope.

For example: `@{Name="WarningPreference";Value="SilentlyContinue";Options="AllScope"}`

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
Limits the aliases in the session to those specified in the value of this parameter, plus any aliases that you define in the *AliasDefinition* parameter.
Wildcard characters are supported.
By default, all aliases that are defined by the Windows PowerShell engine and all aliases that modules export are visible in the session.

For example: `VisibleAliases="gcm", "gp"`

When any *Visible* parameter is included in the session configuration file, Windows PowerShell removes the **Import-Module** cmdlet and its ipmo alias from the session.

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

### -VisibleCmdlets
Limits the cmdlets in the session to those specified in the value of this parameter.
Wildcard characters and Module Qualified Names are supported.

By default, all cmdlets that modules in the session export are visible in the session.
Use the *SessionType* and *ModulesToImport* parameters to determine which modules and snap-ins are imported into the session.
If no modules in *ModulesToImport* expose the cmdlet, the appropriate module will attempt to be autoloaded.

When any *Visible* parameter is included in the session configuration file, Windows PowerShell removes the Import-Module cmdlet and its ipmo alias from the session.

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

### -VisibleFunctions
Limits the functions in the session to those specified in the value of this parameter, plus any functions that you define in the *FunctionDefinition* parameter.
Wildcard characters are supported.

By default, all functions that modules in the session export are visible in the session.
Use the *SessionType* and *ModulesToImport* parameters to determine which modules and snap-ins are imported into the session.

When any *Visible* parameter is included in the session configuration file, Windows PowerShell removes the **Import-Module** cmdlet and its ipmo alias from the session.

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

### -VisibleProviders
Limits the Windows PowerShell providers in the session to those specified in the value of this parameter.
Wildcard characters are supported.

By default, all providers that modules in the session export are visible in the session.
Use the *SessionType* and *ModulesToImport* parameters to determine which modules and snap-ins are imported into the session.

When any *Visible* parameter is included in the session configuration file, Windows PowerShell removes the **Import-Module** cmdlet and its ipmo alias from the session.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
You cannot pipe any objects to this cmdlet.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES
* The *Visible* parameters, such as *VisibleCmdlets* and *VisibleProviders*, do not import items into the session. Instead, they select from among the items imported into the session. For example, if the value of the *VisibleProviders* parameter is the Certificate provider, but the *ModulesToImport* parameter does not specify the **Microsoft.PowerShell.Security** module that contains the Certificate provider, the Certificate provider is not visible in the session.
* **New-PSSessionConfigurationFile** creates a session configuration file that has a .pssc file name extension in the path that you specify in the *Path* parameter. When you use the session configuration file to create a session configuration, the Register-PSSessionConfiguration cmdlet copies the configuration file and saves an active copy of the file in the **SessionConfig** subdirectory of the $pshome directory.

  The **ConfigFilePath** property of the session configuration contains the fully qualified path of the active session configuration file.
You can modify the active configuration file in the $pshome directory at any time, either by using Windows PowerShell ISE or any text editor.
The changes that you make affect all new sessions that use the session configuration, but not existing sessions.

  Before using an edited session configuration file, use the Test-PSSessionConfigurationFile cmdlet to verify that the configuration file entries are valid.

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


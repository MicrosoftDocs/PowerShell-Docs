---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 05/20/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/get-command?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-Command
---
# Get-Command

## SYNOPSIS
Gets all commands.

## SYNTAX

### CmdletSet (Default)

```
Get-Command [-Verb <String[]>] [-Noun <String[]>] [-Module <String[]>]
 [-FullyQualifiedModule <ModuleSpecification[]>] [-TotalCount <Int32>] [-Syntax] [-ShowCommandInfo]
 [[-ArgumentList] <Object[]>] [-All] [-ListImported] [-ParameterName <String[]>]
 [-ParameterType <PSTypeName[]>] [<CommonParameters>]
```

### AllCommandSet

```
Get-Command [[-Name] <String[]>] [-Module <String[]>]
 [-FullyQualifiedModule <ModuleSpecification[]>] [-CommandType <CommandTypes>] [-TotalCount <Int32>]
 [-Syntax] [-ShowCommandInfo] [[-ArgumentList] <Object[]>] [-All] [-ListImported]
 [-ParameterName <String[]>] [-ParameterType <PSTypeName[]>] [-UseFuzzyMatching]
 [-UseAbbreviationExpansion] [<CommonParameters>]
```

## DESCRIPTION

The `Get-Command` cmdlet gets all commands that are installed on the computer, including cmdlets,
aliases, functions, filters, scripts, and applications. `Get-Command` gets the commands from
PowerShell modules and commands that were imported from other sessions. To get only commands that
have been imported into the current session, use the **ListImported** parameter.

Without parameters, `Get-Command` gets all of the cmdlets, functions, and aliases installed on the
computer. `Get-Command *` gets all types of commands, including all of the non-PowerShell files in
the Path environment variable (`$env:Path`), which it lists in the Application command type.

`Get-Command` that uses the exact name of the command, without wildcard characters, automatically
imports the module that contains the command so that you can use the command immediately. To enable,
disable, and configure automatic importing of modules, use the `$PSModuleAutoLoadingPreference`
preference variable. For more information, see [about_Preference_Variables](About/about_Preference_Variables.md).

`Get-Command` gets its data directly from the command code, unlike `Get-Help`, which gets its
information from help topics.

Starting in Windows PowerShell 5.0, results of the `Get-Command` cmdlet display a **Version** column
by default. A new **Version** property has been added to the **CommandInfo** class.

## EXAMPLES

### Example 1: Get cmdlets, functions, and aliases

This command gets the PowerShell cmdlets, functions, and aliases that are installed on the computer.

```powershell
Get-Command
```

### Example 2: Get commands in the current session

This command uses the **ListImported** parameter to get only the commands in the current session.

```powershell
Get-Command -ListImported
```

### Example 3: Get cmdlets and display them in order

This command gets all of the cmdlets, sorts them alphabetically by the noun in the cmdlet name, and
then displays them in noun-based groups. This display can help you find the cmdlets for a task.

```powershell
Get-Command -Type Cmdlet | Sort-Object -Property Noun | Format-Table -GroupBy Noun
```

### Example 4: Get commands in a module

This command uses the **Module** parameter to get the commands in the Microsoft.PowerShell.Security
and Microsoft.PowerShell.Utility modules.

```powershell
Get-Command -Module Microsoft.PowerShell.Security, Microsoft.PowerShell.Utility
```

### Example 5: Get information about a cmdlet

This command gets information about the `Get-AppLockerPolicy` cmdlet. It also imports the
**AppLocker** module, which adds all of the commands in the **AppLocker** module to the current
session.

```powershell
Get-Command Get-AppLockerPolicy
```

When a module is imported automatically, the effect is the same as using the Import-Module cmdlet.
The module can add commands, types and formatting files, and run scripts in the session. To enable,
disable, and configuration automatic importing of modules, use the `$PSModuleAutoLoadingPreference`
preference variable. For more information, see [about_Preference_Variables](../Microsoft.PowerShell.Core/About/about_Preference_Variables.md).

### Example 6: Get the syntax of a cmdlet

This command uses the **ArgumentList** and **Syntax** parameters to get the syntax of the `Get-ChildItem`
cmdlet when it is used in the Cert: drive. The Cert: drive is a PowerShell drive that the
Certificate Provider adds to the session.

```powershell
Get-Command  -Name Get-Childitem -Args Cert: -Syntax
```

When you compare the syntax displayed in the output with the syntax that is displayed when you omit
the **Args** (**ArgumentList**) parameter, you'll see that the **Certificate provider** adds a dynamic
parameter, **CodeSigningCert**, to the `Get-ChildItem` cmdlet.

For more information about the Certificate provider, see [about_Certificate_Provider](../Microsoft.PowerShell.Security/About/about_Certificate_Provider.md).

### Example 7: Get dynamic parameters

The command in the example uses the `Get-DynamicParameters` function to get the dynamic parameters
that the Certificate provider adds to the `Get-ChildItem` cmdlet when it is used in the Cert: drive.

```powershell
function Get-DynamicParameters
{
    param ($Cmdlet, $PSDrive)
    (Get-Command -Name $Cmdlet -ArgumentList $PSDrive).ParameterSets | ForEach-Object {$_.Parameters} | Where-Object { $_.IsDynamic } | Select-Object -Property Name -Unique
}
Get-DynamicParameters -Cmdlet Get-ChildItem -PSDrive Cert:
```

```Output
Name
----
CodeSigningCert
```

The `Get-DynamicParameters` function in this example gets the dynamic parameters of a cmdlet. This
is an alternative to the method used in the previous example. Dynamic parameter can be added to a
cmdlet by another cmdlet or a provider.

### Example 8: Get all commands of all types

This command gets all commands of all types on the local computer, including executable files in the
paths of the **Path** environment variable (`$env:path`).

```powershell
Get-Command *
```

It returns an **ApplicationInfo** object (System.Management.Automation.ApplicationInfo) for each
file, not a **FileInfo** object (System.IO.FileInfo).

### Example 9: Get cmdlets by using a parameter name and type

This command gets cmdlets that have a parameter whose name includes Auth and whose type is
**AuthenticationMechanism**.

```powershell
Get-Command -ParameterName *Auth* -ParameterType AuthenticationMechanism
```

You can use a command like this one to find cmdlets that let you specify the method that is used to
authenticate the user.

The **ParameterType** parameter distinguishes parameters that take an **AuthenticationMechanism**
value from those that take an **AuthenticationLevel** parameter, even when they have similar names.

### Example 10: Get an alias

This example shows how to use the `Get-Command` cmdlet with an alias.

```powershell
Get-Command Name dir
```

```Output
CommandType     Name                                               ModuleName
-----------     ----                                               ----------
Alias           dir -> Get-ChildItem
```

Although it is typically used on cmdlets and functions, `Get-Command` also gets scripts, functions,
aliases, and executable files.

The output of the command shows the special view of the **Name** property value for aliases. The
view shows the alias and the full command name.

### Example 11: Get Syntax from an alias

This example shows how to get the syntax along with the standard name of an alias.

The output of the command shows the labeled alias with the standard name, followed by the syntax.

```powershell
Get-Command -Name dir -Syntax
```

```Output
dir (alias) -> Get-ChildItem

dir [[-Path] <string[]>] [[-Filter] <string>] [-Include <string[]>] [-Exclude <string[]>] [-Recurse] [-Depth <uint>] [-Force] [-Name] [-Attributes <FlagsExpression[FileAttributes]>] [-FollowSymlink] [-Directory] [-File] [-Hidden] [-ReadOnly] [-System] [<CommonParameters>]

dir [[-Filter] <string>] -LiteralPath <string[]> [-Include <string[]>] [-Exclude <string[]>] [-Recurse] [-Depth <uint>] [-Force] [-Name] [-Attributes <FlagsExpression[FileAttributes]>] [-FollowSymlink] [-Directory] [-File] [-Hidden] [-ReadOnly] [-System] [<CommonParameters>]
```

### Example 12: Get all instances of the Notepad command

This example uses the **All** parameter of the `Get-Command` cmdlet to show all instances of the
`Notepad` command on the local computer.

```powershell
Get-Command Notepad -All | Format-Table CommandType, Name, Definition
```

```Output
CommandType     Name           Definition
-----------     ----           ----------
Application     notepad.exe    C:\WINDOWS\system32\notepad.exe
Application     NOTEPAD.EXE    C:\WINDOWS\NOTEPAD.EXE
```

The **All** parameter is useful when there is more than one command with the same name in the
session.

Beginning in Windows PowerShell 3.0, by default, when the session includes multiple commands with
the same name, `Get-Command` gets only the command that runs when you type the command name. With
the **All** parameter, `Get-Command` gets all commands with the specified name and returns them in
execution precedence order. To run a command other than the first one in the list, type the fully
qualified path to the command.

For more information about command precedence, see [about_Command_Precedence](About/about_Command_Precedence.md).

### Example 13: Get the name of a module that contains a cmdlet

This command gets the name of the module in which the `Get-Date` cmdlet originated.
The command uses the **ModuleName** property of all commands.

```powershell
(Get-Command Get-Date).ModuleName
```

```Output
Microsoft.PowerShell.Utility
```

This command format works on commands in PowerShell modules, even if they are not imported into the session.

### Example 14: Get cmdlets and functions that have an output type

```powershell
Get-Command -Type Cmdlet | Where-Object OutputType | Format-List -Property Name, OutputType
```

This command gets the cmdlets and functions that have an output type and the type of objects that they return.

The first part of the command gets all cmdlets. A pipeline operator (`|`) sends the cmdlets to the
`Where-Object` cmdlet, which selects only the ones in which the **OutputType** property is
populated. Another pipeline operator sends the selected cmdlet objects to the `Format-List` cmdlet,
which displays the name and output type of each cmdlet in a list.

The **OutputType** property of a **CommandInfo** object has a non-null value only when the cmdlet
code defines the **OutputType** attribute for the cmdlet.

### Example 15: Get cmdlets that take a specific object type as input

```powershell
Get-Command -ParameterType (((Get-NetAdapter)[0]).PSTypeNames)
```

```Output
CommandType     Name                                               ModuleName
-----------     ----                                               ----------
Function        Disable-NetAdapter                                 NetAdapter
Function        Enable-NetAdapter                                  NetAdapter
Function        Rename-NetAdapter                                  NetAdapter
Function        Restart-NetAdapter                                 NetAdapter
Function        Set-NetAdapter                                     NetAdapter
```

This command finds cmdlets that take net adapter objects as input. You can use this command format
to find the cmdlets that accept the type of objects that any command returns.

The command uses the **PSTypeNames** intrinsic property of all objects, which gets the types that
describe the object. To get the **PSTypeNames** property of a net adapter, and not the
**PSTypeNames** property of a collection of net adapters, the command uses array notation to get the
first net adapter that the cmdlet returns.

### Example 16: Get commands using a fuzzy match

In this example, the name of the command deliberately has a typo as 'get-commnd'.
Using the `-UseFuzzyMatching` switch, the cmdlet determined that the best match
was `Get-Command` followed by other native commands on the system that were a
similar match.

```powershell
Get-Command get-commnd -UseFuzzyMatching
```

```Output
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Get-Command                                        6.2.0.0    Microsoft.PowerShell.Core
Application     getconf                                            0.0.0.0    /usr/bin/getconf
Application     command                                            0.0.0.0    /usr/bin/command
```

## PARAMETERS

### -All

Indicates that this cmdlet gets all commands, including commands of the same type that have the same
name. By default, `Get-Command` gets only the commands that run when you type the command name.

For more information about the method that PowerShell uses to select the command to run when
multiple commands have the same name, see [about_Command_Precedence](About/about_Command_Precedence.md).
For information about module-qualified command names and running commands that do not run by default
because of a name conflict, see [about_Modules](About/about_Modules.md).

This parameter was introduced in Windows PowerShell 3.0.

In Windows PowerShell 2.0, `Get-Command` gets all commands by default.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ArgumentList

Specifies an array of arguments. This cmdlet gets information about a cmdlet or function when it is
used with the specified parameters ("arguments"). The alias for **ArgumentList** is **Args**.

To detect dynamic parameters that are available only when certain other parameters are used, set the
value of **ArgumentList** to the parameters that trigger the dynamic parameters.

To detect the dynamic parameters that a provider adds to a cmdlet, set the value of the
**ArgumentList** parameter to a path in the provider drive, such as WSMan:, HKLM:, or Cert:. When
the command is a PowerShell provider cmdlet, enter only one path in each command. The provider
cmdlets return only the dynamic parameters for the first path the value of **ArgumentList**. For
information about the provider cmdlets, see [about_Providers](About/about_Providers.md).

```yaml
Type: System.Object[]
Parameter Sets: (All)
Aliases: Args

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CommandType

Specifies the types of commands that this cmdlet gets. Enter one or more command types. Use
**CommandType** or its alias, **Type**. By default, `Get-Command` gets all cmdlets, functions, and
aliases.

The acceptable values for this parameter are:

- Alias. Gets the aliases of all PowerShell commands. For more information, see [about_Aliases](About/about_Aliases.md).
- All. Gets all command types. This parameter value is the equivalent of `Get-Command *`.
- Application. Gets non-PowerShell files in paths listed in the **Path** environment
  variable ($env:path), including .txt, .exe, and .dll files. For more information about the
  **Path** environment variable, see about_Environment_Variables.
- Cmdlet. Gets all cmdlets.
- ExternalScript. Gets all .ps1 files in the paths listed in the **Path** environment variable
  ($env:path).
- Filter and Function. Gets all PowerShell advanced and simple functions and filters.
- Script. Gets all script blocks. To get PowerShell scripts (.ps1 files), use the ExternalScript
  value.

```yaml
Type: System.Management.Automation.CommandTypes
Parameter Sets: AllCommandSet
Aliases: Type
Accepted values: Alias, Function, Filter, Cmdlet, ExternalScript, Application, Script, Workflow, Configuration, All

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FullyQualifiedModule

Specifies modules with names that are specified in the form of **ModuleSpecification** objects,
described in the **Remarks** section of
[ModuleSpecification Constructor (Hashtable)](/dotnet/api/microsoft.powershell.commands.modulespecification.-ctor?view=powershellsdk-1.1.0#Microsoft_PowerShell_Commands_ModuleSpecification__ctor_System_Collections_Hashtable_).
For example, the **FullyQualifiedModule** parameter accepts a module name that is specified in one
of the following formats:

- `@{ModuleName = "modulename"; ModuleVersion = "version_number"}`
- `@{ModuleName = "modulename"; ModuleVersion = "version_number"; Guid = "GUID"}`

**ModuleName** and **ModuleVersion** are required, but **Guid** is optional.

You cannot specify the **FullyQualifiedModule** parameter in the same command as a **Module**
parameter. The two parameters are mutually exclusive.

```yaml
Type: Microsoft.PowerShell.Commands.ModuleSpecification[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ListImported

Indicates that this cmdlet gets only commands in the current session.

Starting in PowerShell 3.0, by default, `Get-Command` gets all installed commands,
including, but not limited to, the commands in the current session. In PowerShell 2.0, it
gets only commands in the current session.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Module

Specifies an array of modules. This cmdlet gets the commands that came from the specified modules.
Enter the names of modules or module objects.

This parameter takes string values, but the value of this parameter can also be a **PSModuleInfo**
object, such as the objects that the `Get-Module` and `Import-PSSession` cmdlets return.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: PSSnapin

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -Name

Specifies an array of names. This cmdlet gets only commands that have the specified name. Enter a
name or name pattern. Wildcard characters are permitted.

To get commands that have the same name, use the **All** parameter. When two commands have the same
name, by default, `Get-Command` gets the command that runs when you type the command name.

```yaml
Type: System.String[]
Parameter Sets: AllCommandSet
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -Noun

Specifies an array of command nouns. This cmdlet gets commands, which include cmdlets, functions,
and aliases, that have names that include the specified noun. Enter one or more nouns or noun
patterns. Wildcard characters are permitted.

```yaml
Type: System.String[]
Parameter Sets: CmdletSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -ParameterName

Specifies an array of parameter names. This cmdlet gets commands in the session that have the
specified parameters. Enter parameter names or parameter aliases. Wildcard characters are supported.

The **ParameterName** and **ParameterType** parameters search only commands in the current session.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -ParameterType

Specifies an array of parameter names. This cmdlet gets commands in the session that have parameters
of the specified type. Enter the full name or partial name of a parameter type. Wildcard characters
are supported.

The **ParameterName** and **ParameterType** parameters search only commands in the current session.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.PSTypeName[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -ShowCommandInfo

Indicates that this cmdlet displays command information.

This parameter was introduced in Windows PowerShell 5.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Syntax

Indicates that this cmdlet gets only the following specified data about the command:

- Aliases. Gets the standard name and syntax.
- Cmdlets. Gets the syntax.
- Functions and filters. Gets the function definition.
- Scripts and applications or files. Gets the path and filename.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TotalCount

Specifies the number of commands to get. You can use this parameter to limit the output of a
command.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UseAbbreviationExpansion

Indicates using matching of the characters in the command to find with uppercase characters
in a command. For example, `i-psdf` would match `Import-PowerShellDataFile` as each of
the characters to find matches an uppercase character in the result. When using this
type of match, any wildcards will result in no matches.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: AllCommandSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UseFuzzyMatching

Indicates using a fuzzy matching algorithm when finding commands. The order of the output is from
closest match to least likely match. Wildcards should not be used with fuzzy matching as it will
attempt to match commands that may contain those wildcard characters.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: AllCommandSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Verb

Specifies an array of command verbs. This cmdlet gets commands, which include cmdlets, functions,
and aliases, that have names that include the specified verb. Enter one or more verbs or verb
patterns. Wildcard characters are permitted.

```yaml
Type: System.String[]
Parameter Sets: CmdletSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](About/about_CommonParameters.md).

## INPUTS

### System.String

You can pipe command names to this cmdlet.

## OUTPUTS

### System.Management.Automation.CommandInfo

This cmdlet returns objects derived from the **CommandInfo** class. The type of object that is
returned depends on the type of command that `Get-Command` gets.

### System.Management.Automation.AliasInfo

Represents aliases.

### System.Management.Automation.ApplicationInfo

Represents applications and files.

### System.Management.Automation.CmdletInfo

Represents cmdlets.

### System.Management.Automation.FunctionInfo

Represents functions and filters.

## NOTES

* When more than one command that has the same name is available to the session, `Get-Command`
  returns the command that runs when you type the command name. To get commands that have the same
  name, listed in run order, use the **All** parameter. For more information, see
  [about_Command_Precedence](../Microsoft.PowerShell.Core/About/about_Command_Precedence.md).
* When a module is imported automatically, the effect is the same as using the `Import-Module`
  cmdlet. The module can add commands, types and formatting files, and run scripts in the session.
  To enable, disable, and configuration automatic importing of modules, use the
  `$PSModuleAutoLoadingPreference` preference variable. For more information, see
  [about_Preference_Variables](../Microsoft.PowerShell.Core/About/about_Preference_Variables.md).

## RELATED LINKS

[Export-PSSession](../Microsoft.PowerShell.Utility/Export-PSSession.md)

[Get-Help](Get-Help.md)

[Get-Member](../Microsoft.PowerShell.Utility/Get-Member.md)

[Get-PSDrive](../Microsoft.PowerShell.Management/Get-PSDrive.md)

[Import-PSSession](../Microsoft.PowerShell.Utility/Import-PSSession.md)

[about_Command_Precedence](About/about_Command_Precedence.md)


---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821492
external help file:  System.Management.Automation.dll-Help.xml
title:  Import-Module
---

# Import-Module

## SYNOPSIS
Adds modules to the current session.

## SYNTAX

### Name (Default)
```
Import-Module [-Global] [-Prefix <String>] [-Name] <String[]> [-Function <String[]>] [-Cmdlet <String[]>]
 [-Variable <String[]>] [-Alias <String[]>] [-Force] [-PassThru] [-AsCustomObject] [-MinimumVersion <Version>]
 [-MaximumVersion <String>] [-RequiredVersion <Version>] [-ArgumentList <Object[]>] [-DisableNameChecking]
 [-NoClobber] [-Scope <String>] [<CommonParameters>]
```

### PSSession
```
Import-Module [-Global] [-Prefix <String>] [-Name] <String[]> [-Function <String[]>] [-Cmdlet <String[]>]
 [-Variable <String[]>] [-Alias <String[]>] [-Force] [-PassThru] [-AsCustomObject] [-MinimumVersion <Version>]
 [-MaximumVersion <String>] [-RequiredVersion <Version>] [-ArgumentList <Object[]>] [-DisableNameChecking]
 [-NoClobber] [-Scope <String>] -PSSession <PSSession> [<CommonParameters>]
```

### CimSession
```
Import-Module [-Global] [-Prefix <String>] [-Name] <String[]> [-Function <String[]>] [-Cmdlet <String[]>]
 [-Variable <String[]>] [-Alias <String[]>] [-Force] [-PassThru] [-AsCustomObject] [-MinimumVersion <Version>]
 [-MaximumVersion <String>] [-RequiredVersion <Version>] [-ArgumentList <Object[]>] [-DisableNameChecking]
 [-NoClobber] [-Scope <String>] -CimSession <CimSession> [-CimResourceUri <Uri>] [-CimNamespace <String>]
 [<CommonParameters>]
```

### FullyQualifiedName
```
Import-Module [-Global] [-Prefix <String>] [-FullyQualifiedName] <ModuleSpecification[]> [-Function <String[]>]
 [-Cmdlet <String[]>] [-Variable <String[]>] [-Alias <String[]>] [-Force] [-PassThru] [-AsCustomObject]
 [-ArgumentList <Object[]>] [-DisableNameChecking] [-NoClobber] [-Scope <String>] [<CommonParameters>]
```

### FullyQualifiedNameAndPSSession
```
Import-Module [-Global] [-Prefix <String>] [-FullyQualifiedName] <ModuleSpecification[]> [-Function <String[]>]
 [-Cmdlet <String[]>] [-Variable <String[]>] [-Alias <String[]>] [-Force] [-PassThru] [-AsCustomObject]
 [-ArgumentList <Object[]>] [-DisableNameChecking] [-NoClobber] [-Scope <String>] -PSSession <PSSession>
 [<CommonParameters>]
```

### Assembly
```
Import-Module [-Global] [-Prefix <String>] [-Assembly] <Assembly[]> [-Function <String[]>] [-Cmdlet <String[]>]
 [-Variable <String[]>] [-Alias <String[]>] [-Force] [-PassThru] [-AsCustomObject] [-ArgumentList <Object[]>]
 [-DisableNameChecking] [-NoClobber] [-Scope <String>] [<CommonParameters>]
```

### ModuleInfo
```
Import-Module [-Global] [-Prefix <String>] [-Function <String[]>] [-Cmdlet <String[]>] [-Variable <String[]>]
 [-Alias <String[]>] [-Force] [-PassThru] [-AsCustomObject] [-ModuleInfo] <PSModuleInfo[]>
 [-ArgumentList <Object[]>] [-DisableNameChecking] [-NoClobber] [-Scope <String>] [<CommonParameters>]
```

## DESCRIPTION
The **Import-Module** cmdlet adds one or more modules to the current session.
The modules that you import must be installed on the local computer or a remote computer.

Starting in Windows PowerShell 3.0, installed modules are automatically imported to the session when you use any commands or providers in the module.
However, you can still use the `Import-Module` command to import a module and you can enable and disable automatic module importing by using the `$PSModuleAutoloadingPreference` preference variable.
For more information about modules, see [about_Modules](/powershell/module/microsoft.powershell.core/about/about_modules).
For more information about the `$PSModuleAutoloadingPreference` variable, see [about_Preference_Variables](About/about_Preference_Variables.md).

A module is a package that contains members that can be used in Windows PowerShell.
Members include cmdlets, providers, scripts, functions, variables, and other tools and files.
After a module is imported, you can use the module members in your session.

To import a module, use the `Name`, `Assembly`,  `ModuleInfo`, `MinimumVersion` and `RequiredVersion` parameters to identify the module to import.
By default, `Import-Module` imports all members that the module exports, but you can use the `Alias`, `Function`, `Cmdlet`, and `Variable` parameters to restrict the members that are imported.
You can also use the `NoClobber` parameter to prevent `Import-Module` from importing members that have the same names as members in the current session.

`Import-Module` imports a module only into the current session.
To import the module into all sessions, add an `Import-Module` command to your Windows PowerShell profile.
For more information about profiles, see [about_Profiles](/powershell/module/microsoft.powershell.core/about/about_profiles).

Starting in Windows PowerShell 3.0, you can use `Import-Module` to import Common Information Model (CIM) modules, in which the cmdlets are defined in Cmdlet Definition XML (CDXML) files.
This feature allows you to use cmdlets that are implemented in non-managed code assemblies, such as those written in C++.

With these new features, `Import-Module` cmdlet becomes a primary tool for managing heterogeneous enterprises that include computers that run the Windows operating system and computers that are running other operating systems.

To manage remote computers that run the Windows operating system that have Windows PowerShell and Windows PowerShell remoting enabled, create a **PSSession** on the remote computer and then use the *PSSession* parameter of **Get-Module** to get the Windows PowerShell modules in the **PSSession**.
When you import the modules, and then use the imported commands in the current session, the commands run implicitly in the **PSSession** on the remote computer.
You can use this strategy to manage the remote computer.

You can use a similar strategy to manage computers that do not have Windows PowerShell remoting enabled, including computers that are not running the Windows operating system, and Windows computers that have Windows PowerShell, but do not have Windows PowerShell remoting enabled.

Start by creating a CIM session on the remote computer, which is a connection to Windows Management Instrumentation (WMI) on the remote computer.
Then use the *CIMSession* parameter of `Import-Module` to import CIM modules from the remote computer.
When you import a CIM module and then run the imported commands, the commands run implicitly on the remote computer.
You can use this WMI and CIM strategy to manage the remote computer.

## EXAMPLES

### Example 1: Import the members of a module into the current session
```powershell
Import-Module -Name BitsTransfer
```

This command imports the members of the `BitsTransfer` module into the current session.

The `Name` parameter name is optional and can be omitted.

By default, `Import-Module` does not generate any output when it imports a module.
To request output, use the `PassThru` or `AsCustomObject` parameter, or the `Verbose` common parameter.

### Example 2: Import all modules specified by the module path

```powershell
Get-Module -ListAvailable | Import-Module
```

This command imports all available modules in the path specified by the PSModulePath environment variable (`$env:PSModulePath`) into the current session.

### Example 3: Import the members of several modules into the current session

```powershell
$m = Get-Module -ListAvailable BitsTransfer, ServerManager
Import-Module -ModuleInfo $m
```

These commands import the members of the **BitsTransfer** and **ServerManager** modules into the current session.

The first command uses the `Get-Module` cmdlet to get the `BitsTransfer` and `ServerManager` modules.
It saves the objects in the `$m` variable.
The `ListAvailable` parameter is required when you are getting modules that are not yet imported into the session.

The second command uses the `ModuleInfo` parameter of `Import-Module` to import the modules into the current session.

These commands are equivalent to using a pipeline operator `|` to send the output of a `Get-Module` command to `Import-Module`.

### Example 4: Import all modules specified by a path

```powershell
Import-Module -Name c:\ps-test\modules\test -Verbose
```

```output
VERBOSE: Loading module from path 'C:\ps-test\modules\Test\Test.psm1'.
VERBOSE: Exporting function 'my-parm'.
VERBOSE: Exporting function 'Get-Parameter'.
VERBOSE: Exporting function 'Get-Specification'.
VERBOSE: Exporting function 'Get-SpecDetails'.
```

This command uses an explicit path to identify the module to import.

It also uses the `Verbose` common parameter to get a list of the items imported from the module.
Without the `Verbose`, `PassThru`, or `AsCustomObject` parameter, `Import-Module` does not generate any output when it imports a module.

### Example 5: Restrict module members imported into a session

```powershell
Import-Module BitsTransfer -Cmdlet Add-BitsFile, Get-BitsTransfer
(Get-Module BitsTransfer).ExportedCmdlets
```

```output
Key                   Value
---                   -----
Add-BitsFile          Add-BitsFile
Complete-BitsTransfer Complete-BitsTransfer
Get-BitsTransfer      Get-BitsTransfer
Remove-BitsTransfer   Remove-BitsTransfer
Resume-BitsTransfer   Resume-BitsTransfer
Set-BitsTransfer      Set-BitsTransfer
Start-BitsTransfer    Start-BitsTransfer
Suspend-BitsTransfer  Suspend-BitsTransfer
```

```powershell
Get-Command -Module BitsTransfer
```

```output
CommandType Name             Version Source
----------- ----             ------- ------
Cmdlet      Add-BitsFile     2.0.0.0 BitsTransfer
Cmdlet      Get-BitsTransfer 2.0.0.0 BitsTransfer
```

This example shows how to restrict the module members that are imported into the session and the effect of this command on the session.

The first command imports only the `Add-BitsFile` and `Get-BitsTransfer` cmdlets from the `BitsTransfer` module.
The command uses the `Cmdlet` parameter to restrict the cmdlets that the module imports.
You can also use the `Alias`, `Variable`, and `Function` parameters to restrict other members that a module imports.

The second command uses the `Get-Module` cmdlet to get the object that represents the `BitsTransfer` module.
The `ExportedCmdlets` property lists all of the cmdlets that the module exports, even when they were not all imported.

The third command uses the `Module` parameter of the `Get-Command` cmdlet to get the commands that were imported from the `BitsTransfer` module.
The results confirm that only the `Add-BitsFile` and `Get-BitsTransfer` cmdlets were imported.

### Example 6: Import the members of a module and add a prefix

```powershell
Import-Module BitsTransfer -Prefix PS -PassThru
```

```output
ModuleType Name                                ExportedCommands
---------- ----                                ----------------
Manifest   bitstransfer                        {Add-BitsFile, Complete-...
```

```powershell
Get-Command -Module BitsTransfer
```

```output
CommandType     Name                                               ModuleName
-----------     ----                                               ----------
Cmdlet          Add-BitsFile                                       bitstransfer
Cmdlet          Add-PSBitsFile                                     bitstransfer
Cmdlet          Complete-BitsTransfer                              bitstransfer
Cmdlet          Complete-PSBitsTransfer                            bitstransfer
Cmdlet          Get-BitsTransfer                                   bitstransfer
Cmdlet          Get-PSBitsTransfer                                 bitstransfer
Cmdlet          Remove-BitsTransfer                                bitstransfer
Cmdlet          Remove-PSBitsTransfer                              bitstransfer
Cmdlet          Resume-BitsTransfer                                bitstransfer
Cmdlet          Resume-PSBitsTransfer                              bitstransfer
Cmdlet          Set-BitsTransfer                                   bitstransfer
Cmdlet          Set-PSBitsTransfer                                 bitstransfer
Cmdlet          Start-BitsTransfer                                 bitstransfer
Cmdlet          Start-PSBitsTransfer                               bitstransfer
Cmdlet          Suspend-BitsTransfer                               bitstransfer
Cmdlet          Suspend-PSBitsTransfer                             bitstransfer
```

These commands import the `BitsTransfer` module into the current session, add a prefix to the member names, and then display the prefixed member names.

The first command uses the `Import-Module` cmdlet to import the `BitsTransfer` module.
It uses the `Prefix` parameter to add the PS prefix to all members that are imported from the module and the `PassThru` parameter to return a module object that represents the imported module.

The second command uses the `Get-Command` cmdlet to get the members that have been imported from the module.
It uses the `Module` parameter to specify the module.
The output shows that the module members were correctly prefixed.

The prefix that you use applies only to the members in the current session.
It does not change the module.

### Example 7: Use the AsCustomObject parameter

```powershell
Get-Module -ListAvailable | Format-Table -Property Name, ModuleType -AutoSize
```

```output
Name          ModuleType
----          ----------
Show-Calendar     Script
BitsTransfer    Manifest
PSDiagnostics   Manifest
TestCmdlets       Script
```

```powershell
$a = Import-Module -Name Show-Calendar -AsCustomObject -Passthru
$a | Get-Member
```

```output
    TypeName: System.Management.Automation.PSCustomObject
Name          MemberType   Definition
----          ----------   ----------
Equals        Method       bool Equals(System.Object obj)
GetHashCode   Method       int GetHashCode()
GetType       Method       type GetType()
ToString      Method       string ToString()
Show-Calendar ScriptMethod System.Object Show-Calendar();
```

```powershell
$a."Show-Calendar"()
```

These commands demonstrate how to get and use the custom object that `Import-Module` returns.

Custom objects include synthetic members that represent each of the imported module members.
For example, the cmdlets and functions in a module are converted to script methods of the custom object.

Custom objects are very useful in scripting.
They are also useful when several imported objects have the same names.
Using the script method of an object is equivalent to specifying the fully qualified name of an imported member, including its module name.

The `AsCustomObject` parameter can be used only when importing a script module, so the first task is to determine which of the available modules is a script module.

After viewing available modules with `-ListAvailable`, the second command uses the `Import-Module` cmdlet to import the `PSDiagnostics` script module.
The `AsCustomObject` parameter is used to request a custom object and the `PassThru` parameter to return the object and save it in the `$a` variable.

The `$a` variable is then piped to the `Get-Member` cmdlet, which gets the properties and methods of the PSCustomObject in `$a`.
The output shows a `Show-Calendar` script method.

The last command uses the `Show-Calendar` script method.
The method name must be enclosed in quotation marks, because it includes a hyphen.

### Example 8: Use the Force parameter to re-import a module

```powershell
Import-Module BitsTransfer
Import-Module BitsTransfer -Force -Prefix PS
```

This example shows how to use the `Force` parameter of `Import-Module` when you are re-importing a module into the same session.

The first command imports the `BitsTransfer` module.
The second command imports the module again, this time using the `Prefix` parameter.

The second command also includes the `Force` parameter, which removes the module and then imports it again.
Without this parameter, the session would include two copies of each `BitsTransfer` cmdlet, one with the standard name and one with the prefixed name.

### Example 9: Run commands that have been hidden by imported commands

```powershell
Get-Date
```

```output
Thursday, March 15, 2012 6:47:04 PM
```

```powershell
Import-Module TestModule -Function Get-Date
Get-Date
```

```output
12075
```

```powershell
Get-Command Get-Date -All | Format-Table -Property CommandType, Name, ModuleName -AutoSize
```

```output
CommandType     Name         ModuleName
-----------     ----         ----------
Function        Get-Date     TestModule
Cmdlet          Get-Date     Microsoft.PowerShell.Utility
```

```powershell
Microsoft.PowerShell.Utility\Get-Date
```

```output
Saturday, September 12, 2009 6:33:23 PM
```

This example shows how to run commands that have been hidden by imported commands.

The First two commands show the typical execution of the `Get-date` cmdlet.

Afterwards, a new `Get-Date` function is imported from the `TestModule` module.
Because functions take precedence over cmdlets, when `Get-Date` is called again, the `TestModule` module version runs, instead of the `Get-Date` cmdlet.

Using the `All` parameter of `Get-Command`, it is shown that there are now two `Get-Date` commands in the session.
A function from the `TestModule` module and a cmdlet from the `Microsoft.PowerShell.Utility` module.

The last command runs the hidden cmdlet by qualifying the command name with the module name.

For more information about command precedence in Windows PowerShell, see [about_Command_Precedence](/powershell/module/microsoft.powershell.core/about/about_command_precedence).

### Example 10: Specify a MinimumVersion for import

```powershell
Import-Module -Name PSWorkflow -MinimumVersion 3.0.0.0
```

This command imports the PSWorkflow module.
It uses the `MinimumVersion` (alias=Version) parameter of `Import-Module` to import only version 3.0.0.0 or greater of the module.

You can also use the `RequiredVersion` parameter to import a particular version of a module, or use the `Module` and `Version` parameters of the `#Requires` keyword to require a particular version of a module in a script.

### Example 11: Import a Module from a remote computer

```powershell
$s = New-PSSession -ComputerName Server01
Get-Module -PSSession $s -ListAvailable -Name NetSecurity
```

```output
ModuleType Name                                ExportedCommands
---------- ----                                ----------------
Manifest   NetSecurity                         {New-NetIPsecAuthProposal, New-NetIPsecMainModeCryptoProposal, New-Ne...
```

```powershell
Import-Module -PSSession $s -Name NetSecurity
# Use `Get-NetFirewallRule` to get Windows Remote Management firewall rules on the Server01 computer.
Get-NetFirewallRule -DisplayName "Windows Remote Management*" | Format-Table -Property DisplayName, Name -AutoSize
```

```output
DisplayName                                              Name
-----------                                              ----
Windows Remote Management (HTTP-In)                      WINRM-HTTP-In-TCP
Windows Remote Management (HTTP-In)                      WINRM-HTTP-In-TCP-PUBLIC
Windows Remote Management - Compatibility Mode (HTTP-In) WINRM-HTTP-Compat-In-TCP
```

```powershell
# Perform the same operation as above using Invoke-Command.
Invoke-Command -Session $s {Get-NetFirewallRule -DisplayName "Windows Remote Management*"} | Format-Table -Property DisplayName, Name -AutoSize
```

```output
DisplayName                                              Name
-----------                                              ----
Windows Remote Management (HTTP-In)                      WINRM-HTTP-In-TCP
Windows Remote Management (HTTP-In)                      WINRM-HTTP-In-TCP-PUBLIC
Windows Remote Management - Compatibility Mode (HTTP-In) WINRM-HTTP-Compat-In-TCP
```

This example shows how to use the `Import-Module` cmdlet to import a module from a remote computer.
This command uses the Implicit Remoting feature of Windows PowerShell.

When you import modules from another session, you can use the cmdlets in the current session.
However, commands that use the cmdlets actually run in the remote session.

### Example 12: Manage storage on a remote computer without the Windows operating system
The commands in this example enable you to manage the storage systems of a remote computer that is not running a Windows operating system.

In this example, because the administrator of the computer has installed the Module Discovery WMI provider, the CIM commands can use the default values, which are designed for the provider.

The session connects to WMI on the remote computer and saves the CIM session in the $cs variable.

```powershell
$cs = New-CimSession -ComputerName RSDGF03
Import-Module -CimSession $cs -Name Storage
# Importing a CIM module, converts the CDXML files for each command into PowerShell scripts.
# These appear as functions in the local session.
Get-Command Get-Disk
```

```output
CommandType     Name                  ModuleName
-----------     ----                  ----------
Function        Get-Disk              Storage
```

```powershell
# Use implicit remoting to query disks on the remote computer from which the module was imported.
Get-Disk
```

```output
Number Friendly Name              OperationalStatus          Total Size Partition Style
------ -------------              -----------------          ---------- ---------------
0      Virtual HD ATA Device      Online                          40 GB MBR
```

## PARAMETERS

### -Alias
Specifies the aliases that this cmdlet imports from the module into the current session.
Enter a comma-separated list of aliases.
Wildcard characters are permitted.

Some modules automatically export selected aliases into your session when you import the module.
This parameter lets you select from among the exported aliases.

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

### -ArgumentList
Specifies an array of arguments, or parameter values, that are passed to a script module during the **Import-Module** command.
This parameter is valid only when you are importing a script module.

You can also refer to the *ArgumentList* parameter by its alias, *args*.
For more information, see about_Aliases.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases: Args

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsCustomObject
Indicates that this cmdlet returns a custom object with members that represent the imported module members.
This parameter is valid only for script modules.

When you use the *AsCustomObject* parameter, **Import-Module** imports the module members into the session and then returns a **PSCustomObject** object instead of a **PSModuleInfo** object.
You can save the custom object in a variable and use dot notation to invoke the members.

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

### -Assembly
Specifies an array of assembly objects.
This cmdlet imports the cmdlets and providers implemented in the specified assembly objects.
Enter a variable that contains assembly objects or a command that creates assembly objects.
You can also pipe an assembly object to **Import-Module**.

When you use this parameter, only the cmdlets and providers implemented by the specified assemblies are imported.
If the module contains other files, they are not imported, and you might be missing important members of the module.
Use this parameter for debugging and testing the module, or when you are instructed to use it by the module author.

```yaml
Type: Assembly[]
Parameter Sets: Assembly
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -CimNamespace
Specifies the namespace of an alternate CIM provider that exposes CIM modules.
The default value is the namespace of the Module Discovery WMI provider.

Use this parameter to import CIM modules from computers and devices that are not running a Windows operating system.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: String
Parameter Sets: CimSession
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CimResourceUri
Specifies an alternate location for CIM modules.
The default value is the resource URI of the Module Discovery WMI provider on the remote computer.

Use this parameter to import CIM modules from computers and devices that are not running a Windows operating system.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: Uri
Parameter Sets: CimSession
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CimSession
Specifies a CIM session on the remote computer.
Enter a variable that contains the CIM session or a command that gets the CIM session, such as a [Get-CimSession](https://docs.microsoft.com/en-us/powershell/module/cimcmdlets/get-cimsession) command.

**Import-Module** uses the CIM session connection to import modules from the remote computer into the current session.
When you use the commands from the imported module in the current session, the commands actually run on the remote computer.

You can use this parameter to import modules from computers and devices that are not running the Windows operating system, and Windows computers that have Windows PowerShell, but do not have Windows PowerShell remoting enabled.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: CimSession
Parameter Sets: CimSession
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Cmdlet
Specifies an array of cmdlets that this cmdlet imports from the module into the current session.
Wildcard characters are permitted.

Some modules automatically export selected cmdlets into your session when you import the module.
This parameter lets you select from among the exported cmdlets.

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

### -DisableNameChecking
Indicates that this cmdlet suppresses the message that warns you when you import a cmdlet or function whose name includes an unapproved verb or a prohibited character.

By default, when a module that you import exports cmdlets or functions that have unapproved verbs in their names, Windows PowerShell displays the following warning message:

"WARNING: Some imported command names include unapproved verbs which might make them less discoverable.
Use the Verbose parameter for more detail or type Get-Verb to see the list of approved verbs."

This message is only a warning.
The complete module is still imported, including the non-conforming commands.
Although the message is displayed to module users, the naming problem should be fixed by the module author.

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

### -Force
This parameter causes a module to be loaded, or reloaded, over top of the current one

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

### -FullyQualifiedName
Specifies the fully qualified name of the module specification.

```yaml
Type: ModuleSpecification[]
Parameter Sets: FullyQualifiedName, FullyQualifiedNameAndPSSession
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Function
Specifies an array of functions that this cmdlet imports from the module into the current session.
Wildcard characters are permitted.

Some modules automatically export selected functions into your session when you import the module.
This parameter lets you select from among the exported functions.

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

### -Global
Indicates that this cmdlet imports modules into the global session state so they are available to all commands in the session.

By default, when Import-Module cmdlet is called from the command prompt, script file, or scriptblock, all the commands are imported into the global session state.

When invoked from another module, Import-Module cmdlet imports the commands in a module, including commands from nested modules, into the caller's session state.

The **Global** parameter is equivalent to the **Scope** parameter with a value of Global.

To restrict the commands that a module exports, use an `Export-ModuleMember` command in the script module.

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

### -MaximumVersion
Specifies a maximum version.
This cmdlet imports only a version of the module that is less than or equal to the specified value.
If no version qualifies, **Import-Module** generates an error.

```yaml
Type: String
Parameter Sets: Name, PSSession, CimSession
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MinimumVersion
Specifies a minimum version.
This cmdlet imports only a version of the module that is greater than or equal to the specified value.
If no version qualifies, **Import-Module** generates an error.

By default, **Import-Module** imports the module without checking the version number.

Use the *MinimumVersion* parameter name or its alias, Version.

To specify an exact version, use the *RequiredVersion* parameter.
You can also use the *Module* and *Version* parameters of the **#Requires** keyword to require a specific version of a module in a script.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: Version
Parameter Sets: Name, PSSession, CimSession
Aliases: Version

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ModuleInfo
Specifies an array of module objects to import.
Enter a variable that contains the module objects, or a command that gets the module objects, such as the following command: `Get-Module -ListAvailable`.
You can also pipe module objects to **Import-Module**.

```yaml
Type: PSModuleInfo[]
Parameter Sets: ModuleInfo
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Specifies the names of the modules to import.
Enter the name of the module or the name of a file in the module, such as a .psd1, .psm1, .dll, or ps1 file.
File paths are optional.
Wildcard characters are not permitted.
You can also pipe module names and file names to **Import-Module**.

If you omit a path, **Import-Module** looks for the module in the paths saved in the PSModulePath environment variable ($env:PSModulePath).

Specify only the module name whenever possible.
When you specify a file name, only the members that are implemented in that file are imported.
If the module contains other files, they are not imported, and you might be missing important members of the module.

```yaml
Type: String[]
Parameter Sets: Name, PSSession, CimSession
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -NoClobber
Indicates that this cmdlet does not import commands that have the same names as existing commands in the current session.
By default, **Import-Module** imports all exported module commands.

Commands that have the same names can hide or replace commands in the session.
To avoid command name conflicts in a session, use the *Prefix* or *NoClobber* parameters.
For more information about name conflicts and command precedence, see "Modules and Name Conflicts" in about_Modules and about_Command_Precedence.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: NoOverwrite

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PSSession
Specifies a Windows PowerShell user-managed session (**PSSession**) from which this cmdlet import modules into the current session.
Enter a variable that contains a **PSSession** or a command that gets a **PSSession**, such as a Get-PSSession command.

When you import a module from a different session into the current session, you can use the cmdlets from the module in the current session, just as you would use cmdlets from a local module.
Commands that use the remote cmdlets actually run in the remote session, but the remoting details are managed in the background by Windows PowerShell.

This parameter uses the Implicit Remoting feature of Windows PowerShell.
It is equivalent to using the Import-PSSession cmdlet to import particular modules from a session.

**Import-Module** cannot import Windows PowerShell Core modules from another session.
The Windows PowerShell Core modules have names that begin with Microsoft.PowerShell.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: PSSession
Parameter Sets: PSSession, FullyQualifiedNameAndPSSession
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Returns an object representing the item with which you are working.
By default, this cmdlet does not generate any output.

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

### -Prefix
Specifies a prefix that this cmdlet adds to the nouns in the names of imported module members.

Use this parameter to avoid name conflicts that might occur when different members in the session have the same name.
This parameter does not change the module, and it does not affect files that the module imports for its own use.
These are known as nested modules.
This cmdlet affects only the names of members in the current session.

For example, if you specify the prefix UTC and then import a Get-Date cmdlet, the cmdlet is known in the session as **Get-UTCDate**, and it is not confused with the original **Get-Date** cmdlet.

The value of this parameter takes precedence over the **DefaultCommandPrefix** property of the module, which specifies the default prefix.

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

### -RequiredVersion
Specifies a version of the module that this cmdlet imports.
If the version is not installed, **Import-Module** generates an error.

By default, **Import-Module** imports the module without checking the version number.

To specify a minimum version, use the *MinimumVersion* parameter.
You can also use the *Module* and *Version* parameters of the **#Requires** keyword to require a specific version of a module in a script.

This parameter was introduced in Windows PowerShell 3.0.

Scripts that use *RequiredVersion* to import modules that are included with existing releases of the Windows operating system do not automatically run in future releases of the Windows operating system.
This is because Windows PowerShell module version numbers in future releases of the Windows operating system are higher than module version numbers in existing releases of the Windows operating system.

```yaml
Type: Version
Parameter Sets: Name, PSSession, CimSession
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scope
Specifies a scope into which this cmdlet imports the module.

The acceptable values for this parameter are:

- **Global**. Available to all commands in the session. Equivalent to the *Global* parameter.
- **Local**. Available only in the current scope.

By default, when Import-Module cmdlet is called from the command prompt, script file, or scriptblock, all the commands are imported into the global session state.
You can use the **-Scope** parameter with the value of **Local** to import module into the script or scriptblock scope.

When invoked from another module, Import-Module cmdlet imports the commands in a module, including commands from nested modules, into the caller's session state.
Specifying **-Scope Global** or **-Global** indicates that this cmdlet imports modules into the global session state so they are available to all commands in the session.

The **Global** parameter is equivalent to the **Scope** parameter with a value of Global.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Local, Global

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Variable
Specifies an array of variables that this cmdlet imports from the module into the current session.
Enter a list of variables.
Wildcard characters are permitted.

Some modules automatically export selected variables into your session when you import the module.
This parameter lets you select from among the exported variables.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](/powershell/module/microsoft.powershell.core/about/about_commonparameters).

## INPUTS

### System.String, System.Management.Automation.PSModuleInfo, System.Reflection.Assembly

You can pipe a module name, module object, or assembly object to `Import-Module`.

## OUTPUTS

### None, System.Management.Automation.PSModuleInfo, or System.Management.Automation.PSCustomObject

By default, **Import-Module** does not generate any output.
If you specify the *PassThru* parameter, the cmldet generates a **System.Management.Automation.PSModuleInfo** object that represents the module.
If you specify the *AsCustomObject* parameter, it generates a **PSCustomObject** object.

## NOTES

- Before you can import a module, the module must be installed on the local computer, that is, the module directory must be copied to a directory that is accessible to your local computer. For more information, see [about_Modules](/powershell/module/microsoft.powershell.core/about/about_modules).

  You can also use the `PSSession` and `CIMSession` parameters to import modules that are installed on remote computers.
However, commands that use the cmdlets in these modules actually run in the remote session on the remote computer.

- If you import members with the same name and the same type into your session, Windows PowerShell uses the member imported last by default. Variables and aliases are replaced, and the originals are not accessible. Functions, cmdlets and providers are merely "shadowed" by the new members, and they can be accessed by qualifying the command name with the name of its snap-in, module, or function path.
- To update the formatting data for commands that have been imported from a module, use the `Update-FormatData` cmdlet. `Update-FormatData` also updates the formatting data for commands in the session that were imported from modules. If the formatting file for a module changes, you can run an `Update-FormatData` command to update the formatting data for imported commands. You do not need to import the module again.
- Beginning in Windows PowerShell 3.0, the core commands that are installed with Windows PowerShell are packaged in modules. In Windows PowerShell 2.0, and in host programs that create older-style sessions in later versions of Windows PowerShell, the core commands are packaged in snap-ins ("PSSnapins"). The exception is `Microsoft.PowerShell.Core`, which is always a snap-in. Also, remote sessions, such as those started by the `New-PSSession` cmdlet, are older-style sessions that include core snap-ins.

  For information about the `CreateDefault2` method that creates newer-style sessions with core modules, see [CreateDefault2 Method](/dotnet/api/system.management.automation.runspaces.initialsessionstate.createdefault2) in the MSDN library.

- `Import-Module` cannot import Windows PowerShell Core modules from another session. The Windows PowerShell Core modules have names that begin with Microsoft.PowerShell.
- In Windows PowerShell 2.0, some of the property values of the module object, such as the `ExportedCmdlets` and `NestedModules` property values, were not populated until the module was imported and were not available on the module object that the `PassThru` parameter returns. In Windows PowerShell 3.0, all module property values are populated.
- If you attempt to import a module that contains mixed-mode assemblies that are not compatible with Windows PowerShell 3.0, `Import-Module` returns an error message like the following one.

  `Import-Module : Mixed mode assembly is built against version 'v2.0.50727' of the runtime and cannot be loaded in the 4.0 runtime without additional configuration information.`

  This error occurs when a module that is designed for Windows PowerShell 2.0 contains at least one mixed-module assembly, that is, an assembly that includes both managed and non-managed code, such as C++ and C#.

  To import a module that contains mixed-mode assemblies, start Windows PowerShell 2.0 by using the following command, and then try the `Import-Module` command again.

  `PowerShell.exe -Version 2.0`

- To use the CIM session feature, the remote computer must have WS-Management remoting and Windows Management Instrumentation (WMI), which is the Microsoft implementation of the Common Information Model (CIM) standard. The computer must also have the Module Discovery WMI provider or an alternate CIM provider that has the same basic features.

  You can use the CIM session feature on computers that are not running a Windows operating system and on Windows computers that have Windows PowerShell, but do not have Windows PowerShell remoting enabled.

  You can also use the CIM parameters to get CIM modules from computers that have Windows PowerShell remoting enabled, including the local computer.
When you create a CIM session on the local computer, Windows PowerShell uses DCOM, instead of WMI, to create the session.

## RELATED LINKS

[Export-ModuleMember](Export-ModuleMember.md)

[Get-Module](Get-Module.md)

[New-Module](New-Module.md)

[Remove-Module](Remove-Module.md)
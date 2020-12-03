---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 12/03/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/get-module?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-Module
---
# Get-Module

## SYNOPSIS
List the modules imported in the current session or that can be imported from the PSModulePath.

## SYNTAX

### Loaded (Default)

```
Get-Module [[-Name] <String[]>] [-FullyQualifiedName <ModuleSpecification[]>] [-All] [<CommonParameters>]
```

### Available

```
Get-Module [[-Name] <String[]>] [-FullyQualifiedName <ModuleSpecification[]>] [-All] [-ListAvailable]
 [-PSEdition <String>] [-SkipEditionCheck] [-Refresh] [<CommonParameters>]
```

### PsSession

```
Get-Module [[-Name] <String[]>] [-FullyQualifiedName <ModuleSpecification[]>] [-ListAvailable]
 [-PSEdition <String>] [-SkipEditionCheck] [-Refresh] -PSSession <PSSession> [<CommonParameters>]
```

### CimSession

```
Get-Module [[-Name] <String[]>] [-FullyQualifiedName <ModuleSpecification[]>] [-ListAvailable]
 [-SkipEditionCheck] [-Refresh] -CimSession <CimSession> [-CimResourceUri <Uri>] [-CimNamespace <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-Module` cmdlet lists the PowerShell modules that have been imported, or that can be
imported, into a PowerShell session. Without parameters, `Get-Module` gets modules that have been
imported into the current session. The **ListAvailable** parameter is used to list the modules that
are available to be imported from the paths specified in the PSModulePath environment variable
(`$env:PSModulePath`).

The module object that `Get-Module` returns contains valuable information about the module. You can
also pipe the module objects to other cmdlets, such as the `Import-Module` and `Remove-Module`
cmdlets.

`Get-Module` lists modules, but it does not import them. Starting in Windows PowerShell 3.0, modules
are automatically imported when you use a command in the module, but a `Get-Module` command does not
trigger an automatic import. You can also import the modules into your session using the
`Import-Module` cmdlet.

Starting in Windows PowerShell 3.0, you can get and then, import modules from remote sessions into
the local session. This strategy uses the Implicit Remoting feature of PowerShell and is equivalent
to using the `Import-PSSession` cmdlet. When you use commands in modules imported from another
session, the commands run implicitly in the remote session. This feature lets you manage the remote
computer from the local session.

Also, starting in Windows PowerShell 3.0, you can use `Get-Module` and `Import-Module` to get and
import Common Information Model (CIM) modules. CIM modules define cmdlets in Cmdlet Definition XML
(CDXML) files. This feature lets you use cmdlets that are implemented in non-managed code
assemblies, such as those written in C++.

Implicit remoting can be used to manage remote computers that have PowerShell remoting enabled.
Create a **PSSession** on the remote computer and then use the **PSSession** parameter of
`Get-Module` to get the PowerShell modules in the remote session. When you import a module from the
remote session the imported commands run in the session on the remote computer.

You can use a similar strategy to manage computers that do not have PowerShell remoting enabled.
These include computers that are not running the Windows operating system, and computers that have
PowerShell but do not have PowerShell remoting enabled.

Start by creating a CIM session on the remote computer. A CIM session is a connection to Windows
Management Instrumentation (WMI) on the remote computer. Then use the **CIMSession** parameter of
`Get-Module` to get CIM modules from the CIM session. When you import a CIM module by using the
`Import-Module` cmdlet and then run the imported commands, the commands run implicitly on the remote
computer. You can use this WMI and CIM strategy to manage the remote computer.

## EXAMPLES

### Example 1: Get modules imported into the current session

```powershell
Get-Module
```

This command gets modules that have been imported into the current session.

### Example 2: Get installed modules and available modules

```powershell
Get-Module -ListAvailable
```

This command gets the modules that are installed on the computer and can be imported into the
current session.

`Get-Module` looks for available modules in the path specified by the **$env:PSModulePath**
environment variable. For more information about **PSModulePath**, see
[about_Modules](About/about_Modules.md) and
[about_Environment_Variables](About/about_Environment_Variables.md).

### Example 3: Get all exported files

```powershell
Get-Module -ListAvailable -All
```

This command gets all of the exported files for all available modules.

### Example 4: Get a module by its fully qualified name

```powershell
$FullyQualifedName = @{ModuleName="Microsoft.PowerShell.Management";ModuleVersion="3.1.0.0"}
Get-Module -FullyQualifiedName $FullyQualifedName | Format-Table -Property Name,Version
```

```Output
Name                             Version
----                             -------
Microsoft.PowerShell.Management  3.1.0.0
```

This command gets the **Microsoft.PowerShell.Management** module by specifying the fully qualified
name of the module by using the **FullyQualifiedName** parameter. The command then pipes the results
into the `Format-Table` cmdlet to format the results as a table with **Name** and **Version** as the
column headings.

### Example 5: Get properties of a module

```powershell
Get-Module | Get-Member -MemberType Property | Format-Table Name
```

```Output
Name
----
AccessMode
Author
ClrVersion
CompanyName
Copyright
Definition
Description
DotNetFrameworkVersion
ExportedAliases
ExportedCmdlets
ExportedCommands
ExportedFormatFiles
ExportedFunctions
ExportedTypeFiles
ExportedVariables
ExportedWorkflows
FileList
Guid
HelpInfoUri
LogPipelineExecutionDetails
ModuleBase
ModuleList
ModuleType
Name
NestedModules
OnRemove
Path
PowerShellHostName
PowerShellHostVersion
PowerShellVersion
PrivateData
ProcessorArchitecture
RequiredAssemblies
RequiredModules
RootModule
Scripts
SessionState
Version
```

This command gets the properties of the **PSModuleInfo** object that `Get-Module` returns. There is
one object for each module file.

You can use the properties to format and filter the module objects. For more information about the
properties, see [PSModuleInfo Properties](/dotnet/api/system.management.automation.psmoduleinfo).

The output includes the new properties, such as **Author** and **CompanyName**, that were introduced
in Windows PowerShell 3.0.

### Example 6: Group all modules by name

```powershell
Get-Module -ListAvailable -All | Format-Table -Property Name, Moduletype, Path -Groupby Name
```

```Output
Name: AppLocker

Name      ModuleType Path
----      ---------- ----
AppLocker   Manifest C:\Windows\system32\WindowsPowerShell\v1.0\Modules\AppLocker\AppLocker.psd1


   Name: Appx

Name ModuleType Path
---- ---------- ----
Appx   Manifest C:\Windows\system32\WindowsPowerShell\v1.0\Modules\Appx\en-US\Appx.psd1
Appx   Manifest C:\Windows\system32\WindowsPowerShell\v1.0\Modules\Appx\Appx.psd1
Appx     Script C:\Windows\system32\WindowsPowerShell\v1.0\Modules\Appx\Appx.psm1


   Name: BestPractices

Name          ModuleType Path
----          ---------- ----
BestPractices   Manifest C:\Windows\system32\WindowsPowerShell\v1.0\Modules\BestPractices\BestPractices.psd1


   Name: BitsTransfer

Name         ModuleType Path
----         ---------- ----
BitsTransfer   Manifest C:\Windows\system32\WindowsPowerShell\v1.0\Modules\BitsTransfer\BitsTransfer.psd1
```

This command gets all module files, both imported and available, and then groups them by module
name. This lets you see the module files that each script is exporting.

### Example 7: Display the contents of a module manifest

These commands display the contents of the module manifest for the Windows PowerShell
**BitsTransfer** module.

Modules are not required to have manifest files. When they do have a manifest file, the manifest
file is required only to include a version number. However, manifest files often provide useful
information about a module, its requirements, and its contents.

```powershell
# First command
$m = Get-Module -list -Name BitsTransfer

# Second command
Get-Content $m.Path
```

```Output
@ {
    GUID               = "{8FA5064B-8479-4c5c-86EA-0D311FE48875}"
    Author             = "Microsoft Corporation"
    CompanyName        = "Microsoft Corporation"
    Copyright          = "Microsoft Corporation. All rights reserved."
    ModuleVersion      = "1.0.0.0"
    Description        = "Windows PowerShell File Transfer Module"
    PowerShellVersion  = "2.0"
    CLRVersion         = "2.0"
    NestedModules      = "Microsoft.BackgroundIntelligentTransfer.Management"
    FormatsToProcess   = "FileTransfer.Format.ps1xml"
    RequiredAssemblies = Join-Path $psScriptRoot "Microsoft.BackgroundIntelligentTransfer.Management.Interop.dll"
}
```

The first command gets the PSModuleInfo object that represents BitsTransfer module. It saves the
object in the `$m` variable.

The second command uses the `Get-Content` cmdlet to get the content of the manifest file in the
specified path. It uses dot notation to get the path to the manifest file, which is stored in the
Path property of the object. The output shows the contents of the module manifest.

### Example 8: List files in module directory

```powershell
dir (Get-Module -ListAvailable FileTransfer).ModuleBase
```

```Output
Directory: C:\Windows\system32\WindowsPowerShell\v1.0\Modules\FileTransfer
Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d----        12/16/2008  12:36 PM            en-US
-a---        11/19/2008  11:30 PM      16184 FileTransfer.Format.ps1xml
-a---        11/20/2008  11:30 PM       1044 FileTransfer.psd1
-a---        12/16/2008  12:20 AM     108544 Microsoft.BackgroundIntelligentTransfer.Management.Interop.dll
```

This command lists the files in the directory of the module. This is another way to determine what
is in a module before you import it. Some modules might have help files or ReadMe files that
describe the module.

### Example 9: Get modules installed on a computer

```powershell
$s = New-PSSession -ComputerName Server01

Get-Module -PSSession $s -ListAvailable
```

These commands get the modules that are installed on the Server01 computer.

The first command uses the `New-PSSession` cmdlet to create a **PSSession** on the Server01
computer. The command saves the **PSSession** in the $s variable.

The second command uses the **PSSession** and **ListAvailable** parameters of `Get-Module` to get
the modules in the **PSSession** in the `$s` variable.

If you pipe modules from other sessions to the `Import-Module` cmdlet, `Import-Module` imports the
module into the current session by using the implicit remoting feature. This is equivalent to using
the `Import-PSSession` cmdlet. You can use the cmdlets from the module in the current session, but
commands that use these cmdlets actually run the remote session. For more information, see
[`Import-Module`](Import-Module.md) and
[`Import-PSSession`](../Microsoft.PowerShell.Utility/Import-PSSession.md).

### Example 10: Manage a computer that does not run the Windows operating system

The commands in this example enable you to manage the storage systems of a remote computer that is
not running the Windows operating system.
In this example, because the administrator of the computer has installed the Module Discovery WMI
provider, the CIM commands can use the default values, which are designed for the provider.

```powershell
$cs = New-CimSession -ComputerName RSDGF03
Get-Module -CimSession $cs -Name Storage | Import-Module
Get-Command Get-Disk
```

```Output
CommandType     Name                  ModuleName
-----------     ----                  ----------
Function        Get-Disk              Storage
```

```powershell
Get-Disk
```

```Output
Number Friendly Name              OperationalStatus          Total Size Partition Style
------ -------------              -----------------          ---------- ---------------
0      Virtual HD ATA Device      Online                          40 GB MBR
```

The first command uses the `New-CimSession` cmdlet to create a session on the RSDGF03 remote
computer. The session connects to WMI on the remote computer. The command saves the CIM session in
the `$cs` variable.

The second command uses the CIM session in the `$cs` variable to run a `Get-Module` command on the
RSDGF03 computer. The command uses the Name parameter to specify the Storage module. The command
uses a pipeline operator (|) to send the Storage module to the `Import-Module` cmdlet, which imports
it into the local session.

The third command runs the `Get-Command` cmdlet on the `Get-Disk` command in the Storage module.
When you import a CIM module into the local session, PowerShell converts the CDXML files that
represent the CIM module into PowerShell scripts, which appear as functions in the local session.

The fourth command runs the `Get-Disk` command. Although the command is typed in the local session,
it runs implicitly on the remote computer from which it was imported. The command gets objects from
the remote computer and returns them to the local session.

## PARAMETERS

### -All

Indicates that this cmdlet gets all modules in each module folder, including nested modules,
manifest (.psd1) files, script module (.psm1) files, and binary module (.dll) files. Without this
parameter, `Get-Module` gets only the default module in each module folder.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Loaded, Available
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -CimNamespace

Specifies the namespace of an alternate CIM provider that exposes CIM modules. The default value is
the namespace of the Module Discovery WMI provider.

Use this parameter to get CIM modules from computers and devices that are not running the Windows
operating system.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.String
Parameter Sets: CimSession
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CimResourceUri

Specifies an alternate location for CIM modules. The default value is the resource URI of the Module
Discovery WMI provider on the remote computer.

Use this parameter to get CIM modules from computers and devices that are not running the Windows
operating system.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Uri
Parameter Sets: CimSession
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CimSession

Specifies a CIM session on the remote computer. Enter a variable that contains the CIM session or a
command that gets the CIM session, such as a
[Get-CimSession](/powershell/module/cimcmdlets/get-cimsession) command.

`Get-Module` uses the CIM session connection to get modules from the remote computer. When you
import the module by using the `Import-Module` cmdlet and use the commands from the imported module
in the current session, the commands actually run on the remote computer.

You can use this parameter to get modules from computers and devices that are not running the
Windows operating system, and computers that have PowerShell, but do not have PowerShell remoting
enabled.

The **CimSession** parameter gets all modules in the **CIMSession**. However, you can import only
CIM-based and Cmdlet Definition XML (CDXML)-based modules.

```yaml
Type: Microsoft.Management.Infrastructure.CimSession
Parameter Sets: CimSession
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FullyQualifiedName

Specifies modules with names that are specified in the form of **ModuleSpecification** objects. See
the Remarks section of
[ModuleSpecification Constructor (Hashtable)](/dotnet/api/microsoft.powershell.commands.modulespecification.-ctor#Microsoft_PowerShell_Commands_ModuleSpecification__ctor_System_Collections_Hashtable_).

For example, the **FullyQualifiedModule** parameter accepts a module name that is specified in
either of these formats:

- `@{ModuleName = "modulename"; ModuleVersion = "version_number"}`
- `@{ModuleName = "modulename"; ModuleVersion = "version_number"; Guid = "GUID"}`

**ModuleName** and **ModuleVersion** are required, but **Guid** is optional. You cannot specify the
**FullyQualifiedModule** parameter in the same command as a **Module** parameter. the two
parameters are mutually exclusive.

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

### -ListAvailable

Indicates that this cmdlet gets all installed modules. `Get-Module` gets modules in paths listed in
the **PSModulePath** environment variable. Without this parameter, `Get-Module` gets only the
modules that are both listed in the **PSModulePath** environment variable, and that are loaded in
the current session. **ListAvailable** does not return information about modules that are not found
in the **PSModulePath** environment variable, even if those modules are loaded in the current
session.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Available, PsSession, CimSession
Aliases:

Required: True (Available), False (PsSession, CimSession)
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Specifies names or name patterns of modules that this cmdlet gets. Wildcard characters are
permitted. You can also pipe the names to `Get-Module`. You cannot specify the
**FullyQualifiedName** parameter in the same command as a **Name** parameter.

**Name** cannot accept a module GUID as a value.
To return modules by specifying a GUID, use **FullyQualifiedName** instead.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: True
```

### -PSEdition

Gets the modules that support specified edition of PowerShell.

The acceptable values for this parameter are:

- Desktop
- Core

The Get-Module cmdlet checks **CompatiblePSEditions** property of **PSModuleInfo** object for the
specified value and returns only those modules that have it set.

> [!NOTE]
>
> - **Desktop Edition:** Built on .NET Framework and provides compatibility with scripts and modules
> targeting versions of PowerShell running on full footprint editions of Windows such as Server Core
> and Windows Desktop.
> - **Core Edition:** Built on .NET Core and provides compatibility with scripts and modules
> targeting versions of PowerShell running on reduced footprint editions of Windows such as Nano
> Server and Windows IoT.

```yaml
Type: System.String
Parameter Sets: PsSession, Available
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PSSession

Gets the modules in the specified user-managed PowerShell session (**PSSession**). Enter a variable
that contains the session, a command that gets the session, such as a `Get-PSSession` command, or a
command that creates the session, such as a `New-PSSession` command.

When the session is connected to a remote computer, you must specify the **ListAvailable**
parameter.

A `Get-Module` command that uses the **PSSession** parameter is equivalent to using the
`Invoke-Command` cmdlet to run a `Get-Module -ListAvailable` command in a **PSSession**.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.Runspaces.PSSession
Parameter Sets: PsSession
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Refresh

Indicates that this cmdlet refreshes the cache of installed commands. The command cache is created
when the session starts. It enables the `Get-Command` cmdlet to get commands from modules that are
not imported into the session.

This parameter is designed for development and testing scenarios in which the contents of modules
have changed since the session started.

When you specify the **Refresh** parameter in a command, you must specify **ListAvailable**.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Available, PsSession, CimSession
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipEditionCheck

Skips the check of the `CompatiblePSEditions` field.

By default, Get-Module will omit modules in the `%windir%\System32\WindowsPowerShell\v1.0\Modules`
directory that do not specify `Core` in the `CompatiblePSEditions` field. When this switch is set,
modules without `Core` will be included, so that modules under the Windows PowerShell module path
that are incompatible with PowerShell Core will be returned.

On macOS and Linux, this parameter does nothing.

See [about_PowerShell_Editions](About/about_PowerShell_Editions.md) for more information.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Available, PsSession, CimSession
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
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe module names to this cmdlet.

## OUTPUTS

### System.Management.Automation.PSModuleInfo

This cmdlet returns objects that represent modules.
When you specify the **ListAvailable** parameter, `Get-Module` returns a **ModuleInfoGrouping**
object, which is a type of **PSModuleInfo** object that has the same properties and methods.

## NOTES

- Beginning in Windows PowerShell 3.0, the core commands that are included in PowerShell are
  packaged in modules. The exception is **Microsoft.PowerShell.Core**, which is a snap-in
  (**PSSnapin**). By default, only the **Microsoft.PowerShell.Core** snap-in is added to the
  session. Modules are imported automatically on first use and you can use the `Import-Module`
  cmdlet to import them.

- In Windows PowerShell 2.0, and in host programs that create older-style sessions in later versions
  of PowerShell, the core commands are packaged in snap-ins (**PSSnapins**). The exception is
  **Microsoft.PowerShell.Core**, which is always a snap-in. Also, remote sessions, such as those
  started by the `New-PSSession` cmdlet, are older-style sessions that include core snap-ins.

  For information about the **CreateDefault2** method that creates newer-style sessions with core
  modules, see
  [CreateDefault2 Method](/dotnet/api/system.management.automation.runspaces.initialsessionstate.createdefault2).

- `Get-Module` only gets modules in locations that are stored in the value of the **PSModulePath**
  environment variable ($env:PSModulePath). The `Import-Module` cmdlet can import modules in other
  locations, but you cannot use the `Get-Module` cmdlet to get them.

- Also, starting in PowerShell 3.0, new properties have been added to the object that `Get-Module`
  returns that make it easier to learn about modules even before they are imported. All properties
  are populated before importing. These include the **ExportedCommands**, **ExportedCmdlets** and
  **ExportedFunctions** properties that list the commands that the module exports.

- The **ListAvailable** parameter gets only well-formed modules, that is, folders that contain at
  least one file whose base name is the same as the name of the module folder. The base name is the
  name without the file name extension. Folders that contain files that have different names are
  considered to be containers, but not modules.

  To get modules that are implemented as DLL files, but are not enclosed in a module folder,
  specify both the **ListAvailable** and **All** parameters.

- To use the CIM session feature, the remote computer must have WS-Management remoting and Windows
  Management Instrumentation (WMI), which is the Microsoft implementation of the Common Information
  Model (CIM) standard. The computer must also have the Module Discovery WMI provider or an
  alternate WMI provider that has the same basic features.

  You can use the CIM session feature on computers that are not running the Windows operating system
  and on Windows computers that have PowerShell, but do not have PowerShell remoting enabled.

  You can also use the CIM parameters to get CIM modules from computers that have PowerShell
  remoting enabled. This includes the local computer. When you create a CIM session on the local
  computer, PowerShell uses DCOM, instead of WMI, to create the session.

## RELATED LINKS

[Get-CimSession](../CimCmdlets/Get-CimSession.md)

[New-CimSession](../CimCmdlets/New-CimSession.md)

[about_Modules](About/about_Modules.md)

[Get-PSSession](Get-PSSession.md)

[Import-Module](Import-Module.md)

[Import-PSSession](../Microsoft.PowerShell.Utility/Import-PSSession.md)

[New-PSSession](New-PSSession.md)

[Remove-Module](Remove-Module.md)

[about_PowerShell_Editions](About/about_PowerShell_Editions.md)

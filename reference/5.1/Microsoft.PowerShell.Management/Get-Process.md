---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 04/15/2025
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/get-process?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-Process
---

# Get-Process

## SYNOPSIS
Gets the processes that are running on the local computer or a remote computer.

## SYNTAX

### Name (Default)

```
Get-Process [[-Name] <String[]>] [-ComputerName <String[]>] [-Module] [-FileVersionInfo]
 [<CommonParameters>]
```

### NameWithUserName

```
Get-Process [[-Name] <String[]>] [-IncludeUserName] [<CommonParameters>]
```

### IdWithUserName

```
Get-Process -Id <Int32[]> [-IncludeUserName] [<CommonParameters>]
```

### Id

```
Get-Process -Id <Int32[]> [-ComputerName <String[]>] [-Module] [-FileVersionInfo]
 [<CommonParameters>]
```

### InputObjectWithUserName

```
Get-Process -InputObject <Process[]> [-IncludeUserName] [<CommonParameters>]
```

### InputObject

```
Get-Process -InputObject <Process[]> [-ComputerName <String[]>] [-Module] [-FileVersionInfo]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-Process` cmdlet gets the processes on a local or remote computer.

Without parameters, this cmdlet gets all processes on the local computer. You can also specify a
specific process by process name or process ID (PID), or by piping a **System.Diagnostics.Process**
object to this cmdlet.

By default, this cmdlet returns a **Process** object that has detailed information about the process
and supports methods that let you control it. With parameters, you can change the type of
information returned by this cmdlet.

- **Module**: Retrieve information for each module loaded into the process.
- **FileVersionInfo**: Retrieve file version information for the main module of the process.

> [!NOTE]
> A module is an executable file or a dynamic link library (DLL) loaded into a process. A process
> has one or more modules. The main module is the module used to initially start the process. For
> more information, see [ProcessModule Class](/dotnet/api/system.diagnostics.processmodule).

## EXAMPLES

### Example 1: Get a list of all running processes on the local computer

```powershell
Get-Process
```

This command gets a list of all running processes on the local computer. For a definition of each
display column, see the [NOTES](#notes) section.

To see all properties of a **Process** object, use `Get-Process | Get-Member`. By default,
PowerShell displays certain property values using units such as kilobytes (K) and megabytes (M). The
actual values when accessed with the member-access operator (`.`) are in bytes.

### Example 2: Display detailed information about one or more processes

```powershell
Get-Process winword, explorer | Format-List *
```

This pipeline displays detailed information about the `winword` and `explorer` processes on the
computer. It uses the **Name** parameter to specify the processes, but it omits the optional
parameter name. The pipeline operator (`|`) pipes **Process** objects to the `Format-List`
cmdlet, which displays all available properties (`*`) and their values for each object.

You can also identify the processes by their process IDs. For instance, `Get-Process -Id 664, 2060`.

### Example 3: Get all processes with a working set greater than a specified size

```powershell
Get-Process | Where-Object { $_.WorkingSet -gt 20971520 }
Get-Process | Where-Object WorkingSet -GT 20MB
```

The `Get-Process` cmdlet returns the running processes. The output is piped to the `Where-Object`
cmdlet, which selects the objects with a **WorkingSet** value greater than 20,971,520 bytes.

In the first example, `Where-Object` uses a scriptblock to compare the **WorkingSet** property of
each **Process** object. In the second example, the `Where-Object` cmdlet uses the simplified syntax
to compare the **WorkingSet** property. In this case, `-GT` is a parameter, not a comparison
operator. The second example also uses a
[numeric literal suffix](../Microsoft.PowerShell.Core/About/about_Numeric_Literals.md) as a concise
alternative to `20971520`. In PowerShell, `MB` represents a mebibyte (MiB) multiplier. `20MB` is
equal to 20,971,520 bytes.

### Example 4: Display processes on the computer in groups based on priority

```powershell
$processes = Get-Process
$processes | Sort-Object { $_.PriorityClass } | Format-Table -View Priority
```

These commands display processes on the computer in groups based on their
[priority class](/dotnet/api/system.diagnostics.processpriorityclass). The first command gets all
processes on the computer and stores them in the `$processes` variable.

The second command pipes the **Process** objects stored in the `$processes` variable to the
`Sort-Object` cmdlet, then to the `Format-Table` cmdlet, which formats the processes using the
**Priority** view.

The **Priority** view, and other views, are defined in the `.ps1xml` format files in the PowerShell
home directory (`$PSHOME`).

### Example 5: Add a property to the default `Get-Process` output display

```powershell
Get-Process -Name powershell | Format-Table -Property @(
    'Handles'
    @{ Name = 'NPM(K)'; Expression = { [int] ($_.NPM / 1KB) } }
    @{ Name = 'PM(K)';  Expression = { [int] ($_.PM / 1KB) } }
    @{ Name = 'WS(K)';  Expression = { [int] ($_.WS / 1KB) } }
    @{ Name = 'CPU(s)'; Expression = { if ($_.CPU) { $_.CPU.ToString('N') } } }
    'Id'
    @{ Name = 'SI'; Expression = 'SessionId' }
    'ProcessName'
    'StartTime'
) -AutoSize
```

```Output
Handles NPM(K) PM(K) WS(K) CPU(s)   Id SI ProcessName StartTime
------- ------ ----- ----- ------   -- -- ----------- ---------
    655     34 69424 83424 2.20   4240  1 powershell  4/14/2025 10:40:10 AM
    572     36 68768 57260 7.41   4968  1 powershell  4/13/2025 3:33:50 PM
    405     26 38144 30340 1.80   8776  1 powershell  4/14/2025 9:54:27 AM
```

This example retrieves processes from the local computer and pipes each **Process** object to the
`Format-Table` cmdlet. `Format-Table` recreates the default output display of a **Process** object
using a mixture of property names and
[calculated properties](../Microsoft.PowerShell.Core/About/about_Calculated_Properties.md). The
display includes an additional **StartTime** property not present in the default display.

### Example 6: Get version information for a process

```powershell
Get-Process -Name powershell -FileVersionInfo
```

```Output
ProductVersion   FileVersion      FileName
--------------   -----------      --------
10.0.19041.320   10.0.19041.32... C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
```

This command uses the **FileVersionInfo** parameter to get file version information for the main
module of the `powershell` process. The main module is the file used to start the process, which
in this case is `powershell.exe`.

To use this command with processes that you don't own on Windows Vista and later versions of
Windows, you must run PowerShell with elevated user rights (**Run as administrator**).

### Example 7: Get modules loaded with the specified process

```powershell
Get-Process -Name SQL* -Module
```

This command uses the **Module** parameter to get the modules loaded by all processes with a name
beginning with `SQL`.

To use this command with processes that you don't own on Windows Vista and later versions of
Windows, you must run PowerShell with elevated user rights (**Run as administrator**).

### Example 8: Find the owner of a process

```powershell
Get-Process -Name powershell -IncludeUserName
```

```Output
Handles      WS(K)   CPU(s)     Id UserName            ProcessName
-------      -----   ------     -- --------            -----------
    782     132080     2.08   2188 DOMAIN01\user01     powershell
```

```powershell
Get-CimInstance -ClassName Win32_Process -Filter "name='powershell.exe'" |
    Invoke-CimMethod -MethodName GetOwner
```

```Output
Domain   ReturnValue User   PSComputerName
------   ----------- ----   --------------
DOMAIN01           0 user01
```

The first command shows how to get the owner of a process. The **IncludeUserName** parameter
requires elevated user rights (**Run as Administrator**). The output reveals that the owner is
`DOMAIN01\user01`.

The second pipeline shows a different way to get the owner of a process using `Get-CimInstance` and
`Invoke-CimMethod`. The **Win32_Process** class with a filter retrieves `powershell` processes and
the invoked `GetOwner()` method returns information on the process's **Domain** and **User**. This
method doesn't require elevated user rights.

### Example 9: Use an automatic variable to identify the process hosting the current session

```powershell
Get-Process -Name powershell
```

```Output
Handles  NPM(K)    PM(K)      WS(K)     CPU(s)     Id  SI ProcessName
-------  ------    -----      -----     ------     --  -- -----------
    561      44    47564      40740       6.48   2604   1 powershell
    642      40    72040      24372      23.53   3576   1 powershel
```

```powershell
Get-Process -Id $PID
```

```Output
Handles  NPM(K)    PM(K)      WS(K)     CPU(s)     Id  SI ProcessName
-------  ------    -----      -----     ------     --  -- -----------
    647      40    72464      30716      23.67   3576   1 powershell
```

These commands show how to use the `$PID` automatic variable to identify the process that's hosting
the current PowerShell session. You can use this method to distinguish the host process from other
`powershell` processes that you might want to control.

The first command gets all `powershell` processes running. The second command gets the `powershell`
process that's hosting the current session.

### Example 10: Get all processes that have a main window title and display them in a table

```powershell
Get-Process |
    Where-Object -Property MainWindowTitle |
    Format-Table -Property Id, Name, MainWindowTitle -AutoSize
```

This pipeline gets all processes that have a main window title, and displays them in a table with
the process ID and name.

**MainWindowTitle** is one of many useful properties of the **Diagnostics.Process** object type that
`Get-Process` returns. To view all properties, use `Get-Process | Get-Member`.

## PARAMETERS

### -ComputerName

Specifies the computers for which this cmdlet gets running processes. The default is the local
computer.

Specify the NetBIOS name, an IP address, or a fully qualified domain name (FQDN) of one or more
computers. To specify the local computer, use the computer name, a dot (`.`), or `localhost`.

This parameter doesn't rely on Windows PowerShell remoting. You can use the **ComputerName**
parameter of this cmdlet even if your computer isn't configured to run remote commands.

```yaml
Type: System.String[]
Parameter Sets: Name, Id, InputObject
Aliases: Cn

Required: False
Position: Named
Default value: Local computer
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FileVersionInfo

Indicates that this cmdlet gets the file version information for the program that runs in the
process.

On Windows Vista and later versions of Windows, you must run PowerShell with elevated user rights
(**Run as administrator**) to use this parameter on processes that you don't own.

You can't use the **FileVersionInfo** and **ComputerName** parameters together.

To get file version information for a process on a remote computer, use the `Invoke-Command` cmdlet.

Using this parameter is the same as accessing the **MainModule.FileVersionInfo** property of each
**Process** object. When you use this parameter, `Get-Process` returns a **FileVersionInfo**
object, not a **Process** object. You can't pipe output produced using this parameter to a cmdlet
that expects a **Process** object, such as `Stop-Process`.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Name, Id, InputObject
Aliases: FV, FVI

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

Specifies one or more processes by process ID (PID). You can specify multiple IDs separated by
commas. To get the PID of a process, use `Get-Process`. To get the PID of the current PowerShell
session, use `$PID`.

```yaml
Type: System.Int32[]
Parameter Sets: IdWithUserName, Id
Aliases: PID

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IncludeUserName

Indicates that this command adds a **UserName** property to each returned **Process** object.

You must run PowerShell with elevated user rights (**Run as administrator**) to use this
parameter.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: NameWithUserName, IdWithUserName, InputObjectWithUserName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies one or more **Process** objects. Use a variable that contains the objects, or a command
or expression that gets the objects.

```yaml
Type: System.Diagnostics.Process[]
Parameter Sets: InputObjectWithUserName, InputObject
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Module

Indicates that this cmdlet gets the modules that the process has loaded.

On Windows Vista and later versions of Windows, you must run PowerShell with elevated user rights
(**Run as administrator**) to use this parameter on processes that you don't own.

To get the modules loaded by a process on a remote computer, use the `Invoke-Command` cmdlet.

Using this parameter is the same as accessing the **Modules** property of each **Process** object.
When you use this parameter, `Get-Process` returns a **ProcessModule** object, not a **Process**
object. You can't pipe output produced using this parameter to a cmdlet that expects a **Process**
object, such as `Stop-Process`.

When you use both the **Module** and **FileVersionInfo** parameters together, this cmdlet returns a
**FileVersionInfo** object with information about the file version of all modules.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Name, Id, InputObject
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Specifies one or more processes by process name. You can specify multiple process names separated by
commas and use wildcard characters. Using the `-Name` parameter is optional.

```yaml
Type: System.String[]
Parameter Sets: Name, NameWithUserName
Aliases: ProcessName

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### System.Diagnostics.Process

You can pipe **Process** objects to this cmdlet.

## OUTPUTS

### System.Diagnostics.Process

By default, this cmdlet returns a **System.Diagnostics.Process** object.

### System.Diagnostics.FileVersionInfo

If you use the **FileVersionInfo** parameter, this cmdlet returns a
**System.Diagnostics.FileVersionInfo** object.

### System.Diagnostics.ProcessModule

If you use the **Module** parameter, without the **FileVersionInfo** parameter, this cmdlet returns
a **System.Diagnostics.ProcessModule** object.

## NOTES

Windows PowerShell includes the following aliases for `Get-Process`:

- `gps`
- `ps`

On computers running 64-bit Windows, the 64-bit version of PowerShell gets the main module and
64-bit process modules. The 32-bit version of PowerShell gets only 32-bit process modules.

> [!WARNING]
> When you use `Get-Process` to get a 64-bit process in the 32-bit version of PowerShell, properties
> such as `Path` and `MainModule` of the returned **Process** object are `$null`. You must use
> either the 64-bit version of PowerShell or the
> [Win32_Process](/windows/desktop/CIMWin32Prov/win32-process) class.

To get process information from a remote computer, use the `Invoke-Command` cmdlet. For more
information, see [Invoke-Command](../Microsoft.PowerShell.Core/Invoke-Command.md).

You can use the Windows Management Instrumentation (WMI)
[Win32_Process](/windows/desktop/CIMWin32Prov/win32-process) class in PowerShell as an alternative
to `Get-Process`. For more information, see:

- [Example 8: Find the owner of a process](#example-8-find-the-owner-of-a-process)
- [Get-CimInstance](../CimCmdlets/Get-CimInstance.md)

The default display of a **Process** object is a table view that includes the following columns.

- **Handles**: The number of handles that the process has opened.
- **NPM(K)**: The amount of non-paged memory that the process is using, in kilobytes.
- **PM(K)**: The amount of pageable memory that the process is using, in kilobytes.
- **WS(K)**: The size of the working set of the process, in kilobytes. The working set consists of
  the pages of memory that were recently referenced by the process.
- **CPU(s)**: The amount of processor time that the process has used on all processors, in seconds.
- **Id**: The process ID (PID) of the process.
- **SI**: The session ID of the process.
- **ProcessName**: The name of the process.

You can use the built-in alternate views for **Process** objects available with `Format-Table`, such
as **StartTime** and **Priority**. You can also design your own views.

For a description of all available **Process** object members, see
[Process Properties](xref:System.Diagnostics.Process#properties) and
[Process Methods](xref:System.Diagnostics.Process#methods).

## RELATED LINKS

[Debug-Process](Debug-Process.md)

[Get-Process](Get-Process.md)

[Start-Process](Start-Process.md)

[Stop-Process](Stop-Process.md)

[Wait-Process](Wait-Process.md)

[Where-Object](../Microsoft.PowerShell.Core/Where-Object.md)

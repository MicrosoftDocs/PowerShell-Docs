---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 02/04/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/set-location?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Set-Location
---
# Set-Location

## SYNOPSIS
Sets the current working location to a specified location.

## SYNTAX

### Path (Default)

```
Set-Location [[-Path] <String>] [-PassThru] [-UseTransaction] [<CommonParameters>]
```

### LiteralPath

```
Set-Location -LiteralPath <String> [-PassThru] [-UseTransaction] [<CommonParameters>]
```

### Stack

```
Set-Location [-PassThru] [-StackName <String>] [-UseTransaction] [<CommonParameters>]
```

## DESCRIPTION

The `Set-Location` cmdlet sets the working location to a specified location. That location could be
a directory, a subdirectory, a registry location, or any provider path.

You can also use the **StackName** parameter to make a named location stack the current location
stack. For more information about location stacks, see the Notes.

## EXAMPLES

### Example 1: Set the current location

```powershell
PS C:\> Set-Location -Path "HKLM:\"
```

```output
PS HKLM:\>
```

This command sets the current location to the root of the `HKLM:` drive.

### Example 2: Set the current location and display that location

```powershell
PS C:\> Set-Location -Path "Env:\" -PassThru
```

```output
Path
----
Env:\

PS Env:\>
```

This command sets the current location to the root of the `Env:` drive. It uses the **PassThru**
parameter to direct PowerShell to return a **PathInfo** object that represents the `Env:\` location.

### Example 3: Set location to the current location in the C: drive

```powershell
PS C:\Windows\> Set-Location HKLM:\
PS HKLM:\> Set-Location C:
PS C:\Windows\>
```

The first command sets the location to the root of the `HKLM:` drive in the Registry provider.
The second command sets the location to the current location of the `C:` drive in the FileSystem
provider.
When the drive name is specified in the form `<DriveName>:` (without backslash), the cmdlet sets
the location to the current location in the PSDrive.
To get the current location in the PSDrive use `Get-Location -PSDrive <DriveName>` command.

### Example 4: Set the current location to a named stack

```powershell
PS C:\> Push-Location -Path 'C:\Program Files\PowerShell\' -StackName "Paths"
PS C:\Program Files\PowerShell\> Set-Location -StackName "Paths"
PS C:\Program Files\PowerShell\> Get-Location -Stack
```

```Output
Path
----
C:\
```

The first command adds the current location to the Paths stack.
The second command makes the Paths location stack the current location stack.
The third command displays the locations in the current location stack.

The `*-Location` cmdlets use the current location stack unless a different location stack is
specified in the command. For information about location stacks, see the [Notes](#notes).

## PARAMETERS

### -LiteralPath

Specifies a path of the location. The value of the **LiteralPath** parameter is used exactly as it
is typed. No characters are interpreted as wildcard characters. If the path includes escape
characters, enclose it in single quotation marks. Single quotation marks tell PowerShell not to
interpret any characters as escape sequences.

Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: System.String
Parameter Sets: LiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PassThru

Returns a **PathInfo** object that represents the location. By default, this cmdlet does not
generate any output.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specify the path of a new working location. If no path is provided, `Set-Location` defaults to the
current user's home directory. When wildcards are used, the cmdlet chooses the first path that
matches the wildcard pattern.

```yaml
Type: System.String
Parameter Sets: Path
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -StackName

Specifies the existing location stack name that this cmdlet makes the current location stack. Enter
a location stack name. To indicate the unnamed default location stack, type `$null` or an empty
string (`""`).

The `*-Location` cmdlets act on the current stack unless you use the **StackName** parameter to
specify a different stack.

```yaml
Type: System.String
Parameter Sets: Stack
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UseTransaction

Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see about_Transactions.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: usetx

Required: False
Position: Named
Default value: False
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

You can pipe a string that contains a path, but not a literal path, to this cmdlet.

## OUTPUTS

### None, System.Management.Automation.PathInfo, System.Management.Automation.PathInfoStack

This cmdlet does not generate any output unless you specify the **PassThru** parameter. Using
**PassThru** with **Path** or **LiteralPath** generates a **PathInfo** object that represents the
new location. Using **PassThru** with **StackName** generates a **PathInfoStack** object
representing the new stack context.

## NOTES

PowerShell supports multiple runspaces per process. Each runspace has its own _current directory_.
This is not the same as `[System.Environment]::CurrentDirectory`. This behavior can be an issue
when calling .NET APIs or running native applications without providing explicit directory paths.

Even if the location cmdlets did set the process-wide current directory, you can't depend on it
because another runspace might change it at any time. You should use the location cmdlets to perform
path-based operations using the current working directory specific to the current runspace.

The `Set-Location` cmdlet is designed to work with the data exposed by any provider. To list the
providers available in your session, type `Get-PSProvider`. For more information, see
[about_Providers](../Microsoft.PowerShell.Core/about/about_Providers.md).

A stack is a last-in, first-out list in which only the most recently added item can be accessed. You
add items to a stack in the order that you use them, and then retrieve them for use in the reverse
order. PowerShell lets you store provider locations in location stacks. PowerShell creates an
unnamed default location stack. You can create multiple named location stacks. If you do not specify
a stack name, PowerShell uses the current location stack. By default, the unnamed default location
is the current location stack, but you can use the `Set-Location` cmdlet to change the current
location stack.

To manage location stacks, use the `*-Location` cmdlets, as follows:

- To add a location to a location stack, use the `Push-Location` cmdlet.

- To get a location from a location stack, use the `Pop-Location` cmdlet.

- To display the locations in the current location stack, use the **Stack** parameter of the
  `Get-Location` cmdlet. To display the locations in a named location stack, use the **StackName**
  parameter of `Get-Location`.

- To create a new location stack, use the **StackName** parameter of `Push-Location`. If you specify
  a stack that does not exist, `Push-Location` creates the stack.

- To make a location stack the current location stack, use the **StackName** parameter of
  `Set-Location`.

The unnamed default location stack is fully accessible only when it is the current location stack.
If you make a named location stack the current location stack, you can no longer use the
`Push-Location` or `Pop-Location` cmdlets to add or get items from the default stack or use the
`Get-Location` cmdlet to display the locations in the unnamed stack. To make the unnamed stack
the current stack, use the **StackName** parameter of the `Set-Location` cmdlet with a value of
`$null` or an empty string (`""`).

## RELATED LINKS

[Get-Location](Get-Location.md)

[Pop-Location](Pop-Location.md)

[Push-Location](Push-Location.md)

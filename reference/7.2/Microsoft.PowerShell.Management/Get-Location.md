---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 03/12/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/get-location?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-Location
---
# Get-Location

## SYNOPSIS
Gets information about the current working location or a location stack.

## SYNTAX

### Location (Default)

```
Get-Location [-PSProvider <String[]>] [-PSDrive <String[]>] [<CommonParameters>]
```

### Stack

```
Get-Location [-Stack] [-StackName <String[]>] [<CommonParameters>]
```

## DESCRIPTION

The `Get-Location` cmdlet gets an object that represents the current directory, much like the print
working directory (pwd) command.

When you move between PowerShell drives, PowerShell retains your location in each drive. You can use
this cmdlet to find your location in each drive.

You can use this cmdlet to get the current directory at run time and use it in functions and
scripts, such as in a function that displays the current directory in the PowerShell prompt.

You can also use this cmdlet to display the locations in a location stack. For more information, see
the Notes and the descriptions of the **Stack** and **StackName** parameters.

## EXAMPLES

### Example 1: Display your current drive location

This command displays your location in the current PowerShell drive.

```powershell
PS C:\Windows> Get-Location
```

```Output
Path
----
C:\Windows
```

For instance, if you are in the `Windows` directory of the `C:` drive, it displays the path to that
directory.

### Example 2: Display your current location for different drives

This example demonstrates the use of `Get-Location` to display your current location in different
PowerShell drives. `Set-Location` is used to change the location to several different paths on
different PSDrives.

```powershell
PS C:\> Set-Location C:\Windows
PS C:\Windows> Set-Location HKLM:\Software\Microsoft
PS HKLM:\Software\Microsoft> Set-Location "HKCU:\Control Panel\Input Method"
PS HKCU:\Control Panel\Input Method> Get-Location -PSDrive C

Path
----
C:\Windows

PS HKCU:\Control Panel\Input Method> Get-Location -PSDrive HKLM

Path
----
HKLM:\Software\Microsoft

PS HKCU:\Control Panel\Input Method> Set-Location C:
PS C:\Windows> Get-Location -PSProvider Registry

Path
----
HKCU:\Control Panel\Input Method
```

### Example 3: Get locations using stacks

This example shows how to use the **Stack** and **StackName** parameters of `Get-Location` to list
the locations in the current location stack and alternate location stacks.

The `Push-Location` cmdlet is used to change into three different locations. The third push uses a
different stack name. The **Stack** parameter of `Get-Location` displays the contents of the default
stack. The **StackName** parameter of `Get-Location` displays the contents of the stack named
`Stack2`.

```powershell
PS C:\> Push-Location C:\Windows
PS C:\Windows>Push-Location System32
PS C:\Windows\System32>Push-Location WindowsPowerShell -StackName Stack2
C:\Windows\System32\WindowsPowerShell>Get-Location -Stack

Path
----
C:\Windows
C:\

C:\Windows\System32\WindowsPowerShell>Get-Location -StackName Stack2

Path
----
C:\Windows\System32
```

### Example 4: Customize the PowerShell prompt

This example shows how to customize the PowerShell prompt.

```powershell
PS C:\>
function prompt { 'PowerShell: ' + (Get-Location) + '> '}
PowerShell: C:\>
```

The function that defines the prompt includes a `Get-Location` command, which is run whenever the
prompt appears in the console.

The format of the default PowerShell prompt is defined by a special function named `prompt`. You can
change the prompt in your console by creating a new function named `prompt`.

To see the current prompt function, type the following command: `Get-Content Function:\prompt`

## PARAMETERS

### -PSDrive

Gets the current location in the specified PowerShell drive.

For instance, if you are in the `Cert:` drive, you can use this parameter to find your
current location in the `C:` drive.

```yaml
Type: System.String[]
Parameter Sets: Location
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PSProvider

Gets the current location in the drive supported by the specified PowerShell provider.
If the specified provider supports more than one drive, this cmdlet returns the location on the most
recently accessed drive.

For example, if you are in the `C:` drive, you can use this parameter to find your current location
in the drives of the PowerShell **Registry** provider.

```yaml
Type: System.String[]
Parameter Sets: Location
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Stack

Indicates that this cmdlet displays the locations added to the current location stack. You can add
locations to stacks by using the `Push-Location` cmdlet.

To display the locations in a different location stack, use the **StackName** parameter. For
information about location stacks, see the [Notes](#notes).

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Stack
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StackName

Specifies, as a string array, the named location stacks. Enter one or more location stack names.

To display the locations in the current location stack, use the **Stack** parameter. To make a
location stack the current location stack, use the `Set-Location` cmdlet.

This cmdlet cannot display the locations in the unnamed default stack unless it is the current
stack.

```yaml
Type: System.String[]
Parameter Sets: Stack
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe input to this cmdlet.

## OUTPUTS

### System.Management.Automation.PathInfo or System.Management.Automation.PathInfoStack

If you use the **Stack** or **StackName** parameters, this cmdlet returns a **PathInfoStack**
object. Otherwise, it returns a **PathInfo** object.

## NOTES

PowerShell supports multiple runspaces per process. Each runspace has its own _current directory_.
This is not the same as `[System.Environment]::CurrentDirectory`. This behavior can be an issue
when calling .NET APIs or running native applications without providing explicit directory paths.
The `Get-Location` cmdlet returns the current directory of the current PowerShell runspace.

This cmdlet is designed to work with the data exposed by any provider. To list the providers in your
session, type `Get-PSProvider`. For more information, see
[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

The ways that the **PSProvider**, **PSDrive**, **Stack**, and **StackName** parameters interact
depends on the provider. Some combinations will result in errors, such as specifying both a drive
and a provider that does not expose that drive. If no parameters are specified, this cmdlet returns
the **PathInfo** object for the provider that contains the current working location.

A stack is a last-in, first-out list in which only the most recently added item is accessible. You
add items to a stack in the order that you use them, and then retrieve them for use in the reverse
order. PowerShell lets you store provider locations in location stacks. PowerShell creates an
unnamed default location stack and you can create multiple named location stacks. If you do not
specify a stack name, PowerShell uses the current location stack. By default, the unnamed default
location is the current location stack, but you can use the `Set-Location` cmdlet to change the
current location stack.

To manage location stacks, use the PowerShell `*-Location` cmdlets, as follows.

- To add a location to a location stack, use the `Push-Location` cmdlet.

- To get a location from a location stack, use the `Pop-Location` cmdlet.

- To display the locations in the current location stack, use the **Stack** parameter of the
  `Get-Location` cmdlet. To display the locations in a named location stack, use the **StackName**
  parameter of the `Get-Location` cmdlet.

- To create a new location stack, use the **StackName** parameter of the `Push-Location` cmdlet.
  If you specify a stack that does not exist, `Push-Location` creates the stack.

- To make a location stack the current location stack, use the **StackName** parameter of the
  `Set-Location` cmdlet.

The unnamed default location stack is fully accessible only when it is the current location stack.
If you make a named location stack the current location stack, you can no longer use the
`Push-Location` or `Pop-Location` cmdlets to add or get items from the default stack or use this
cmdlet to display the locations in the unnamed stack. To make the unnamed stack the current stack,
use the **StackName** parameter of the `Set-Location` cmdlet with a value of `$null` or an empty
string (`""`).

## RELATED LINKS

[Pop-Location](Pop-Location.md)

[Push-Location](Push-Location.md)

[Set-Location](Set-Location.md)


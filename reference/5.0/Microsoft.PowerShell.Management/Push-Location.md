---
ms.date:  01/22/2019
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821612
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Push-Location
---
# Push-Location

## SYNOPSIS
Adds the current location to the top of a location stack.

## SYNTAX

### Path (Default)

```
Push-Location [[-Path] <String>] [-PassThru] [-StackName <String>] [-UseTransaction] [<CommonParameters>]
```

### LiteralPath

```
Push-Location [-LiteralPath <String>] [-PassThru] [-StackName <String>] [-UseTransaction] [<CommonParameters>]
```

## DESCRIPTION

The `Push-Location` cmdlet adds ("pushes") the current location onto a location stack. If you
specify a path, `Push-Location` pushes the current location onto a location stack and then changes
the current location to the location specified by the path. You can use the `Pop-Location` cmdlet
to get locations from the location stack.

By default, the `Push-Location` cmdlet pushes the current location onto the current location stack,
but you can use the StackName parameter to specify an alternate location stack. If the stack does
not exist, `Push-Location` creates it.

For more information about location stacks, see the Notes.

## EXAMPLES

### Example 1

This example pushes the current location onto the default location stack and then changes the location to `C:\Windows`.

```
PS C:\> Push-Location C:\Windows
```

### Example 2

This example pushes the current location onto the RegFunction stack and changes the current location to the `HKLM:\Software\Policies` location.

```
PS C:\> Push-Location HKLM:\Software\Policies -StackName RegFunction
```

You can use the Location cmdlets in any PowerShell drive (PSDrive).

### Example 3

This command pushes the current location onto the default stack.
It does not change the location.

```
PS C:\> Push-Location
```

### Example 4 - Create and use a named stack

These commands show how to create and use a named location stack.

```
PS C:\> Push-Location ~ -StackName Stack2
PS C:\Users\User01> Pop-Location -StackName Stack2
PS C:\>
```

The first command pushes the current location onto a new stack named Stack2, and then changes the
current location to the home directory, which is represented in the command by the tilde symbol (~)
(same as `$env:USERPROFILE` or `$HOME`).

If Stack2 does not already exist in the session, `Push-Location` creates it. The second command
uses the `Pop-Location` cmdlet to pop the original location (PS C:\\\>) from the Stack2 stack.
Without the StackName parameter, `Pop-Location` would pop the location from the unnamed default
stack.

For more information about location stacks, see the [Notes](#notes).

## PARAMETERS

### -LiteralPath

Specifies the path to the new location. Unlike the **Path** parameter, the value of the
**LiteralPath** parameter is used exactly as it is typed. No characters are interpreted as
wildcards. If the path includes escape characters, enclose it in single quotation marks. Single
quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String
Parameter Sets: LiteralPath
Aliases: PSPath

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PassThru

Passes an object representing the location to the pipeline. By default, this cmdlet does not
generate any output.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Changes your location to the location specified by this path after it adds (pushes) the current
location onto the top of the stack. Enter a path to any location whose provider supports this
cmdlet. Wildcards are permitted. The parameter name is optional.

```yaml
Type: String
Parameter Sets: Path
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -StackName

Specifies the location stack to which the current location is added. Enter a location stack name.
If the stack does not exist, `Push-Location` creates it.

Without this parameter, `Push-Location` adds the location to the current location stack. By
default, the current location stack is the unnamed default location stack that PowerShell creates.
To make a location stack the current location stack, use the StackName parameter of the
`Set-Location` cmdlet. For more information about location stacks, see the [Notes](#notes).

> [!NOTE]
> `Push-Location` cannot add a location to the unnamed default stack unless it is the current
> location stack.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Default stack
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UseTransaction

Includes the command in the active transaction. This parameter is valid only when a transaction is
in progress. For more information, see [about_Transactions](../Microsoft.PowerShell.Core/About/about_transactions.md).

```yaml
Type: SwitchParameter
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
[about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a string that contains a path (but not a literal path) to `Push-Location`.

## OUTPUTS

### None or System.Management.Automation.PathInfo

When you use the PassThru parameter, `Push-Location` generates a
**System.Management.Automation.PathInfo** object that represents the location. Otherwise, this
cmdlet does not generate any output.

## NOTES

A "stack" is a last-in, first-out list in which only the most recently added item is accessible.
You add items to a stack in the order that you use them, and then retrieve them for use in the
reverse order. PowerShell lets you store provider locations in location stacks.

PowerShell creates an unnamed default location stack and you can create multiple named location
stacks. If you do not specify a stack name, Windows PowerShell uses the current location stack. By
default, the unnamed default location is the current location stack, but you can use the
`Set-Location` cmdlet to change the current location stack.

To manage location stacks, use the PowerShell Location cmdlets, as follows.

- To add a location to a location stack, use the `Push-Location` cmdlet.
- To get a location from a location stack, use the `Pop-Location` cmdlet.
- To display the locations in the current location stack, use the **Stack** parameter of the
  `Get-Location` cmdlet.

To display the locations in a named location stack, use the **StackName** parameter of the
`Get-Location` cmdlet.

- To create a new location stack, use the StackName parameter of the `Push-Location` cmdlet. If you
  specify a stack that does not exist, `Push-Location` creates the stack.
- To make a location stack the current location stack, use the StackName parameter of the
  `Set-Location` cmdlet.

The unnamed default location stack is fully accessible only when it is the current location stack.
If you make a named location stack the current location stack, you can no longer use
`Push-Location` or `Pop-Location` cmdlets add or get items from the default stack or use
`Get-Location` command to display the locations in the unnamed stack. To make the unnamed stack the
current stack, use the StackName parameter of the `Set-Location` cmdlet with a value of $null or an
empty string ("").

You can also refer to `Push-Location` by its built-in alias, `pushd`. For more information, see
[about_Aliases](../Microsoft.PowerShell.Core/About/about_Aliases.md).

The `Push-Location` cmdlet is designed to work with the data exposed by any provider. To list the
providers available in your session, type `Get-PSProvider`. For more information, see
[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

## RELATED LINKS

[Get-Location](Get-Location.md)

[Pop-Location](Pop-Location.md)

[Set-Location](Set-Location.md)

[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)
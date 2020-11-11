---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 02/04/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/pop-location?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Pop-Location
---
# Pop-Location

## SYNOPSIS
Changes the current location to the location most recently pushed onto the stack.

## SYNTAX

```
Pop-Location [-PassThru] [-StackName <String>] [<CommonParameters>]
```

## DESCRIPTION

The `Pop-Location` cmdlet changes the current location to the location most recently pushed onto the
stack by using the `Push-Location` cmdlet. You can pop a location from the default stack or from a
stack that you create by using a `Push-Location` command.

## EXAMPLES

### Example 1: Change to most recent location

```
PS C:\> Pop-Location
```

This command changes your location to the location most recently added to the current stack.

### Example 2: Change to most recent location in a named stack

```
PS C:\> Pop-Location -StackName "Stack2"
```

This command changes your location to the location most recently added to the Stack2 location stack.

For more information about location stacks, see the [Notes](#notes).

### Example 3: Move between locations for different providers

```
PS C:\> pushd HKLM:\Software\Microsoft\PowerShell
PS HKLM:\Software\Microsoft\PowerShell> pushd Cert:\LocalMachine\TrustedPublisher
PS cert:\LocalMachine\TrustedPublisher> popd
PS HKLM:\Software\Microsoft\PowerShell> popd
PS C:\>
```

These commands use the `Push-Location` and `Pop-Location` cmdlets to move between locations
supported by different PowerShell providers. The commands use the `pushd` alias for `Push-Location`
and the `popd` alias for `Pop-Location`.

The first command pushes the current file system location onto the stack and moves to the HKLM drive
supported by the PowerShell Registry provider.

The second command pushes the registry location onto the stack and moves to a location supported by
the PowerShell certificate provider.

The last two commands pop those locations off the stack. The first `popd` command returns to the
Registry drive, and the second command returns to the file system drive.

## PARAMETERS

### -PassThru

Passes an object that represents the location to the pipeline. By default, this cmdlet does not
generate any output.

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

### -StackName

Specifies the location stack from which the location is popped. Enter a location stack name.

Without this parameter, `Pop-Location` pops a location from the current location stack. By
default, the current location stack is the unnamed default location stack that PowerShell
creates. To make a location stack the current location stack, use the **StackName** parameter
of the `Set-Location` cmdlet. For more information about location stacks, see the [Notes](#notes).

`Pop-Location` cannot pop a location from the unnamed default stack unless it is the current
location stack.

```yaml
Type: System.String
Parameter Sets: (All)
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

### None, System.Management.Automation.PathInfo

This cmdlet generates a **System.Management.Automation.PathInfo** object that represents the
location, if you specify the **PassThru** parameter. Otherwise, this cmdlet does not generate any
output.

## NOTES

PowerShell supports multiple runspaces per process. Each runspace has its own _current directory_.
This is not the same as `[System.Environment]::CurrentDirectory`. This behavior can be an issue
when calling .NET APIs or running native applications without providing explicit directory paths.

Even if the location cmdlets did set the process-wide current directory, you can't depend on it
because another runspace might change it at any time. You should use the location cmdlets to perform
path-based operations using the current working directory specific to the current runspace.

A stack is a last-in, first-out list in which only the most recently added item can be accessed. You
add items to a stack in the order that you use them, and then retrieve them for use in the reverse
order. PowerShell lets you store provider locations in location stacks.

PowerShell creates an unnamed default location stack and you can create multiple named location
stacks. If you do not specify a stack name, PowerShell uses the current location stack. By
default, the unnamed default location is the current location stack, but you can use the
`Set-Location` cmdlet to change the current location stack.

To manage location stacks, use the PowerShell `*-Location` cmdlets, as follows:

- To add a location to a location stack, use the `Push-Location` cmdlet.

- To get a location from a location stack, use the `Pop-Location` cmdlet.

- To display the locations in the current location stack, use the **Stack** parameter of the
  `Get-Location` cmdlet.

- To display the locations in a named location stack, use the **StackName** parameter of the
  `Get-Location` cmdlet.

- To create a new location stack, use the **StackName** parameter of the `Push-Location` cmdlet. If
  you specify a stack that does not exist, `Push-Location` creates the stack.

- To make a location stack the current location stack, use the **StackName** parameter of the
  `Set-Location` cmdlet.

The unnamed default location stack is fully accessible only when it is the current location stack.
If you make a named location stack the current location stack, you can no longer use the
`Push-Location` or `Pop-Location` cmdlets to add or get items from the default stack or use the
`Get-Location` cmdlet to display the locations in the unnamed stack. To make the unnamed stack
the current stack, use the **StackName** parameter of the `Set-Location` cmdlet with a value of
`$Null` or an empty string (`""`).

You can also refer to `Pop-Location` by its built-in alias, `popd`. For more information, see
[about_Aliases](../Microsoft.PowerShell.Core/About/about_Aliases.md).

`Pop-Location` is designed to work with the data exposed by any provider. To list the
providers available in your session, type `Get-PSProvider`. For more information, see
[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

## RELATED LINKS

[Get-Location](Get-Location.md)

[Push-Location](Push-Location.md)

[Set-Location](Set-Location.md)

[about_Aliases](../Microsoft.PowerShell.Core/About/about_Aliases.md)

[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)

---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 06/01/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/set-clipboard?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Set-Clipboard
---

# Set-Clipboard

## SYNOPSIS
Sets the contents of the clipboard.

## SYNTAX

```
Set-Clipboard [-Value] <string[]> [-Append] [-PassThru] [-AsOSC52] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-Clipboard` cmdlet sets the contents of the clipboard.

> [!NOTE]
> On Linux, this cmdlet requires the `xclip` utility to be in the path.

## EXAMPLES

### Example 1: Copy text to the clipboard

```powershell
Set-Clipboard -Value "This is a test string"
```

### Example 2: Copy the contents of a file to the clipboard

This example pipes the contents of a file to the clipboard. In this example, we are getting a public
ssh key so that it can be pasted into another application, like GitHub.

```powershell
Get-Content C:\Users\user1\.ssh\id_ed25519.pub | Set-Clipboard
```

### Example 3: Copy text to the clipboard of the local host over an SSH remote session

The **AsOSC52** parameter allows you to set the clipboard of the local machine when connected to a
remote session over SSH.

```powershell
Set-Clipboard -Value "This is a test string" -AsOSC52
```

### Example 4: Set the default value of the **AsOSC52** parameter

You can detect if you are connected to a remote session over SSH by checking the value of the
`$env:SSH_CLIENT` or `$env:SSH_TTY` environment variables. If either of these variables are set,
then you are connected to a remote session over SSH. You can use this information to set the default
value of the **AsOSC52** parameter. Add one of the following lines to your PowerShell profile
script.

```powershell
$PSDefaultParameterValues['Set-Clipboard:AsOSC52'] = $env:SSH_CLIENT
$PSDefaultParameterValues['Set-Clipboard:AsOSC52'] = $env:SSH_TTY
```

For more information about `$PSDefaultParameterValues`, see
[about_Parameters_Default_Values](/powershell/module/microsoft.powershell.core/about/about_parameters_default_values).

## PARAMETERS

### -Append

Indicates that the cmdlet does not clear the clipboard and appends content to it.

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

### -AsOSC52

When connected to a remote session over SSH, `Set-Clipboard` sets the clipboard of the remote
machine, not the local host. When you use this parameter, `Set-Clipboard` the OSC52 ANSI escape
sequence to set the clipboard of the local machine.

For this feature to work, your terminal application must support the OSC52 ANSI escape sequence. The
[Windows Terminal](/windows/terminal/) supports this feature.

This parameter was added in PowerShell 7.4.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: ToLocalhost

Required: False
Position: Named
Default value: None
Accept pipeline input: ByValue (False), ByName (False)
Accept wildcard characters: False
```

### -PassThru

Returns an object representing the item with which you're working. By default, this cmdlet does not
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

### -Value

The string values to be added to the clipboard.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

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

You can pipe a string containing the content to set to the clipboard to this cmdlet.

## OUTPUTS

### None

This cmdlet returns no output.

## NOTES

PowerShell includes the following aliases for `Set-Clipboard`:

- All platforms:
  - `scb`

In rare cases when using `Set-Clipboard` with a high number of values in rapid succession, like in a
loop, you might sporadically get a blank value from the clipboard. This can be fixed by adding a
`Start-Sleep -Milliseconds 1` command to the loop.

## RELATED LINKS

[Get-Clipboard](Get-Clipboard.md)

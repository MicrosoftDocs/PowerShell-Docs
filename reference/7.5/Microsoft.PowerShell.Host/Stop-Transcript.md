---
external help file: Microsoft.PowerShell.ConsoleHost.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Host
ms.date: 01/04/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.host/stop-transcript?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Stop-Transcript
---

# Stop-Transcript

## SYNOPSIS
Stops a transcript.

## SYNTAX

```
Stop-Transcript [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Stop-Transcript` cmdlet stops a transcript that was started by the `Start-Transcript` cmdlet.
Alternatively, you can end a session to stop a transcript.

## EXAMPLES

### Example 1: Stop all transcripts

```powershell
Stop-Transcript
```

This command stops all transcripts.

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the cmdlet.

This parameter was added in PowerShell 7.4.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet isn't run.

This parameter was added in PowerShell 7.4.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

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

### None

You can't pipe objects to this cmdlet.

## OUTPUTS

### System.String

This cmdlet returns a string that contains a status message and the path to the output file.

## NOTES

If a transcript hasn't been started, the command fails.

## RELATED LINKS

[Start-Transcript](Start-Transcript.md)

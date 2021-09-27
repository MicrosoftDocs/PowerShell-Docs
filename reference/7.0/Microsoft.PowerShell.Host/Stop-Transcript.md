---
external help file: Microsoft.PowerShell.ConsoleHost.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Host
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.host/stop-transcript?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Stop-Transcript
---
# Stop-Transcript

## Synopsis
Stops a transcript.

## Syntax

```
Stop-Transcript [<CommonParameters>]
```

## Description

The `Stop-Transcript` cmdlet stops a transcript that was started by the `Start-Transcript` cmdlet.
Alternatively, you can end a session to stop a transcript.

## Examples

### Example 1: Stop all transcripts

```powershell
Stop-Transcript
```

This command stops all transcripts.

## Parameters

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### None

You cannot pipe input to this cmdlet.

## Outputs

### System.String

This cmdlet returns a string that contains a status message and the path to the output file.

## Notes

* If a transcript has not been started, the command fails.

*

## Related links

[Start-Transcript](Start-Transcript.md)

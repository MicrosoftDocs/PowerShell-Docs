---
external help file: Microsoft.PowerShell.ConsoleHost.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.host/stop-transcript?view=powershell-4.0&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Stop-Transcript
---

# Stop-Transcript

## SYNOPSIS
Stops a transcript.

## SYNTAX

```powershell
Stop-Transcript [<CommonParameters>]
```

## DESCRIPTION
The `Stop-Transcript` cmdlet stops a transcript that was started by using the `Start-Transcript` cmdlet.
You can also stop a transcript by ending the session.

## EXAMPLES

### Example 1
```powershell
Stop-Transcript
```

This command stops any running transcripts.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### System.String
`Stop-Transcript` returns a string that contains a status message and the path to the output file.

## NOTES
* If a transcript has not been started, the command fails.

*

## RELATED LINKS

[Start-Transcript](Start-Transcript.md)



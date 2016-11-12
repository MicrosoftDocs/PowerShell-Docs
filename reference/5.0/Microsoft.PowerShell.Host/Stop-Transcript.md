---
author: jpjofre
description: 
external help file: Microsoft.PowerShell.ConsoleHost.dll-Help.xml
keywords: powershell, cmdlet
manager: carolz
ms.date: 2016-09-30
ms.prod: powershell
ms.technology: powershell
ms.topic: reference
online version: http://go.microsoft.com/fwlink/?LinkId=821533
schema: 2.0.0
title: Stop-Transcript
---

# Stop-Transcript

## SYNOPSIS
Stops a transcript.

## SYNTAX

```
Stop-Transcript [<CommonParameters>]
```

## DESCRIPTION
The **Stop-Transcript** cmdlet stops a transcript that was started by the Start-Transcript cmdlet.
Alternatively, you can end a session to stop a transcript.

## EXAMPLES

### Example 1: Stop all transcripts
```
PS C:\>Stop-Transcript
```

This command stops all transcripts.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### System.String
This cmdlet returns a string that contains a status message and the path to the output file.

## NOTES
* If a transcript has not been started, the command fails.

*

## RELATED LINKS

[Start-Transcript](Start-Transcript.md)


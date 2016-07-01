---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Stop Transcript
ms.technology:  powershell
external help file:  PSITPro4_Host.xml
online version:  http://go.microsoft.com/fwlink/p/?linkid=289794
schema:  2.0.0
---


# Stop-Transcript
## SYNOPSIS
Stops a transcript.
## SYNTAX

```
Stop-Transcript [<CommonParameters>]
```

## DESCRIPTION
The Stop-Transcript cmdlet stops a transcript that was started by using the Start-Transcript cmdlet.
You can also stop a transcript by ending the session.
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>stop-transcript
```

This command stops any running transcripts.
## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

### None
You cannot pipe input to this cmdlet.
## OUTPUTS

### System.String
Stop-Transcript returns a string that contains a status message and the path to the output file.
## NOTES
* If a transcript has not been started, the command fails.

*
## RELATED LINKS

[Start-Transcript](Start-Transcript.md)


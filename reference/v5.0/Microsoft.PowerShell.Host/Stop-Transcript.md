---
external help file: PSITPro5_Host.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=289794
schema: 2.0.0
---

# Stop-Transcript
## SYNOPSIS
Stops a transcript.

## SYNTAX

```
Stop-Transcript
```

## DESCRIPTION
The Stop-Transcript cmdlet stops a transcript that was started by the Start-Transcript cmdlet.
Alternatively, you can end a session to stop a transcript.

## EXAMPLES

### Example 1: Stop all transcripts
```
PS C:\>Stop-Transcript
```

This command stops all transcripts.

## PARAMETERS

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

[Start-Transcript](05b8f72c-ae3b-45d5-95e0-86aa1ca1908a)


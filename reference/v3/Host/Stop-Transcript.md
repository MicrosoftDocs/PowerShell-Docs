---
external help file: PSITPro3_Host.xml
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
The Stop-Transcript cmdlet stops a transcript that was started by using the Start-Transcript cmdlet.
You can also stop a transcript by ending the session.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>stop-transcript
```

This command stops any running transcripts.

## PARAMETERS

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### System.String
Stop-Transcript returns a string that contains a status message and the path to the output file.

## NOTES
If a transcript has not been started, the command fails.

## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=113415)

[Start-Transcript](05b8f72c-ae3b-45d5-95e0-86aa1ca1908a)



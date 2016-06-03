---
external help file: PSITPro3_Utility.xml
schema: 2.0.0
---

# Get-TraceSource
## SYNOPSIS
Gets the Windows PowerShell components that are instrumented for tracing.

## SYNTAX

```
Get-TraceSource [[-Name] <String[]>]
```

## DESCRIPTION
The Get-TraceSource cmdlet gets the trace sources for Windows PowerShell components that are currently in use.
You can use the data to determine which Windows PowerShell components you can trace.
When tracing, the component generates detailed messages about each step in its internal processing.
Developers use the trace data to monitor data flow, program execution, and errors.
The tracing cmdlets were designed for Windows PowerShell developers, but they are available to all users.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-traceSource  *provider*
```

This command gets all of the trace sources that have names that include "provider".

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>get-tracesource
```

This command gets all of the Windows PowerShell components that can be traced.

## PARAMETERS

### -Name
Gets only the specified trace sources.
Wildcards are permitted.
The parameter name \("Name"\) is optional.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: 
Accept pipeline input: true (ByValue, ByPropertyName)
Accept wildcard characters: True
```

## INPUTS

### System.String
You can pipe a string that contains the name of a trace source to Get-TraceSource.

## OUTPUTS

### System.Management.Automation.PSTraceSource
Get-TraceSource returns objects that represent the trace sources.

## NOTES

## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=113333)

[Set-TraceSource](442780bb-7332-4995-b583-6e07889d1e26)

[Trace-Command](db7c9374-998e-44c3-ad94-e0445176cf7b)



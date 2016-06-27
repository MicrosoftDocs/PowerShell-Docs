---
external help file: System.Management.Automation.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=289602
schema: 2.0.0
---

# Out-Null
## SYNOPSIS
Deletes output instead of sending it down the pipeline.

## SYNTAX

```
Out-Null [-InputObject <PSObject>]
```

## DESCRIPTION
The Out-Null cmdlet sends output to NULL, in effect, deleting it.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>Get-ChildItem | Out-Null
```

This command gets the items in the local directory, but then it deletes them instead of passing them through the pipeline or displaying them at the command line.
This is useful for deleting output that you do not need.

## PARAMETERS

### -InputObject
Specifies the object that was sent to null (deleted).
Enter a variable that contains the objects, or type a command or expression that gets the objects.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

## INPUTS

### System.Management.Automation.PSObject
You can pipe any object to Out-Null.

## OUTPUTS

### None
Out-Null does not generate any output.

## NOTES
The cmdlets that contain the Out verb (the Out cmdlets) do not have parameters for names or file paths.
To send data to an Out cmdlet, use a pipeline operator (|) to send the output of a Windows PowerShell command to the cmdlet.
You can also store data in a variable and use the InputObject parameter to pass the data to the cmdlet.
For more information, see the examples.

Out-Null does not return any output objects.
If you pipe the output of Out-Null to the Get-Member cmdlet, Get-Member reports that no objects have been specified.

## RELATED LINKS

[Out-Default]()

[Out-File]()

[Out-Host]()

[Out-Printer]()

[Out-String]()


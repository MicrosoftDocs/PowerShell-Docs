---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=113366
external help file:  System.Management.Automation.dll-Help.xml
title:  Out-Null
---
# Out-Null

## SYNOPSIS

Hides the output instead of sending it down the pipeline or displaying it.

## SYNTAX

```
Out-Null [-InputObject <PSObject>] [<CommonParameters>]
```

## DESCRIPTION

The **Out-Null** cmdlet sends its output to NULL, in effect, removing it from the pipeline and
preventing the output to be displayed at the screen.

## EXAMPLES

### Example 1

```
PS> Get-ChildItem | Out-Null
```

This command gets items in the current location/directory, but its output is not passed through
the pipeline nor displayed at the command line.
This is useful for hiding output that you do not need.

## PARAMETERS

### -InputObject

Specifies the object to be sent to NULL (removed from pipeline).
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](./About/about_CommonParameters.md).

## INPUTS

### System.Management.Automation.PSObject

You can pipe any object to **Out-Null**.

## OUTPUTS

### None

**Out-Null** does not generate any output.

## NOTES

- The cmdlets that contain the Out verb (the Out cmdlets) do not have parameters for names or file paths. To send data to an Out cmdlet, use a pipeline operator (|) to send the output of a Windows PowerShell command to the cmdlet. You can also store data in a variable and use the InputObject parameter to pass the data to the cmdlet. For more information, see the examples.

- 

  **Out-Null** does not return any output objects.
If you pipe the output of **Out-Null** to the Get-Member cmdlet, **Get-Member** reports that no objects have been specified.

## RELATED LINKS

[Out-Default](Out-Default.md)

[Out-File](../Microsoft.PowerShell.Utility/Out-File.md)

[Out-Host](Out-Host.md)

[Out-Printer](../Microsoft.PowerShell.Utility/Out-Printer.md)

[Out-String](../Microsoft.PowerShell.Utility/Out-String.md)
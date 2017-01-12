---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Convert String
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/?LinkId=821756
external help file:   Microsoft.PowerShell.Commands.Utility.dll-Help.xml
---


# Convert-String

## SYNOPSIS
Formats a string to match examples.

## SYNTAX

```
Convert-String [-Example <System.Collections.Generic.List`1[System.Management.Automation.PSObject]>]
 -InputObject <String> [<CommonParameters>]
```

## DESCRIPTION
The **Convert-String** cmdlet formats a string to match the format of examples.

## EXAMPLES

### Example 1: Convert format of a string
```
PS C:\> $Names = "Evan Narvaez","David Chew","Elisa Daugherty"
Convert-String -InputObject $Names -Example "Patti Fuller = Fuller, P."
Narvaez, E. 
Chew, D. 
Daugherty, E.
```

The first command creates an array named **$Names** that contains first and last names.

The second command formats the names in **$Names** according to the example.
It puts the surname first in the output, followed by an initial.

### Example 2: Format process information
```
PS C:\> $Processes = Get-Process -Name "svchost" | Select-Object -Property processname, id | ConvertTo-Csv -NoTypeInformation
PS C:\> $Processes | Convert-String -Example '"svchost", "219"=219, s.'
716, s. 
892, s. 
908, s. 
1004, s.
...
```

The first command gets processes named svchost by using the Get-Process cmdlet.
The command passes them to the Select-Object cmdlet, which selects the process name and process ID.
The command converts the output to comma separated values without type information by using the ConvertTo-Csv cmdlet.
The command stores the results in the **$Processes** variable.
**$Processes** now contains SVCHOST and PID.

The second command specifies an example that changes the order of the items and abbreviates svchost.
The command coverts each string in **$Processes**.

## PARAMETERS

### -Example
Specifies a list of examples of the target format.
Specify pairs separated by the equal (=) sign, with the source pattern on the left and the target pattern on the right, as in the following example: 

`Patti Fuller = Fuller, P.`

Alternatively, specify a list of hash tables that contain **Before** and **After** properties.

```yaml
Type: System.Collections.Generic.List`1[System.Management.Automation.PSObject]
Parameter Sets: (All)
Aliases: E

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies a string to format.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### String
You can pipe strings to this cmdlet.

## OUTPUTS

### String
This cmdlet returns a string.

## NOTES

## RELATED LINKS

[ConvertFrom-String](ConvertFrom-String.md)

[ConvertTo-Csv](ConvertTo-Csv.md)

[Out-String](Out-String.md)

[Select-Object](Select-Object.md)


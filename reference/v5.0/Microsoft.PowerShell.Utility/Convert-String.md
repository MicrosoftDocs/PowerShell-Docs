---
external help file: PSITPro5_Utility.xml
online version: cd730eb5-baf5-4624-a255-97652e67c821
schema: 2.0.0
---

# Convert-String
## SYNOPSIS
Formats a string to match examples.

## SYNTAX

```
Convert-String [-Example <List`1>] -InputObject <String>
```

## DESCRIPTION
The Convert-String cmdlet formats a string to match the format of examples.

## EXAMPLES

### Example 1: Convert format of a string
```
PS C:\>$Names = "Evan Narvaez","David Chew","Elisa Daugherty"
Convert-String -InputObject $Names -Example "Patti Fuller = Fuller, P."
Narvaez, E. 
Chew, D. 
Daugherty, E.
```

The first command creates an array named $Names that contains first and last names.

The second command formats the names in $Names according to the example.
It puts the surname first in the output, followed by an initial.

### Example 2: Format process information
```
PS C:\>$Processes = Get-Process -Name "svchost" | Select-Object -Property processname, id | ConvertTo-Csv -NoTypeInformation
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
The command stores the results in the $Processes variable.
$Processes now contains SVCHOST and PID.

The second command specifies an example that changes the order of the items and abbreviates svchost.
The command coverts each string in $Processes.

## PARAMETERS

### -Example
Specifies a list of examples of the target format.
Specify pairs separated by the equal (=) sign, with the source pattern on the left and the target pattern on the right, as in the following example: 

Patti Fuller = Fuller, P.

Alternatively, specify a list of hash tables that contain Before and After properties.

```yaml
Type: List`1
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
Accept pipeline input: True(ByValue)
Accept wildcard characters: False
```

## INPUTS

### String
You can pipe strings to this cmdlet.

## OUTPUTS

### String
This cmdlet returns a string.

## NOTES

## RELATED LINKS

[ConvertFrom-String](cd730eb5-baf5-4624-a255-97652e67c821)

[ConvertTo-Csv](02cf7085-f243-45ed-b803-da0466fd6085)

[Get-Process](b30db241-c0f6-40d3-ab3b-ab86342b36c1)

[Out-String](d4502a29-2351-4580-b456-fb75280fedb4)

[Select-Object](2f182056-7955-4b77-9c58-64ab4a680074)


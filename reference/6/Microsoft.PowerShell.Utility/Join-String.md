---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Module Name: Microsoft.PowerShell.Utility
online version:
schema: 2.0.0
ms.date:  02/01/2019
---

# Join-String

## SYNOPSIS
Combines objects from the pipeline into a single string.

## SYNTAX

### default (Default)

```
Join-String [[-Property] <PSPropertyExpression>] [[-Separator] <String>] [-OutputPrefix <String>]
 [-OutputSuffix <String>] [-InputObject <PSObject>] [<CommonParameters>]
```

### SingleQuote

```
Join-String [[-Property] <PSPropertyExpression>] [[-Separator] <String>] [-OutputPrefix <String>]
 [-OutputSuffix <String>] [-SingleQuote] [-InputObject <PSObject>] [<CommonParameters>]
```

### DoubleQuote

```
Join-String [[-Property] <PSPropertyExpression>] [[-Separator] <String>] [-OutputPrefix <String>]
 [-OutputSuffix <String>] [-DoubleQuote] [-InputObject <PSObject>] [<CommonParameters>]
```

### Format

```
Join-String [[-Property] <PSPropertyExpression>] [[-Separator] <String>] [-OutputPrefix <String>]
 [-OutputSuffix <String>] [-FormatString <String>] [-InputObject <PSObject>] [<CommonParameters>]
```

## DESCRIPTION

The `Join-String` cmdlet joins (compines) text from pipeline objects into a single string.

If no parameters are specified, the pipeline objects are converted to a string and joined with the
default separatator $OFS.

By specifying a property name, the value of the property is converted to a string and joined into a
string.

Instead of a property name, a script block can be used. In that case the result of the scriptblock
will be converted to a string before joining it to form the result. It can either combine the text
of a property of an object or the result of converting the object to a string.

## EXAMPLES

### Example 1

```powershell
PS> gci -Directory c:\ | join-string -Property Name -DoubleQuote -Separator ', '
```

```Output
"PerfLogs", "Program Files", "Program Files (x86)", "Users", "Windows"
```

This example joins the directory names of c:\, double qouted and separated by ', ' to a string.

### Example 2

```powershell
PS> gci -Directory c:\ | join-string -Property {$_.Name.SubString(0,4)} -SingleQuote -Separator ';'
```

```Output
'Perf';'Prog';'Prog';'User';'Wind'
```

This example joins the first four letters of the directory names of c:\, single qouted and separated by ';' to a string.


### Example 3

```powershell
PS> gsv se* | Join-String Name -Separator "`r`n`t" -OutputPrefix "`t"
```

```Output
    seclogon
    SecurityHealthService
    SEMgrSvc
    SENS
    Sense
    SensorDataService
    SensorService
    SensrSvc
    SessionEnv
```

This example joins the the names of services with names starting on 'se' with each service on a
separate line and indented by a tab.


### Example 4

```powershell
PS> ([pscustomobject] @{Name = "Joe"; Age = 42}).PSObject.Properties | join-string -Property Name -FormatString '  ${0}' -OutputPrefix "class {`n" -OutputSuffix "`n}`n" -Separator "`n"
```

```Output
class {
  $Name
  $Age
}
```

This example generates a PowerShell class definition from a custom PSOBject by joining the names of
the properties.

## PARAMETERS

### -DoubleQuote

Wrap the string value of each pipeline object in double-quotes.

```yaml
Type: SwitchParameter
Parameter Sets: DoubleQuote
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FormatString

A format string that specifies how each item should be formatted.

```yaml
Type: String
Parameter Sets: Format
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies the text to be joined. Enter a variable that contains the text, or type a command or
expression that gets the objects to join into strings.

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

### -OutputPrefix

Text that will be prepended to that output string.

```yaml
Type: String
Parameter Sets: (All)
Aliases: op

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutputSuffix

Text that will be appened to that output string.

```yaml
Type: String
Parameter Sets: (All)
Aliases: os

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Property

The name of a property (or a property expression) that will project the pipeline object to text.

```yaml
Type: PSPropertyExpression
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Separator

A text that will be inserted between the text for each pipeline object.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SingleQuote

Wrap the string value of each pipeline object in single-quotes.

```yaml
Type: SwitchParameter
Parameter Sets: SingleQuote
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

## OUTPUTS

### System.String

## NOTES

## RELATED LINKS

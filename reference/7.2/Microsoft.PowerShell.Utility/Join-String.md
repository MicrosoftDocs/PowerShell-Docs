---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Module Name: Microsoft.PowerShell.Utility
ms.date: 12/12/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/join-string?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Join-String
---

# Join-String

## SYNOPSIS
Combines objects from the pipeline into a single string.

## SYNTAX

### Default (Default)

```
Join-String [[-Property] <PSPropertyExpression>] [[-Separator] <String>] [-OutputPrefix <String>]
 [-OutputSuffix <String>] [-UseCulture] [-InputObject <PSObject[]>] [<CommonParameters>]
```

### SingleQuote

```
Join-String [[-Property] <PSPropertyExpression>] [[-Separator] <String>] [-OutputPrefix <String>]
 [-OutputSuffix <String>] [-SingleQuote] [-UseCulture] [-InputObject <PSObject[]>]
 [<CommonParameters>]
```

### DoubleQuote

```
Join-String [[-Property] <PSPropertyExpression>] [[-Separator] <String>] [-OutputPrefix <String>]
 [-OutputSuffix <String>] [-DoubleQuote] [-UseCulture] [-InputObject <PSObject[]>]
 [<CommonParameters>]
```

### Format

```
Join-String [[-Property] <PSPropertyExpression>] [[-Separator] <String>] [-OutputPrefix <String>]
 [-OutputSuffix <String>] [-FormatString <String>] [-UseCulture] [-InputObject <PSObject[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Join-String` cmdlet joins, or combines, text from pipeline objects into a single string.

If no parameters are specified, the pipeline objects are converted to a string and joined with the
default separator `$OFS`.

By specifying a property name, the property's value is converted to a string and joined into a
string.

Instead of a property name, a script block can be used. The script block's result is converted to a
string before it's joined to form the result. It can either combine the text of an object's property
or the result of the object that was converted to a string.

This cmdlet was introduced in PowerShell 6.2.

## EXAMPLES

### Example 1: Join directory names

<!-- markdownlint-disable MD038 -->
This example joins directory names, wraps the output in double-quotes, and separates the directory
names with a comma and space (`, `). The output is a string object.

```powershell
Get-ChildItem -Directory C:\ | Join-String -Property Name -DoubleQuote -Separator ', '
```

```Output
"PerfLogs", "Program Files", "Program Files (x86)", "Users", "Windows"
```

`Get-ChildItem` uses the **Directory** parameter to get all the directory names for the `C:\` drive.
The objects are sent down the pipeline to `Join-String`. The **Property** parameter specifies the
directory names. The **DoubleQuote** parameter wraps the directory names with double-quote marks.
The **Separator** parameter specifies to use a comma and space (`, `) to separate the directory
names.

The `Get-ChildItem` objects are **System.IO.DirectoryInfo** and `Join-String` converts the objects
to **System.String**.

### Example 2: Use a property substring to join directory names

This example uses a substring method to get the first four letters of directory names, wraps the
output in single-quotes, and separates the directory names with a semicolon (`;`).

```powershell
Get-ChildItem -Directory C:\ | Join-String -Property {$_.Name.SubString(0,4)} -SingleQuote -Separator ';'
```

```Output
'Perf';'Prog';'Prog';'User';'Wind'
```

`Get-ChildItem` uses the **Directory** parameter to get all the directory names for the `C:\` drive.
The objects are sent down the pipeline to `Join-String`.

The **Property** parameter script block uses automatic variable (`$_`) to specify each object's
**Name** property substring. The substring gets the first four letters of each directory name. The
substring specifies the character start and end positions. The **SingleQuote** parameter wraps the
directory names with single-quote marks. The **Separator** parameter specifies to use a semicolon
(`;`) to separate the directory names.

For more information about automatic variables and substrings, see
[about_Automatic_Variables](../microsoft.powershell.core/about/about_automatic_variables.md) and
[Substring](/dotnet/api/system.string.substring).

### Example 3: Display join output on a separate line

This example joins service names with each service on a separate line and indented by a tab.

```powershell
Get-Service -Name se* | Join-String -Property Name -Separator "`r`n`t" -OutputPrefix "Services:`n`t"
```

```Output
Services:
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

`Get-Service` uses the **Name** parameter with to specify services that begin with `se*`. The
asterisk (`*`) is a wildcard for any character.

The objects are sent down the pipeline to `Join-String` that uses the **Property** parameter to
specify the service names. The **Separator** parameter specifies three special characters that
represent a carriage return (`` `r ``), newline (`` `n ``), and tab (`` `t ``). The **OutputPrefix**
inserts a label **Services:** with a new line and tab before the first line of output.

For more information about special characters, see
[about_Special_Characters](..//microsoft.powershell.core/about/about_special_characters.md).

### Example 4: Create a class definition from an object

This example generates a PowerShell class definition using an existing object as a template.

This code sample uses splatting to reduce the line length and improve readability. For more
information, see [about_Splatting](../Microsoft.PowerShell.Core/About/about_Splatting.md).

```powershell
$obj = [pscustomobject] @{Name = "Joe"; Age = 42}
$parms = @{
  Property = "Name"
  FormatString = '  ${0}'
  OutputPrefix = "class {`n"
  OutputSuffix = "`n}`n"
  Separator = "`n"
}
$obj.PSObject.Properties | Join-String @parms
```

```Output
class {
  $Name
  $Age
}
```

## PARAMETERS

### -DoubleQuote

Wraps the string value of each pipeline object in double-quotes.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: DoubleQuote
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FormatString

A format string that specifies how each item should be formatted.

```yaml
Type: System.String
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
Type: System.Management.Automation.PSObject[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -OutputPrefix

Text that's inserted before the output string. The string can contain special characters such as
carriage return (`` `r ``), newline (`` `n ``), and tab (`` `t ``).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: op

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutputSuffix

Text that's appended to the output string. The string can contain special characters such as
carriage return (`` `r ``), newline (`` `n ``), and tab (`` `t ``).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: os

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Property

The name of a property, or a property expression, that will project the pipeline object to text.

```yaml
Type: Microsoft.PowerShell.Commands.PSPropertyExpression
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Separator

Text or characters such as a comma or semicolon that's inserted between the text for each pipeline
object.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SingleQuote

Wraps the string value of each pipeline object in single quotes.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: SingleQuote
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseCulture

Uses the list separator for the current culture as the item delimiter. To find the list separator
for a culture, use the following command: `(Get-Culture).TextInfo.ListSeparator`.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

## OUTPUTS

### System.String

## NOTES

## RELATED LINKS

[about_Automatic_Variables](../microsoft.powershell.core/about/about_automatic_variables.md)

[about_Special_Characters](..//microsoft.powershell.core/about/about_special_characters.md)

[Substring](/dotnet/api/system.string.substring)


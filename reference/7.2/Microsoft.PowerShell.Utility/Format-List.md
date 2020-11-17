---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 12/19/2018
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/format-list?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Format-List
---
# Format-List

## SYNOPSIS
Formats the output as a list of properties in which each property appears on a new line.

## SYNTAX

```
Format-List [[-Property] <Object[]>] [-GroupBy <Object>] [-View <string>] [-ShowError]
[-DisplayError] [-Force] [-Expand <string>] [-InputObject <psobject>] [<CommonParameters>]
```

## DESCRIPTION

The `Format-List` cmdlet formats the output of a command as a list of properties in which each
property is displayed on a separate line. You can use `Format-List` to format and display all or
selected properties of an object as a list (format-list *).

Because more space is available for each item in a list than in a table, PowerShell displays more
properties of the object in the list, and the property values are less likely to be truncated.

## EXAMPLES

### Example 1: Format computer services

```powershell
Get-Service | Format-List
```

This command formats information about services on the computer as a list. By default, the services
are formatted as a table. The `Get-Service` cmdlet gets objects representing the services on the
computer. The pipeline operator (|) passes the results through the pipeline to `Format-List`.
Then, the `Format-List` command formats the service information in a list and sends it to the
default output cmdlet for display.

### Example 2: Format PS1XML files

These commands display information about the PS1XML files in the PowerShell directory as a list.

```powershell
$A = Get-ChildItem $pshome\*.ps1xml
Format-List -InputObject $A
```

The first command gets the objects representing the files and stores them in the `$A` variable.

The second command uses `Format-List` to format information about objects stored in `$A`. This
command uses the **InputObject** parameter to pass the variable to `Format-List`, which then sends
the formatted output to the default output cmdlet for display.

### Example 3: Format process properties by name

This command displays the name, base priority, and priority class of each process on the computer.

```powershell
Get-Process | Format-List -Property name, basepriority, priorityclass
```

It uses the `Get-Process` cmdlet to get an object representing each process. The pipeline operator
(|) passes the process objects through the pipeline to `Format-List`. `Format-List` formats the
processes as a list of the specified properties. The *Property* parameter name is optional, so you
can omit it.

### Example 4: Format all properties for a process

This command displays all of the properties of the Winlogon process.

```powershell
Get-Process winlogon | Format-List -Property *
```

It uses the Get-Process cmdlet to get an object representing the Winlogon process. The pipeline
operator (|) passes the Winlogon process object through the pipeline to `Format-List`. The command
uses the *Property* parameter to specify the properties and the \* to indicate all properties.
Because the name of the *Property* parameter is optional, you can omit it and type the command as
`Format-List *`. `Format-List` automatically sends the results to the default output cmdlet for
display.

### Example 5: Troubleshooting format errors

The following examples show of the results of adding the **DisplayError** or **ShowError**
parameters with an expression.

```powershell
PC /> Get-Date | Format-List DayOfWeek,{ $_ / $null } -DisplayError

DayOfWeek    : Friday
 $_ / $null  : #ERR

PC /> Get-Date | Format-List DayOfWeek,{ $_ / $null } -ShowError

DayOfWeek    : Friday
 $_ / $null  :

Failed to evaluate expression " $_ / $null ".
+ CategoryInfo          : InvalidArgument: (12/21/2018 7:59:23 AM:PSObject) [], RuntimeException
+ FullyQualifiedErrorId : PSPropertyExpressionError
```

## PARAMETERS

### -DisplayError

Indicates that this cmdlet displays errors at the command line. This parameter is rarely used, but
can be used as a debugging aid when you are formatting expressions in a `Format-List` command, and
the expressions do not appear to be working.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Expand

Specifies the formatted collection object, as well as the objects in the collection. This parameter
is designed to format objects that support the ICollection (System.Collections) interface. The
default value is EnumOnly. The acceptable values for this parameter are:

- EnumOnly. Displays the properties of the objects in the collection.
- CoreOnly. Displays the properties of the collection object.
- Both. Displays the properties of the collection object and the properties of objects in the
  collection.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: CoreOnly, EnumOnly, Both

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Indicates that this cmdlet displays all of the error information. Use with the **DisplayError** or
**ShowError** parameter. By default, when an error object is written to the error or display
streams, only some of the error information is displayed.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupBy

Specifies the output in groups based on a shared property or value. Enter an expression or a
property of the output.

The value of the **GroupBy** parameter can be a new calculated property. The calculated property can
be a script block or a hash table. Valid key-value pairs are:

- Name (or Label) - `<string>`
- Expression - `<string>` or `<script block>`
- FormatString - `<string>`

For more information, see
[about_Calculated_Properties](../Microsoft.PowerShell.Core/About/about_Calculated_Properties.md).

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies the objects to be formatted. Enter a variable that contains the objects or type a command
or expression that gets the objects.

```yaml
Type: System.Management.Automation.PSObject
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Property

Specifies the object properties that appear in the display and the order in which they appear.
Wildcards are permitted.

If you omit this parameter, the properties that appear in the display depend on the object being
displayed. The parameter name "Property" is optional. You cannot use the **Property** and **View**
parameters in the same command.

The value of the **Property** parameter can be a new calculated property. The calculated property
can be a script block or a hash table. Valid key-value pairs are:

- Name (or Label) - `<string>`
- Expression - `<string>` or `<script block>`
- FormatString - `<string>`

For more information, see
[about_Calculated_Properties](../Microsoft.PowerShell.Core/About/about_Calculated_Properties.md).

```yaml
Type: System.Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -ShowError

Indicates that the cmdlet sends errors through the pipeline. This parameter is rarely used, but can
be used as a debugging aid when you are formatting expressions in a `Format-List` command, and the
expressions do not appear to be working.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -View

Specifies the name of an alternate list format or view. You cannot use the **Property** and
**View** parameters in the same command.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable,
-Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

You can pipe any object to `Format-List`.

## OUTPUTS

### Microsoft.PowerShell.Commands.Internal.Format

`Format-List` returns the format objects that represent the list.

## NOTES

You can also refer to Format-List by its built-in alias, FL. For more information, see
[about_Aliases](../Microsoft.PowerShell.Core/About/about_Aliases.md).

The format cmdlets, such as `Format-List`, arrange the data to be displayed but do not display it.
The data is displayed by the output features of PowerShell and by the cmdlets that contain the Out
verb (the Out cmdlets), such as `Out-Host` or `Out-File`.

If you do not use a format cmdlet, PowerShell applies that default format for each object that it
displays.

The **GroupBy** parameter assumes that the objects are sorted. Use Sort-Object before using
`Format-List` to group the objects.

The **View** parameter lets you specify an alternate format for the table. You can use the views
defined in the `*.format.PS1XML` files in the PowerShell directory, or you can create your own views
in new PS1XML files and use the Update-FormatData cmdlet to include them in PowerShell.

The alternate view for the **View** parameter must use the list format, otherwise, the command
fails. If the alternate view is a table, use `Format-Table`. If the alternate view is not a list or
a table, use `Format-Custom`.

## RELATED LINKS

[about_Calculated_Properties](../Microsoft.PowerShell.Core/About/about_Calculated_Properties.md)

[Format-Custom](Format-Custom.md)

[Format-Hex](Format-Hex.md)

[Format-Table](Format-Table.md)

[Format-Wide](Format-Wide.md)

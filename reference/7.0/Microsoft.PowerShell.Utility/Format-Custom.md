---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 08/10/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/format-custom?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Format-Custom
---
# Format-Custom

## SYNOPSIS
Uses a customized view to format the output.

## SYNTAX

```
Format-Custom [[-Property] <Object[]>] [-Depth <Int32>] [-GroupBy <Object>] [-View <String>]
 [-ShowError] [-DisplayError] [-Force] [-Expand <String>] [-InputObject <PSObject>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Format-Custom` cmdlet formats the output of a command as defined in an alternate view.
`Format-Custom` is designed to display views that are not just tables or just lists. You can use the
views defined in PowerShell, or you can create your own views in a new `format.ps1xml` file and use
the `Update-FormatData` cmdlet to add them to PowerShell.

## EXAMPLES

### Example 1: Format output with a custom view

```powershell
Get-Command Start-Transcript | Format-Custom -View MyView
```

This command formats information about the `Start-Transcript` cmdlet in the format defined by the
MyView view, a custom view created by the user. To run this command successfully, you must first
create a new PS1XML file, define the **MyView** view, and then use the `Update-FormatData` command
to add the PS1XML file to PowerShell.

### Example 2: Format output with the default view

```powershell
Get-Process Winlogon | Format-Custom
```

This command formats information about the **Winlogon** process in an alternate customized view.
Because the command does not use the **View** parameter, `Format-Custom` uses a default custom view
to format the data.

### Example 3: Troubleshooting format errors

The following examples show of the results of adding the **DisplayError** or **ShowError**
parameters with an expression.

```powershell
PC /> Get-Date | Format-Custom DayOfWeek,{ $_ / $null } -DisplayError

class DateTime
{
  DayOfWeek = Friday
   $_ / $null  = #ERR
}


PC /> Get-Date | Format-Custom DayOfWeek,{ $_ / $null } -ShowError

class DateTime
{
  DayOfWeek = Friday
   $_ / $null  =
}

Failed to evaluate expression " $_ / $null ".
+ CategoryInfo          : InvalidArgument: (12/21/2018 8:01:04 AM:PSObject) [], RuntimeException
+ FullyQualifiedErrorId : PSPropertyExpressionError
```

## PARAMETERS

### -Depth

Specifies the number of columns in the display.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayError

Displays errors at the command line. This parameter is rarely used, but can be used as a debugging
aid when you are formatting expressions in a `Format-Custom` command, and the expressions do not
appear to be working.

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

Formats the collection object, as well as the objects in the collection. This parameter is designed
to format objects that support the **System.Collections.ICollection** interface. The default value
is **EnumOnly**.

Valid values are:

- EnumOnly: Displays the properties of the objects in the collection.
- CoreOnly: Displays the properties of the collection object.
- Both: Displays the properties of the collection object and the objects in the collection.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: CoreOnly, EnumOnly, Both

Required: False
Position: Named
Default value: EnumOnly
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Directs the cmdlet to display all of the error information. Use with the **DisplayError** or
**ShowError** parameters. By default, when an error object is written to the error or display
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

Formats the output in groups based on a shared property or value. Enter an expression or a property
of the output.

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
displayed. The parameter name **Property** is optional. You cannot use the **Property** and
**View** parameters in the same command.

The value of the **Property** parameter can be a new calculated property. The calculated property
can be a script block or a hash table. Valid key-value pairs are:

- Expression - `<string>` or `<script block>`
- Depth - `<int32>`

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

Sends errors through the pipeline. This parameter is rarely used, but can be used as a debugging aid
when you are formatting expressions in a `Format-Custom` command, and the expressions do not appear
to be working.

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

Specifies the name of an alternate format or view. If you omit this parameter, `Format-Custom`
uses a default custom view. You cannot use the **Property** and **View** parameters in the same
command.

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
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

You can pipe any object to `Format-Custom`.

## OUTPUTS

### Microsoft.PowerShell.Commands.Internal.Format

`Format-Custom` returns the format objects that represent the display.

## NOTES

`Format-Custom` is designed to display views that are not just tables or just lists. To display an
alternate table view, use `Format-Table`. To display an alternate list view, use `Format-List`.

You can also refer to `Format-Custom` by its built-in alias, `fc`. For more information, see
[about_Aliases](../Microsoft.PowerShell.Core/About/about_Aliases.md).

The **GroupBy** parameter assumes that the objects are sorted. Before using `Format-Custom` to
group the objects, use `Sort-Object` to sort them.

## RELATED LINKS

[about_Calculated_Properties](../Microsoft.PowerShell.Core/About/about_Calculated_Properties.md)

[Format-Hex](Format-Hex.md)

[Format-List](Format-List.md)

[Format-Table](Format-Table.md)

[Format-Wide](Format-Wide.md)

[Get-Process](../Microsoft.PowerShell.Management/Get-Process.md)

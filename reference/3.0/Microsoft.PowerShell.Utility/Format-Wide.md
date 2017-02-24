---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Format Wide
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/?LinkID=113304
external help file:   Microsoft.PowerShell.Commands.Utility.dll-Help.xml
---


# Format-Wide
## SYNOPSIS
Formats objects as a wide table that displays only one property of each object.
## SYNTAX

```
Format-Wide [[-Property] <Object>] [-AutoSize] [-Column <Int32>] [-GroupBy <Object>] [-View <String>]
 [-ShowError] [-DisplayError] [-Force] [-Expand <String>] [-InputObject <PSObject>] [<CommonParameters>]
```

## DESCRIPTION
The Format-Wide cmdlet formats objects as a wide table that displays only one property of each object.
You can use the Property parameter to determine which property is displayed.
## EXAMPLES

### Example 1
```
PS C:\> get-childitem | format-wide -column 3
```

This command displays the names of files in the current directory in three columns across the screen.
The Get-ChildItem cmdlet gets objects representing each file in the directory.
The pipeline operator (|) passes the file objects through the pipeline to Format-Wide, which formats them for output.
The Column parameter specifies the number of columns.
### Example 2
```
PS C:\> get-childitem HKCU:\software\microsoft | format-wide -property pschildname -autosize
```

This command displays the names of registry keys in the HKEY_CURRENT_USER\Software\Microsoft key.
The Get-ChildItem cmdlet gets objects representing the keys.
The path is specified as "HKCU:", one of the drives exposed by the Windows PowerShell Registry provider, followed by the key path.
The pipeline operator (|) passes the registry key objects through the pipeline to Format-Wide, which formats them for output.
The Property parameter specifies the name of the property, and the AutoSize parameter adjusts the columns for readability.
## PARAMETERS

### -AutoSize
Adjusts the column size and number of columns based on the width of the data.
By default, the column size and number are determined by the view.
You cannot use the AutoSize and Column parameters in the same command.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Column
Specifies the number of columns in the display.
You cannot use the AutoSize and Column parameters in the same command.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayError
Displays errors at the command line.
This parameter is rarely used, but can be used as a debugging aid when you are formatting expressions in a Format-Wide command, and the expressions do not appear to be working.
The following shows an example of the results of adding the DisplayError parameter with an expression.

PS \> Get-Date | Format-Wide DayOfWeek,{ $_ / $null } -ShowError
DayOfWeek  $_ / $null
--------- ------------
Wednesday #ERR

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Expand
Formats the collection object, as well as the objects in the collection.
This parameter is designed to format objects that support the ICollection (System.Collections) interface.
The default value is EnumOnly.

Valid values are:

- EnumOnly: Displays the properties of the objects in the collection.
- CoreOnly: Displays the properties of the collection object.
- Both: Displays the properties of the collection object and the properties of objects in the collection.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: EnumOnly
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Overrides restrictions that prevent the command from succeeding, just so the changes do not compromise security.
For example, Force will override the read-only attribute or create directories to complete a file path, but it will not attempt to change file permissions.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupBy
Formats the output in groups based on a shared property or value.
Enter an expression or a property of the output.

The value of the GroupBy parameter can be a new calculated property.
To create a calculated, property, use a hash table.
Valid keys are:

- Name (or Label) \<string\>
- Expression \<string\> or \<script block\>
- FormatString \<string\>

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies the objects to be formatted.
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

### -Property
Specifies the object properties that appear in the display and the order in which they appear.
Wildcards are permitted.

If you omit this parameter, the properties that appear in the display depend on the object being displayed.
The parameter name ("Property") is optional.
You cannot use the Property and View parameters in the same command.

The value of the Property parameter can be a new calculated property.
To create a calculated, property, use a hash table.
Valid keys are:

- Expression \<string\> or \<script block\>
- FormatString \<string\>

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -ShowError
Sends errors through the pipeline.
This parameter is rarely used, but can be used as a debugging aid when you are formatting expressions in a Format-Wide command, and the expressions do not appear to be working.
The following shows an example of the results of adding the ShowError parameter with an expression.

PS \> Get-Date | Format-Wide DayOfWeek,{ $_ / $null } -ShowError
DayOfWeek  $_ / $null
--------- ------------
Wednesday

Failed to evaluate expression " $_ / $null ".
    + CategoryInfo          : InvalidArgument: (10/30/2013 2:28:07 PM:PSObject) \[\], RuntimeException
    + FullyQualifiedErrorId : mshExpressionError

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -View
Specifies the name of an alternate table format or "view." You cannot use the Property and View parameters in the same command.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

### System.Management.Automation.PSObject
You can pipe any object to Format-Wide.
## OUTPUTS

### Microsoft.PowerShell.Commands.Internal.Format
Format-Wide returns format objects that represent the table.
## NOTES
* You can also refer to Format-Wide by its built-in alias, "fw". For more information, see about_Aliases.
The GroupBy parameter assumes that the objects are sorted. Before using Format-Custom to group the objects, use Sort-Object to sort them.
The -View parameter lets you specify an alternate format for the table. You can use the views defined in the *.format.PS1XML files in the Windows PowerShell directory or you can create your own views in new PS1XML files and use the Update-FormatData cmdlet to include them in Windows PowerShell.
The alternate view for the View parameter must use table format; if it does not, the command fails. If the alternate view is a list, use Format-List. If the alternate view is neither a list nor a table, use Format-Custom.

*
## RELATED LINKS


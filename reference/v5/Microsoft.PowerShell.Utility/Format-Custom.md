---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293960
schema: 2.0.0
---

# Format-Custom
## SYNOPSIS
Uses a customized view to format the output.

## SYNTAX

```
Format-Custom [[-Property] <Object[]>] [-Depth <Int32>] [-GroupBy <Object>] [-View <String>] [-ShowError]
 [-DisplayError] [-Force] [-Expand <String>] [-InputObject <PSObject>] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>]
```

## DESCRIPTION
The Format-Custom cmdlet formats the output of a command as defined in an alternate view.
Format-Custom is designed to display views that are not just tables or just lists.
You can use the views defined in the *format.PS1XML files in the Windows PowerShell directory, or you can create your own views in new PS1XML files and use the Update-FormatData cmdlet to add them to Windows PowerShell.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-command start-transcript | format-custom -view MyView
```

This command formats information about the Start-Transcript cmdlet in the format defined by the MyView view, a custom view created by the user.
To run this command successfully, you must first create a new PS1XML file, define the MyView view, and then use the Update-FormatData command to add the PS1XML file to Windows PowerShell.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>get-process Winlogon | format-custom
```

This command formats information about the Winlogon process in an alternate customized view.
Because the command does not use the View parameter, Format-Custom uses a default custom view to format the data.

## PARAMETERS

### -Depth
Specifies the number of columns in the display.

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
This parameter is rarely used, but can be used as a debugging aid when you are formatting expressions in a Format-Custom command, and the expressions do not appear to be working.
The following shows an example of the results of adding the DisplayError parameter with an expression.

PS \> Get-Date | Format-Custom DayOfWeek,{ $_ / $null } -ShowError
DayOfWeek  $_ / $null
--------- ------------
Wednesday #ERR

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Expand
Formats the collection object, as well as the objects in the collection.
This parameter is designed to format objects that support the ICollection (System.Collections) interface.
The default value is EnumOnly.

Valid values are:

-- EnumOnly: Displays the properties of the objects in the collection.
-- CoreOnly: Displays the properties of the collection object.
-- Both: Displays the properties of the collection object and the properties of objects in the collection.

```yaml
Type: String
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
Directs the cmdlet to display all of the error information.
Use with the DisplayError or ShowError parameters.
By default, when an error object is written to the error or display streams, only some of the error information is displayed.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupBy
Formats the output in groups based on a shared property or value.
Enter an expression or a property of the output.

The value of the GroupBy parameter can be a new calculated property.
To create a calculated, property, use a hash table.
Valid keys are:

-- Name (or Label) \<string\>
-- Expression \<string\> or \<script block\>
-- FormatString \<string\>

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

### -InformationAction
@{Text=}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa
Accepted values: SilentlyContinue, Stop, Continue, Inquire, Ignore, Suspend

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
@{Text=}

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies the objects to be formatted.
Enter a variable that contains the objects or type a command or expression that gets the objects.

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
To create a calculated property, use a hash table.
Valid keys are:

-- Expression \<string\> or \<script block\>
-- Depth \<int32\>

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowError
Sends errors through the pipeline.
This parameter is rarely used, but can be used as a debugging aid when you are formatting expressions in a Format-Custom command, and the expressions do not appear to be working.
The following shows an example of the results of adding the ShowError parameter with an expression.

PS \> Get-Date | Format-Custom DayOfWeek,{ $_ / $null } -ShowError
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
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -View
Specifies the name of an alternate format or "view." If you omit this parameter, Format-Custom uses a default custom view.
You cannot use the Property and View parameters in the same command.

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

## INPUTS

### System.Management.Automation.PSObject
You can pipe any object to Format-Custom

## OUTPUTS

### Microsoft.PowerShell.Commands.Internal.Format
Format-Custom returns the format objects that represent the display.

## NOTES
Format-Custom is designed to display views that are not just tables or just lists.
To display an alternate table view, use Format-Table.
To display an alternate list view, use Format-List.

You can also refer to Format-Custom by its built-in alias, "fc".
For more information, see about_Aliases.

The GroupBy parameter assumes that the objects are sorted.
Before using Format-Custom to group the objects, use Sort-Object to sort them.

## RELATED LINKS


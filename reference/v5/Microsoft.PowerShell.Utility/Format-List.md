---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293961
schema: 2.0.0
---

# Format-List
## SYNOPSIS
Formats the output as a list of properties in which each property appears on a new line.

## SYNTAX

```
Format-List [[-Property] <Object[]>] [-GroupBy <Object>] [-View <String>] [-ShowError] [-DisplayError] [-Force]
 [-Expand <String>] [-InputObject <PSObject>] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>]
```

## DESCRIPTION
The Format-List cmdlet formats the output of a command as a list of properties in which each property is displayed on a separate line.
You can use Format-List to format and display all or selected properties of an object as a list (format-list *).

Because more space is available for each item in a list than in a table, Windows PowerShell displays more properties of the object in the list, and the property values are less likely to be truncated.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-service | format-list
```

This command formats information about services on the computer as a list.
By default, the services are formatted as a table.
The Get-Service cmdlet gets objects representing the services on the computer.
The pipeline operator (|) passes the results through the pipeline to Format-List.
Then, the Format-List command formats the service information in a list and sends it to the default output cmdlet for display.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>$a = get-childitem $pshome\*.ps1xml
PS C:\>format-list -InputObject $a
```

These commands display information about the PS1XML files in the Windows PowerShell directory as a list.

The first command gets the objects representing the files and stores them in the $a variable.

The second command uses Format-List to format information about objects stored in $a.
This command uses the InputObject parameter to pass the variable to Format-List, which then sends the formatted output to the default output cmdlet for display.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>get-process | format-list -property name, basepriority, priorityclass
```

This command displays the name, base priority, and priority class of each process on the computer.
It uses the Get-Process cmdlet to get an object representing each process.
The pipeline operator (|) passes the process objects through the pipeline to Format-List.
Format-List formats the processes as a list of the specified properties.
The "Property" parameter name is optional, so you can omit it.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>get-process winlogon | format-list -property *
```

This command displays all of the properties of the Winlogon process.
It uses the Get-Process cmdlet to get an object representing the Winlogon process.
The pipeline operator (|) passes the Winlogon process object through the pipeline to Format-List.
The command uses the Property parameter to specify the properties and the * to indicate all properties.
Because the name of the Property parameter is optional, you can omit it and type the command as: "format-list *".
Format-List automatically sends the results to the default output cmdlet for display.

## PARAMETERS

### -DisplayError
Displays errors at the command line.
This parameter is rarely used, but can be used as a debugging aid when you are formatting expressions in a Format-List command, and the expressions do not appear to be working.
The following shows an example of the results of adding the DisplayError parameter with an expression.

PS \> Get-Date | Format-List DayOfWeek,{ $_ / $null } -ShowError
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
To create a calculated property, use a hash table.
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
PS \> Get-Date | Format-List DayOfWeek,{ $_ / $null } -ShowError
DayOfWeek  $_ / $null
--------- ------------
Wednesday #ERR

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
PS \> Get-Date | Format-List DayOfWeek,{ $_ / $null } -ShowError
DayOfWeek  $_ / $null
--------- ------------
Wednesday #ERR

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

-- Name (or Label) \<string\>
-- Expression \<string\> or \<script block\>
-- FormatString \<string\>

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
This parameter is rarely used, but can be used as a debugging aid when you are formatting expressions in a Format-List command, and the expressions do not appear to be working.
The following shows an example of the results of adding the ShowError parameter with an expression.

PS \> Get-Date | Format-List DayOfWeek,{ $_ / $null } -ShowError
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
Specifies the name of an alternate list format or "view." You cannot use the Property and View parameters in the same command.

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
You can pipe any object to Format-List.

## OUTPUTS

### Microsoft.PowerShell.Commands.Internal.Format
Format-List returns the format objects that represent the list.

## NOTES
You can also refer to Format-List by its built-in alias, "FL".
For more information, see about_Aliases.

The format cmdlets, such as Format-List, arrange the data to be displayed but do not display it.
The data is displayed by the output features of Windows PowerShell and by the cmdlets that contain the Out verb (the Out cmdlets), such as Out-Host, Out-File, and Out-Printer.

If you do not use a format cmdlet, Windows PowerShell applies that default format for each object that it displays.

The GroupBy parameter assumes that the objects are sorted.
Before using Format-Custom to group the objects, use Sort-Object to sort them.

The View parameter lets you specify an alternate format for the table.
You can use the views defined in the *.format.PS1XML files in the Windows PowerShell directory, or you can create your own views in new PS1XML files and use the Update-FormatData cmdlet to include them in Windows PowerShell.

The alternate view for the View parameter must use the list format; if not, the command fails.
If the alternate view is a table, use Format-Table.
If the alternate view is neither a list nor a table, use Format-Custom.

## RELATED LINKS


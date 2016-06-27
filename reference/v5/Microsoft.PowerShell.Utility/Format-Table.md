---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293962
schema: 2.0.0
---

# Format-Table
## SYNOPSIS
Formats the output as a table.

## SYNTAX

```
Format-Table [-AutoSize] [-HideTableHeaders] [-Wrap] [[-Property] <Object[]>] [-GroupBy <Object>]
 [-View <String>] [-ShowError] [-DisplayError] [-Force] [-Expand <String>] [-InputObject <PSObject>]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

## DESCRIPTION
The Format-Table cmdlet formats the output of a command as a table with the selected properties of the object in each column.
The object type determines the default layout and properties that are displayed in each column, but you can use the Property parameter to select the properties that you want to see.

You can also use a hash table to add calculated properties to an object before displaying it and to specify the column headings in the table.
To add a calculated property, use the Property or GroupBy parameters.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-pssnapin | format-table -auto
```

This command formats information about Windows PowerShell snap-ins in a table.
By default, they are formatted in a list.
The Get-PSSnapin cmdlet gets objects representing the snap-ins.
The pipeline operator (|) passes the object to the Format-Table command.
Format-Table formats the objects in a table.
The Autosize parameter adjusts the column widths to minimize truncation.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>get-process | sort-object -property basepriority | format-table -groupby basepriority -wrap
```

This command displays the processes on the computer in groups with the same base priority.

The Get-Process cmdlet gets objects representing each process on the computer.
The pipeline operator (|) passes the object to the Sort-Object cmdlet, which sorts the objects in order of their base priority.

Another pipeline operator passes the results to the Format-Table cmdlet.
The GroupBy parameter arranges the data about the processes into groups based on the value of their BasePriority property.
The Wrap parameter ensures that data is not truncated.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>get-process | sort-object starttime | format-table -view starttime
```

This command displays information about the processes on the computer in group based on the start date of the process.
It uses the Get-Process cmdlet to get objects representing the processes on the computer.
The pipeline operator (|) sends the output of Get-Process to the Sort-Object cmdlet, which sorts it based on the StartTime property.
Another pipeline operator sends the sorted results to Format-Table.

The View parameter is used to select the StartTime view that is defined in the DotNetTypes.format.ps1xml formatting file for System.Diagnostics.Process objects, such as those returned by Get-Process.
This view converts the StartTime of the process to a short date and then groups the processes by start date.

The DotNetTypes.format.ps1xml formatting file also contains a Priority view for processes, and you can create your own format.ps1xml files with customized views.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>get-service | format-table -property Name, DependentServices
```

This command displays all of the services on the computer in a table with two columns, Name and DependentServices.
The command uses the Get-Service cmdlet to get all of the services on the computer.
The pipeline operator (|) sends the results to the Format-Table cmdlet, which formats the output in a table.
The Property parameter specifies the properties that appear in the table as columns.
The name of the Property parameter is optional, so you can omit it ("format-table name, dependentservices").

Property and DependentServices are just two of the properties of service objects.
To view all of the properties, type "get-service | get-member".

### -------------------------- EXAMPLE 5 --------------------------
```
PS C:\>get-process notepad | format-table ProcessName, @{Label="TotalRunningTime"; Expression={(get-date) - $_.StartTime}}
```

This command shows how to use a calculated property in a table.
The command displays a table with the process name and total running time of all Notepad processes on the local computer.
The total running time is calculated by subtracting the start time of each process from the current time.

The command uses the Get-Process cmdlet to get all processes named "Notepad" on the local computer.
The pipeline operator (|) sends the results to Format-Table, which displays a table with two columns: ProcessName, a standard property of processes, and TotalRunningTime, a calculated property.

The TotalRunningTime property is specified by a hash table with two keys, Label and Expression.
The name of the property is assigned to the Label key.
The calculation is assigned to the Expression key.
The expression gets the StartTime property of each process object and subtracts it from the result of a Get-Date command, which gets the current date (and time).

### -------------------------- EXAMPLE 6 --------------------------
```
PS C:\>$processes = get-wmiobject -ComputerName Server01 win32_process -filter "name='notepad.exe'"
PS C:\>$processes | format-table ProcessName, @{ Label = "Total  Running Time"; Expression={(get-date) - $_.ConvertToDateTime($_.CreationDate)}}
```

These commands are similar to the previous command, except that these commands use the Get-WmiObject cmdlet and the Win32_Process class to display information about Notepad processes on a remote computer.

The first command uses the Get-WmiObject cmdlet to get instances of the Windows Management Instrumentation (WMI) Win32_Process class that describes all of the processes on the Server01 computer that are named Notepad.exe.
The command stores the process information in the $processes variable.

The second command uses a pipeline operator (|) to send the process information in the $processes variable to the Format-Table cmdlet, which displays the ProcessName of each process along with a new calculated property.

The command assigns the name of the new calculated property, Total Running Time, to the Label key.
The script block that is assigned to the Expression key calculates how long the process has been running by subtracting the creation date of the process from the current date.
The Get-Date cmdlet gets the current date.
The ConvertToDateTime method converts the CreationDate property of the Win32_Process object from a WMI CIM_DATETIME object to a Microsoft .NET Framework DateTime object that can be compared with the output of Get-Date.
Then, the converted creation date is subtracted from the current date.
The result is the value of Total Running Time.

## PARAMETERS

### -AutoSize
Adjusts the column size and number of columns based on the width of the data.
By default, the column size and number are determined by the view.

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

### -DisplayError
Displays errors at the command line.
This parameter is rarely used, but can be used as a debugging aid when you are formatting expressions in a Format-Table command, and the expressions do not appear to be working.
The following shows an example of the results of adding the DisplayError parameter with an expression.

PS \> Get-Date | Format-Table DayOfWeek,{ $_ / $null } -ShowError
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
Arranges sorted output in separate tables based on a property value.
For example, you can use GroupBy to list services in separate tables based on their status.

Enter an expression or a property of the output.
The output must be sorted before you send it to Format-Table.

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

### -HideTableHeaders
Omits the column headings from the table.

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
Type one or more property names (separated by commas), or use a hash table to display a calculated property.
Wildcards are permitted.

If you omit this parameter, the properties that appear in the display depend on the object being displayed.
The parameter name ("Property") is optional.
You cannot use the Property and View parameters in the same command.

The value of the Property parameter can be a new calculated property.
To create a calculated, property, use a hash table.
Valid keys are:

-- Name (or Label) \<string\>
-- Expression \<string\> or \<script block\>
-- FormatString \<string\>
-- Width \<int32\>
-- Alignment  (value can be "Left", "Center", or "Right")

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
This parameter is rarely used, but can be used as a debugging aid when you are formatting expressions in a Format-Table command, and the expressions do not appear to be working.
The following shows an example of the results of adding the ShowError parameter with an expression.

PS \> Get-Date | Format-Table DayOfWeek,{ $_ / $null } -ShowError
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

### -Wrap
Displays text that exceeds the column width on the next line.
By default, text that exceeds the column width is truncated.

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

## INPUTS

### System.Management.Automation.PSObject
You can pipe any object to Format-Table.

## OUTPUTS

### Microsoft.PowerShell.Commands.Internal.Format
Format-Table returns format objects that represent the table.

## NOTES
The GroupBy parameter assumes that the objects are sorted.
Before using Format-Table to group the objects, use the Sort-Object cmdlet to sort them.

The View parameter lets you specify an alternate format for the table.
You can use the views defined in the *.format.PS1XML files in the Windows PowerShell directory or you can create your own views in new PS1XML files and then use the TUpdate-FormatData cmdlet to include them in Windows PowerShell.

The alternate views for the View parameter must use the table format.
If it does not, the command fails.
If the alternate view is a list, use the Format-List cmdlet.
If the alternate view is neither a list nor a table, use the T:Microsoft.PowerShell.Commands.Format-Custom cmdlet.

## RELATED LINKS

[Format-Custom]()

[Format-List]()

[Format-Wide]()


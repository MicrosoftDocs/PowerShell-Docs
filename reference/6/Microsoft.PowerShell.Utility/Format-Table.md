---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Utility
ms.date: 03/01/2018
online version: http://go.microsoft.com/fwlink/?LinkId=821775
schema: 2.0.0
title: Format-Table
---
# Format-Table

## SYNOPSIS
Formats the output as a table.

## SYNTAX

```
Format-Table [-AutoSize] [-RepeatHeader] [-HideTableHeaders] [-Wrap] [[-Property] <Object[]>]
 [-GroupBy <Object>] [-View <String>] [-ShowError] [-DisplayError] [-Force] [-Expand <String>]
 [-InputObject <PSObject>] [<CommonParameters>]
```

## DESCRIPTION

The `Format-Table` cmdlet formats the output of a command as a table with the selected properties
of the object in each column. The object type determines the default layout and properties that are
displayed in each column, but you can use the **Property** parameter to select the properties that
you want to see.

You can also use a hash table to add calculated properties to an object before displaying it and to
specify the column headings in the table. To add a calculated property, use the **Property** or
**GroupBy** parameter.

## EXAMPLES

### Example 1: Format PowerShell host

This command displays information about the host program for PowerShell in a table. By default,
they are formatted in a list.

```powershell
Get-Host | Format-Table -AutoSize
```

The `Get-Host` cmdlet gets objects representing the host. The pipeline operator (|) passes the
object to the `Format-Table` cmdlet. The `Format-Table` cmdlet formats the objects in a table. The
**AutoSize** parameter adjusts the column widths to minimize truncation.

### Example 2: Format processes by BasePriority

This command displays the processes on the computer in groups with the same base priority.

```powershell
Get-Process | Sort-Object -Property basepriority | Format-Table -GroupBy basepriority -Wrap
```

The Get-Process cmdlet gets objects representing each process on the computer. The pipeline
operator (|) passes the object to the Sort-Object cmdlet, which sorts the objects in order of their
base priority.

Another pipeline operator passes the results to the `Format-Table` cmdlet. The **GroupBy**
parameter arranges the data about the processes into groups based on the value of their
BasePriority property. The **Wrap** parameter ensures that data is not truncated.

### Example 3: Format processes by start date

```powershell
Get-Process | Sort-Object starttime | Format-Table -View starttime
```

This command displays information about the processes on the computer in group based on the start
date of the process. It uses the Get-Process cmdlet to get objects representing the processes on
the computer. The pipeline operator (|) sends the output of `Get-Process` to the `Sort-Object`
cmdlet, which sorts it based on the StartTime property. Another pipeline operator sends the sorted
results to `Format-Table`.

The **View** parameter is used to select the *StartTime* view that is defined in the
`DotNetTypes.format.ps1xml` file for **System.Diagnostics.Process** objects, such as those returned
by `Get-Process`. This view converts the **StartTime** of the process to a short date and then
groups the processes by start date.

The `DotNetTypes.format.ps1xml` file also contains a *Priority* view for processes. You can create
your own format.ps1xml files with customized views.

### Example 4: Format services

```powershell
Get-Service | Format-Table -Property Name, DependentServices
```

This command displays all of the services on the computer in a table with two columns, **Name** and
**DependentServices**. The `Get-Service` cmdlet gets all of the services on the computer. The pipeline
operator (|) sends the results to the `Format-Table` cmdlet, which formats the output in a table.
The **Property** parameter specifies the properties that appear in the table as columns. The name
of the **Property** parameter is optional, so you can omit it, for example
`Format-Table Name, DependentServices`.

**Name** and **DependentServices** are just two of the properties of service objects. To view all
of the properties, type `Get-Service | Get-Member -MemberType Properties`.

### Example 5: Format a process and calculate its running time

This command shows how to use a calculated property in a table.

```powershell
Get-Process Notepad | Format-Table ProcessName,
   @{Label="TotalRunningTime"; Expression={(Get-Date) - $_.StartTime}}
```

The command displays a table with the process name and total running time of all Notepad processes
on the local computer. The total running time is calculated by subtracting the start time of each
process from the current time.

The command uses the `Get-Process` cmdlet to get all processes named Notepad on the local computer.
The pipeline operator (|) sends the results to `Format-Table`, which displays a table with two
columns: ProcessName, a standard property of processes, and TotalRunningTime, a calculated
property.

The **TotalRunningTime** property is specified by a hash table with two keys, **Label** and
**Expression**. The name of the property is assigned to the **Label** key. The calculation is
assigned to the **Expression** key. The expression gets the **StartTime** property of each process
object and subtracts it from the result of a `Get-Date` command, which gets the current date and
time.

### Example 6: Format Notepad processes

These commands are similar to the previous command, except that these commands use the
`Get-WmiObject` cmdlet.

```powershell
$Processes = Get-WmiObject -ComputerName "Server01" -Class win32_process -Filter "name='notepad.exe'"
$Processes | Format-Table ProcessName, @{ Label = "Total Running Time"; Expression={(Get-Date) - $_.ConvertToDateTime($_.CreationDate)}}
```

The first command uses the `Get-WmiObject` cmdlet to get instances of the WMI **Win32_Process**
class that describes all of the processes on the Server01 computer that are named `Notepad.exe`.
The command stores the process information in the `$Processes` variable.

The second command uses a pipeline operator (|) to send the process information in the `$Processes`
variable to the `Format-Table` cmdlet, which displays the **ProcessName** and a new calculated
property.

The command assigns the name of the new calculated property, "Total Running Time", to the **Label**
key. The script block that is assigned to the **Expression** key calculates how long the process
has been running by subtracting the creation date of the process from the current date. The
`Get-Date` cmdlet gets the current date. The **ConvertToDateTime** method converts the
**CreationDate** property of the **Win32_Process** object from a WMI CIM_DATETIME object to a .NET
**DateTime** object that can be compared with the output of `Get-Date`. Then, the converted
creation date is subtracted from the current date. The result is the value of **Total Running Time**.

### Example 7: Troubleshooting format errors

The following examples show of the results of adding the **DisplayError** or **ShowError**
parameters with an expression.

```powershell
PC /> Get-Date | Format-Table DayOfWeek,{ $_ / $null } -DisplayError

DayOfWeek  $_ / $null
--------- ------------
Wednesday #ERR

PC /> Get-Date | Format-Table DayOfWeek,{ $_ / $null } -ShowError

DayOfWeek  $_ / $null
--------- ------------
Wednesday

Failed to evaluate expression " $_ / $null ".
    + CategoryInfo          : InvalidArgument: (10/30/2013 2:28:07 PM:PSObject) \[\], RuntimeException
    + FullyQualifiedErrorId : mshExpressionError
```

## PARAMETERS

### -AutoSize

Indicates that the cmdlet adjusts the column size and number of columns based on the width of the
data. By default, the column size and number are determined by the view.

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

Indicates that the cmdlet displays errors at the command line. This parameter is rarely used, but
can be used as a debugging aid when you are formatting expressions in a `Format-Table` command, and
the expressions do not appear to be working.

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

Specifies the format of the collection object, as well as the objects in the collection. This
parameter is designed to format objects that support the ICollection (System.Collections)
interface. The default value is **EnumOnly**. The acceptable values for this parameter are:

- EnumOnly: Displays the properties of the objects in the collection.
- CoreOnly: Displays the properties of the collection object.
- Both: Displays the properties of the collection object and the properties of objects in the
  collection.

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

Indicates that the cmdlet directs the cmdlet to display all of the error information. Use with the
**DisplayError** or **ShowError** parameter. By default, when an error object is written to the
error or display streams, only some of the error information is displayed.

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

Specifies sorted output in separate tables based on a property value. For example, you can use
**GroupBy** to list services in separate tables based on their status.

Enter an expression or a property of the output. The output must be sorted before you send it to
`Format-Table`.

The value of the **GroupBy** parameter can be a new calculated property. To create a calculated,
property, use a hash table. Valid keys are:

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

### -InputObject

Specifies the objects to format. Enter a variable that contains the objects, or type a command or
expression that gets the objects.

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

Specifies the object properties that appear in the display and the order in which they appear. Type
one or more property names (separated by commas), or use a hash table to display a calculated
property. Wildcards are permitted.

If you omit this parameter, the properties that appear in the display depend on the object being
displayed. The parameter name "Property" is optional. You cannot use the **Property** and
**View** parameters in the same command.

The value of the **Property** parameter can be a new calculated property. To create a calculated
property, use a hash table. Valid keys are:

- Name (or Label) \<string\>
- Expression \<string\> or \<script block\>
- FormatString \<string\>
- Width \<int32\>
- Alignment (value can be "Left", "Center", or "Right")

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowError

Sends errors through the pipeline. This parameter is rarely used, but can be used as a debugging
aid when you are formatting expressions in a `Format-Table` command, and the expressions do not
appear to be working.

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

Specifies the name of an alternate table format or view. You cannot use the **Property** and
**View** parameters in the same command.

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

Displays text that exceeds the column width on the next line. By default, text that exceeds the
column width is truncated.

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

### -RepeatHeader

Repeats displaying the header of a table after every screen full. This is most useful when the
output is piped to a pager such as `less` or `more` or paging and using a screen reader.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

You can pipe any object to `Format-Table`.

## OUTPUTS

### Microsoft.PowerShell.Commands.Internal.Format

`Format-Table` returns format objects that represent the table.

## NOTES

The **GroupBy** parameter assumes that the objects are sorted. Use the `Sort-Object` cmdlet before
using `Format-Table` to group the objects.

The **View** parameter lets you specify an alternate format for the table. You can use the views
defined in the `*.format.PS1XML` files in the PowerShell directory or you can create your own views
in new PS1XML files and then use the `Update-FormatData` cmdlet to include them in PowerShell. The
alternate views for the **View** parameter must use the table format, otherwise, the command fails.
If the alternate view is a list, use the `Format-List` cmdlet. If the alternate view is neither a
list or a table, use the `Format-Custom` cmdlet.

## RELATED LINKS

[Format-Custom](Format-Custom.md)

[Format-Hex](Format-Hex.md)

[Format-List](Format-List.md)

[Format-Wide](Format-Wide.md)
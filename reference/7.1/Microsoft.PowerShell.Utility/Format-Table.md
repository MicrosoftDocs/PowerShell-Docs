---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 08/10/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/format-table?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Format-Table
---

# Format-Table

## SYNOPSIS
Formats the output as a table.

## SYNTAX

### All

```
Format-Table [-AutoSize] [-RepeatHeader] [-HideTableHeaders] [-Wrap] [[-Property] <Object[]>]
 [-GroupBy <Object>] [-View <String>] [-ShowError] [-DisplayError] [-Force] [-Expand <String>]
 [-InputObject <PSObject>] [<CommonParameters>]
```

## DESCRIPTION

The `Format-Table` cmdlet formats the output of a command as a table with the selected properties of
the object in each column. The object type determines the default layout and properties that are
displayed in each column. You can use the **Property** parameter to select the properties that you
want to display.

PowerShell uses default formatters to define how object types are displayed. You can use `.ps1xml`
files to create custom views that display an output table with specified properties. After a custom
view is created, use the **View** parameter to display the table with your custom view. For more
information about views, see [about_Format.ps1xml](../Microsoft.PowerShell.Core/About/about_Format.ps1xml.md).

You can use a hash table to add calculated properties to an object before displaying it and to
specify the column headings in the table. To add a calculated property, use the **Property** or
**GroupBy** parameter. For more information about hash tables, see
[about_Hash_Tables](../Microsoft.PowerShell.Core/About/about_Hash_Tables.md).

## EXAMPLES

### Example 1: Format PowerShell host

This example displays information about the host program for PowerShell in a table.

```powershell
Get-Host | Format-Table -AutoSize
```

The `Get-Host` cmdlet gets **System.Management.Automation.Internal.Host.InternalHost** objects that
represent the host. The objects are sent down the pipeline to `Format-Table` and displayed in a
table. The **AutoSize** parameter adjusts the column widths to minimize truncation.

### Example 2: Format processes by BasePriority

In this example, processes are displayed in groups that have the same **BasePriority** property.

```powershell
Get-Process | Sort-Object -Property BasePriority | Format-Table -GroupBy BasePriority -Wrap
```

The `Get-Process` cmdlet gets objects that represent each process on the computer and sends them
down the pipeline to `Sort-Object`. The objects are sorted in the order of their **BasePriority**
property.

The sorted objects are sent down the pipeline to `Format-Table`. The **GroupBy** parameter arranges
the process data into groups based on their **BasePriority** property's value. The **Wrap**
parameter ensures that data isn't truncated.

### Example 3: Format processes by start date

This example displays information about the processes running on the computer. The objects are
sorted and `Format-Table` uses a view to group the objects by their start date.

```powershell
Get-Process | Sort-Object StartTime | Format-Table -View StartTime
```

`Get-Process` gets the **System.Diagnostics.Process** objects that represent the processes running
on the computer. The objects are sent down the pipeline to `Sort-Object`, and are sorted based on
the **StartTime** property.

The sorted objects are sent down the pipeline to `Format-Table`. The **View** parameter specifies
the **StartTime** view that's defined in the PowerShell `DotNetTypes.format.ps1xml` file for
**System.Diagnostics.Process** objects. The **StartTime** view converts each processes start time to
a short date and then groups the processes by the start date.

The `DotNetTypes.format.ps1xml` file contains a **Priority** view for processes. You can create your
own `format.ps1xml` files with customized views.

### Example 4: Use a custom view for table output

In this example, a custom view displays a directory's contents. The custom view adds the
**CreationTime** column to the table output for **System.IO.DirectoryInfo** and
**System.IO.FileInfo** objects created by `Get-ChildItem`.

The custom view in this example was created from the view defined in PowerShell source code. For
more information about views and the code used to create this example's view, see
[about_Format.ps1xml](../Microsoft.PowerShell.Core/About/about_Format.ps1xml.md#sample-xml-for-a-format-table-custom-view).

```powershell
Get-ChildItem  -Path C:\Test | Format-Table -View mygciview
```

```Output
    Directory: C:\Test

Mode                LastWriteTime              CreationTime         Length Name
----                -------------              ------------         ------ ----
d-----        11/4/2019     15:54       9/24/2019     15:54                Archives
d-----        8/27/2019     14:22       8/27/2019     14:22                Drawings
d-----       10/23/2019     09:38       2/25/2019     09:38                Files
-a----        11/7/2019     11:07       11/7/2019     11:07          11345 Alias.txt
-a----        2/27/2019     15:15       2/27/2019     15:15            258 alias_out.txt
-a----        2/27/2019     15:16       2/27/2019     15:16            258 alias_out2.txt
```

`Get-ChildItem` gets the contents of the current directory, `C:\Test`. The
**System.IO.DirectoryInfo** and **System.IO.FileInfo** objects are sent down the pipeline.
`Format-Table` uses the **View** parameter to specify the custom view **mygciview** that includes
the **CreationTime** column.

The default `Format-Table` output for `Get-ChildItem` doesn't include the **CreationTime** column.

### Example 5: Use properties for table output

This example uses the **Property** parameter to display all the computer's services in a two-column
table that shows the properties **Name** and **DependentServices**.

```powershell
Get-Service | Format-Table -Property Name, DependentServices
```

`Get-Service` gets all the services on the computer and sends the
**System.ServiceProcess.ServiceController** objects down the pipeline. `Format-Table` uses the
**Property** parameter to specify that the **Name** and **DependentServices** properties are
displayed in the table.

**Name** and **DependentServices** are two of the object type's properties. To view all the
properties: `Get-Service | Get-Member -MemberType Properties`.

### Example 6: Format a process and calculate its running time

This example displays a table with the process name and total running time for the local computer's
**notepad** processes. The total running time is calculated by subtracting the start time of each
process from the current time.

```powershell
Get-Process notepad |
  Format-Table ProcessName, @{Label="TotalRunningTime"; Expression={(Get-Date) - $_.StartTime}}
```

```Output
ProcessName TotalRunningTime
----------- ----------------
notepad     03:20:00.2751767
notepad     00:00:16.7710520
```

`Get-Process` gets all the local computer's **notepad** processes and sends the objects down the
pipeline. `Format-Table` displays a table with two columns: **ProcessName**, a `Get-Process`
property, and **TotalRunningTime**, a calculated property.

The **TotalRunningTime** property is specified by a hash table with two keys, **Label** and
**Expression**. The **Label** key specifies the property name. The **Expression** key specifies the
calculation. The expression gets the **StartTime** property of each process object and subtracts it
from the result of a `Get-Date` command, which gets the current date and time.

### Example 7: Format Notepad processes

This example uses `Get-CimInstance` to get the running time for all **notepad** processes on the local
computer. You can use `Get-CimInstance` with the **ComputerName** parameter to get information from
remote computers.

```powershell
$Processes = Get-CimInstance -Class win32_process -Filter "name='notepad.exe'"
$Processes | Format-Table ProcessName, @{ Label = "Total Running Time"; Expression={(Get-Date) - $_.CreationDate}}
```

```Output
ProcessName Total Running Time
----------- ------------------
notepad.exe 03:39:39.6260693
notepad.exe 00:19:56.1376922
```

`Get-CimInstance` gets instances of the WMI **Win32_Process** class that describes all the local
computer's processes named **notepad.exe**. The process objects are stored in the `$Processes`
variable.

The process objects in the `$Processes` variable are sent down the pipeline to `Format-Table`, which
displays the **ProcessName** property and a new calculated property, **Total Running Time**.

The command assigns the name of the new calculated property, **Total Running Time**, to the
**Label** key. The **Expression** key's script block calculates how long the process has been
running by subtracting the processes creation date from the current date. The `Get-Date` cmdlet gets
the current date. The creation date is subtracted from the current date. The result is the value of
**Total Running Time**.

### Example 8: Troubleshooting format errors

The following examples show the results of adding the **DisplayError** or **ShowError** parameters
with an expression.

```powershell
Get-Date | Format-Table DayOfWeek,{ $_ / $null } -DisplayError
```

```Output
DayOfWeek  $_ / $null
--------- ------------
Wednesday #ERR
```

```powershell
Get-Date | Format-Table DayOfWeek,{ $_ / $null } -ShowError
```

```Output
DayOfWeek  $_ / $null
--------- ------------
Wednesday

InvalidArgument: Failed to evaluate expression " $_ / $null ".
```

## PARAMETERS

### -AutoSize

Indicates that the cmdlet adjusts the column size and number of columns based on the width of the
data. By default, the column size and number are determined by the view.

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

### -DisplayError

Indicates that the cmdlet displays errors on the command line. This parameter can be used as a
debugging aid when you're formatting expressions in a `Format-Table` command and need to
troubleshoot the expressions.

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

### -Expand

Specifies the format of the collection object and the objects in the collection. This parameter is
designed to format objects that support the
[ICollection](/dotnet/api/system.collections.icollection)
([System.Collections](/dotnet/api/system.collections)) interface. The default value is **EnumOnly**.
The acceptable values for this parameter are as follows:

- **EnumOnly**: Displays the properties of the objects in the collection.
- **CoreOnly**: Displays the properties of the collection object.
- **Both**: Displays the properties of the collection object and the properties of objects in the
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

Indicates that the cmdlet directs the cmdlet to display all the error information. Use with the
**DisplayError** or **ShowError** parameter. By default, when an error object is written to the
error or display streams, only some of the error information is displayed.

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

### -GroupBy

Specifies sorted output in separate tables based on a property value. For example, you can use
**GroupBy** to list services in separate tables based on their status.

Enter an expression or a property. The **GroupBy** parameter expects that the objects are sorted.
Use the `Sort-Object` cmdlet before using `Format-Table` to group the objects.

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

### -HideTableHeaders

Omits the column headings from the table.

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

### -InputObject

Specifies the objects to format. Enter a variable that contains the objects, or type a command or
expression that gets the objects.

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

Specifies the object properties that appear in the display and the order in which they appear. Type
one or more property names, separated by commas, or use a hash table to display a calculated
property. Wildcards are permitted.

If you omit this parameter, the properties that appear in the display depend on the first object's
properties. For example, if the first object has **PropertyA** and **PropertyB** but subsequent
objects have **PropertyA**, **PropertyB**, and **PropertyC**, then only the **PropertyA** and
**PropertyB** headers will display.

The **Property** parameter is optional. You can't use the **Property** and **View** parameters in
the same command.

The value of the **Property** parameter can be a new calculated property. The calculated property can
be a script block or a hash table. Valid key-value pairs are:

- Name (or Label) `<string>`
- Expression - `<string>` or `<script block>`
- FormatString - `<string>`
- Width - `<int32>` - must be greater than `0`
- Alignment - value can be `Left`, `Center`, or `Right`

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

### -RepeatHeader

Repeats displaying the header of a table after every screen full. The repeated header is useful when
the output is piped to a pager such as `less` or `more` or paging with a screen reader.

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

### -ShowError

This parameter sends errors through the pipeline. This parameter can be used as a debugging aid when
you're formatting expressions in a `Format-Table` command and need to troubleshoot the expressions.

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

### -View

Beginning in PowerShell 6, the default views are defined in PowerShell `C#` source code. The
`*.format.ps1xml` files from PowerShell 5.1 and earlier versions don't exist in PowerShell 6 and
later versions.

The **View** parameter lets you specify an alternate format or custom view for the table. You can
use the default PowerShell views or create custom views. For more information about how to create a
custom view, see [about_Format.ps1xml](../Microsoft.PowerShell.Core/About/about_Format.ps1xml.md).

The alternate and custom views for the **View** parameter must use the table format, otherwise,
`Format-Table` fails. If the alternate view is a list, use the `Format-List` cmdlet. If the
alternate view isn't a list or a table, use the `Format-Custom` cmdlet.

You can't use the **Property** and **View** parameters in the same command.

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

### -Wrap

Displays text that exceeds the column width on the next line. By default, text that exceeds the
column width is truncated.

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

You can send any object down the pipeline to `Format-Table`.

## OUTPUTS

### Microsoft.PowerShell.Commands.Internal.Format

`Format-Table` returns format objects that represent the table.

## NOTES

## RELATED LINKS

[about_Calculated_Properties](../Microsoft.PowerShell.Core/About/about_Calculated_Properties.md)

[about_Format.ps1xml](../Microsoft.PowerShell.Core/About/about_Format.ps1xml.md)

[about_Hash_Tables](../Microsoft.PowerShell.Core/About/about_Hash_Tables.md)

[Export-FormatData](Export-FormatData.md)

[Format-Custom](Format-Custom.md)

[Format-Hex](Format-Hex.md)

[Format-List](Format-List.md)

[Format-Wide](Format-Wide.md)

[Get-FormatData](Get-FormatData.md)

[Get-Member](Get-Member.md)

[Get-CimInstance](../CimCmdlets/Get-CimInstance.md)

[Update-FormatData](Update-FormatData.md)

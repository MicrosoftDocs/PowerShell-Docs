---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 10/28/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/out-gridview?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Out-GridView
---
# Out-GridView

## SYNOPSIS
Sends output to an interactive table in a separate window.

## SYNTAX

### PassThru (Default)

```
Out-GridView [-InputObject <PSObject>] [-Title <String>] [-PassThru] [<CommonParameters>]
```

### Wait

```
Out-GridView [-InputObject <PSObject>] [-Title <String>] [-Wait] [<CommonParameters>]
```

### OutputMode

```
Out-GridView [-InputObject <PSObject>] [-Title <String>] [-OutputMode <OutputModeOption>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Out-GridView` cmdlet sends the output from a command to a grid view window where the output is
displayed in an interactive table.

Because this cmdlet requires a user interface, it does not work on Windows Server Core or Windows
Nano Server.

You can use the following features of the table to examine your data:

- Hide, Show, and Reorder Columns
- Sort rows
- Quick Filter
- Add Criteria Filter
- Copy and paste

For full instructions, see the [Notes](#notes) section of this article.

> [!NOTE]
> This cmdlet was reintroduced in PowerShell 7. This cmdlet is only available on Windows systems
> that support the Windows Desktop. For a cross-platform version of this cmdlet, see the
> [GraphicalTools](https://www.powershellgallery.com/packages/Microsoft.PowerShell.GraphicalTools)
> module in the PowerShell Gallery.

## EXAMPLES

### Example 1: Output processes to a grid view

This example gets the processes running on the local computer and sends them to a grid view window.

```powershell
Get-Process | Out-GridView
```

### Example 2: Use a variable to output processes to a grid view

This example also gets the processes running on the local computer and sends them to a grid view window.

```powershell
$P = Get-Process
$P | Out-GridView
```

The output of the `Get-Process` cmdlet is saved in the `$P` variable. Then, `$P` is piped to
`Out-GridView`.

### Example 3: Display a selected properties in a grid view

This example displays selected properties of the running processes in a grid view.

```powershell
Get-Process | Select-Object -Property Name, WorkingSet, PeakWorkingSet |
  Sort-Object -Property WorkingSet -Descending | Out-GridView
```

The output of `Get-Process` is piped to `Select-Object` to select the **Name**, **WorkingSet**, and
**PeakWorkingSet** properties. Another pipeline operator sends the filtered objects to the
`Sort-Object` cmdlet to sort them in descending order by the value of the **WorkingSet** property.
Then, the sorted results are piped to `Out-GridView`. You can now use the features of the grid view
to search, sort, and filter the data.

### Example 4: Save output to a variable, and then output a grid view

This example saves cmdlet output in a variable then sends it to `Out-GridView`.

```powershell
($A = Get-ChildItem -Path $PSHOME -Recurse) | Out-GridView
```

`Get-ChildItem` gets all the files in the PowerShell installation directory and its subdirectories
using the the `$PSHOME` automatic variable. The parentheses in the command establish the order of
operations. As a result, the output from the `Get-ChildItem` command is saved in the `$A` variable
before it is sent to `Out-GridView`.

### Example 5: Output processes for a specified computer to a grid view

This example displays the processes that are running on the Server01 computer in a grid view window.

```powershell
Get-Process -ComputerName "Server01" | ogv -Title "Processes - Server01"
```

The examle uses `ogv`, which is the alias for the `Out-GridView` cmdlet. The **Title** parameter
specifies the window title.

### Example 6: Output data from remote computers to a grid view

This example shows how to send data collected from remote computers to `Out-GridView`.

```powershell
Invoke-Command -ComputerName S1, S2, S3 -ScriptBlock {Get-Culture} | Out-GridView
```

`Invoke-Command` runs `Get-Culture` on three remote computers. The resulting data is piped to
`Out-GridView`. Notice that the script block that runs on the remote computer does not include the
`Out-GridView` command. If it did, the command would fail when it tried to open a grid view window
on each of the remote computers.

### Example 7: Pass multiple items through `Out-GridView`

This example lets you select multiple processes from the `Out-GridView` window. The processes that
you select are passed to the `Export-Csv` command and written to the `ProcessLog.csv` file.

```powershell
Get-Process | Out-GridView -PassThru | Export-Csv -Path .\ProcessLog.csv
```

The **PassThru** parameter of `Out-GridView` lets you send multiple items down the pipeline. The
**PassThru** parameter is equivalent to using the **Multiple** value of the **OutputMode**
parameter.

### Example 8: Create a Windows shortcut to `Out-GridView`

This example shows how to use the **Wait** parameter of `Out-GridView` to create a Windows shortcut
to the `Out-GridView` window.

```powershell
pwsh -Command "Get-Service | Out-GridView -Wait"
```

This command line can be used in a Windows shortcut. Without the **Wait** parameter, PowerShell
would exit as soon as the `Out-GridView` window opened, which would close the `Out-GridView` window
almost immediately.

## PARAMETERS

### -InputObject

Specifies object that the cmdlet accepts as input for `Out-GridView`.

When you use the **InputObject** parameter to send a collection of objects to `Out-GridView`,
`Out-GridView` treats the collection as one collection object, and it displays one row that
represents the collection. To display the each object in the collection, use a pipeline operator
(`|`) to send objects to `Out-GridView`.

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

### -OutputMode

Specifies the items that the interactive window sends down the pipeline as input to other commands.
By default, this cmdlet does not generate any output. To send items from the interactive window down
the pipeline, click to select the items and then click OK.

The values of this parameter determine how many items you can send down the pipeline.

- None.  No items. This is the default value.
- Single. Zero items or one item. Use this value when the next command can take only one input
  object.
- Multiple. Zero, one, or many items. Use this value when the next command can take multiple input
  objects. This value is equivalent to the **Passthru** parameter.

```yaml
Type: Microsoft.PowerShell.Commands.OutputModeOption
Parameter Sets: OutputMode
Aliases:
Accepted values: None, Single, Multiple

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru

Indicates that the cmdlet sends items from the interactive window down the pipeline as input to
other commands. By default, this cmdlet does not generate any output. This parameter is equivalent
to using the **Multiple** value of the **OutputMode** parameter.

To send items from the interactive window down the pipeline, click to select the items and then
click OK. Shift-click and Ctrl-click are supported.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: PassThru
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title

Specifies the text that appears in the title bar of the `Out-GridView` window. By default, the title
bar displays the command that invokes `Out-GridView`.

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

### -Wait

Indicates that the cmdlet suppresses the command prompt and prevents Windows PowerShell from closing
until the `Out-GridView` window is closed. By default, the command prompt returns when the
`Out-GridView` window opens.

This feature lets you use the `Out-GridView` cmdlets in Windows shortcuts. When `Out-GridView` is
used in a shortcut without the **Wait** parameter, the `Out-GridView` window appears only
momentarily before PowerShell closes.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Wait
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

You can send any object to this cmdlet.

## OUTPUTS

### None

Normally, `Out-GridView` does not return any objects. When using the **PassThru** parameter, the
objects representing the selected rows are returned to the pipeline.

## NOTES

This cmdlet is only available on Windows platforms.

You cannot use a remote command to open a grid view window on another computer.

The command output that you send to `Out-GridView` cannot be formatted using the `Format` cmdlets,
such as `Format-Table` or `Format-Wide` cmdlets. To select properties, use the `Select-Object`
cmdlet.

Deserialized output from remote commands might not be formatted correctly in the grid view window.

**Keyboard Shortcuts for** `Out-GridView`

|              Use this key:              |                                   To perform this action:                                    |
| --------------------------------------- | -------------------------------------------------------------------------------------------- |
| <kbd>Tab</kbd>                          | Moves the cursor from the **Filter** box to the **Add criteria** menu to the table and back. |
| <kbd>UpArrow</kbd>                      | Move up one row. Moves to column headers from first row of data.                             |
| <kbd>DownArrow</kbd>                    | Move down one row.                                                                           |
| <kbd>LeftArrow</kbd>                    | In column header row, move left one column.                                                  |
| <kbd>RightArrow</kbd>                   | In column header row, move right one column.                                                 |
| <kbd>ContextMenuKey</kbd>               | In column header row, displays the Select Columns option.                                    |
| <kbd>Enter</kbd> or <kbd>Spacebar</kbd> | In column header row, sort column data (toggle A-Z, Z-A).                                    |

**How to Use the Grid View Window Features**

**To hide or show a column:**

1. Right-click any column header and click **Select Columns**.
2. In the **Select Columns** dialog box, use the arrow keys to move the columns between the Selected
    columns to the Available columns boxes. Only columns in the **Select Columns** box appear in the
    grid view window.

**To reorder columns:**

You can drag and drop columns into the desired location. Or use the following steps:

1. Right-click any column header and click **Select Columns**.
2. In the **Select Columns** dialog box, use the **Move up** and **Move down** buttons to reorder
   the columns. Columns at the top of the list appear to the left of columns at the bottom of the
   list in the grid view window.

**How to Sort Table Data**

- To sort the data, click a column header.
- To change the sort order, click the column header again. Each time you click the same header,
  the sort order toggles between ascending to descending order. The current order is indicated by
  a triangle in the column header.

**How to Select Table Data**

- To select a row, select the row or use the up or down arrow to navigate to the row.
- To select all rows (except for the header row), press <kbd>CTRL</kbd>+<kbd>A</kbd>.
- To select consecutive rows, press and hold the <kbd>SHIFT</kbd> key while clicking the rows or using the
  arrow keys.
- To select nonconsecutive rows, press the <kbd>CTRL</kbd> key and click to add a row to the selection.
- You cannot select columns, and you cannot select the entire column header row.

**How to Copy Rows**

- To copy one or more rows from the table, select the rows and then press CTRL+C.

  You can paste the data into any text or spreadsheet program. You cannot copy columns or parts of
  rows and you cannot copy the column header row.

**How to Search in the Table (Quick Filter)**

Use the Filter box to search for data in the table. When you type in the box, only items that
include the typed text appear in the table.

- Search for text. To search for text in the table, in the Filter box, type the text to find.
- Search for multiple words. To search for multiple words in the table, type the words separated by
  spaces. `Out-GridView` displays rows that include all the words (logical AND).
- Search for literal phrases. To search for phrases that include spaces or special characters,
  enclose the phrase in quotation marks. `Out-GridView` displays rows that include an exact match
  for the phrase.
- Search in columns. To search for text in one or more columns, use the following format:

  `<column>:<text> [<column>:<text>] ...`

  For example, to find "Net" in the **DisplayName** column, in the **Filter** box, type:

  `displayname:net`

  To find rows with "Net" in the **DisplayName** and **Name** columns, in the **Filter** box, type:

  `displayname:net name:net`

- Turn off search. To display the entire table again, click the red X button in the top right corner
  of the **Filter** box or delete the text from the **Filter** box.

**Use Criteria to Filter the Table**

You can use rules or criteria to determine which items are displayed in the table. Items appear only
when they satisfy all the criteria that you establish. The available criteria are determined by the
properties of the objects displayed in the grid view window and the .NET Framework types of those
properties.

Each criterion has the following format:

`<column> <operator> <value>`

Criteria for different properties are connected by **AND**. Criteria for the same property are
connected by **OR**. You cannot change the logical connectors.

The criteria only affects the display. It does not delete items from the table.

**How to Add Criteria**

1. To display the **Add criteria** menu button, in the upper right corner of the window, click the
   Expand arrow.
2. Click the **Add Criteria** menu button.
3. Click to select columns (properties). You can select one or many properties.
4. When you are finished selecting properties, click the **Add** button.
5. To cancel the additions, click **Cancel**.
6. To add more criteria, click the **Add Criteria** button again.

**How to Edit a Criterion**

- To change an operator, click the blue operator value, and then select a different operator from
  the drop-down list.
- To enter or change a value, type a value in the value box. If you enter a value that is not valid,
  a circular X icon appears. To remove it, change the value.
- To create an **OR** statement, add a criteria with the same property.

**How to Delete Criteria**

- To delete selected criteria, click the red X beside each criterion.
- To delete all criteria, click the **Clear All** button.

## RELATED LINKS

[Out-File](Out-File.md)

[Out-Printer](Out-Printer.md)

[Out-String](Out-String.md)

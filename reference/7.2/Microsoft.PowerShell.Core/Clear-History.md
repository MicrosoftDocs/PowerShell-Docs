---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 05/13/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/clear-history?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Clear-History
---

# Clear-History

## SYNOPSIS
Deletes entries from the PowerShell session command history.

## SYNTAX

### IDParameter (Default)

```
Clear-History [[-Id] <int[]>] [[-Count] <int>] [-Newest] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### CommandLineParameter

```
Clear-History [[-Count] <int>] [-CommandLine <string[]>] [-Newest] [-WhatIf] [-Confirm]
[<CommonParameters>]
```

## DESCRIPTION

`Clear-History` deletes the command history from a PowerShell session. Each PowerShell session has
its own command history. To display the command history, use the `Get-History` cmdlet.

By default, `Clear-History` deletes the entire command history from a PowerShell session. You can
use parameters with `Clear-History` to delete selected commands.

`Clear-History` does not clear the `PSReadLine` command history file. The `PSReadLine` module stores
a history file that contains every PowerShell command from every PowerShell session. From a
PowerShell prompt, use the up and down arrows on your keyboard to scroll through the command
history. To display the `PSReadLine` configuration for command history, use `Get-PSReadLineOption`.
`PSReadLine` shipped with PowerShell 5.0 and above. For more information, see
[about_PSReadLine](../PSReadLine/About/about_PSReadLine.md).

## EXAMPLES

### Example 1: Delete the command history from a PowerShell session

This command deletes all of the commands from a PowerShell session's history.

```powershell
Get-History
```

```Output
  Id CommandLine
  -- -----------
   1 Set-Location .\Test
   2 Update-Help
   3 Set-Location C:\Test\Logs
   4 Get-Location
```

```powershell
Clear-History
Get-History
```

```Output
  Id CommandLine
  -- -----------
   5 Clear-History
```

The `Get-History` cmdlet displays the PowerShell session's history. `Clear-History` deletes the
entire command history. `Get-History` displays the updated command history and confirms the prior
history was deleted.

### Example 2: Delete the newest commands

This command uses the **Count** and **Newest** parameters to delete the newest commands from a
PowerShell session's history.

```powershell
Get-History
```

```Output
  Id CommandLine
  -- -----------
   1 Set-Location C:\Test\
   2 Get-Command Clear-History
   3 Get-Command Clear-History -Syntax
   4 Get-Command Clear-History -ShowCommandInfo
   5 Get-Help Get-Alias
   6 Get-Command Get-ChildItem -Syntax
   7 Get-Help Clear-History
   8 Set-Location C:\Test\Logs
   9 Get-Help Get-Variable
  10 Get-Help Get-ChildItem
```

```powershell
Clear-History -Count 5 -Newest
Get-History
```

```Output
  Id CommandLine
  -- -----------
   1 Set-Location C:\Test\
   2 Get-Command Clear-History
   3 Get-Command Clear-History -Syntax
   4 Get-Command Clear-History -ShowCommandInfo
   5 Get-Help Get-Alias
  11 Clear-History -Count 5 -Newest
```

The `Get-History` cmdlet displays the PowerShell session's history. `Clear-History` is used to
delete the command history. The **Count** parameter specifies the number of commands to delete,
inclusive of the specified **Id**. The **Newest** parameter specifies that the newest commands are
cleared from the history. `Get-History` displays the updated command history and confirms that the
five newest commands were deleted, **Id 6** - **Id 10**.

### Example 3: Delete commands that match specific criteria

This command deletes commands that match specific criteria defined by the **CommandLine** parameter.

```powershell
Get-History
```

```Output
  Id CommandLine
  -- -----------
   1 Set-Location C:\Test\
   2 Get-Command Clear-History
   3 Get-Command Clear-History -Syntax
   4 Get-Command Clear-History -ShowCommandInfo
   5 Get-Help Get-Alias
   6 Get-Command Get-ChildItem -Syntax
   7 Get-Help Clear-History
```

```powershell
Clear-History -CommandLine *Help*, *Syntax
Get-History
```

```Output
  Id CommandLine
  -- -----------
   1 Set-Location C:\Test\
   2 Get-Command Clear-History
   4 Get-Command Clear-History -ShowCommandInfo
   8 Clear-History -CommandLine *Help*, *Syntax
```

The `Get-History` cmdlet displays the PowerShell session's history. `Clear-History` deletes the
command history. The **CommandLine** parameter specifies commands that contain **Help** or end with
**Syntax**. `Get-History` displays the updated command history and confirms that commands **Id 3**,
**Id 5**, **Id 6**, and **Id 7** were deleted.

### Example 4: Delete commands by Id number

This command deletes specific history items using the **Id**. To delete multiple commands, submit a
comma-separated list of **Id** numbers.

```powershell
Get-History
```

```Output
  Id CommandLine
  -- -----------
   1 Set-Location C:\Test\
   2 Get-History
   3 Get-Help Get-Alias
   4 Get-Command Clear-History
   5 Get-Command Clear-History -Syntax
   6 Get-Command Clear-History -ShowCommandInfo
```

```powershell
Clear-History -Id 3, 5
Get-History
```

```Output
  Id CommandLine
  -- -----------
   1 Set-Location C:\Test\
   2 Get-History
   4 Get-Command Clear-History
   6 Get-Command Clear-History -ShowCommandInfo
   7 Get-History
   8 Clear-History -Id 3, 5
```

The `Get-History` cmdlet displays the PowerShell session's history. `Clear-History` deletes the
command history. The **Id** parameter specifies which commands to delete. `Get-History` displays the
updated command history and confirms that **Id 3** and **Id 5** were deleted.

### Example 5: Delete commands by Id number and count

This command uses the **Id** and **Count** parameters to delete command history. Commands are
deleted from the specified **Id** in reverse order, newest to oldest.

```powershell
Get-History
```

```Output
  Id CommandLine
  -- -----------
   1 Set-Location C:\Test\
   2 Get-Command Clear-History
   3 Get-Command Clear-History -Syntax
   4 Get-Command Clear-History -ShowCommandInfo
   5 Get-Help Get-Alias
   6 Get-Command Get-ChildItem -Syntax
   7 Get-Help Clear-History
   8 Set-Location C:\Test\Logs
   9 Get-Help Get-Variable
  10 Get-Help Get-ChildItem
```

```powershell
Clear-History -Id 7 -Count 5
Get-History
```

```Output
  Id CommandLine
  -- -----------
   1 Set-Location C:\Test\
   2 Get-Command Clear-History
   8 Set-Location C:\Test\Logs
   9 Get-Help Get-Variable
  10 Get-Help Get-ChildItem
  11 Clear-History -Id 7 -Count 5
```

The `Get-History` cmdlet displays the PowerShell session's history. `Clear-History` deletes the
command history. The **Id** parameter specifies to begin with **Id 7**. The **Count** parameter
specifies to delete five commands, inclusive of the specified **Id**. `Get-History` displays the
updated command history and confirms that five commands were deleted, **Id 3** - **Id 7**.

## PARAMETERS

### -CommandLine

Deletes command history from a PowerShell session. The string must be an exact match or use
wildcards to match commands in the PowerShell session history displayed by `Get-History`. If you
enter more than one string, `Clear-History` deletes commands that match any of the strings. The
**CommandLine** parameter can be used with **Count**.

For strings with a space, use single quotations. For more information, see [about_Quoting_Rules](About/about_Quoting_Rules.md).

```yaml
Type: System.String[]
Parameter Sets: CommandLineParameter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Count

Specifies the number of history entries that `Clear-History` deletes. Commands are deleted in order,
beginning with the oldest entry in the history.

The **Count** and **Id** parameters can be used together. The **Count** parameter specifies the
number of commands to delete, inclusive of the specified **Id**. Beginning at the specified **Id**,
commands are deleted in reverse sequential order. For example, if the **Id** is 30 and the **Count**
is 10, `Clear-History` deletes items 21 through 30.

The **Count** and **CommandLine** parameters can be used together. **Count** specifies the number of
commands to delete that match **CommandLine** parameter value. The commands are deleted in
sequential order.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

Specifies the command history **Id** that `Clear-History` deletes. To display **Id** numbers, use
the `Get-History` cmdlet. The **Id** numbers are sequential and commands keep their **Id** number
throughout a PowerShell session. The **Id** parameter can be used with **Count** and **Newest**.

```yaml
Type: System.Int32[]
Parameter Sets: IDParameter
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Newest

When the **Newest** parameter is used, `Clear-History` deletes the newest entries in the history. By
default, `Clear-History` deletes the oldest entries in the history.

The **Newest** parameter can be used with **Id** and **Count**. The **Count** parameter specifies
the number of commands to delete, inclusive of the specified **Id**. Beginning at the specified
**Id**, commands are deleted in sequential order. For example, if the **Id** is 30 and the **Count**
is 10, `Clear-History` deletes items 30 through 39.

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

### -Confirm

Prompts you for confirmation before running the `Clear-History` cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the `Clear-History` cmdlet runs. The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

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
[about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### None

You cannot pipe objects to `Clear-History`.

## OUTPUTS

### None

`Clear-History` does not generate any output.

## NOTES

The PowerShell session history is a list of the commands entered during a PowerShell session. You
can view the history, add and delete commands, and run commands from the history. For more
information, see [about_History](About/about_History.md).

The session history is managed separately from the history maintained by the **PSReadLine** module.
Both histories are available in sessions where **PSReadLine** is loaded. This cmdlet only works with
the session history. For more information see, [about_PSReadLine](../PSReadLine/About/about_PSReadLine.md).

## RELATED LINKS

[about_History](About/about_History.md)

[about_PSReadLine](../PSReadLine/About/about_PSReadLine.md)

[about_Quoting_Rules](About/about_Quoting_Rules.md)

[Add-History](Add-History.md)

[Get-History](Get-History.md)

[Invoke-History](Invoke-History.md)

[Get-PSReadLineOption](/powershell/module/psreadline/get-psreadlineoption)

[Set-PSReadLineOption](/powershell/module/psreadline/set-psreadlineoption)


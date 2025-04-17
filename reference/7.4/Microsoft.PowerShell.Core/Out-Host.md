---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 04/17/2025
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/out-host?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Out-Host
---

# Out-Host

## SYNOPSIS
Sends output to the command line.

## SYNTAX

### All

```
Out-Host [-Paging] [-InputObject <PSObject>] [<CommonParameters>]
```

## DESCRIPTION

The `Out-Host` cmdlet sends output to the PowerShell host for display. The host displays the output
at the command line. Because `Out-Host` is the default, you don't have to specify it unless you want
to use its parameters.

`Out-Host` passes the output of the pipeline to the host executing the command. `Out-Host` ignores
ANSI escape sequences. The escape sequences are handled by the host. `Out-Host` passes ANSI escape
sequences to the host without trying to interpret or change them.

## EXAMPLES

### Example 1: Display output one page at a time

This example displays the system processes one page at a time.

```powershell
Get-Process | Out-Host -Paging
```

```Output
NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
     30    24.12      36.95      15.86   21004  14 ApplicationFrameHost
     55    24.33      60.48      10.80   12904  14 BCompare
<SPACE> next page; <CR> next line; Q quit
      9     4.71       8.94       0.00   16864  14 explorer
<SPACE> next page; <CR> next line; Q quit
```

`Get-Process` gets the system processes and sends the objects down the pipeline. `Out-Host` uses the
**Paging** parameter to display one page of data at a time.

### Example 2: Use a variable as input

This example uses objects stored in a variable as the input for `Out-Host`.

```powershell
$io = Get-History
Out-Host -InputObject $io
```

`Get-History` gets the PowerShell session's history, and stores the objects in the `$io` variable.
`Out-Host` uses the **InputObject** parameter to specify the `$io` variable and displays the
history.

## PARAMETERS

### -InputObject

Specifies the objects that are written to the console. Enter a variable that contains the objects,
or type a command or expression that gets the objects.

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

### -Paging

Indicates that `Out-Host` displays one page of output at a time. The page size is determined by the
characteristics of the host.

After outputting the first page, the command waits for user input before the remaining pages are
displayed. Press the <kbd>Spacebar</kbd> to display the next page of output or the <kbd>Enter</kbd>
key to view the next line of output. Press <kbd>Q</kbd> to quit.

Using **Paging** is similar to using the **more** command.

> [!NOTE]
> The **Paging** parameter isn't supported by the PowerShell ISE host.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

You can pipe any object to this cmdlet.

## OUTPUTS

### None

This cmdlet returns no output. It sends objects to the host for display.

## NOTES

PowerShell includes the following aliases for `Out-Host`:

- All platforms:
  - `oh`

Not all PowerShell hosts support the **Paging** parameter. For example, if you use the **Paging**
parameter in the Windows PowerShell ISE, the following error is displayed:

> out-lineoutput : The method or operation is not implemented.

The cmdlets that contain the **Out** verb, `Out-`, don't format objects. They render objects and
send them to the specified display destination. If you send an unformatted object to an `Out-`
cmdlet, the cmdlet sends it to a formatting cmdlet before rendering it.

The `Out-` cmdlets don't read input from files. To send data to an `Out-` cmdlet, use the pipeline
to send data to the cmdlet. Or, you can store data in a variable and use the **InputObject**
parameter to pass the data to the cmdlet.

`Out-Host` sends data to the host only. Tt doesn't produce output objects to the pipeline. If you
pipeline the output of `Out-Host` to the `Get-Member` cmdlet, `Get-Member` reports that no objects
have been specified.

## RELATED LINKS

[Clear-Host](Clear-Host.md)

[Out-Default](Out-Default.md)

[Out-File](../Microsoft.PowerShell.Utility/Out-File.md)

[Out-Null](Out-Null.md)

[Out-Printer](../Microsoft.PowerShell.Utility/Out-Printer.md)

[Out-String](../Microsoft.PowerShell.Utility/Out-String.md)

[Write-Host](../Microsoft.PowerShell.Utility/Write-Host.md)

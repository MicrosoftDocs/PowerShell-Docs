---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 10/28/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/out-printer?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Out-Printer
---

# Out-Printer

## SYNOPSIS
Sends output to a printer.

## SYNTAX

```
Out-Printer [[-Name] <String>] [-InputObject <PSObject>] [<CommonParameters>]
```

## DESCRIPTION

The `Out-Printer` cmdlet sends output to the default printer or to an alternate printer, if one is
specified.

> [!NOTE]
> This cmdlet was reintroduced in PowerShell 7. This cmdlet is only available on Windows systems
> that support the Windows Desktop.

## EXAMPLES

### Example 1 - Send a file to be printed on the default printer

This example shows how to print a file, even though `Out-Printer` does not have a **Path**
parameter.

```powershell
Get-Content -Path ./readme.txt | Out-Printer
```

`Get-Content`gets the contents of the `readme.txt` file in the current directory and pipes it to
`Out-Printer`, which sends it to the default printer.

### Example 2: Print a string to a remote printer

This example prints `Hello, World` to the **Prt-6B Color** printer on Server01.

```powershell
"Hello, World" | Out-Printer -Name "\\Server01\Prt-6B Color"
```

The **Name** parameter selects a specific printer, rather than the default.

### Example 3 - Print a help topic to the default printer

This example prints the full version of the Help topic for `Get-CimInstance`.

```powershell
$H = Get-Help -Full Get-CimInstance
Out-Printer -InputObject $H
```

`Get-Help` gets the full version of the Help topic for `Get-CimInstance` and stores it in the `$H`
variable. The **InputObject** parameter passes the value of `$H` to `Out-Printer`.

## PARAMETERS

### -InputObject

Specifies the objects to be sent to the printer. Enter a variable that contains the objects, or type
a command or expression that gets the objects.

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

### -Name

Sends the output to the specified printer. The parameter name **Name** is optional.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: PrinterName

Required: False
Position: 0
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

You can pipe any object to `Out-Printer`.

## OUTPUTS

### None

`Out-Printer` does not return any objects.

## NOTES

This cmdlet is only available on Windows platforms.

The cmdlets that contain the `Out` verb do not format objects. They just render them and send them
to the specified display destination. If you send an unformatted object to an `Out` cmdlet, the
cmdlet sends it to a formatting cmdlet before rendering it.

`Out-Printer` sends data to the printer, but does not emit any output objects to the pipeline. If
you pipe the output of `Out-Printer` to `Get-Member`, `Get-Member` reports that no objects have been
specified.

## RELATED LINKS

[Out-File](Out-File.md)

[Out-String](Out-String.md)

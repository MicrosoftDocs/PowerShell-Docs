---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 02/07/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/out-default?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Out-Default
---
# Out-Default

## SYNOPSIS
Sends the output to the default formatter and to the default output cmdlet.

## SYNTAX

```
Out-Default [-Transcript] [-InputObject <PSObject>] [<CommonParameters>]
```

## DESCRIPTION

PowerShell automatically adds `Out-Default` to the end of every pipeline. `Out-Default` decides how
to format and output the object stream. If the object stream is a stream of strings, `Out-Default`
pipes these directly to `Out-Host` which calls the appropriate APIs provided by the host. If the
object stream does not contain strings, `Out-Default` inspects the object to determine what to do.
First it looks at the object type and determines whether there is a registered _view_ for this
object type.

PowerShell defines an XML schema and a mechanism (the `Update-FormatData` cmdlet) where anyone can
register views for an object type. You can specify **wide**, **list**, **table**, or **custom**
views for any object type. The views specify which properties to display and how they should be
displayed. If a view is registered, it defines which formatter to use. So if the registered view is
a **table** view, `Out-Default` streams the objects to `Format-Table | Out-Host`. `Format-Table`
transforms the objects into a stream of Formatting records (driven by the data in the view
definition) and `Out-Host` transforms the formatting records into calls on the Host interface.

This cmdlet isn't intended to be used by the end user. Other cmdlets are recommended for controlling
output like [Out-Host](Out-Host.md) or using `Format-*` cmdlets and the [Format.ps1xml](About/about_format.ps1xml.md)
file to control formatting.

## EXAMPLES

### Example 1

While this cmdlet is not intended to be run directly by the end user, it can be.

```powershell
Get-Process | Select-Object -First 5 | Out-Default
```

```Output
 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
     12     2.56       5.20       0.00    7376   0 aesm_service
     48    34.32      18.10      26.64    9320  13 AlertusDesktopAlert
     24    13.97      12.74       0.77   12656  13 ApplicationFrameHost
      8     1.79       4.41       0.00    8180   0 AppVShNotify
      9     1.99       5.07       0.19   19320  13 AppVShNotify
```

No error is thrown when using `Out-Default` but the output isn't changed if it's not explicitly
called.

## PARAMETERS

### -InputObject

Accepts input to the cmdlet.

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

### -Transcript

Determines whether the output should be sent to PowerShell's transcription services.

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
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Format-Custom](../Microsoft.PowerShell.Utility/Format-Custom.md)

[Format-List](../Microsoft.PowerShell.Utility/Format-List.md)

[Format-Table](../Microsoft.PowerShell.Utility/Format-Table.md)

[Format-Wide](../Microsoft.PowerShell.Utility/Format-Wide.md)

[about_Format.ps1xml](About/about_Format.ps1xml.md)

[How PowerShell Formatting and Outputting REALLY works](https://devblogs.microsoft.com/powershell/how-powershell-formatting-and-outputting-really-works/)

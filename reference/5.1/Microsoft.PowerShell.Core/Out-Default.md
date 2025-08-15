---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 04/17/2025
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/out-default?view=powershell-5.1&WT.mc_id=ps-gethelp
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

PowerShell automatically adds `Out-Default` to the end of every top-level interactive pipeline.
`Out-Default` passes the objects it receives to the PowerShell format system. Then, it writes the
formatted output to the console. This cmdlet isn't intended to be used by the end user.

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

When you use this parameter, the output is only sent to the PowerShell transcript.

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

## OUTPUTS

## NOTES

## RELATED LINKS

[Format-Custom](../Microsoft.PowerShell.Utility/Format-Custom.md)

[Format-List](../Microsoft.PowerShell.Utility/Format-List.md)

[Format-Table](../Microsoft.PowerShell.Utility/Format-Table.md)

[Format-Wide](../Microsoft.PowerShell.Utility/Format-Wide.md)

[about_Format.ps1xml](About/about_Format.ps1xml.md)

[How PowerShell Formatting and Outputting REALLY works](https://devblogs.microsoft.com/powershell/how-powershell-formatting-and-outputting-really-works/)

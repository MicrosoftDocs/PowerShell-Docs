---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821531
external help file:  Microsoft.PowerShell.Commands.Diagnostics.dll-Help.xml
title:  New-WinEvent
---

# New-WinEvent

## SYNOPSIS
Creates an ETW event for the specified event provider.

## SYNTAX

```
New-WinEvent [-ProviderName] <String> [-Id] <Int32> [-Version <Byte>] [[-Payload] <Object[]>]
 [<CommonParameters>]
```

## DESCRIPTION
The **New-WinEvent** cmdlet creates an Event Tracing for Windows (ETW) event for an event provider.
You can use this cmdlet to add events to ETW channels from Windows PowerShell.

## EXAMPLES

### Example 1: Create an ETW event for a specified provider
```
PS C:\> New-WinEvent -ProviderName Microsoft-Windows-PowerShell -Id 45090 -Payload @("Workflow", "Running")
```

This command uses the **New-WinEvent** cmdlet to create event 45090 for the Microsoft-Windows-PowerShell provider.

## PARAMETERS

### -Id


```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Payload


```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProviderName


```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Version


```yaml
Type: Byte
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES
* After the provider writes the even to an event log, you can use the Get-WinEvent cmdlet to get the event from the event log.
* For information about Event Tracing for Windows, see Improve Debugging And Performance Tuning With ETWhttp://msdn.microsoft.com/en-us/magazine/cc163437.aspx (http://msdn.microsoft.com/en-us/magazine/cc163437.aspx).

## RELATED LINKS

[Get-WinEvent](Get-WinEvent.md)
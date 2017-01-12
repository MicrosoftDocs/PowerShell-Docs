---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  New WinEvent
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/?LinkId=821531
external help file:   Microsoft.PowerShell.Commands.Diagnostics.dll-Help.xml
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
Specifies an event ID that was registered through an instrumentation manifest.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Payload
Specifies the message for the event.
When the event is written to an event log, the payload is stored in the **Message** property of the event object.

When the specified payload does not match the payload in the event definition, Windows PowerShell generates a warning, but the command still succeeds.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProviderName
Specifies the event provider that writes the event to an event log, such as Microsoft-Windows-PowerShell.
An ETW event provider is a logical entity that writes events to ETW sessions.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Version
Specifies the version number of the event.
Type the event number.
Windows PowerShell converts the number to the required Byte type.

This parameter lets you specify an event when different versions of the same event are defined.

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


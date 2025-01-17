---
external help file: Microsoft.PowerShell.Commands.Diagnostics.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Diagnostics
ms.date: 12/12/2022
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.diagnostics/new-winevent?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: New-WinEvent
---

# New-WinEvent

## SYNOPSIS
Creates a new Windows event for the specified event provider.

## SYNTAX

```
New-WinEvent [-ProviderName] <String> [-Id] <Int32> [-Version <Byte>] [[-Payload] <Object[]>]
 [<CommonParameters>]
```

## DESCRIPTION

> **This cmdlet is only available on the Windows platform.**

The `New-WinEvent` cmdlet creates an Event Tracing for Windows (ETW) event for an event provider.
You can use this cmdlet to add events to ETW channels from PowerShell.

## EXAMPLES

### Example 1 - Create a new event

```powershell
New-WinEvent -ProviderName Microsoft-Windows-PowerShell -Id 45090 -Payload @("Workflow", "Running")
```

This command uses the `New-WinEvent` cmdlet to create event 45090 for the
Microsoft-Windows-PowerShell provider.

### Example 2 - Get the template for an event

In this example, `Get-WinEvent` is used to get the template for event id 8007 from the Group Policy
event provider. Notice that the event has two formats.

In version 0, the **IsMachine** field is a boolean value. In version 1, the **IsMachine** field is
an unsigned integer value.

```powershell
(Get-WinEvent -ListProvider Microsoft-Windows-GroupPolicy).Events | Where-Object Id -eq 8007
```

```Output
Id          : 8007
Version     : 0
LogLink     : System.Diagnostics.Eventing.Reader.EventLogLink
Level       : System.Diagnostics.Eventing.Reader.EventLevel
Opcode      : System.Diagnostics.Eventing.Reader.EventOpcode
Task        : System.Diagnostics.Eventing.Reader.EventTask
Keywords    : {}
Template    : <template xmlns="http://schemas.microsoft.com/win/2004/08/events">
                <data name="PolicyElaspedTimeInSeconds" inType="win:UInt32" outType="xs:unsignedInt"/>
                <data name="ErrorCode" inType="win:UInt32" outType="win:HexInt32"/>
                <data name="PrincipalSamName" inType="win:UnicodeString" outType="xs:string"/>
                <data name="IsMachine" inType="win:Boolean" outType="xs:boolean"/>
                <data name="IsConnectivityFailure" inType="win:Boolean" outType="xs:boolean"/>
              </template>

Description : Completed periodic policy processing for user %3 in %1 seconds.

Id          : 8007
Version     : 1
LogLink     : System.Diagnostics.Eventing.Reader.EventLogLink
Level       : System.Diagnostics.Eventing.Reader.EventLevel
Opcode      : System.Diagnostics.Eventing.Reader.EventOpcode
Task        : System.Diagnostics.Eventing.Reader.EventTask
Keywords    : {}
Template    : <template xmlns="http://schemas.microsoft.com/win/2004/08/events">
                <data name="PolicyElaspedTimeInSeconds" inType="win:UInt32" outType="xs:unsignedInt"/>
                <data name="ErrorCode" inType="win:UInt32" outType="win:HexInt32"/>
                <data name="PrincipalSamName" inType="win:UnicodeString" outType="xs:string"/>
                <data name="IsMachine" inType="win:UInt32" outType="xs:unsignedInt"/>
                <data name="IsConnectivityFailure" inType="win:Boolean" outType="xs:boolean"/>
              </template>

Description : Completed periodic policy processing for user %3 in %1 seconds.
```

The **Description** property contains the message that gets written to the event log. The `%3` and
`%1` value are placeholders for the values passed into the template. The `%3` string is replace with
the value passed to the **PrincipalSamName** field. The `%1` string is replaced withe value passed
to the **PolicyElaspedTimeInSeconds** field.

### Example 3 - Create a new event using a versioned template

This example shows how to create an event using a specific template version.

```powershell
$Payload = @(300, [uint32]'0x8001011f', $env:USERNAME, 0, 1)
New-WinEvent -ProviderName Microsoft-Windows-GroupPolicy -Id 8007 -Version 1 -Payload $Payload
Get-winEvent -ProviderName Microsoft-Windows-GroupPolicy -MaxEvents 1
```

```Output
   ProviderName: Microsoft-Windows-GroupPolicy

TimeCreated            Id LevelDisplayName Message
-----------            -- ---------------- -------
5/4/2022 8:40:24 AM  8007 Information      Completed periodic policy processing for user User1 in 300 seconds
```

If the values in the payload do not match the types in the template, the event is logged but the
payload contains an error.

## PARAMETERS

### -Id

Specifies an event Id that is registered in the event provider.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Payload

The payload is an array of values passed as positional arguments to the event template. The values
are inserted into the template to construct the message for the event. Events can have multiple
template versions that use different formats.

If the values in the payload do not match the types in the template, the event is logged but the
payload contains an error.

```yaml
Type: System.Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProviderName

Specifies the event provider that writes the event to an event log, such as
"Microsoft-Windows-PowerShell". An ETW event provider is a logical entity that writes events to ETW
sessions.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Version

Specifies the version number of the event. PowerShell converts the number to the required Byte type.
The value specifies the version of the event when different versions of the same event are defined.

```yaml
Type: System.Byte
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

### None

You can't pipe objects to this cmdlet.

## OUTPUTS

### None

This cmdlet returns no output.

## NOTES

After the provider writes the event to an eventlog, you can use the `Get-WinEvent` cmdlet to get the
event from the event log.

## RELATED LINKS

[Get-WinEvent](Get-WinEvent.md)

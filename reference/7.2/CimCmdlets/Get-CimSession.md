---
external help file: Microsoft.Management.Infrastructure.CimCmdlets.dll-Help.xml
Locale: en-US
Module Name: CimCmdlets
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/cimcmdlets/get-cimsession?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-CimSession
---

# Get-CimSession

## SYNOPSIS
Gets the CIM session objects from the current session.

## SYNTAX

### ComputerNameSet (Default)

```
Get-CimSession [[-ComputerName] <String[]>] [<CommonParameters>]
```

### SessionIdSet

```
Get-CimSession [-Id] <UInt32[]> [<CommonParameters>]
```

### InstanceIdSet

```
Get-CimSession -InstanceId <Guid[]> [<CommonParameters>]
```

### NameSet

```
Get-CimSession -Name <String[]> [<CommonParameters>]
```

## DESCRIPTION

By default, the cmdlet gets all of the CIM sessions created in the current PowerShell session. You
can use the parameters of `Get-CimSession` to get the sessions that are for particular computers, or
you can identify sessions by their names or other identifiers. `Get-CimSession` does not get CIM
sessions that were created in other PowerShell sessions or that were created on other computers.

For more information about CIM sessions, see [about_CimSession](../Microsoft.PowerShell.Core/About/about_CimSession.md).

## EXAMPLES

### Example 1: Get CIM sessions from the current PowerShell session

This example creates CIM sessions using [New-CimSession](New-CimSession.md), and then gets the CIM
sessions using `Get-CimSession`.

```powershell
New-CimSession -ComputerName Server01,Server02
Get-CimSession
```

```Output
Id           : 1
Name         : CimSession1
InstanceId   : d1413bc3-162a-4cb8-9aec-4d2c61253d59
ComputerName : Server01
Protocol     : WSMAN

Id           : 2
Name         : CimSession2
InstanceId   : c0095981-52c5-4e7f-a5bb-c4c680541710
ComputerName : Server02
Protocol     : WSMAN
```

### Example 2: Get the CIM sessions to a specific computer

This example gets the CIM sessions that are connected to the computer named **Server02**.

```powershell
Get-CimSession -ComputerName Server02
```

```Output
Id           : 2
Name         : CimSession2
InstanceId   : c0095981-52c5-4e7f-a5bb-c4c680541710
ComputerName : Server02
Protocol     : WSMAN
```

### Example 3: Get a list of CIM sessions and then format the list

This example gets all CIM sessions in the current PowerShell session and displays a table containing
only the **ComputerName** and **InstanceID** properties.

```powershell
Get-CimSession | Format-Table -Property ComputerName,InstanceId
```

```Output
ComputerName InstanceId
------------ ----------
Server01     d1413bc3-162a-4cb8-9aec-4d2c61253d59
Server02     c0095981-52c5-4e7f-a5bb-c4c680541710
```

### Example 4: Get all the CIM sessions that have specific names

This example gets all CIM sessions that have names that begin with **serv**.

```powershell
Get-CimSession -ComputerName Serv*
```

```Output
Id           : 1
Name         : CimSession1
InstanceId   : d1413bc-162a-4cb8-9aec-4d2c61253d59
ComputerName : Server01
Protocol     : WSMAN

Id           : 2
Name         : CimSession2
InstanceId   : c0095981-52c5-4e7f-a5bb-c4c680541710
ComputerName : Server02
Protocol     : WSMAN
```

### Example 5: Get a specific CIM session

This example gets the CIM session that has an **Id** of 2.

```powershell
Get-CimSession -ID 2
```

```Output
Id           : 2
Name         : CimSession2
InstanceId   : c0095981-52c5-4e7f-a5bb-c4c680541710
ComputerName : Server02
Protocol     : WSMAN
```

## PARAMETERS

### -ComputerName

Specifies the name of the computer to get CIM sessions connected to. Wildcard characters are
permitted.

```yaml
Type: System.String[]
Parameter Sets: ComputerNameSet
Aliases: CN, ServerName

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -Id

Specifies the identifier of the CIM session to get. For multiple IDs, use commas to separate the IDs
or use the range operator (`..`) to specify a range of IDs. An **Id** is an integer that uniquely
identifies the CIM session within the current PowerShell session.

For more information about the range operator, see [about_Operators](../Microsoft.PowerShell.Core/About/about_Operators.md).

```yaml
Type: System.UInt32[]
Parameter Sets: SessionIdSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InstanceId

Specifies the instance IDs of the CIM session to get.

**InstanceId** is a globally-unique identifier (GUID) that uniquely identifies a CIM session. The
**InstanceId** is unique, even when you have multiple sessions running in PowerShell.

The **InstanceId** is stored in the **InstanceId** property of the object that represents a CIM
session.

```yaml
Type: System.Guid[]
Parameter Sets: InstanceIdSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name

Gets one or more CIM sessions which contain the specified friendly names. Wildcard characters are
permitted.

```yaml
Type: System.String[]
Parameter Sets: NameSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### Microsoft.Management.Infrastructure.CimSession

## NOTES

## RELATED LINKS

[Format-Table](../microsoft.powershell.utility/format-table.md)

[New-CimSession](New-CimSession.md)

[Remove-CimSession](remove-cimsession.md)

[about_CimSession](../Microsoft.PowerShell.Core/About/about_CimSession.md)


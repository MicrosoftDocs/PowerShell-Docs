---
external help file: Microsoft.Management.Infrastructure.CimCmdlets.dll-Help.xml
Module Name: CimCmdlets
online version:
schema: 2.0.0
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
The Get-CimSession cmdlet gets the CIM session objects created in the current Windows PowerShell session.

If used without any parameters, the cmdlet gets all of the CIM sessions created in the current Windows PowerShell session.
You can use the parameters of Get-CimSession to get the sessions that are for particular computers, or you can identify sessions by their names, IDs, or instance IDs.

For more information about Windows PowerShell sessions, see about_CimSessions

## EXAMPLES

### Example 1: Get CIM sessions from the current PowerShell session

By default, Get-CimSession only gets information about the CIM sessions that exist in the current PowerShell session.
Get-CimSession does not get CIM sessions that were created in other PowerShell sessions or that were created on other computers.

```powershell
PS C:\> New-CimSession -ComputerName Server01,Server02

PS C:\> Get-CimSession

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

This command first creates CIM sessions by using New-CimSession, and then gets the CIM sessions by using Get-CimSession.

### Example 2: Get the CIM sessions to a specific computer

```powershell
PS C:\> Get-CimSession -ComputerName Server02

Id           : 2
Name         : CimSession2
InstanceId   : c0095981-52c5-4e7f-a5bb-c4c680541710
ComputerName : Server02
Protocol     : WSMAN
```

This command gets the CIM sessions that are connected to the computer named Server02.

### Example 3: Get a list of CIM sessions and then format the list

```powershell
PS C:\> Get-CimSession | Format-Table -Property ComputerName,InstanceId

ComputerName InstanceId
------------ ----------
Server01     d1413bc3-162a-4cb8-9aec-4d2c61253d59
Server02     c0095981-52c5-4e7f-a5bb-c4c680541710
```

This command gets all of the CIM sessions in the current PowerShell session, and then formats the list in a table containing only the ComputerName and InstanceID parameters.

### Example 4: Get all the CIM sessions that have specific names

```powershell
PS C:\> Get-CimSession -ComputerName Serv*

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

This command gets all of the CIM sessions that have names that begin with the characters serv.

### Example 5: Get a specific CIM session

```powershell
PS C:\> Get-CimSession -ID 2

Id           : 2
Name         : CimSession2
InstanceId   : c0095981-52c5-4e7f-a5bb-c4c680541710
ComputerName : Server02
Protocol     : WSMAN
```

This command gets the CIM session that has an ID of 2.

## PARAMETERS

### -ComputerName

Specifies the name of the computer to get CIM sessions connected to.
Wildcard characters are permitted.

```yaml
Type: String[]
Parameter Sets: ComputerNameSet
Aliases: CN, ServerName

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -Id

Specifies the identifier (ID) of the CIM session to get.
For one or more IDs, use commas to separate the IDs, or use the range operator (..) to specify a range of IDs.

An ID is an integer that uniquely identifies the CIM session in the current PowerShell session.
It is easier to remember and type than InstanceId, but it is unique only within the current PowerShell session.

For more information about the range operator, see [about_Operators](../Microsoft.PowerShell.Core/About/about_Operators.md).

```yaml
Type: UInt32[]
Parameter Sets: SessionIdSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InstanceId

Specifies the instance IDs of the CIM session to get.

InstanceId is a GUID that uniquely identifies a CIM session.
The InstanceId is unique, even when you have multiple sessions running in PowerShell.

The InstanceId is stored in the InstanceId property of the object that represents a CIM session.

```yaml
Type: Guid[]
Parameter Sets: InstanceIdSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Gets one or more CIM sessions which contain the specified friendly names.
Wildcard characters are permitted.

```yaml
Type: String[]
Parameter Sets: NameSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### Microsoft.Management.Infrastructure.CimSession

## NOTES

## RELATED LINKS

[Format-Table](../microsoft.powershell.utility/format-table.md)

[New-CimSession](New-CimSession.md)

[Remove-CimSession](remove-cimsession.md)
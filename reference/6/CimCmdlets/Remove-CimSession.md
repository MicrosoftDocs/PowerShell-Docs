---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
external help file:  Microsoft.Management.Infrastructure.CimCmdlets.dll-Help.xml
---

# Remove-CimSession

## SYNOPSIS
Removes one or more CIM sessions.

## SYNTAX

### CimSessionSet (Default)
```
Remove-CimSession [-CimSession] <CimSession[]> [-WhatIf] [-Confirm]
```

### ComputerNameSet
```
Remove-CimSession [-ComputerName] <String[]> [-WhatIf] [-Confirm]
```

### SessionIdSet
```
Remove-CimSession [-Id] <UInt32[]> [-WhatIf] [-Confirm]
```

### InstanceIdSet
```
Remove-CimSession -InstanceId <Guid[]> [-WhatIf] [-Confirm]
```

### NameSet
```
Remove-CimSession -Name <String[]> [-WhatIf] [-Confirm]
```

## DESCRIPTION
The Remove-CimSession cmdlet removes one or more CIM session objects from the local wps_1 session.

## EXAMPLES

### Example 1: Remove all the CIM sessions
```
PS C:\> Get-CimSession | Remove-CimSession
```

This command retrieves all the available CIM sessions on the local computer using the Get-CimSession cmdlet, and then removes them using the Remove-CimSession.

### Example 2: Remove a specific CIM session
```
PS C:\> Remove-CimSession -Id 5
```

This command removes the CIM session that has an ID value of 5.

### Example 3: Show the list of CIM sessions to remove by using the WhatIf parameterby the  parameter
```
PS C:\>Remove-CimSession -Name a* -WhatIf
```

This command uses the common parameter WhatIf to specify that the removal should not be done, but only output what would happen if it were done.

## PARAMETERS

### -CimSession
Runs the command using the specified CIM session.
Enter a variable that contains the CIM session, or a command that creates or gets the CIM session, such as the New-CimSession or Get-CimSession cmdlets.
For more information, see about_CimSessions.

```yaml
Type: CimSession[]
Parameter Sets: CimSessionSet
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ComputerName
Specifies the name of the computer on which you want to run the CIM operation.
You can specify a fully qualified domain name (FQDN) or a NetBIOS name.

If you specify this parameter, the cmdlet creates a temporary session to the specified computer using the WsMan protocol.

If you do not specify this parameter, the cmdlet performs the operation on the local computer using Component Object Model (COM).

If multiple operations are being performed on the same computer, connecting using a CIM session gives better performance.

```yaml
Type: String[]
Parameter Sets: ComputerNameSet
Aliases: CN, ServerName

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Id
Specifies the ID of the CIM session to remove.
Specify one or more IDs separated by commas, or use the range operator (..) to specify a range of IDs.

An ID is an integer that uniquely identifies the CIM session in the current wps_2 session.
It is easier to remember and type than InstanceId, but it is unique only within the current wps_2 session.

For more information about the range operator, see about_Operators.

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
Specifies the instance ID of the CIM session to remove.

InstanceID is a Globally Unique Identifier (GUID) that uniquely identifies a CIM session.
The InstanceID is unique, even when you have multiple sessions running in wps_2.

The InstanceID is stored in the InstanceID property of the object that represents a CIM session.

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
Specifies the friendly name of the CIM session to remove.
You can use wildcard characters with this parameter.

```yaml
Type: String[]
Parameter Sets: NameSet
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Confirm
psdx_confirmdesc

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
psdx_whatifdesc

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None
This cmdlet accepts no input objects.

## OUTPUTS

### System.Object
This cmdlet returns an object that contains CIM session information.

## NOTES

## RELATED LINKS

[Get-CimSession](Get-CimSession.md)

[New-CimSession](New-CimSession.md)


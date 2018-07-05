---
external help file: Microsoft.Management.Infrastructure.CimCmdlets.dll-Help.xml
Module Name: CimCmdlets
online version:
schema: 2.0.0
---

# Remove-CimSession

## SYNOPSIS
Removes one or more CIM sessions.

## SYNTAX

### CimSessionSet (Default)
```
Remove-CimSession [-CimSession] <CimSession[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ComputerNameSet
```
Remove-CimSession [-ComputerName] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### SessionIdSet
```
Remove-CimSession [-Id] <UInt32[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### InstanceIdSet
```
Remove-CimSession -InstanceId <Guid[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### NameSet
```
Remove-CimSession -Name <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The Remove-CimSession cmdlet removes one or more CIM session objects from the local PowerShell session.

## EXAMPLES

### Example 1: Remove all the CIM sessions

```powershell
PS C:\> Get-CimSession | Remove-CimSession
```

This command retrieves all the available CIM sessions on the local computer using the [Get-CimSession](Get-CimSession.md) cmdlet, and then removes them using the Remove-CimSession.

### Example 2: Remove a specific CIM session

```powershell
PS C:\> Remove-CimSession -Id 5
```

This command removes the CIM session that has an ID value of 5.

### Example 3: Show the list of CIM sessions to remove by using the WhatIf parameter

```powershell
PS C:\>Remove-CimSession -Name a* -WhatIf
```

This command uses the common parameter WhatIf to specify that the removal should not be done, but only output what would happen if it were done.

## PARAMETERS

### -CimSession

Runs the command using the specified CIM session.
Enter a variable that contains the CIM session, or a command that creates or gets the CIM session, such as the [New-CimSession](New-CimSession.md) or [Get-CimSession](Get-CimSession.md) cmdlets.
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

Specifies the name of the computer to remove CIM sessions connected to.
You can specify a fully qualified domain name (FQDN) or a NetBIOS name.

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

An ID is an integer that uniquely identifies the CIM session in the current Windows PowerShell session.
It is easier to remember and type than InstanceId, but it is unique only within the current Windows PowerShell session.

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

Specifies the instance ID of the CIM session to remove.

InstanceId is a Globally Unique Identifier (GUID) that uniquely identifies a CIM session.
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

Prompts you for confirmation before running the cmdlet.

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

Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

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

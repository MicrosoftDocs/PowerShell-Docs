---
external help file: Microsoft.Management.Infrastructure.CimCmdlets.dll-Help.xml
Locale: en-US
Module Name: CimCmdlets
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/cimcmdlets/remove-cimsession?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Remove-CimSession
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

The `Remove-CimSession` cmdlet removes one or more CIM session objects from the local PowerShell
session.

## EXAMPLES

### Example 1: Remove all the CIM sessions

This example retrieves all the available CIM sessions on the local computer using the
[Get-CimSession](Get-CimSession.md) cmdlet, and then removes them using the `Remove-CimSession`.

```powershell
Get-CimSession | Remove-CimSession
```

### Example 2: Remove a specific CIM session

This example removes the CIM session that has an **Id** value of 5.

```powershell
Remove-CimSession -Id 5
```

### Example 3: Show the list of CIM sessions to remove by using the WhatIf parameter

This example uses the common parameter **WhatIf** to specify that the removal should not be done,
but only output what would happen if it were done.

```powershell
Remove-CimSession -Name a* -WhatIf
```

## PARAMETERS

### -CimSession

Specifies the session objects of the CIM sessions to close.

Enter a variable that contains the CIM session, or a command that creates or gets the CIM session,
such as the [`New-CimSession`](New-CimSession.md) or [`Get-CimSession`](Get-CimSession.md) cmdlets.
For more information, see
[about_CimSessions](../Microsoft.PowerShell.Core/About/about_CimSession.md).

```yaml
Type: Microsoft.Management.Infrastructure.CimSession[]
Parameter Sets: CimSessionSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ComputerName

Specifies an array of names of computers. Removes the sessions that connect to the specified
computers. You can specify a fully qualified domain name (FQDN) or a NetBIOS name.

```yaml
Type: System.String[]
Parameter Sets: ComputerNameSet
Aliases: CN, ServerName

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -Id

Specifies the ID of the CIM session to remove. Specify one or more IDs separated by commas, or use
the range operator (`..`) to specify a range of IDs. An **Id** is an integer that uniquely
identifies the CIM session in the current PowerShell session.

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

Specifies the instance ID of the CIM session to remove. **InstanceId** is a Globally Unique
Identifier (GUID) that uniquely identifies a CIM session. The **InstanceId** is unique, even when
you have multiple sessions running in PowerShell.

The **InstanceId** is stored in the **InstanceId** property of the object that represents a CIM session.

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

Specifies the friendly name of the CIM session to remove. You can use wildcard characters with this
parameter.

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

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
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
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
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

This cmdlet accepts no input objects.

## OUTPUTS

### System.Object

This cmdlet returns an object that contains CIM session information.

## NOTES

## RELATED LINKS

[Get-CimSession](Get-CimSession.md)

[New-CimSession](New-CimSession.md)

[about_CimSession](../Microsoft.PowerShell.Core/About/about_CimSession.md)


---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/get-pssessioncapability?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-PSSessionCapability
---
# Get-PSSessionCapability

## SYNOPSIS
Gets the capabilities of a specific user on a constrained session configuration.

## SYNTAX

```
Get-PSSessionCapability [-ConfigurationName] <String> [-Username] <String> [-Full] [<CommonParameters>]
```

## DESCRIPTION

The **Get-PSSessionCapability** cmdlet gets the capabilities of a specific user on a constrained session configuration.
Use this cmdlet to audit customized session configurations for users.

Starting in Windows PowerShell 5.0, you can use the **RoleDefinitions** property in a session configuration (.pssc) file.
Using this property lets you grant users different capabilities on a single constrained endpoint based on group membership.
The **Get-PSSessionCapability** cmdlet reduces complexity when auditing these endpoints by letting you determine the exact capabilities granted to a user.

By default, the **Get-PSSessionCapability** cmdlet returns a list of commands the specified user can run in the specified endpoint.
This is equivalent to the user running **Get-Command** in the specified endpoint.
When run with the *Full* parameter, this cmdlet returns an **InitialSessionState** object.
This object contains details about the PowerShell runspace the specified user would interact with for the specified endpoint.
It includes information such as Language Mode, Execution Policy, and Environmental Variables.

## EXAMPLES

### Example 1: Get commands available for a user

```powershell
Get-PSSessionCapability -ConfigurationName Endpoint1 -Username 'CONTOSO\User'
```

This example returns the commands available to the user CONTOSO\User when connecting to the Endpoint1 constrained endpoint on the local computer.

### Example 2: Get details about a runspace for a user

```powershell
Get-PSSessionCapability -ConfigurationName Endpoint1 -Username 'CONTOSO\User' -Full
```

This example returns details about the runspace the user CONTOSO\User would interact with when connecting to the Endpoint1 constrained endpoint.

## PARAMETERS

### -ConfigurationName

Specifies the constrained session configuration (endpoint) that you are inspecting.

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

### -Full

Indicates that this cmdlet returns the entire initial session state for the specified user at the specified constrained endpoint.

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

### -Username

Specifies the user whose capabilities you are inspecting.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.AliasInfo

### System.Management.Automation.FunctionInfo

### System.Management.Automation.Runspaces.InitialSessionState

## NOTES

## RELATED LINKS

[New-PSRoleCapabilityFile](New-PSRoleCapabilityFile.md)


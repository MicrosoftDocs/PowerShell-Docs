---
external help file: System.Management.Automation.dll-Help.xml
online version: 
schema: 2.0.0
---

# Get-PSSessionCapability
## SYNOPSIS
Gets the capabilities of a specific user on a constrained session configuration.

## SYNTAX

```
Get-PSSessionCapability [-ConfigurationName] <String> [-Username] <String> [-Full]
```

## DESCRIPTION
The Get-PSSessionCapability cmdlet gets the capabilities of a specific user on a constrained session configuration.
This cmdlet is used by system administrators to audit customized session configurations for their users.

Beginning in Windows PowerShell 5.0, you can use the RoleDefinitions property in a session configuration (.pssc) file.
Using this property allows you to grant users different capabilities on a single constrained endpoint based on group membership.
The Get-PSSessionCapability cmdlet reduces complexity when auditing these endpoints by allowing you to determine the exact capabilities granted to a user.

By default, the Get-PSSessionCapability cmdlet returns a list of commands the specified user can run in the specified endpoint.
This is equivalent to the user running Get-Command in the specified endpoint.
When run with the Full parameter, an InitialSessionState object is returned.
This object contains details about the PowerShell runspace the specified user would interact with for the specified endpoint, including information such as Language Mode, Execution Policy, and Environmental Variables.

## EXAMPLES

### 1: ====== EXAMPLE 1 ========
```
PS C:\>Get-PSSessionCapability -ConfigurationName Endpoint1 -Username 'CONTOSO\User'
```

This example returns the commands available to the user "CONTOSO\User" when connecting to the "Endpoint1" constrained endpoint on the local computer.

### 2: ====== EXAMPLE 2 ========
```
PS C:\>Get-PSSessionCapability -ConfigurationName Endpoint1 -Username 'CONTOSO\User' -Full
```

This example returns details about the runspace the user "CONTOSO\User" would interact with when connecting to the "Endpoint1" constrained endpoint.

## PARAMETERS

### -ConfigurationName
Specifies the constrained session configuration (endpoint) you are inspecting.

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

### -Full
Returns the entire initial session state for the specified user at the specified constrained endpoint.

```yaml
Type: SwitchParameter
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
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### System.Management.Automation.AliasInfo

### System.Management.Automation.FunctionInfo

### System.Management.Automation.Runspaces.InitialSessionState

## NOTES

## RELATED LINKS

[New-PSRoleCapabilityFile]()


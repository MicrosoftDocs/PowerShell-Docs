---
ms.date:  17/10/2018
schema: 2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version: 
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  Remove-Alias
---

# Remove-Alias

## SYNOPSIS

Remove aliases for the current session.

## SYNTAX

```
Remove-Alias [-Name] <String[]> [-Scope <String>] [-Force] [<CommonParameters>]
```

## DESCRIPTION

The **Remove-Alias** cmdlet removes an alias in the current PowerShell session.
You must use **Remove-Alias** with **-Force** to remove any aliases with **Constant** or **Read-Only** option.

## EXAMPLES

### Example 1

```powershell
PS C:\> Remove-Alias -Name del
```

This command removes an alias named del that represent the Remove-Item cmdlet.

### Example 2

```powershell
PS C:\> Get-Alias | Where-Object { $_.Options -ne "Constant" } | Remove-Alias -Force
```

This command get all aliases except for alias with Constant option and removes them in the current PowerShell session.

## PARAMETERS

### -Force

Indicates that the cmdlet removes an alias even if it is read-only.
Even using the *Force* parameter, the cmdlet cannot remove a constant.

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

### -Name

Specifies the name of the alias to be removed.
The parameter name (*Name*) is optional.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Scope

Gets only the variables in the specified scope.
The acceptable values for this parameter are:

- Global
- Local
- Script
- A number relative to the current scope (0 through the number of scopes, where 0 is the current scope and 1 is its parent)

Local is the default.
For more information, see about_Scopes.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]

You can pipe an alias object to **Remove-Alias**.

## OUTPUTS

### None

This cmdlet does not return any output.

## NOTES

- Changes affect only the current scope, such as a session. To delete an alias from all sessions, add a **Remove-Alias** command to your PowerShell profile.

For more information, see about_Aliases.

## RELATED LINKS

[Export-Alias](Export-Alias.md)

[Get-Alias](Get-Alias.md)

[Import-Alias](Import-Alias.md)

[New-Alias](New-Alias.md)

[Set-Alias](Set-Alias.md)
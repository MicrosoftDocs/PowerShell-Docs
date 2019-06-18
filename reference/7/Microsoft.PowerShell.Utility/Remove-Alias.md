---
ms.date:  10/17/2018
schema: 2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version: 
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  Remove-Alias
---

# Remove-Alias

## SYNOPSIS

Remove an alias from the current session.

## SYNTAX

```
Remove-Alias [-Name] <String[]> [-Scope <String>] [-Force] [<CommonParameters>]
```

## DESCRIPTION

The `Remove-Alias` cmdlet removes an alias from the current PowerShell session.
You must use the **-Force** parameter to remove any aliases with the **Read-Only** option.

## EXAMPLES

### Example 1 - Remove an alias

This command removes an alias named `del` that represents the Remove-Item cmdlet.

```powershell
Remove-Alias -Name del
```


### Example 2 - Remove all non-Constant aliases

This command get all aliases except for alias with Constant option and removes them from the current PowerShell session.

```powershell
Get-Alias | Where-Object { $_.Options -ne "Constant" } | Remove-Alias -Force
```

## PARAMETERS

### -Force

Indicates that the cmdlet removes an alias even if it is read-only.
Even using the **Force** parameter, the cmdlet cannot remove a constant alias.

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

Affects only the aliases in the specified scope.
The acceptable values for this parameter are:

- Global
- Local
- Script
- A number relative to the current scope (0 through the number of scopes, where 0 is the current scope and 1 is its parent)

Local is the default scope.
For more information, see [about_Scopes](../microsoft.powershell.core/about/about_scopes.md).

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

Changes affect only the current scope. To remove an alias from all sessions, add a **Remove-Alias** command to your PowerShell profile.

For more information, see [about_Aliases](../microsoft.powershell.core/about/about_aliases.md).

## RELATED LINKS

[Export-Alias](Export-Alias.md)

[Get-Alias](Get-Alias.md)

[Import-Alias](Import-Alias.md)

[New-Alias](New-Alias.md)

[Set-Alias](Set-Alias.md)

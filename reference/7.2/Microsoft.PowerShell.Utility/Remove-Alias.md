---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 10/24/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/remove-alias?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Remove-Alias
---

# Remove-Alias

## SYNOPSIS
Remove an alias from the current session.

## SYNTAX

### Default (Default)

```
Remove-Alias [-Name] <String[]> [-Scope <String>] [-Force] [<CommonParameters>]
```

## DESCRIPTION

The `Remove-Alias` cmdlet removes an alias from the current PowerShell session. To remove an alias
with the **Option** property set to **ReadOnly**, use the **Force** parameter.

The `Remove-Alias` cmdlet was introduced in PowerShell 6.0.

## EXAMPLES

### Example 1 - Remove an alias

This example removes an alias named `del` that represents the `Remove-Item` cmdlet.

```powershell
Remove-Alias -Name del
```

### Example 2 - Remove all non-Constant aliases

This example removes all aliases from the current PowerShell session, except for aliases with the
**Options** property set to **Constant**. After the command is run, the aliases are available in
other PowerShell sessions or new PowerShell sessions.

```powershell
Get-Alias | Where-Object { $_.Options -NE "Constant" } | Remove-Alias -Force
```

`Get-Alias` gets all the aliases in the PowerShell session and sends the objects down the pipeline.
`Where-Object` uses a script block, and the automatic variable (`$_`) and **Options** property
represent the current pipeline object. The parameter **NE** (not equal), selects objects that don't
have an **Options** value set to **Constant**. `Remove-Alias` uses the **Force** parameter to remove
aliases, including read-only aliases, from the PowerShell session.

## PARAMETERS

### -Force

Indicates that the cmdlet removes an alias, including aliases with the **Option** property set to
**ReadOnly**. The **Force** parameter can't remove an alias with an **Option** property set to
**Constant**.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Specifies the name of the alias to remove.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Scope

Affects only the aliases in the specified scope. The default scope is **Local**. For more
information, see [about_Scopes](../microsoft.powershell.core/about/about_scopes.md).

The acceptable values for this parameter are:

- Global
- Local
- Script
- A number relative to the current scope (0 through the number of scopes, where 0 is the current
  scope and 1 is its parent)

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Local
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]

You can pipe an alias object to **Remove-Alias**.

## OUTPUTS

### None

This cmdlet doesn't return any output.

## NOTES

Changes only affect the current scope. To remove an alias from all sessions, add a **Remove-Alias**
command to your PowerShell profile.

For more information, see [about_Aliases](../microsoft.powershell.core/about/about_aliases.md).

## RELATED LINKS

[about_Automatic_Variables](../Microsoft.PowerShell.Core/About/about_Automatic_Variables.md)

[Export-Alias](Export-Alias.md)

[Get-Alias](Get-Alias.md)

[Import-Alias](Import-Alias.md)

[New-Alias](New-Alias.md)

[Set-Alias](Set-Alias.md)

[Where-Object](../Microsoft.PowerShell.Core/Where-Object.md)


---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/new-alias?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: New-Alias
---
# New-Alias

## SYNOPSIS
Creates a new alias.

## SYNTAX

```
New-Alias [-Name] <String> [-Value] <String> [-Description <String>] [-Option <ScopedItemOptions>] [-PassThru]
 [-Scope <String>] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The **New-Alias** cmdlet creates a new alias in the current PowerShell session.
Aliases created by using **New-Alias** are not saved after you exit the session or close PowerShell.
You can use the Export-Alias cmdlet to save your alias information to a file.
You can later use **Import-Alias** to retrieve that saved alias information.

## EXAMPLES

### Example 1: Create an alias for a cmdlet

```
PS C:\> New-Alias -Name "List" Get-ChildItem
```

This command creates an alias named List to represent the Get-ChildItem cmdlet.

### Example 2: Create a read-only alias for a cmdlet

```
PS C:\> New-Alias -Name "W" -Value Get-WmiObject -Description "quick wmi alias" -Option ReadOnly
PS C:\> Get-Alias -Name "W" | Format-List *
```

This command creates an alias named W to represent the Get-WmiObject cmdlet.
It creates a description, quick wmi alias, for the alias and makes it read-only.
The last line of the command uses Get-Alias to get the new alias and pipes it to Format-List to display all of the information about it.

## PARAMETERS

### -Description

Specifies a description of the alias.
You can type any string.
If the description includes spaces, enclose it in quotation marks.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Indicates that the cmdlet acts like Set-Alias if the alias named already exists.

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

### -Name

Specifies the new alias.
You can use any alphanumeric characters in an alias, but the first character cannot be a number.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Option

Specifies the value of the **Options** property of the alias.
Valid values are:

- None: The alias has no constraints (default value)
- ReadOnly: The alias can be deleted but cannot be changed except by using the **Force** parameter
- Constant: The alias cannot be deleted or changed
- Private: The alias is available only in the current scope
- AllScope: The alias is copied to any new scopes that are created
- Unspecified: The option is not specified

To see the **Options** property of all aliases in the session, type `Get-Alias | Format-Table -Property Name, Options -AutoSize`.

```yaml
Type: System.Management.Automation.ScopedItemOptions
Parameter Sets: (All)
Aliases:
Accepted values: None, ReadOnly, Constant, Private, AllScope, Unspecified

Required: False
Position: Named
Default value: [System.Management.Automation.ScopedItemOptions]::None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru

Returns an object representing the item with which you are working.
By default, this cmdlet does not generate any output.

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

### -Scope

Specifies the scope of the new alias.
The acceptable values for this parameter are:

- Global
- Local
- Script
- A number relative to the current scope (0 through the number of scopes, where 0 is the current scope and 1 is its parent).

Local is the default.
For more information, see about_Scopes.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value

Specifies the name of the cmdlet or command element that is being aliased.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
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

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe input to this cmdlet.

## OUTPUTS

### None or System.Management.Automation.AliasInfo

When you use the *Passthru* parameter, **New-Alias** generates a **System.Management.Automation.AliasInfo** object representing the new alias.
Otherwise, this cmdlet does not generate any output.

## NOTES

* To create a new alias, use `Set-Alias` or `New-Alias`. To change an alias, use `Set-Alias`. To delete an alias, use `Remove-Item`.

## RELATED LINKS

[Export-Alias](Export-Alias.md)

[Get-Alias](Get-Alias.md)

[Import-Alias](Import-Alias.md)

[Set-Alias](Set-Alias.md)


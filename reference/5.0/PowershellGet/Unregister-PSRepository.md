---
external help file: PSModule-help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: PowerShellGet
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821675
schema: 2.0.0
title: Unregister-PSRepository
---
# Unregister-PSRepository

## SYNOPSIS
Unregisters a repository.

## SYNTAX

```
Unregister-PSRepository [-Name] <String[]> [<CommonParameters>]
```

## DESCRIPTION

The `Unregister-PSRepository` cmdlet unregisters a repository for the current user.

## EXAMPLES

### Example 1: Unregister a repository

This example unregisters the repository named myNuGetSource.

```powershell
Unregister-PSRepository -Name "myNuGetSource"
```

### Example 2: Unregister all repositories

This example uses `Get-PSRepository` to get all registered repositories, and uses the pipeline operator to pass them to `Unregister-PSRepository` to unregister them.

```powershell
Get-PSRepository | Unregister-PSRepository
```

Note that PSGallery is a built-in repository and cannot be unregistered.

## PARAMETERS

### -Name

Specifies an array of names of the repositories to remove.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-PSRepository](Get-PSRepository.md)

[Register-PSRepository](Register-PSRepository.md)

[Set-PSRepository](Set-PSRepository.md)
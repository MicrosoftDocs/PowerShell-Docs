---
external help file: PSGet.psm1-help.xml
online version: 
schema: 2.0.0
---

# Unregister-PSRepository
## SYNOPSIS
Unregisters a repository.

## SYNTAX

```
Unregister-PSRepository [-Name] <String[]>
```

## DESCRIPTION
The Unregister-PSRepository cmdlet unregisters a repository for the current user.

## EXAMPLES

### Example 1: Unregister a repository
```
PS C:\>Unregister-PSRepository -Name "myNuGetSource"
```

This command unregisters the repository named myNuGetSource.

### Example 2: Unregister all repositories
```
PS C:\>Get-PSRepository | Unregister-PSRepository
```

This command uses Get-PSRepository to get all registered repositories, and uses the pipeline operator to pass them to Unregister-PSRepository to unregister them.
Note that PSGallery is a built-in repository and cannot be unregistered.

## PARAMETERS

### -Name
Specifies an array of names of the repositories to remove.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-PSRepository]()

[Register-PSRepository]()

[Set-PSRepository]()


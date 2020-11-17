---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/get-psprovider?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-PSProvider
---
# Get-PSProvider

## SYNOPSIS
Gets information about the specified PowerShell provider.

## SYNTAX

```
Get-PSProvider [[-PSProvider] <String[]>] [<CommonParameters>]
```

## DESCRIPTION

The `Get-PSProvider` cmdlet gets the PowerShell providers in the current session.
You can get a particular drive or all drives in the session.

PowerShell providers let you access a variety of data stores as though they were file system drives.
For information about PowerShell providers, see [about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

## EXAMPLES

### Example 1: Display a list of all available providers

```powershell
Get-PSProvider
```

This command displays a list of all available PowerShell providers.

### Example 2: Display a list of all PowerShell providers that begin with specified letters

```powershell
Get-PSProvider f*, r* | Format-List
```

This command displays a list of all PowerShell providers with names that begin with the letter f or
r.

### Example 3: Find snap-ins or module that added providers to your session

```powershell
Get-PSProvider | Format-Table name, module, pssnapin -auto
```

```Output
Name        Module       PSSnapIn
----        ------       --------
Test        TestModule
WSMan                    Microsoft.WSMan.Management
Alias                    Microsoft.PowerShell.Core
Environment              Microsoft.PowerShell.Core
FileSystem               Microsoft.PowerShell.Core
Function                 Microsoft.PowerShell.Core
Registry                 Microsoft.PowerShell.Core
Variable                 Microsoft.PowerShell.Core
Certificate              Microsoft.PowerShell.Security
```

```powershell
Get-PSProvider | Where {$_.pssnapin -eq "Microsoft.PowerShell.Security"}
```

```Output
Name            Capabilities      Drives
----            ------------      ------
Certificate     ShouldProcess     {cert}
```

These commands find the PowerShell snap-ins or modules that added providers to your session.
All PowerShell elements, including providers, originate in a snap-in or in a module.

These commands use the PSSnapin and Module properties of the **ProviderInfo** object that
`Get-PSProvider` returns.
The values of these properties contain the name of the snap-in or module that adds the provider.

The first command gets all of the providers in the session and formats them in a table with the
values of their Name, Module, and PSSnapin properties.

The second command uses the `Where-Object` cmdlet to get the providers that come from the
**Microsoft.PowerShell.Security** snap-in.

### Example 4: Resolve the path of the Home property of the file system provider

```powershell
C:\> Resolve-Path ~
```

```Output
Path
----
C:\Users\User01
```

```powershell
PS C:\> (get-psprovider FileSystem).home
```

```Output
C:\Users\User01
```

This example shows that the tilde symbol (~) represents the value of the **Home** property of the
FileSystem provider.
The **Home** property value is optional, but for the **FileSystem** provider, it is defined as
`$env:homedrive\$env:homepath` or `$home`.

## PARAMETERS

### -PSProvider

Specifies the name or names of the PowerShell providers about which this cmdlet gets information.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### String[]

You can pipe one or more provider name strings to this cmdlet.

## OUTPUTS

### System.Management.Automation.ProviderInfo

This cmdlet returns objects that represent the PowerShell providers in the session.

## NOTES

## RELATED LINKS


---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/p/?linkid=290501
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Get-PSProvider
---

# Get-PSProvider

## SYNOPSIS
Gets information about the specified Windows PowerShell provider.

## SYNTAX

```
Get-PSProvider [[-PSProvider] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
The Get-PSProvider cmdlet gets the Windows PowerShell providers in the current session.
You can get a particular drive or all drives in the session.

Windows PowerShell providers let you access a variety of data stores as though they were file system drives.
For information about Windows PowerShell providers, see about_Providers.

## EXAMPLES

### Example 1
```
PS C:\> get-psprovider
```

This command displays a list of all available Windows PowerShell providers.

### Example 2
```
PS C:\> get-psprovider f*, r* | format-list
```

This command displays a list of all Windows PowerShell providers with names that begin with the letter "f" or "r".

### Example 3
```
PS C:\> get-psprovider | format-table name, module, pssnapin -auto

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

PS C:\> get-psprovider | where {$_.pssnapin -eq "Microsoft.PowerShell.Security"}

Name            Capabilities      Drives
----            ------------      ------
Certificate     ShouldProcess     {cert}
```

These commands find the Windows PowerShell snap-ins or modules that added providers to your session.
All Windows PowerShell elements, including providers, originate in a snap-in or in a module.

These commands use the PSSnapin and Module properties of the ProviderInfo object that Get-PSProvider returns.
The values of these properties contain the name of the snap-in or module that adds the provider.

The first command gets all of the providers in the session and formats them in a table with the values of their Name, Module, and PSSnapin properties.

The second command uses the Where-Object cmdlet to get the providers that come from the Microsoft.PowerShell.Security snap-in.

### Example 4
```
PS C:\> resolve-path ~

Path
----
C:\Users\User01

PS C:\> (get-psprovider FileSystem).home
C:\Users\User01
```

This example shows that the tilde symbol (~) represents the value of the Home property of the FileSystem provider.
The Home property value is optional, but for the FileSystem provider, it is defined as $env:homedrive\$env:homepath or $home.

## PARAMETERS

### -PSProvider
Specifies the name or names of the Windows PowerShell providers about which to retrieve information.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
You cannot pipe objects to this cmdlet.

## OUTPUTS

### System.Management.Automation.ProviderInfo
Get-PSProvider returns objects that represent the Windows PowerShell providers in the session.

## NOTES

## RELATED LINKS

[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)


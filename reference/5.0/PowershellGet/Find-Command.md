---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=822318
external help file:  PSModule-help.xml
title:  Find-Command
---

# Find-Command

## SYNOPSIS
Finds PowerShell commands in modules.

## SYNTAX

```
Find-Command [[-Name] <String[]>] [-ModuleName <String>] [-MinimumVersion <Version>]
 [-MaximumVersion <Version>] [-RequiredVersion <Version>] [-AllVersions] [-Tag <String[]>] [-Filter <String>]
 [-Proxy <Uri>] [-ProxyCredential <PSCredential>] [-Repository <String[]>] [<CommonParameters>]
```

## DESCRIPTION
The **Find-Command** cmdlet finds PowerShell commands such as cmdlets, aliases, functions, and workflows.
**Find-Command** searches modules in registered repositories.

For each command that this cmdlet finds, it returns a **PSGetCommandInfo** object.
You can pass a **PSGetCommandInfo** object to the Install-Module cmdlet to install the module that contains the command.

## EXAMPLES

### Example 1: Find all commands in a specified repository
```
PS C:\> Find-Command -Repository "INT" | Select-Object -First 10
Name                                Version    ModuleName                          Repository
----                                -------    ----------                          ----------
Get-RequiredModule4                 2.5        RequiredModule4                     INT
Get-RequiredModule5                 2.5        RequiredModule5                     INT
Get-NestedRequiredModule4           2.5        NestedRequiredModule4               INT
Get-NestedRequiredModule5           2.5        NestedRequiredModule5               INT
Enable-AzureRmDataCollection        1.0.4      AzureRM.Profile                     INT
Disable-AzureRmDataCollection       1.0.4      AzureRM.Profile                     INT
Remove-AzureRmEnvironment           1.0.4      AzureRM.Profile                     INT
Get-AzureRmEnvironment              1.0.4      AzureRM.Profile                     INT
Set-AzureRmEnvironment              1.0.4      AzureRM.Profile                     INT
Add-AzureRmEnvironment              1.0.4      AzureRM.Profile                     INT
```

This command finds commands in modules in the INT repository, and uses the pipeline operator to pass the results to Select-Object to select the first 10 commands.

### Example 2: Find a command by name
```
PS C:\> Find-Command -Repository "INT" -Name "Get-ContosoClient"
Name                                Version    ModuleName                          Repository
----                                -------    ----------                          ----------
Get-ContosoClient                   2.5        ContosoClient                       INT
```

This command finds the command named Get-ContosoClient in the INT repository.
The command is contained in the ContosoClient module.

### Example 3: Find commands by name and install them
```
PS C:\> Find-Command -Repository "INT" -Name "Get-ContosoClient,Get-ContosoServer" | Install-Module
PS C:\> Get-InstalledModule
Version    Name                                Type       Repository           Description
-------    ----                                ----       ----------           -----------
2.5        ContosoClient                       Module     INT                  ContosoClient module
2.5        ContosoServer                       Module     INT                  ContosoServer module
```

The first command finds the specified commands in the INT repository, and then uses the pipeline operator to pass them to Install-Module to install them.

The second command uses Get-InstalledModule to verify the modules from the prior command are installed.

### Example 4: Find a command and save its module
```
PS C:\> Find-Command -Name "Get-NestedRequiredModule4" -Repository "INT" | Save-Module -Path "C:\temp\" -Verbose
```

This command finds the specified command, and then passes it to Save-Module to save it to the C:\temp folder.

## PARAMETERS

### -AllVersions
Indicates that this cmdlet gets all versions of a module.

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

### -Filter
Finds modules based on the PackageManagement provider-specific search syntax.
For NuGet, this is the equivalent of using the search bar on the PowerShell Gallery website.

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

### -MaximumVersion
Specifies the maximum (exclusively) version of the module to include in results.
The *MaximumVersion* and the *RequiredVersion* parameters are mutually exclusive; you cannot use both parameters in the same command.

```yaml
Type: Version
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MinimumVersion
Specifies the minimum version of the module to include in results.
The *MinimumVersion* and the *RequiredVersion* parameters are mutually exclusive; you cannot use both parameters in the same command.

```yaml
Type: Version
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ModuleName
Specifies the name of the module in which to search for commands.
The default is all modules.

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

### -Name
Specifies an array of names of commands to search for.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Proxy
Specifies a proxy server for the request, rather than connecting directly to the Internet resource.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ProxyCredential
Specifies a user account that has permission to use the proxy server that is specified by the **Proxy** parameter.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Repository
Specifies an array of registered repositories in which to search.
The default is all repositories.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequiredVersion
Specifies the version of the module to include in the results.

```yaml
Type: Version
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tag
Specifies an array of tags.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
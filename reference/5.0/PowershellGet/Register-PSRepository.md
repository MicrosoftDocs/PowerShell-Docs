---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Register PSRepository
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/?LinkId=821668
external help file:   PSGet-help.xml
---


# Register-PSRepository

## SYNOPSIS
Registers a PowerShell repository.

## SYNTAX

```
Register-PSRepository -Name <String> -SourceLocation <Uri> [-PublishLocation <Uri>]
 [-InstallationPolicy <String>] [-PackageManagementProvider <String>] [<CommonParameters>]
```

## DESCRIPTION
The **Register-PSRepository** cmdlet registers the default repository for PowerShell modules.
After a repository is registered, you can reference it from the Find-Module, Install-Module, and Publish-Module cmdlets.
The registered repository becomes the default repository in **Find-Module** and **Install-Module**.

Registered repositories are user-specific.
They are not registered in a system-wide context.

Each registered repository is associated with a OneGet package provider, which is specified with the *PackageManagementProvider* parameter.
Each OneGet provider is designed to interact with a specific type of repository.
For example, the NuGet provider is designed to interact with NuGet-based repositories.
If a OneGet provider is not specified during registration, PowerShellGet attempts to find a OneGet provider that can handle the specified source location.

## EXAMPLES

### Example 1: Register a repository
```
PS C:\> Register-PSRepository -Name "myNuGetSource" -SourceLocation "https://www.myget.org/F/powershellgetdemo/api/v2" -PublishLocation "https://www.myget.org/F/powershellgetdemo/api/v2/Packages" -InstallationPolicy Trusted
PS C:\> Get-PSRepository
Name                                     SourceLocation                                     OneGetProvider       InstallationPolicy
----                                     --------------                                     --------------       ------------------
PSGallery                                http://go.micro...                                 NuGet                Untrusted
myNuGetSource                            https://myget.c...                                 NuGet                Trusted
```

The first command registers https://www.myget.org/F/powershellgetdemo/ as a repository for the current user.
After myNuGetSource is registered, you can explicitly reference it when searching for, installing, and publishing modules.
Because the *PackageManamentProvider* parameter isn't specified, the repository is not explicitly associated with a OneGet packkage provider, so PowerShellGet polls available package providers and associates it with the NuGet provider.

The second command gets registered repositories and displays the results.

## PARAMETERS

### -InstallationPolicy
Specifies the installation policy.
Valid values are: Trusted, UnTrusted.
The default value is UnTrusted.

A repository's installation policy specifies PowerShell behavior when installing from that repository.
When installing modules from an UnTrusted repository, the user is prompted for confirmation.

You can set the *InstallationPolicy* with the Set-PSRepository cmdlet.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: Trusted, Untrusted

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies the name of the repository to register.
You can use this name to specify the repository in cmdlets such as Find-Module and Install-Module.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PackageManagementProvider
Specifies a OneGet package provider.
If you don't specify a value for this parameter, PowerShellGet polls available package providers and associates this repository with the first package provider that indicates it can handle the repository.

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

### -PublishLocation
Specifies the URI of the publish location.
For example, for NuGet-based repositories, the publish location is similar to http://someNuGetUrl.com/api/v2/Packages.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SourceLocation
Specifies the URI for discovering and installing modules from this repository.
For example, for NuGet-based repositories, the source location is similar to http://someNuGetUrl.com/api/v2.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases: 

Required: True
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

[Get-PSRepository](Get-PSRepository.md)

[Set-PSRepository](Set-PSRepository.md)

[Unregister-PSRepository](Unregister-PSRepository.md)


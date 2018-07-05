---
external help file: PSDesiredStateConfiguration-help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: PSDesiredStateConfiguration
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821458
schema: 2.0.0
title: Get-DscResource
---

# Get-DscResource

## SYNOPSIS
Gets the DSC resources present on the computer.

## SYNTAX

```
Get-DscResource [[-Name] <String[]>] [[-Module] <Object>] [-Syntax] [<CommonParameters>]
```

## DESCRIPTION
The **Get-DscResource** cmdlet retrieves the Windows PowerShell Desired State Configuration (DSC) resources present on the computer.
This cmdlet discovers only the resources installed in the PSModulePath.
It shows the details about built-in and custom providers, which are created by the user.
This cmdlet also shows details about composite resources, which are other configurations that are packaged as module or created at run time in the session.

## EXAMPLES

### Example 1: Get all resources on the local computer
```
PS C:\> Get-DscResource
```

This command gets all the resources on the local computer.

### Example 2: Get a resource by specifying the name
```
PS C:\> Get-DscResource -Name "WindowsFeature"
```

This command gets the WindowsFeature resource.

### Example 3: Get all the resources from a module
```
PS C:\> Get-DscResource -Module "xHyper-V"
```

This command gets all the resources from the xHyper-V module.

### Example 4: Get a resource by using wildcard characters
```
PS C:\> Get-DscResource -Name P*,r*
```

This command gets all resources that match the wildcard pattern specified by the *Name* parameter.

### Example 5: Get a resource syntax
```
PS C:\> Get-DscResource -Name "WindowsFeature" -Syntax
```

This command gets the WindowsFeature resource, and shows the syntax for the resource.

### Example 6: Get all the properties for a resource
```
PS C:\> Get-DscResource -Name "User" | Select-Object -ExpandProperty Properties
```

This command gets the User resource, and then uses the pipeline operator to return all the properties for the User resource.

### Example 7: Get all the resources from a specified module with a specified version
```
PS C:\> Get-DscResource -Module @{ModuleName='xHyper-V';RequiredVersion='3.0.0.0'}
```

This command gets all the resources from xHyper-V module with version 3.0.0.0.

## PARAMETERS

### -Module
Specifies the name or fully qualified name of the module for which to view the DSC resource.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Name
Specifies an array of names of the DSC resource to view.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Syntax
Indicates that the cmdlet returns the syntax view of the specified DSC resources.
The returned syntax shows how to use the resources in aWindows PowerShell script.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.PowerShell.DesiredStateConfiguration.DscResourceInfo

## NOTES

## RELATED LINKS

[Windows PowerShell Desired State Configuration Overview](http://go.microsoft.com/fwlink/?LinkID=311940)

[Invoke-DscResource](Invoke-DscResource.md)
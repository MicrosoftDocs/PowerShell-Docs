---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 06/07/2021
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/get-itempropertyvalue?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-ItemPropertyValue
---
# Get-ItemPropertyValue

## Synopsis
Gets the value for one or more properties of a specified item.

## Syntax

### Path (Default)

```
Get-ItemPropertyValue [[-Path] <String[]>] [-Name] <String[]> [-Filter <String>] [-Include <String[]>]
 [-Exclude <String[]>] [-Credential <PSCredential>] [<CommonParameters>]
```

### LiteralPath

```
Get-ItemPropertyValue -LiteralPath <String[]> [-Name] <String[]> [-Filter <String>] [-Include <String[]>]
 [-Exclude <String[]>] [-Credential <PSCredential>] [<CommonParameters>]
```

## Description

The `Get-ItemPropertyValue` gets the current value for a property that you specify when you use the
**Name** parameter, located in a path that you specify with either the **Path** or **LiteralPath**
parameters.

## Examples

### Example 1: Get the value of the ProductID property

This command gets the value of the **ProductID** property of the "\SOFTWARE\Microsoft\Windows
NT\CurrentVersion" object in the Windows Registry provider.

```powershell
Get-ItemPropertyValue 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name ProductID
```

```output
94253-50000-11141-AA785
```

### Example 2: Get the last write time of a file or folder

This command gets the value of the **LastWriteTime** property, or the last time a file or folder was
changed, from the `C:\Program Files\PowerShell` folder, working in the FileSystem
provider.

```powershell
Get-ItemPropertyValue -Path 'C:\Program Files\PowerShell' -Name LastWriteTime
```

```output
Wednesday, September 3, 2014 2:53:22 PM
```

### Example 3: Get multiple property values of a file or folder

This command gets the values of the **LastWriteTime**, **CreationTime**, and **Root** properties of
a folder. The property values are returned in the order in which you specified the property names.

```powershell
Get-ItemPropertyValue -Path 'C:\Program Files\PowerShell' -Name LastWriteTime,CreationTime,Root
```

```output
Tuesday, March 23, 2021 6:53:13 AM
Monday, August 14, 2017 1:42:40 PM

Parent              :
Root                : C:\
FullName            : C:\
Extension           :
Name                : C:\
Exists              : True
CreationTime        : 10/30/2015 1:28:30 AM
CreationTimeUtc     : 10/30/2015 6:28:30 AM
LastAccessTime      : 5/26/2021 9:22:24 AM
LastAccessTimeUtc   : 5/26/2021 2:22:24 PM
LastWriteTime       : 5/25/2021 7:25:08 AM
LastWriteTimeUtc    : 5/25/2021 12:25:08 PM
Attributes          : Hidden, System, Directory
Mode                : d--hs
ModeWithoutHardLink : d--hs
BaseName            : C:\
Target              :
LinkType            :
```

## Parameters

### -Credential

> [!NOTE]
> This parameter is not supported by any providers installed with PowerShell.
> To impersonate another user, or elevate your credentials when running this cmdlet,
> use [Invoke-Command](../Microsoft.PowerShell.Core/Invoke-Command.md).

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Exclude

Specifies, as a string array, an item or items that this cmdlet excludes in the operation. The value
of this parameter qualifies the **Path** parameter. Enter a path element or pattern, such as
`*.txt`. Wildcard characters are permitted. The **Exclude** parameter is effective only when the
command includes the contents of an item, such as `C:\Windows\*`, where the wildcard character
specifies the contents of the `C:\Windows` directory.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Filter

Specifies a filter to qualify the **Path** parameter. The [FileSystem](../Microsoft.PowerShell.Core/About/about_FileSystem_Provider.md)
provider is the only installed PowerShell provider that supports the use of filters. You can find
the syntax for the **FileSystem** filter language in [about_Wildcards](../Microsoft.PowerShell.Core/About/about_Wildcards.md).
Filters are more efficient than other parameters, because the provider applies them when the cmdlet
gets the objects rather than having PowerShell filter the objects after they are retrieved.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Include

Specifies, as a string array, an item or items that this cmdlet includes in the operation. The value
of this parameter qualifies the **Path** parameter. Enter a path element or pattern, such as
`"*.txt"`. Wildcard characters are permitted. The **Include** parameter is effective only when the
command includes the contents of an item, such as `C:\Windows\*`, where the wildcard character
specifies the contents of the `C:\Windows` directory.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -LiteralPath

Specifies a path to one or more locations. The value of **LiteralPath** is used exactly as it is
typed. No characters are interpreted as wildcards. If the path includes escape characters, enclose
it in single quotation marks. Single quotation marks tell PowerShell not to interpret any characters
as escape sequences.

For more information, see [about_Quoting_Rules](../Microsoft.Powershell.Core/About/about_Quoting_Rules.md).

```yaml
Type: System.String[]
Parameter Sets: LiteralPath
Aliases: PSPath, LP

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name

Specifies the name of the property or properties to retrieve.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: PSProperty

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specifies the path to the item or items.
Wildcard characters are permitted.

```yaml
Type: System.String[]
Parameter Sets: Path
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`,
`-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`,
`-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see
[about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## Inputs

### System.String

You can pipe a string that contains a path to this cmdlet.

## Outputs

### System.Boolean, System.String, System.DateTime

This cmdlet returns an object for each item property value that it gets.
The object type depends on the property value that is retrieved.
For example, in a file system drive, the cmdlet might return a file or folder.

## Notes

This cmdlet is designed to work with the data exposed by any provider. To list the providers
available in your session, run the `Get-PSProvider` cmdlet. For more information, see
[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md).

## Related Links

[Get-ItemProperty](Get-ItemProperty.md)

[Clear-ItemProperty](Clear-ItemProperty.md)

[Copy-ItemProperty](Copy-ItemProperty.md)

[Get-PSProvider](Get-PSProvider.md)

[Move-ItemProperty](Move-ItemProperty.md)

[New-ItemProperty](New-ItemProperty.md)

[Remove-ItemProperty](Remove-ItemProperty.md)

[Rename-ItemProperty](Rename-ItemProperty.md)

[Set-ItemProperty](Set-ItemProperty.md)

[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)


---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 01/27/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/get-formatdata?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-FormatData
---
# Get-FormatData

## SYNOPSIS
Gets the formatting data in the current session.

## SYNTAX

```
Get-FormatData [[-TypeName] <String[]>] [-PowerShellVersion <Version>] [<CommonParameters>]
```

## DESCRIPTION

The `Get-FormatData` cmdlet gets the formatting data in the current session.

The formatting data in the session includes formatting data from `Format.ps1xml` formatting files,
such as those in the `$PSHOME` directory, formatting data for modules that you import into the
session, and formatting data for commands that you import into your session by using the
`Import-PSSession` cmdlet.

You can use this cmdlet to examine the formatting data. Then, you can use the `Export-FormatData`
cmdlet to serialize the objects, convert them to XML, and save them in `Format.ps1xml` files.

For more information about formatting files in PowerShell, see
[about_Format.ps1xml](../Microsoft.PowerShell.Core/About/about_Format.ps1xml.md).

## EXAMPLES

### Example 1: Get all formatting data

This example gets all the formatting data in the session.

```powershell
Get-FormatData
```

### Example 2: Get formatting data by type name

This example gets the formatting data items whose names begin with
`System.Management.Automation.Cmd`.

```powershell
Get-FormatData -TypeName 'System.Management.Automation.Cmd*'
```

### Example 3: Examine a formatting data object

This example shows how to get a formatting data object and examine its properties.

```powershell
$F = Get-FormatData -TypeName 'System.Management.Automation.Cmd*'
$F
```

```Output
TypeName        FormatViewDefinition
--------        --------------------
HelpInfoShort   {help , TableControl}
```

```powershell
$F.FormatViewDefinition[0].control
```

```Output
Headers          : {System.Management.Automation.TableControlColumnHeader,
                   System.Management.Automation.TableControlColumnHeader,
                   System.Management.Automation.TableControlColumnHeader,
                   System.Management.Automation.TableControlColumnHeader}
Rows             : {System.Management.Automation.TableControlRow}
AutoSize         : False
HideTableHeaders : False
GroupBy          :
OutOfBand        : False
```

```powershell
$F.FormatViewDefinition[0].control.Headers
```

```Output
Label       Alignment Width
-----       --------- -----
CommandType Undefined    15
Name        Undefined    50
Version     Undefined    10
Source      Undefined     0
```

### Example 4: Get formatting data and export it

This example shows how to use `Get-FormatData` and `Export-FormatData` to export the formatting
data that is added by a module.

```powershell
$A = Get-FormatData
Import-Module bitstransfer
$B = Get-FormatData
Compare-Object $A $B
```

```Output
InputObject                                                SideIndicator
-----------                                                -------------
Microsoft.BackgroundIntelligentTransfer.Management.BitsJob =>
```

```powershell
Get-FormatData *bits* | Export-FormatData -FilePath c:\test\bits.format.ps1xml
Get-Content c:\test\bits.format.ps1xml
```

```Output
<?xml version="1.0" encoding="utf-8"?><Configuration><ViewDefinitions>
<View><Name>Microsoft.BackgroundIntelligentTransfer.Management.BitsJob</Name>
...
```

The first four commands use the `Get-FormatData`, `Import-Module`, and `Compare-Object` cmdlets to
identify the format type that the **BitsTransfer** module adds to the session.

The fifth command uses the `Get-FormatData` cmdlet to get the format type that the **BitsTransfer**
module adds. It uses a pipeline operator (`|`) to send the format type object to the
`Export-FormatData` cmdlet, which converts it back to XML and saves it in the specified
`format.ps1xml` file.

The final command shows an excerpt of the `format.ps1xml` file content.

### Example 5: Get formatting data based on the specified version of PowerShell

This example shows how to use `Get-FormatData` to get format data for a specified **TypeName** and
PowerShell version.

```powershell
Get-FormatData -TypeName 'Microsoft.Powershell.Utility.FileHash' -PowerShellVersion $PSVersionTable.PSVersion

TypeNames                               FormatViewDefinition
---------                               --------------------
{Microsoft.Powershell.Utility.FileHash} {Microsoft.Powershell.Utility.FileHash}
```

## PARAMETERS

### -PowerShellVersion

Specify the version of PowerShell this cmdlet gets for the formatting data. Enter a two digit number
separated by a period.

This parameter was added in PowerShell 5.1 to improve compatibility when remoting computers running
older versions of PowerShell.

```yaml
Type: System.Version
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TypeName

Specifies the type names that this cmdlet gets for the formatting data.
Enter the type names.
Wildcards are permitted.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe input to this cmdlet.

## OUTPUTS

### System.Management.Automation.ExtendedTypeDefinition

## NOTES

## RELATED LINKS

[Export-FormatData](Export-FormatData.md)

[Update-FormatData](Update-FormatData.md)

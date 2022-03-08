---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 08/15/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/import-clixml?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Import-Clixml
---

# Import-Clixml

## SYNOPSIS
Imports a CLIXML file and creates corresponding objects in PowerShell.

## SYNTAX

### ByPath (Default)

```
Import-Clixml [-Path] <String[]> [-IncludeTotalCount] [-Skip <UInt64>] [-First <UInt64>]
 [<CommonParameters>]
```

### ByLiteralPath

```
Import-Clixml -LiteralPath <String[]> [-IncludeTotalCount] [-Skip <UInt64>] [-First <UInt64>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Import-Clixml` cmdlet imports a Common Language Infrastructure (CLI) XML file with data that
represents Microsoft .NET Framework objects and creates the PowerShell objects. For more information
about CLI, see [Language independence](/dotnet/standard/language-independence).

A valuable use of `Import-Clixml` on Windows computers is to import credentials and secure strings
that were exported as secure XML using `Export-Clixml`. For an example, see Example 2.

`Import-Clixml` uses the byte-order-mark (BOM) to detect the encoding format of the file. If the
file has no BOM, it assumes the encoding is UTF8.

## EXAMPLES

### Example 1: Import a serialized file and recreate an object

This example uses the `Export-Clixml` cmdlet to save a serialized copy of the process information
returned by `Get-Process`. `Import-Clixml` retrieves the serialized file's contents and recreates an
object that is stored in the `$Processes` variable.

```powershell
Get-Process | Export-Clixml -Path .\pi.xml
$Processes = Import-Clixml -Path .\pi.xml
```

### Example 2: Import a secure credential object

In this example, given a credential that you've stored in the `$Credential` variable by running the
`Get-Credential` cmdlet, you can run the `Export-Clixml` cmdlet to save the credential to disk.

> [!IMPORTANT]
> `Export-Clixml` only exports encrypted credentials on Windows. On non-Windows operating systems
> such as macOS and Linux, credentials are exported in plain text.

```powershell
$Credxmlpath = Join-Path (Split-Path $Profile) TestScript.ps1.credential
$Credential | Export-Clixml $Credxmlpath
$Credxmlpath = Join-Path (Split-Path $Profile) TestScript.ps1.credential
$Credential = Import-Clixml $Credxmlpath
```

The `Export-Clixml` cmdlet encrypts credential objects by using the Windows [Data Protection API](/previous-versions/windows/apps/hh464970(v=win.10)).
The encryption ensures that only your user account can decrypt the contents of the credential
object. The exported `CLIXML` file can't be used on a different computer or by a different user.

In the example, the file in which the credential is stored is represented by
`TestScript.ps1.credential`. Replace **TestScript** with the name of the script with which you're
loading the credential.

You send the credential object down the pipeline to `Export-Clixml`, and save it to the path,
`$Credxmlpath`, that you specified in the first command.

To import the credential automatically into your script, run the final two commands. Run
`Import-Clixml` to import the secured credential object into your script. This import eliminates the
risk of exposing plain-text passwords in your script.

## PARAMETERS

### -First

Gets only the specified number of objects. Enter the number of objects to get.

```yaml
Type: System.UInt64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeTotalCount

Reports the total number of objects in the data set followed by the selected objects. If the cmdlet
can't determine the total count, it displays **Unknown total count**. The integer has an
**Accuracy** property that indicates the reliability of the total count value. The value of
**Accuracy** ranges from `0.0` to `1.0` where `0.0` means that the cmdlet couldn't count the
objects, `1.0` means that the count is exact, and a value between `0.0` and `1.0` indicates an
increasingly reliable estimate.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralPath

Specifies the path to the XML files. Unlike **Path**, the value of the **LiteralPath** parameter is
used exactly as it's typed. No characters are interpreted as wildcards. If the path includes escape
characters, enclose it in single quotation marks. Single quotation marks tell PowerShell not to
interpret any characters as escape sequences.

```yaml
Type: System.String[]
Parameter Sets: ByLiteralPath
Aliases: PSPath, LP

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path

Specifies the path to the XML files.

```yaml
Type: System.String[]
Parameter Sets: ByPath
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Skip

Ignores the specified number of objects and then gets the remaining objects. Enter the number of
objects to skip.

```yaml
Type: System.UInt64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipeline a string that contains a path to `Import-Clixml`.

## OUTPUTS

### PSObject

`Import-Clixml` returns objects that were deserialized from the stored XML files.

## NOTES

When specifying multiple values for a parameter, use commas to separate the values. For example,
`<parameter-name> <value1>, <value2>`.

## RELATED LINKS

[Export-Clixml](Export-Clixml.md)

[Introducing XML Serialization](/dotnet/standard/serialization/introducing-xml-serialization)

[Join-Path](../Microsoft.PowerShell.Management/Join-Path.md)

[Securely Store Credentials on Disk](https://powershellcookbook.com/recipe/PukO/securely-store-credentials-on-disk)

[Use PowerShell to Pass Credentials to Legacy Systems](https://devblogs.microsoft.com/scripting/use-powershell-to-pass-credentials-to-legacy-systems/)


---
external help file: Microsoft.PowerShell.Archive-help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Archive
ms.date: 07/17/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.archive/expand-archive?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Expand-Archive
---

# Expand-Archive

## SYNOPSIS
Extracts files from a specified archive (zipped) file.

## SYNTAX

### Path (Default)

```
Expand-Archive [-Path] <String> [[-DestinationPath] <String>] [-Force] [-PassThru] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### LiteralPath

```
Expand-Archive -LiteralPath <String> [[-DestinationPath] <String>] [-Force] [-PassThru] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Expand-Archive` cmdlet extracts files from a specified zipped archive file to a specified
destination folder. An archive file allows multiple files to be packaged, and optionally compressed,
into a single zipped file for easier distribution and storage.

## EXAMPLES

### Example 1: Extract the contents of an archive

This example extracts the contents of an existing archive file into the folder specified by the
**DestinationPath** parameter.

```powershell
Expand-Archive -LiteralPath 'C:\Archives\Draft[v1].Zip' -DestinationPath C:\Reference
```

In this example, the **LiteralPath** parameter is used because the filename contains characters that
could be interpreted as wildcards.

### Example 2: Extract the contents of an archive in the current folder

This example extracts the contents of an existing archive file in the current folder into the folder
specified by the **DestinationPath** parameter.

```powershell
Expand-Archive -Path Draftv2.Zip -DestinationPath C:\Reference
```

## PARAMETERS

### -DestinationPath

By default, `Expand-Archive` creates a folder in the current location that is the same name as the
ZIP file. The parameter allows you to specify the path to a different folder. The target folder is
created if it does not exist.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: A folder in the current location
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Forces the command to run without asking for user confirmation.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralPath

Specifies the path to an archive file. Unlike the **Path** parameter, the value of **LiteralPath**
is used exactly as it is typed. Wildcard characters are not supported. If the path includes escape
characters, enclose each escape character in single quotation marks, to instruct PowerShell not to
interpret any characters as escape sequences.

```yaml
Type: System.String
Parameter Sets: LiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PassThru

Causes the cmdlet to output a list of the files expanded from the archive.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specifies the path to the archive file.

```yaml
Type: System.String
Parameter Sets: Path
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a string that contains a path to an existing archive file.

## OUTPUTS

### System.IO.FileSystemInfo

When the `-PassThru` parameter is used, the cmdlet outputs a list of files that were expanded from
the archive.

## NOTES

The [ZIP file specification](https://pkware.cachefly.net/webdocs/casestudies/APPNOTE.TXT) does not
specify a standard way of encoding filenames that contain non-ASCII characters. The
`Compress-Archive` cmdlet uses UTF-8 encoding. Other ZIP archive tools may use a different encoding
scheme. When extracting files with filenames not stored using UTF-8 encoding, `Expand-Archive` uses
the raw value found in the archive. This can result in a filename that is different than the source
filename stored in the archive.

## RELATED LINKS

[Compress-Archive](compress-archive.md)

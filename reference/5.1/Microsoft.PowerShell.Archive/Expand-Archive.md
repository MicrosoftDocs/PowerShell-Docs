---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Expand Archive
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/?LinkId=821655
external help file:   Microsoft.PowerShell.Archive-help.xml
---


# Expand-Archive

## SYNOPSIS
Extracts files from a specified archive (zipped) file.

## SYNTAX

### Path (Default)
```
Expand-Archive [-Path] <String> [[-DestinationPath] <String>] [-Force] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### LiteralPath
```
Expand-Archive -LiteralPath <String> [[-DestinationPath] <String>] [-Force] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
The **Expand-Archive** cmdlet extracts files from a specified zipped archive file to a specified destination folder.
An archive file allows multiple files to be packaged, and optionally compressed, into a single zipped file for easier distribution and storage.

## EXAMPLES

### Example 1: Extract the contents of an archive
```
PS C:\> Expand-Archive -LiteralPath C:\Archives\Draft.Zip -DestinationPath C:\Reference
```

This command extracts the contents of an existing archive file, Draft.zip, into the folder specified by the *DestinationPath* parameter, C:\Reference.

### Example 2: Extract the contents of an archive in the current folder
```
PS C:\> Expand-Archive -Path Draft.Zip -DestinationPath C:\Reference
```

This command extracts the contents of an existing archive file in the current folder, Draft.zip, into the folder specified by the *DestinationPath* parameter, C:\Reference.

## PARAMETERS

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DestinationPath
Specifies the path to the folder in which you want the command to save extracted files.
Enter the path to a folder, but do not specify a file name or file name extension.
This parameter is required.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Forces the command to run without asking for user confirmation.

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

### -LiteralPath
Specifies the path to an archive file.
Unlike the *Path* parameter, the value of *LiteralPath* is used exactly as it is typed.
Wildcard characters are not supported.
If the path includes escape characters, enclose each escape character in single quotation marks, to instruct Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String
Parameter Sets: LiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path
Specifies the path to the archive file.

```yaml
Type: String
Parameter Sets: Path
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
You can pipe a string that contains a path to an existing archive file.

## OUTPUTS

### System.IO.FileInfo or System.IO.DirectoryInfo

## NOTES

## RELATED LINKS


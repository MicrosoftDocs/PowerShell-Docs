---
external help file: Microsoft.PowerShell.Archive.psm1-help.xml
online version: http://go.microsoft.com/fwlink/?LinkID=393253
schema: 2.0.0
---

# Expand-Archive
## SYNOPSIS
Extracts files from a specified archive (zipped) file.

## SYNTAX

### Path (Default)
```
Expand-Archive [-Path] <String> [[-DestinationPath] <String>] [-Force] [-WhatIf] [-Confirm]
```

### LiteralPath
```
Expand-Archive -LiteralPath <String> [[-DestinationPath] <String>] [-Force] [-WhatIf] [-Confirm]
```

## DESCRIPTION
The Expand-Archive cmdlet extracts files from a specified zipped archive file to a specified destination folder.
An archive file allows multiple files to be packaged, and optionally compressed, into a single zipped file for easier distribution and storage.

## EXAMPLES

### Example 1: Extract the contents of an archive
```
PS C:\>Expand-Archive -LiteralPath C:\Archives\Draft.Zip -DestinationPath C:\Reference
```

This command extracts the contents of an existing archive file, Draft.zip, into the folder specified by the DestinationPath parameter, C:\Reference.

### Example 2: Extract the contents of an archive in the current folder
```
PS C:\>Expand-Archive -Path Draft.Zip -DestinationPath C:\Reference
```

This command extracts the contents of an existing archive file in the current folder, Draft.zip, into the folder specified by the DestinationPath parameter, C:\Reference.

## PARAMETERS

### -DestinationPath
Specifies the path to the folder in which you want the command to save extracted files.
Enter the path to a folder, but do not specify a file name or file name extension.
This parameter is required.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Forces the extraction of files from an archive file.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralPath
Specifies the path to an archive file.
Unlike the Path parameter, the value of LiteralPath is used exactly as it is typed.
Wildcard characters are not supported.
If the path includes escape characters, enclose each escape character in single quotation marks, to instruct Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String
Parameter Sets: LiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: 
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
Position: 1
Default value: 
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

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

## INPUTS

### System.String
You can pipe a string that contains a path to an existing archive file.

## OUTPUTS

### System.IO.FileInfo or System.IO.DirectoryInfo

## NOTES

## RELATED LINKS


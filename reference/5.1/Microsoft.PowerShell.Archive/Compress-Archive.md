---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821654
external help file:  Microsoft.PowerShell.Archive-help.xml
title:  Compress-Archive
---

# Compress-Archive

## SYNOPSIS
Creates an archive, or zipped file, from specified files and folders.

## SYNTAX

### Path (Default)
```powershell
Compress-Archive [-Path] <String[]> [-DestinationPath] <String> [-CompressionLevel <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### PathWithUpdate
```powershell
Compress-Archive [-Path] <String[]> [-DestinationPath] <String> [-CompressionLevel <String>] [-Update]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### PathWithForce
```powershell
Compress-Archive [-Path] <String[]> [-DestinationPath] <String> [-CompressionLevel <String>] [-Force] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### LiteralPathWithUpdate
```powershell
Compress-Archive -LiteralPath <String[]> [-DestinationPath] <String> [-CompressionLevel <String>] [-Update]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### LiteralPathWithForce
```powershell
Compress-Archive -LiteralPath <String[]> [-DestinationPath] <String> [-CompressionLevel <String>] [-Force]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### LiteralPath
```powershell
Compress-Archive -LiteralPath <String[]> [-DestinationPath] <String> [-CompressionLevel <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The `Compress-Archive` cmdlet creates a zipped (or compressed) archive file from one or more specified files or folders.
An archive file allows multiple files to be packaged, and optionally compressed, into a single zipped file for easier distribution and storage.
An archive file can be compressed by using the compression algorithm specified by the CompressionLevel parameter.

Because `Compress-Archive` relies upon the Microsoft .NET Framework API `System.IO.Compression.ZipArchive` to compress files, the maximum file size that you can compress by using `Compress-Archive` is currently 2 GB.
This is a limitation of the underlying API.

## EXAMPLES

### Example 1: Create an archive file
```powershell
Compress-Archive -Path C:\Reference\Draftdoc.docx, C:\Reference\Images\diagram2.vsd -CompressionLevel Optimal -DestinationPath C:\Archives\Draft.Zip
```
### Example 2: Create an archive file (using LiteralPath)
```powershell
Compress-Archive -LiteralPath "C:\Reference\Draft Doc.docx", "C:\Reference\Images\Diagram 2.vsd"  -CompressionLevel Optimal -DestinationPath C:\Archives\Draft.Zip
```

This command creates a new archive file, Draft.zip, by compressing two files, Draftdoc.docx and diagram2.vsd, specified by the **LiteralPath** parameter.
The compression level specified for this operation is Optimal.

### Example 3: Create an archive with wildcard characters
```powershell
Compress-Archive -Path C:\Reference\* -CompressionLevel Fastest -DestinationPath C:\Archives\Draft
```

This command creates a new archive file, Draft.zip, in the C:\Archives folder.
Note that though the file name extension .zip was not added to the value of the **DestinationPath** parameter, Windows PowerShell appends this to the specified archive file name automatically.
The new archive file contains every file in the C:\Reference folder, because a wildcard character was used in place of specific file names in the **Path** parameter.
The specified compression level is Fastest, which might result in a larger output file, but compresses a large number of files faster.

### Example 4: Update an existing archive file
```powershell
Compress-Archive -Path C:\Reference\* -Update -DestinationPath C:\Archives\Draft.Zip
```

This command updates an existing archive file, Draft.Zip, in the C:\Archives folder.
The command is run to update Draft.Zip with newer versions of existing files that came from the C:\Reference folder, and also to add new files that have been added to C:\Reference since Draft.Zip was initially created.

### Example 5: Create an archive from an entire folder
```powershell
Compress-Archive -Path C:\Reference -DestinationPath C:\Archives\Draft
```

This command creates an archive from an entire folder, C:\Reference.
Note that though the file name extension .zip was not added to the value of the **DestinationPath** parameter, Windows PowerShell appends this to the specified archive file name automatically.

## PARAMETERS

### -CompressionLevel
Specifies how much compression to apply when you are creating the archive file.
Faster compression requires less time to create the file, but can result in larger file sizes.
The acceptable values for this parameter are:

- Fastest.
Use the fastest compression method available to decrease processing time; this can result in larger file sizes.
- NoCompression.
Do not compress the source files.
- Optimal.
Processing time is dependent on file size.

If this parameter is not specified, the command uses the default value, Optimal.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Optimal, NoCompression, Fastest

Required: False
Position: Named
Default value: Optimal
Accept pipeline input: False
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

### -DestinationPath
Specifies the path to the archive output file.
This parameter is required.
The specified **DestinationPath** value should include the desired name of the output zipped file; it specifies either the absolute or relative path to the zipped file.
If the file name specified in **DestinationPath** does not have a .zip file name extension, the cmdlet adds a .zip file name extension.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Forces the command to run without asking for user confirmation.

```yaml
Type: SwitchParameter
Parameter Sets: PathWithForce, LiteralPathWithForce
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralPath
Specifies the path or paths to the files that you want to add to the archive zipped file.
Unlike the **Path** parameter, the value of **LiteralPath** is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose each escape character in single quotation marks, to instruct Windows PowerShell not to interpret any characters as escape sequences.
To specify multiple paths, and include files in multiple locations in your output zipped file, use commas to separate the paths.

```yaml
Type: String[]
Parameter Sets: LiteralPathWithUpdate, LiteralPathWithForce, LiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path
Specifies the path or paths to the files that you want to add to the archive zipped file.
This parameter can accept wildcard characters.
Wildcard characters allow you to add all files in a folder to your zipped archive file.
To specify multiple paths, and include files in multiple locations in your output zipped file, use commas to separate the paths.

```yaml
Type: String[]
Parameter Sets: Path, PathWithUpdate, PathWithForce
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Update
Updates the specified archive by replacing older versions of files in the archive with newer versions of files that have the same names.
You can also add this parameter to add files to an existing archive.

```yaml
Type: SwitchParameter
Parameter Sets: PathWithUpdate, LiteralPathWithUpdate
Aliases:

Required: True
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
You can pipe a string that contains a path to one or more files.

## OUTPUTS

### System.IO.FileInfo

## NOTES

## RELATED LINKS

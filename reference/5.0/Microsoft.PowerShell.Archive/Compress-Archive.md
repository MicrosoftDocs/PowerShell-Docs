---
external help file: Microsoft.PowerShell.Archive-help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Archive
ms.date: 02/12/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.archive/compress-archive?view=powershell-5.0&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Compress-Archive
---

# Compress-Archive

## SYNOPSIS
Creates a compressed archive, or zipped file, from specified files and folders.

## SYNTAX

### Path (Default)

```
Compress-Archive [-Path] <String[]> [-DestinationPath] <String> [-CompressionLevel <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### PathWithUpdate

```
Compress-Archive [-Path] <String[]> [-DestinationPath] <String> [-CompressionLevel <String>] [-Update]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### PathWithForce

```
Compress-Archive [-Path] <String[]> [-DestinationPath] <String> [-CompressionLevel <String>] [-Force] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### LiteralPathWithUpdate

```
Compress-Archive -LiteralPath <String[]> [-DestinationPath] <String> [-CompressionLevel <String>] [-Update]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### LiteralPathWithForce

```
Compress-Archive -LiteralPath <String[]> [-DestinationPath] <String> [-CompressionLevel <String>] [-Force]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### LiteralPath

```
Compress-Archive -LiteralPath <String[]> [-DestinationPath] <String> [-CompressionLevel <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Compress-Archive` cmdlet creates a compressed, or zipped, archive file from one or more
specified files or folders. An archive packages multiple files, with optional compression, into a
single zipped file for easier distribution and storage. An archive file can be compressed by using
the compression algorithm specified by the **CompressionLevel** parameter.

The `Compress-Archive` cmdlet uses the Microsoft .NET API [System.IO.Compression.ZipArchive](/dotnet/api/system.io.compression.ziparchive)
to compress files. The maximum file size is 2 GB because there's a limitation of the underlying API.

Some examples use splatting to reduce the line length of the code samples. For more information, see
[about_Splatting](../Microsoft.PowerShell.Core/About/about_Splatting.md).

## EXAMPLES

### Example 1: Create an archive file

This example creates a new archive file, `Draft.zip`, by compressing two files, `Draftdoc.docx` and
`diagram2.vsd`, specified by the **Path** parameter. The compression level specified for this
operation is **Optimal**.

```powershell
$compress = @{
Path= "C:\Test\Reference\Draftdoc.docx", "C:\Test\Reference\Images\diagram2.vsd"
CompressionLevel = "Optimal"
DestinationPath = "C:\Test\Archives\Draft.Zip"
}
Compress-Archive @compress
```

### Example 2: Create an archive file using LiteralPath

This example creates a new archive file, `Draft.zip`, by compressing two files, `Draft doc.docx` and
`Diagram [2].vsd`, specified by the **LiteralPath** parameter. The compression level specified for
this operation is **Optimal**.

```powershell
$compress = @{
LiteralPath= "C:\Test\Reference\Draft Doc.docx", "C:\Test\Reference\Images\Diagram [2].vsd"
CompressionLevel = "Optimal"
DestinationPath = "C:\Test\Archives\Draft.Zip"
}
Compress-Archive @compress
```

### Example 3: Create an archive with wildcard characters

This example creates a new archive file, `Draft.zip`, in the `C:\Archives` folder. The new archive
file contains every file, folder, and subfolder in the `C:\Reference` root folder, because an
asterisk (`*`) wildcard character was used in place of specific file names in the **Path**
parameter. The root folder, `Reference`, is excluded from the archive.

```powershell
Compress-Archive -Path C:\Reference\* -CompressionLevel Fastest -DestinationPath C:\Archives\Draft
```

Notice that the file name extension `.zip` wasn't added to the value of the **DestinationPath**
parameter. PowerShell appends the `.zip` extension to the file name automatically. The specified
compression level is **Fastest**. The faster compression level will compress large numbers of files
faster, but might result in a larger output file.

> [!NOTE]
> To zip only the files in the specified root folder, use the **star-dot-star** (`*.*`) wildcard.

### Example 4: Update an existing archive file

This example updates an existing archive file, `Draft.Zip`, in the `C:\Archives` folder.

```powershell
Compress-Archive -Path C:\Reference\* -Update -DestinationPath C:\Archives\Draft.Zip
```

The command is run to update `Draft.Zip` with newer versions of existing files that came from the
C:\Reference folder, and also to add new files that have been added to `C:\Reference` since
`Draft.Zip` was initially created.

### Example 5: Create an archive from an entire folder

This example creates an archive from an entire folder, `C:\Reference`. The archive contains the root
folder, `Reference`, and all its files, folders, and subfolders.

```powershell
Compress-Archive -Path C:\Reference -DestinationPath C:\Archives\Draft
```

Notice that the file name extension `.zip` wasn't added to the value of the **DestinationPath**
parameter. PowerShell appends the `.zip` extension to the file name automatically.

## PARAMETERS

### -CompressionLevel

Specifies how much compression to apply when you're creating the archive file. Faster compression
requires less time to create the file, but can result in larger file sizes.

If this parameter isn't specified, the command uses the default value, **Optimal**.

The acceptable values for this parameter are as follows:

- **Fastest**. Use the fastest compression method available to reduce processing time. Faster
  compression can result in larger file sizes.
- **NoCompression**. Doesn't compress the source files.
- **Optimal**. Processing time is dependent on file size.

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

Specifies the path to the archive output file. This parameter is required. The specified
**DestinationPath** value should include the desired name of the output zipped file, and specifies
either the absolute or relative path to the zipped file. If the file name specified in
**DestinationPath** doesn't have a `.zip` file name extension, the cmdlet adds a `.zip` file name
extension.

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

Specifies the path or paths to the files that you want to add to the archive zipped file. Unlike the
**Path** parameter, the value of **LiteralPath** is used exactly as it's typed. No characters are
interpreted as wildcards. If the path includes escape characters, enclose each escape character in
single quotation marks, to instruct PowerShell not to interpret any characters as escape sequences.
To specify multiple paths, and include files in multiple locations in your output zipped file, use
commas to separate the paths.

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

Specifies the path or paths to the files that you want to add to the archive zipped file. This
parameter can accept wildcard characters. Wildcard characters allow you to add all files in a folder
to your zipped archive file. To specify multiple paths, and include files in multiple locations in
your output zipped file, use commas to separate the paths.

To zip all the files, folders, and subfolders in a specified root folder, use the asterisk (`*`)
wildcard. The root folder is excluded from the archive.

For example:

`-Path C:\Reference\*`

To zip only the files in the specified root folder, use the **star-dot-star** (`*.*`) wildcard.

For example:

`-Path C:\Reference\*.*`

```yaml
Type: String[]
Parameter Sets: Path, PathWithUpdate, PathWithForce
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -Update

Updates the specified archive by replacing older file versions in the archive with newer file
versions that have the same names. You can also add this parameter to add files to an existing
archive.

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

Shows what would happen if the cmdlet runs. The cmdlet isn't run.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a string that contains a path to one or more files.

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[Expand-Archive](Expand-Archive.md)

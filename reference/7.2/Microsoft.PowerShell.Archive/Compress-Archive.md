---
external help file: Microsoft.PowerShell.Archive-help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Archive
ms.date: 02/20/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.archive/compress-archive?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Compress-Archive
---

# Compress-Archive

## SYNOPSIS
Creates a compressed archive, or zipped file, from specified files and directories.

## SYNTAX

### Path (Default)

```
Compress-Archive [-Path] <String[]> [-DestinationPath] <String> [-CompressionLevel <String>]
 [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### PathWithUpdate

```
Compress-Archive [-Path] <String[]> [-DestinationPath] <String> [-CompressionLevel <String>] -Update
 [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### PathWithForce

```
Compress-Archive [-Path] <String[]> [-DestinationPath] <String> [-CompressionLevel <String>] -Force
 [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### LiteralPathWithUpdate

```
Compress-Archive -LiteralPath <String[]> [-DestinationPath] <String> [-CompressionLevel <String>]
 -Update [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### LiteralPathWithForce

```
Compress-Archive -LiteralPath <String[]> [-DestinationPath] <String> [-CompressionLevel <String>]
 -Force [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### LiteralPath

```
Compress-Archive -LiteralPath <String[]> [-DestinationPath] <String> [-CompressionLevel <String>]
 [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Compress-Archive` cmdlet creates a compressed, or zipped, archive file from one or more
specified files or directories. An archive packages multiple files, with optional compression, into
a single zipped file for easier distribution and storage. An archive file can be compressed by using
the compression algorithm specified by the **CompressionLevel** parameter.

The `Compress-Archive` cmdlet uses the Microsoft .NET API
[System.IO.Compression.ZipArchive](/dotnet/api/system.io.compression.ziparchive) to compress files.
The maximum file size is 2 GB because there's a limitation of the underlying API.

Some examples use splatting to reduce the line length of the code samples. For more information, see
[about_Splatting](../Microsoft.PowerShell.Core/About/about_Splatting.md).

## EXAMPLES

### Example 1: Compress files to create an archive file

This example compresses files from different directories and creates an archive file. A wildcard is
used to get all files with a particular file extension. There's no directory structure in the
archive file because the **Path** only specifies file names.

```powershell
$compress = @{
  Path = "C:\Reference\Draftdoc.docx", "C:\Reference\Images\*.vsd"
  CompressionLevel = "Fastest"
  DestinationPath = "C:\Archives\Draft.Zip"
}
Compress-Archive @compress
```

The **Path** parameter accepts specific file names and file names with wildcards, `*.vsd`. The
**Path** uses a comma-separated list to get files from different directories. The compression level
is **Fastest** to reduce processing time. The **DestinationPath** parameter specifies the location
for the `Draft.zip` file. The `Draft.zip` file contains `Draftdoc.docx` and all the files with a
`.vsd` extension.

### Example 2: Compress files using a LiteralPath

This example compresses specific named files and creates a new archive file. There's no directory
structure in the archive file because the **Path** only specifies file names.

```powershell
$compress = @{
LiteralPath= "C:\Reference\Draft Doc.docx", "C:\Reference\Images\diagram2.vsd"
CompressionLevel = "Fastest"
DestinationPath = "C:\Archives\Draft.Zip"
}
Compress-Archive @compress
```

Absolute path and file names are used because the **LiteralPath** parameter doesn't accept
wildcards. The **Path** uses a comma-separated list to get files from different directories. The
compression level is **Fastest** to reduce processing time. The **DestinationPath** parameter
specifies the location for the `Draft.zip` file. The `Draft.zip` file only contains `Draftdoc.docx`
and `diagram2.vsd`.

### Example 3: Compress a directory that includes the root directory

This example compresses a directory and creates an archive file that **includes** the root
directory, and all its files and subdirectories. The archive file has a directory structure because
the **Path** specifies a root directory.

```powershell
Compress-Archive -Path C:\Reference -DestinationPath C:\Archives\Draft.zip
```

`Compress-Archive` uses the **Path** parameter to specify the root directory, `C:\Reference`. The
**DestinationPath** parameter specifies the location for the archive file. The `Draft.zip` archive
includes the `Reference` root directory, and all its files and subdirectories.

### Example 4: Compress a directory that excludes the root directory

This example compresses a directory and creates an archive file that **excludes** the root directory
because the **Path** uses an asterisk (`*`) wildcard. The archive contains a directory structure
that contains the root directory's files and subdirectories.

```powershell
Compress-Archive -Path C:\Reference\* -DestinationPath C:\Archives\Draft.zip
```

`Compress-Archive` uses the **Path** parameter to specify the root directory, `C:\Reference` with an
asterisk (`*`) wildcard. The **DestinationPath** parameter specifies the location for the archive
file. The `Draft.zip` archive contains the root directory's files and subdirectories. The
`Reference` root directory is excluded from the archive.

### Example 5: Compress only the files in a root directory

This example compresses only the files in a root directory and creates an archive file. There's no
directory structure in the archive because only files are compressed.

```powershell
Compress-Archive -Path C:\Reference\*.* -DestinationPath C:\Archives\Draft.zip
```

`Compress-Archive` uses the **Path** parameter to specify the root directory, `C:\Reference` with a
**star-dot-star** (`*.*`) wildcard. The **DestinationPath** parameter specifies the location for the
archive file. The `Draft.zip` archive only contains the `Reference` root directory's files and the
root directory is excluded.

### Example 6: Use the pipeline to archive files

This example sends files down the pipeline to create an archive. There's no directory structure in
the archive file because the **Path** only specifies file names.

```powershell
Get-ChildItem -Path C:\Reference\Afile.txt, C:\Reference\Images\Bfile.txt |
  Compress-Archive -DestinationPath C:\Archives\PipelineFiles.zip
```

`Get-ChildItem` uses the **Path** parameter to specify two files from different directories. Each
file is represented by a **FileInfo** object and is sent down the pipeline to `Compress-Archive`.
The two specified files are archived in `PipelineFiles.zip`.

### Example 7: Use the pipeline to archive a directory

This example sends a directory down the pipeline to create an archive. Files are sent as
**FileInfo** objects and directories as **DirectoryInfo** objects. The archive's directory structure
doesn't include the root directory, but its files and subdirectories are included in the archive.

```powershell
Get-ChildItem -Path C:\LogFiles | Compress-Archive -DestinationPath C:\Archives\PipelineDir.zip
```

`Get-ChildItem` uses the **Path** parameter to specify the `C:\LogFiles` root directory. Each
**FileInfo** and **DirectoryInfo** object is sent down the pipeline.

`Compress-Archive` adds each object to the `PipelineDir.zip` archive. The **Path** parameter isn't
specified because the pipeline objects are received into parameter position 0.

### Example 8: How recursion can affect archives

This example shows how recursion can duplicate files in your archive. For example, if you use
`Get-ChildItem` with the **Recurse** parameter. As recursion processes, each **FileInfo** and
**DirectoryInfo** object is sent down the pipeline and added to the archive.

```powershell
Get-ChildItem -Path C:\TestLog -Recurse |
  Compress-Archive -DestinationPath C:\Archives\PipelineRecurse.zip
```

The `C:\TestLog` directory doesn't contain any files. It does contain a subdirectory named `testsub`
that contains the `testlog.txt` file.

`Get-ChildItem` uses the **Path** parameter to specify the root directory, `C:\TestLog`. The
**Recurse** parameter processes the files and directories. A **DirectoryInfo** object is created for
`testsub` and a **FileInfo** object `testlog.txt`.

Each object is sent down the pipeline to `Compress-Archive`. The **DestinationPath** specifies the
location for the archive file. The **Path** parameter isn't specified because the pipeline objects
are received into parameter position 0.

The following summary describes the `PipelineRecurse.zip` archive's contents that contains a
duplicate file:

- The **DirectoryInfo** object creates the `testsub` directory and contains the `testlog.txt` file,
  which reflects the original directory structure.
- The **FileInfo** object creates a duplicate `testlog.txt` in the archive's root. The duplicate
  file is created because recursion sent a file object to `Compress-Archive`. This behavior is
  expected because each object sent down the pipeline is added to the archive.

### Example 9: Update an existing archive file

This example updates an existing archive file, `Draft.Zip`, in the `C:\Archives` directory. In this
example, the existing archive file contains the root directory, and its files and subdirectories.

```powershell
Compress-Archive -Path C:\Reference -Update -DestinationPath C:\Archives\Draft.Zip
```

The command updates `Draft.Zip` with newer versions of existing files in the `C:\Reference`
directory and its subdirectories. And, new files that were added to `C:\Reference` or its
subdirectories are included in the updated `Draft.Zip` archive.

## PARAMETERS

### -CompressionLevel

Specifies how much compression to apply when you're creating the archive file. Faster compression
requires less time to create the file, but can result in larger file sizes.

If this parameter isn't specified, the command uses the default value, **Optimal**.

The following are the acceptable values for this parameter:

- **Fastest**. Use the fastest compression method available to reduce processing time. Faster
  compression can result in larger file sizes.
- **NoCompression**. Doesn't compress the source files.
- **Optimal**. Processing time is dependent on file size.

```yaml
Type: System.String
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
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DestinationPath

This parameter is required and specifies the path to the archive output file. The
**DestinationPath** should include the name of the zipped file, and either the absolute or relative
path to the zipped file.

If the file name in **DestinationPath** doesn't have a `.zip` file name extension, the cmdlet adds
the `.zip` file name extension.

```yaml
Type: System.String
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
Type: System.Management.Automation.SwitchParameter
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
Type: System.String[]
Parameter Sets: LiteralPathWithUpdate, LiteralPathWithForce, LiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PassThru

Causes the cmdlet to output a file object representing the archive file created.

This parameter was introduced in PowerShell 6.0.

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

### -Path

Specifies the path or paths to the files that you want to add to the archive zipped file. To specify
multiple paths, and include files in multiple locations, use commas to separate the paths.

This parameter accepts wildcard characters. Wildcard characters allow you to add all files in a
directory to your archive file.

Using wildcards with a root directory affects the archive's contents:

- To create an archive that **includes** the root directory, and all its files and subdirectories,
  specify the root directory in the **Path** without wildcards. For example: `-Path C:\Reference`
- To create an archive that **excludes** the root directory, but zips all its files and
  subdirectories, use the asterisk (`*`) wildcard. For example: `-Path C:\Reference\*`
- To create an archive that only zips the files in the root directory, use the **star-dot-star**
  (`*.*`) wildcard. Subdirectories of the root aren't included in the archive. For example:
  `-Path C:\Reference\*.*`

```yaml
Type: System.String[]
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
Type: System.Management.Automation.SwitchParameter
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

You can pipe a string that contains a path to one or more files.

## OUTPUTS

### System.IO.FileInfo

The cmdlet only returns a **FileInfo** object when you use the **PassThru** parameter.

## NOTES

Using recursion and sending objects down the pipeline can duplicate files in your archive. For
example, if you use `Get-ChildItem` with the **Recurse** parameter, each **FileInfo** and
**DirectoryInfo** object that's sent down the pipeline is added to the archive.

The [ZIP file specification](https://pkware.cachefly.net/webdocs/casestudies/APPNOTE.TXT) does not
specify a standard way of encoding filenames that contain non-ASCII characters. The
`Compress-Archive` cmdlet uses UTF-8 encoding. Other ZIP archive tools may use a different encoding
scheme. When extracting files with filenames not stored using UTF-8 encoding, `Expand-Archive` uses
the raw value found in the archive. This can result in a filename that is different than the source
filename stored in the archive.

## RELATED LINKS

[Expand-Archive](Expand-Archive.md)

[Get-ChildItem](../Microsoft.PowerShell.Management/Get-ChildItem.md)


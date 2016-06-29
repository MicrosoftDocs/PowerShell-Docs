# Archive cmdlets

Two new cmdlets, **Compress-Archive** and **Expand-Archive**, let you compress and expand ZIP files.

## Compress-Archive
The **Compress-Archive** cmdlet creates a new archive file from specified files. An archive file allows multiple files to be packaged and optionally compressed into a single file for easier handling and storage. An archive file can be compressed by using a compression algorithm specified in the **-CompressionLevel** parameter.
```PowerShell
Compress-Archive -LiteralPath <String[]> [-DestinationPath] <String> [-Update] [-CompressionLevel <Microsoft.PowerShell.Commands.CompressionLevel>] 
Compress-Archive [-Path] <String[]> [-DestinationPath] <String> [-Update] [-CompressionLevel <Microsoft.PowerShell.Commands.CompressionLevel>]
```

## Expand-Archive
The **Expand-Archive** cmdlet extracts files from a specified archive file. An archive file allows multiple files to be packaged and optionally compressed into a single file for easier handling and storage.
```PowerShell
Expand-Archive -LiteralPath <String> [-DestinationPath] <String>
Expand-Archive [-Path] <String> [-DestinationPath] <String>
```

---
external help file: Microsoft.PowerShell.ConsoleHost.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Host
ms.date: 10/21/2026
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.host/start-transcript?view=powershell-7.7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Start-Transcript
---
# Start-Transcript

## SYNOPSIS
Creates a record of all or part of a PowerShell session to a text file.

## SYNTAX

### ByPath (Default)

```
Start-Transcript [[-Path] <String>] [-Append] [-Force] [-NoClobber]
 [-IncludeInvocationHeader] [-UseMinimalHeader] [-IncludeTimeStamp]
 [-TimeStampFormat <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ByLiteralPath

```
Start-Transcript [[-LiteralPath] <String>] [-Append] [-Force] [-NoClobber]
 [-IncludeInvocationHeader] [-UseMinimalHeader] [-IncludeTimeStamp]
 [-TimeStampFormat <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ByOutputDirectory

```
Start-Transcript [[-OutputDirectory] <String>] [-Append] [-Force] [-NoClobber]
 [-IncludeInvocationHeader] [-UseMinimalHeader] [-IncludeTimeStamp]
 [-TimeStampFormat <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Start-Transcript` cmdlet creates a record of all or part of a PowerShell session to a text
file. The transcript includes all command that the user types and all output that appears on the
console.

By default, `Start-Transcript` stores the transcript in the following location using the default
name:

- On Windows: `$HOME\Documents`
- On Linux or macOS: `$HOME`

The default filename is `PowerShell_transcript.<computername>.<random>.<timestamp>.txt`.

Starting in Windows PowerShell 5.0, `Start-Transcript` includes the hostname in the generated file
name of all transcripts. The filename also includes random characters in names to prevent potential
overwrites or duplication when you start two or more transcripts simultaneously. Including the
computer name is useful if you store your transcripts in a centralized location. The random
character string prevents guessing of the filename to gain unauthorized access to the file.

If the target file doesn't have a Byte Order Mark (BOM), `Start-Transcript` defaults to `Utf8NoBom`
encoding in the target file.

## EXAMPLES

### Example 1: Start a transcript file with default settings

```powershell
Start-Transcript
```

This command starts a transcript in the default file location.

### Example 2: Start a transcript file at a specific location

```powershell
Start-Transcript -Path "C:\transcripts\transcript0.txt" -NoClobber
```

This command starts a transcript in the `Transcript0.txt` file in `C:\transcripts`. **NoClobber**
parameter prevents any existing files from being overwritten. If the `Transcript0.txt` file already
exists, the command fails.

### Example 3: Start a transcript file with a unique name and store it on a file share

The following example creates a transcript file with a name unique enough to be stored on in a
shared location. The filename is constructed from the user's name, the hostname of the computer
running PowerShell, the version of PowerShell, and the date and time. The transcript is stored in
the `\\Server01\Transcripts` file share.

```powershell
$sharePath  = '\\Server01\Transcripts'
$username   = $Env:USERNAME
$hostname   = hostname
$version    = $PSVersionTable.PSVersion.ToString()
$datetime   = Get-Date -F 'yyyyMMddHHmmss'
$filename   = "Transcript-${username}-${hostname}-${version}-${datetime}.txt"
$Transcript = Join-Path -Path $sharePath -ChildPath $filename
Start-Transcript
```

The full path to the transcript file is stored in the `$Transcript` preference variable. For more
information about the `$Transcript` preference variable, see
[about_Preference_Variables](../Microsoft.PowerShell.Core/About/about_Preference_Variables.md#transcript).

### Example 4: Start a transcript using a relative path on Windows systems

When you use a relative path with the **OutputDirectory** parameter on Windows, the path is relative
to your `Documents` directory.

```powershell
Start-Transcript -Path .\transcripts
```

```Output
Transcript started, output file is C:\Users\username\Documents\.\transcripts\PowerShell_transcript.HOSTNAME.8S6RpEfN.20251105152247.txt
```

### Example 5: Start a transcript using a relative path on non-Windows systems

When you use a relative path with the **OutputDirectory** parameter on non-Windows systems, the
path is relative to your home directory.

```powershell
Start-Transcript -Path ./transcripts
```

```Output
Transcript started, output file is /home/username/./transcripts/PowerShell_transcript.hostname.ift21QeV.20251105151236.txt
```

### Example 6: Record a timestamp for each line of transcript output

The **IncludeTimeStamp** parameter prefixes each recorded line of command input and output with
the time it was recorded. The default timestamp format is `yyyy-MM-dd HH:mm:ss`.

```powershell
Start-Transcript -Path .\transcript.txt -IncludeTimeStamp
Write-Host 'Processing started'
Start-Sleep -Seconds 5
Write-Host 'Processing complete'
Stop-Transcript
Get-Content .\transcript.txt | Select-Object -Last 4
```

```Output
2026-10-21 19:12:09 Processing started
2026-10-21 19:12:14 Processing complete
**********************
PowerShell transcript end
```

### Example 7: Record timestamps in a custom format

The **TimeStampFormat** parameter accepts any standard or custom .NET date and time format
string. Specifying it implies the **IncludeTimeStamp** parameter. Timestamps are rendered using
the invariant culture.

```powershell
Start-Transcript -Path .\transcript.txt -TimeStampFormat 'HH:mm:ss.fff'
Write-Host 'Processing started'
Stop-Transcript
Get-Content .\transcript.txt | Select-Object -Last 3
```

```Output
19:12:09.482 Processing started
**********************
PowerShell transcript end
```

For more information about format strings, see
[standard date and time format strings](/dotnet/standard/base-types/standard-date-and-time-format-strings)
and [custom date and time format strings](/dotnet/standard/base-types/custom-date-and-time-format-strings).

## PARAMETERS

### -Append

Indicates that this cmdlet adds the new transcript to the end of an existing file. Use the **Path**
parameter to specify the file.

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

### -Force

Allows the cmdlet to append the transcript to an existing read-only file. When used on a read-only
file, the cmdlet changes the file permission to read-write. The cmdlet can't override security
restrictions when this parameter is used.

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

### -IncludeInvocationHeader

Indicates that this cmdlet logs the time stamp when commands are run.

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

### -IncludeTimeStamp

Indicates that this cmdlet prefixes each recorded line of command input and output with a
timestamp. By default, the timestamp uses the `yyyy-MM-dd HH:mm:ss` format. Use the
**TimeStampFormat** parameter to specify a different format.

Standalone native command output on Windows is captured when the command completes, so all lines
of that output receive the command's completion time. Piping the native command output into a
PowerShell command records each line as it's produced. This parameter was added in PowerShell 7.7.

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

Specifies a location to the transcript file. Unlike the **Path** parameter, the value of the
**LiteralPath** parameter is used exactly as it's typed. No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks. Single quotation marks
inform PowerShell not to interpret any characters as escape sequences.

```yaml
Type: System.String
Parameter Sets: ByLiteralPath
Aliases: PSPath, LP

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoClobber

Indicates that this cmdlet doesn't overwrite an existing file. By default, if a transcript file
exists in the specified path, `Start-Transcript` overwrites the file without warning.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: NoOverwrite

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutputDirectory

Specifies a specific path and folder in which to save a transcript. PowerShell automatically assigns
the transcript name. If you use a relative path, the path is relative to your `Documents` directory
on Windows. On Linux and macOS, the path is relative to your home directory.

```yaml
Type: System.String
Parameter Sets: ByOutputDirectory
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specifies a location to the transcript file. Enter a path to a `.txt` file. Wildcards aren't
permitted. If any of the directories in the path don't exist, the command fails.

If you don't specify a path, `Start-Transcript` uses the path in the value of the `$Transcript`
global variable. If you haven't created this variable, `Start-Transcript` stores the transcripts in
the default location and filename.

```yaml
Type: System.String
Parameter Sets: ByPath
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeStampFormat

Specifies a .NET standard or custom date and time format string, such as `HH:mm:ss` or `o`, for
the timestamp prefix added by the **IncludeTimeStamp** parameter. The default format is
`yyyy-MM-dd HH:mm:ss`. Timestamps are rendered using the invariant culture.

Specifying this parameter implies the **IncludeTimeStamp** parameter. Invalid format strings, or
format strings that produce multi-line timestamps, cause a terminating error. This parameter was
added in PowerShell 7.7.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseMinimalHeader

Prepend a short header to the transcript, instead of the detailed header included by default. This
parameter was added in PowerShell 6.2.

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

### None

You can't pipe objects to this cmdlet.

## OUTPUTS

### System.String

This cmdlet returns a string containing a confirmation message and the path to the output file.

## NOTES

To stop a transcript, use the `Stop-Transcript` cmdlet.

To record an entire session, add the `Start-Transcript` command to your profile. For more
information, see [about_Profiles](../Microsoft.PowerShell.Core/About/about_Profiles.md).

## RELATED LINKS

[Stop-Transcript](Stop-Transcript.md)

[about_Preference_Variables](../Microsoft.PowerShell.Core/About/about_Preference_Variables.md#transcript)

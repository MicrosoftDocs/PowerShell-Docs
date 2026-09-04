---
description: >-
  Understand how default encoding changed from Windows PowerShell 5.1 to
  PowerShell 7 and choose a migration strategy for your scripts.
ms.date: 04/15/2026
title: Encoding changes in PowerShell 7
---

# Encoding changes in PowerShell 7

PowerShell 7 changed the default encoding for file output from
locale-dependent encodings (such as Windows-1252) and UTF-16LE to UTF-8
without a byte order mark (BOM). This change aligns with modern tooling and
cross-platform expectations, but it can break scripts that depend on specific
encodings.

## What changed

### Default encoding comparison

The following table shows the default encoding for common cmdlets and
features in each edition:

| Cmdlet or feature | Windows PowerShell 5.1 | PowerShell 7 |
| ----------------- | ---------------------- | ------------ |
| `Out-File` / `>` operator | UTF-16LE with BOM | UTF-8 without BOM |
| `Set-Content` | System locale (often Windows-1252) | UTF-8 without BOM |
| `Add-Content` | System locale | UTF-8 without BOM |
| `Export-Csv` | ASCII | UTF-8 without BOM |
| `Export-Clixml` | UTF-8 with BOM | UTF-8 without BOM |
| `New-ModuleManifest` | UTF-16LE with BOM | UTF-8 without BOM |
| `Start-Transcript` | UTF-8 with BOM | UTF-8 without BOM |
| `$OutputEncoding` (pipe to native) | ASCII | UTF-8 without BOM |

### The -Encoding parameter

In Windows PowerShell 5.1, the `-Encoding` parameter accepted string values
such as `UTF8`, which produced UTF-8 _with_ BOM. In PowerShell 7, the
parameter accepts `System.Text.Encoding` objects and string values with
updated meanings:

| Value | PowerShell 7 behavior |
| ----- | --------------------- |
| `utf8` | UTF-8 without BOM |
| `utf8BOM` | UTF-8 with BOM |
| `utf8NoBOM` | UTF-8 without BOM (same as `utf8`) |
| `utf16` or `unicode` | UTF-16LE with BOM |
| `utf16BE` or `bigendianunicode` | UTF-16BE with BOM |
| `ascii` | ASCII (7-bit) |
| `oem` | OEM code page |
| `ansi` | ANSI code page |

### Removed: -Encoding Byte

The `Byte` encoding value was removed in PowerShell 7. Use the
`-AsByteStream` parameter instead:

**Before (Windows PowerShell 5.1)**:

```powershell
Get-Content -Path file.bin -Encoding Byte
```

**After (PowerShell 7)**:

```powershell
Get-Content -Path file.bin -AsByteStream
```

## Impact assessment

### Scripts that generate files for other tools

If your scripts use `Out-File`, `Set-Content`, `Export-Csv`, or the `>`
operator to create files that are consumed by other tools, check whether
those tools expect a specific encoding.

Common scenarios that break:

- **SIEM or log analysis tools** that detect file type by BOM. UTF-16LE
  files have a `0xFF 0xFE` BOM; PowerShell 7's UTF-8 files have no BOM.
- **Legacy Windows tools** that expect the system locale encoding
  (such as Windows-1252 for Western European systems).
- **Signed scripts** where the encoding affects the digital signature.
  Re-sign scripts after changing encoding.

### Scripts that read files from Windows PowerShell

If your PowerShell 7 scripts read files that were created by Windows
PowerShell 5.1, encoding detection generally works correctly. PowerShell 7
detects the BOM in UTF-16LE files and reads them without issues. Files
without a BOM are read as UTF-8.

### Pipe-to-native-command changes

The `$OutputEncoding` variable controls the encoding when PowerShell pipes
text to native commands. It changed from ASCII to UTF-8:

- **ASCII** (Windows PowerShell 5.1): Characters outside the 7-bit ASCII
  range were replaced with `?`.
- **UTF-8** (PowerShell 7): Extended characters are preserved but may
  appear garbled if the native command doesn't support UTF-8.

If you pipe output to legacy tools like `cmd.exe /c findstr` and see
garbled characters, set `$OutputEncoding` to ASCII in your session or
profile:

```powershell
$OutputEncoding = [System.Text.Encoding]::ASCII
```

## Migration strategies

### Strategy 1: Embrace UTF-8

UTF-8 is the dominant encoding for modern tools, web APIs, cross-platform
scripts, and version-controlled files. If possible, update all consumers to
expect UTF-8 without BOM.

To re-encode existing files in bulk:

```powershell
Get-ChildItem -Path .\output -Filter *.csv -Recurse | ForEach-Object {
    $content = Get-Content -Path $_.FullName -Raw
    [System.IO.File]::WriteAllText(
        $_.FullName,
        $content,
        [System.Text.UTF8Encoding]::new($false)
    )
}
```

### Strategy 2: Force legacy encoding in PowerShell 7

If you can't update consuming tools, force the old encoding defaults in your
PowerShell 7 profile using `$PSDefaultParameterValues`:

```powershell
# Restore Windows PowerShell 5.1 encoding behavior
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8BOM'
$PSDefaultParameterValues['Set-Content:Encoding'] = 'utf8BOM'
$PSDefaultParameterValues['Add-Content:Encoding'] = 'utf8BOM'
$PSDefaultParameterValues['Export-Csv:Encoding'] = 'utf8BOM'
$PSDefaultParameterValues['Export-Clixml:Encoding'] = 'utf8BOM'
```

> [!IMPORTANT]
> Setting `$PSDefaultParameterValues` in a profile affects all scripts in
> that session. For targeted control, set the encoding per-script instead.

### Strategy 3: Explicit encoding per script

For scripts that must work in both Windows PowerShell 5.1 and PowerShell 7,
always specify the `-Encoding` parameter explicitly:

```powershell
$data | Export-Csv -Path report.csv -Encoding UTF8 -NoTypeInformation
```

> [!NOTE]
> The value `UTF8` produces UTF-8 _with_ BOM in Windows PowerShell 5.1 and
> UTF-8 _without_ BOM in PowerShell 7. If you need identical output in both
> editions, use `[System.Text.UTF8Encoding]::new($true)` (with BOM) or
> `[System.Text.UTF8Encoding]::new($false)` (without BOM) as the
> `-Encoding` value.

## BOM considerations

### When BOMs are required

- XML files consumed by tools that require a BOM to detect encoding
- Signed PowerShell scripts (re-encode and re-sign after migration)
- Interop with older Java versions that expect a UTF-8 BOM
- Files read by applications that default to the system locale without BOM
  detection

### When BOMs cause problems

- Unix and Linux tools (many treat the BOM as visible characters)
- Git diff output (BOM appears as invisible changes at the start of files)
- JSON parsers (the JSON specification prohibits BOMs)
- Shell scripts on non-Windows platforms

### PowerShell 7 reads BOMs correctly

Regardless of the default output encoding, PowerShell 7 detects and
respects BOMs when _reading_ files. A file created with UTF-16LE BOM by
Windows PowerShell 5.1 is read correctly by PowerShell 7.

## Verify encoding in your environment

Use the following function to check the encoding of a file by inspecting
its first few bytes:

```powershell
function Get-FileEncoding {
    param(
        [Parameter(Mandatory)]
        [string]$Path
    )

    $bytes = [byte[]](
        Get-Content -Path $Path -AsByteStream -TotalCount 4
    )

    if ($bytes.Length -ge 3 -and
        $bytes[0] -eq 0xEF -and
        $bytes[1] -eq 0xBB -and
        $bytes[2] -eq 0xBF) {
        'UTF-8 with BOM'
    }
    elseif ($bytes.Length -ge 2 -and
            $bytes[0] -eq 0xFF -and
            $bytes[1] -eq 0xFE) {
        'UTF-16 LE (BOM)'
    }
    elseif ($bytes.Length -ge 2 -and
            $bytes[0] -eq 0xFE -and
            $bytes[1] -eq 0xFF) {
        'UTF-16 BE (BOM)'
    }
    else {
        'No BOM (UTF-8 or ASCII)'
    }
}
```

Scan a directory of output files:

```powershell
Get-ChildItem -Path .\output -File | ForEach-Object {
    [PSCustomObject]@{
        File     = $_.Name
        Encoding = Get-FileEncoding -Path $_.FullName
    }
}
```

## Quick reference

| I need to... | Use this |
| ------------ | -------- |
| Write UTF-8 without BOM (PS 7 default) | `Out-File -Path file.txt` |
| Write UTF-8 with BOM (match WinPS default) | `Out-File -Path file.txt -Encoding utf8BOM` |
| Write UTF-16LE with BOM (match WinPS `>`) | `Out-File -Path file.txt -Encoding unicode` |
| Read binary data | `Get-Content -Path file.bin -AsByteStream` |
| Force ASCII for native pipe | `$OutputEncoding = [System.Text.Encoding]::ASCII` |

## Next steps

- [Migrate PowerShell profiles][profile-migration]
- [Audit scripts for PowerShell 7 compatibility][script-audit]
- [Migrating from Windows PowerShell 5.1 to PowerShell 7][migration-guide]
- [Differences between Windows PowerShell 5.1 and PowerShell 7.x][differences]

<!-- link references -->
[differences]: ../differences-from-windows-powershell.md
[migration-guide]: ../Migrating-from-Windows-PowerShell-51-to-PowerShell-7.md
[profile-migration]: ./profile-migration.md
[script-audit]: ./script-compatibility-audit.md

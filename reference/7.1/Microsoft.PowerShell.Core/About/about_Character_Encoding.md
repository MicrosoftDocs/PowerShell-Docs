---
description: Describes how PowerShell uses character encoding for input and output of string data.
Locale: en-US
ms.date: 10/21/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_character_encoding?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Character_Encoding
---
# about_Character_Encoding

## Short description
Describes how PowerShell uses character encoding for input and output of string
data.

## Long description

Unicode is a worldwide character-encoding standard. The system uses Unicode
exclusively for character and string manipulation. For a detailed description
of all aspects of Unicode, refer to
[The Unicode Standard](https://www.unicode.org/standard/standard.html).

Windows supports Unicode and traditional character sets. Traditional character
sets, such as Windows code pages, use 8-bit values or combinations of 8-bit
values to represent the characters used in a specific language or geographical
region settings.

PowerShell uses a Unicode character set by default. However, several cmdlets
have an **Encoding** parameter that can specify encoding for a different
character set. This parameter allows you to choose the specific the character
encoding you need for interoperability with other systems and applications.

The following cmdlets have the **Encoding** parameter:

- Microsoft.PowerShell.Management
  - Add-Content
  - Get-Content
  - Set-Content
- Microsoft.PowerShell.Utility
  - Export-Clixml
  - Export-Csv
  - Export-PSSession
  - Format-Hex
  - Import-Csv
  - Out-File
  - Select-String
  - Send-MailMessage

## The byte-order-mark

The byte-order-mark (BOM) is a _Unicode signature_ in the first few bytes of a
file or text stream that indicate which Unicode encoding used for the data. For
more information, see the
[Byte order mark](/globalization/encoding/byte-order-mark) documentation.

In Windows PowerShell, any Unicode encoding, except `UTF7`, always creates a
BOM. PowerShell Core defaults to `utf8NoBOM` for all text output.

For best overall compatibility, avoid using BOMs in UTF-8 files. Unix platforms
and Unix-heritage utilities also used on Windows Platforms don't support BOMs.

Similarly, `UTF7` encoding should be avoided. UTF-7 is not a standard Unicode
encoding and is written without a BOM in all versions of PowerShell.

Creating PowerShell scripts on a Unix-like platform or using a cross-platform
editor on Windows, such as Visual Studio Code, results in a file encoded using
`UTF8NoBOM`. These files work fine on PowerShell Core, but may break in Windows
PowerShell if the file contains non-Ascii characters.

If you need to use non-Ascii characters in your scripts, save them as UTF-8
with BOM. Without the BOM, Windows PowerShell misinterprets your script as
being encoded in the legacy "ANSI" codepage. Conversely, files that do have the
UTF-8 BOM can be problematic on Unix-like platforms. Many Unix tools such as
`cat`, `sed`, `awk`, and some editors such as `gedit` don't know how to treat
the BOM.

## Character encoding in Windows PowerShell

In PowerShell 5.1, the **Encoding** parameter supports the following values:

- `Ascii` Uses Ascii (7-bit) character set.
- `BigEndianUnicode` Uses UTF-16 with the big-endian byte order.
- `BigEndianUTF32` Uses UTF-32 with the big-endian byte order.
- `Byte` Encodes a set of characters into a sequence of bytes.
- `Default` Uses the encoding that corresponds to the system's active code page
  (usually ANSI).
- `Oem` Uses the encoding that corresponds to the system's current OEM code
  page.
- `String` Same as `Unicode`.
- `Unicode` Uses UTF-16 with the little-endian byte order.
- `Unknown` Same as `Unicode`.
- `UTF32` Uses UTF-32 with the little-endian byte order.
- `UTF7` Uses UTF-7.
- `UTF8` Uses UTF-8 (with BOM).

In general, Windows PowerShell uses the Unicode
[UTF-16LE](https://wikipedia.org/wiki/UTF-16) encoding by default. However,
the default encoding used by cmdlets in Windows PowerShell is not consistent.

> [!NOTE]
> Using any Unicode encoding, except `UTF7`, always creates a BOM.

For cmdlets that write output to files:

- `Out-File` and the redirection operators `>` and `>>` create UTF-16LE, which
  notably differs from `Set-Content` and `Add-Content`.

- `New-ModuleManifest` and `Export-CliXml` also create UTF-16LE files.

- When the target file is empty or doesn't exist, `Set-Content` and
  `Add-Content` use `Default` encoding. `Default` is the encoding specified by
  the active system locale's ANSI legacy code page.

- `Export-Csv` creates `Ascii` files but uses different encoding when using
  **Append** parameter (see below).

- `Export-PSSession` creates UTF-8 files with BOM by default.

- `New-Item -Type File -Value` creates a BOM-less UTF-8 file.

- `Send-MailMessage` uses `Default` encoding by default.

- `Start-Transcript` creates `Utf8` files with a BOM. When the **Append**
  parameter is used, the encoding can be different (see below).

For commands that append to an existing file:

- `Out-File -Append` and the `>>` redirection operator make no attempt to match
  the encoding of the existing target file's content. Instead, they use the
  default encoding unless the **Encoding** parameter is used. You must use the
  files original encoding when appending content.

- In the absence of an explicit **Encoding** parameter, `Add-Content` detects
  the existing encoding and automatically applies it to the new content. If the
  existing content has no BOM, `Default` ANSI encoding is used. The behavior of
  `Add-Content` is the same in PowerShell Core (v6 and higher) except the
  default encoding is `Utf8`.

- `Export-Csv -Append` matches the existing encoding when the target file
  contains a BOM. In the absence of a BOM, it uses `Utf8` encoding.

- `Start-Transcript -Append` matches the existing encoding of files that
  include a BOM. In the absence of a BOM, it defaults to `Ascii` encoding. This
  encoding can result in data loss or character corruption when the data in the
  transcript contains multibyte characters.

For cmdlets that read string data in the absence of a BOM:

- `Get-Content` and `Import-PowerShellDataFile` uses the `Default` ANSI
  encoding. ANSI is also what the PowerShell engine uses when it reads source
  code from files.

- `Import-Csv`, `Import-CliXml`, and `Select-String` assume `Utf8` in the
  absence of a BOM.

## Character encoding in PowerShell Core

In PowerShell Core (v6 and higher), the **Encoding** parameter supports the
following values:

- `ascii`: Uses the encoding for the ASCII (7-bit) character set.
- `bigendianunicode`: Encodes in UTF-16 format using the big-endian byte order.
- `oem`: Uses the default encoding for MS-DOS and console programs.
- `unicode`: Encodes in UTF-16 format using the little-endian byte order.
- `utf7`: Encodes in UTF-7 format.
- `utf8`: Encodes in UTF-8 format (no BOM).
- `utf8BOM`: Encodes in UTF-8 format with Byte Order Mark (BOM)
- `utf8NoBOM`: Encodes in UTF-8 format without Byte Order Mark (BOM)
- `utf32`: Encodes in UTF-32 format.

PowerShell Core defaults to `utf8NoBOM` for all output.

Beginning with PowerShell 6.2, the **Encoding** parameter also allows numeric
IDs of registered code pages (like `-Encoding 1251`) or string names of
registered code pages (like `-Encoding "windows-1251"`). For more information,
see the .NET documentation for
[Encoding.CodePage](/dotnet/api/system.text.encoding.codepage).

## Changing the default encoding

PowerShell has two default variables that can be used to change the default
encoding behavior.

- `$PSDefaultParameterValues`
- `$OutputEncoding`

For more information, see
[about_Preference_Variables](about_Preference_Variables.md).

Beginning in PowerShell 5.1, the redirection operators (`>` and `>>`) call the
`Out-File` cmdlet. Therefore, you can set the default encoding of them using
the `$PSDefaultParameterValues` preference variable as shown in this example:

```powershell
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
```

Use the following statement to change the default encoding for all cmdlets that
have the **Encoding** parameter.

```powershell
$PSDefaultParameterValues['*:Encoding'] = 'utf8'
```

> [!IMPORTANT]
> Putting this command in your PowerShell profile makes the preference a
> session-global setting that affects all commands and scripts that do not
> explicitly specify an encoding.
>
> Similarly, you should include such commands in your scripts or modules that
> you want to behave the same way. Using these commands ensure that cmdlets
> behave the same way even when run by another user, on a different computer,
> or in a different version of PowerShell.

The automatic variable `$OutputEncoding` affects the encoding PowerShell uses
to communicate with external programs. It has no effect on the encoding that
the output redirection operators and PowerShell cmdlets use to save to files.

## See also

- [Introduction to character encoding in .NET](/dotnet/standard/base-types/character-encoding-introduction)
- [Code Pages - Win32 apps](/windows/win32/intl/code-pages)
- [The Unicode Standard](https://www.unicode.org/standard/standard.html)
- [Encoding.CodePage](/dotnet/api/system.text.encoding.codepage)
- [UTF-16LE](https://wikipedia.org/wiki/UTF-16)
- [Byte order mark](https://wikipedia.org/wiki/Byte_order_mark)
- [about_Preference_Variables](about_Preference_Variables.md)

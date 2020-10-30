---
title: Understanding file encoding in VS Code and PowerShell
description: Configure file encoding in VS Code and PowerShell
ms.date: 02/28/2019
---
# Understanding file encoding in VS Code and PowerShell

When using VS Code to create and edit PowerShell scripts, it is important that your files are saved
using the correct character encoding format.

## What is file encoding and why is it important?

VS Code manages the interface between a human entering strings of characters into a buffer and
reading/writing blocks of bytes to the filesystem. When VS Code saves a file, it uses a text
encoding to decide what bytes each character becomes. For more information, see
[about_Character_Encoding](/powershell/module/microsoft.powershell.core/about/about_character_encoding).

Similarly, when PowerShell runs a script it must convert the bytes in a file to characters to
reconstruct the file into a PowerShell program. Since VS Code writes the file and PowerShell reads
the file, they need to use the same encoding system. This process of parsing a PowerShell script
goes: _bytes_ -> _characters_ -> _tokens_ -> _abstract syntax tree_ -> _execution_.

Both VS Code and PowerShell are installed with a sensible default encoding configuration. However,
the default encoding used by PowerShell has changed with the release of PowerShell Core (v6.x). To
ensure you have no problems using PowerShell or the PowerShell extension in VS Code, you need to
configure your VS Code and PowerShell settings properly.

## Common causes of encoding issues

Encoding problems occur when the encoding of VS Code or your script file does not match the expected
encoding of PowerShell. There is no way for PowerShell to automatically determine the file encoding.

You're more likely to have encoding problems when you're using characters not in the
[7-bit ASCII character set](https://ascii.cl/). For example:

<!-- markdownlint-disable MD038 -->
- Extended non-letter characters like em-dash (`—`), non-breaking space (` `) or left double
  quotation mark (`"`)
- Accented latin characters (`É`, `ü`)
- Non-latin characters like Cyrillic (`Д`, `Ц`)
- CJK characters (`本`, `화`, `が`)

Common reasons for encoding issues are:

- The encodings of VS Code and PowerShell have not been changed from their defaults. For PowerShell
  5.1 and below, the default encoding is different from VS Code's.
- Another editor has opened and overwritten the file in a new encoding. This often happens with the
  ISE.
- The file is checked into source control in an encoding that is different from what VS Code or
  PowerShell expects. This can happen when collaborators use editors with different encoding
  configurations.

### How to tell when you have encoding issues

Often encoding errors present themselves as parse errors in scripts. If you find strange character
sequences in your script, this can be the problem. In the example below, an en-dash (`–`) appears as
the characters `â&euro;"`:

```Output
Send-MailMessage : A positional parameter cannot be found that accepts argument 'Testing FuseMail SMTP...'.
At C:\Users\<User>\<OneDrive>\Development\PowerShell\Scripts\Send-EmailUsingSmtpRelay.ps1:6 char:1
+ Send-MailMessage â&euro;"From $from â&euro;"To $recipient1 â&euro;"Subject $subject  ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidArgument: (:) [Send-MailMessage], ParameterBindingException
    + FullyQualifiedErrorId : PositionalParameterNotFound,Microsoft.PowerShell.Commands.SendMailMessage
```

This problem occurs because VS Code encodes the character `–` in UTF-8 as the bytes
`0xE2 0x80 0x93`. When these bytes are decoded as Windows-1252, they are interpreted as the
characters `â&euro;"`.

Some strange character sequences that you might see include:

<!-- markdownlint-disable MD038 -->
- `â&euro;"` instead of `–`
- `â&euro;"` instead of `—`
- `Ã„2` instead of `Ä`
- `Â` instead of ` `  (a non-breaking space)
- `Ã&copy;` instead of `é`
<!-- markdownlint-enable MD038 -->

This handy [reference](https://www.i18nqa.com/debug/utf8-debug.html) lists the common patterns that
indicate a UTF-8/Windows-1252 encoding problem.

## How the PowerShell extension in VS Code interacts with encodings

The PowerShell extension interacts with scripts in a number of ways:

1. When scripts are edited in VS Code, the contents are sent by VS Code to the extension. The
   [Language Server Protocol][] mandates that this content is transferred in UTF-8. Therefore, it is
   not possible for the extension to get the wrong encoding.
1. When scripts are executed directly in the Integrated Console, they're read from the file by
   PowerShell directly. If PowerShell's encoding differs from VS Code's, something can go wrong
   here.
1. When a script that is open in VS Code references another script that is not open in VS Code, the
   extension falls back to loading that script's content from the file system. The PowerShell
   extension defaults to UTF-8 encoding, but uses [byte-order mark][], or BOM, detection to select
   the correct encoding.

The problem occurs when assuming the encoding of BOM-less formats (like [UTF-8][] with no BOM and
[Windows-1252][]). The PowerShell extension defaults to UTF-8. The extension cannot change VS Code's
encoding settings. For more information, see
[issue #824](https://github.com/Microsoft/VSCode/issues/824).

## Choosing the right encoding

Different systems and applications can use different encodings:

- In .NET Standard, on the web, and in the Linux world, UTF-8 is now the dominant encoding.
- Many .NET Framework applications use [UTF-16][]. For historical reasons, this is sometimes called
  "Unicode", a term that now refers to a broad [standard](https://en.wikipedia.org/wiki/Unicode)
  that includes both UTF-8 and UTF-16.
- On Windows, many native applications that predate Unicode continue to use Windows-1252 by default.

Unicode encodings also have the concept of a byte-order mark (BOM). BOMs occur at the beginning of
text to tell a decoder which encoding the text is using. For multi-byte encodings, the BOM also
indicates [endianness](https://en.wikipedia.org/wiki/Endianness) of the encoding. BOMs are designed
to be bytes that rarely occur in non-Unicode text, allowing a reasonable guess that text is Unicode
when a BOM is present.

BOMs are optional and their adoption isn't as popular in the Linux world because a dependable
convention of UTF-8 is used everywhere. Most Linux applications presume that text input is encoded
in UTF-8. While many Linux applications will recognize and correctly handle a BOM, a number do not,
leading to artifacts in text manipulated with those applications.

**Therefore**:

- If you work primarily with Windows applications and Windows PowerShell, you should prefer an
  encoding like UTF-8 with BOM or UTF-16.
- If you work across platforms, you should prefer UTF-8 with BOM.
- If you work mainly in Linux-associated contexts, you should prefer UTF-8 without BOM.
- Windows-1252 and latin-1 are essentially legacy encodings that you should avoid if possible.
  However, some older Windows applications may depend on them.
- It's also worth noting that script signing is
  [encoding-dependent](https://github.com/PowerShell/PowerShell/issues/3466), meaning a change of
  encoding on a signed script will require resigning.

## Configuring VS Code

VS Code's default encoding is UTF-8 without BOM.

To set [VS Code's encoding][], go to the VS Code settings (<kbd>Ctrl</kbd>+<kbd>,</kbd>) and set the
`"files.encoding"` setting:

```json
"files.encoding": "utf8bom"
```

Some possible values are:

- `utf8`: [UTF-8] without BOM
- `utf8bom`: [UTF-8] with BOM
- `utf16le`: Little endian [UTF-16]
- `utf16be`: Big endian [UTF-16]
- `windows1252`: [Windows-1252]

You should get a dropdown for this in the GUI view, or completions for it in the JSON view.

You can also add the following to autodetect encoding when possible:

```json
"files.autoGuessEncoding": true
```

If you don't want these settings to affect all files types, VS Code also allows per-language
configurations. Create a language-specific setting by putting settings in a `[<language-name>]`
field. For example:

```json
"[powershell]": {
    "files.encoding": "utf8bom",
    "files.autoGuessEncoding": true
}
```

You may also want to consider installing the [Gremlins tracker][] for Visual Studio Code. This
extension reveals certain Unicode characters that easily corrupted because they are invisible or
look like other normal characters.

## Configuring PowerShell

PowerShell's default encoding varies depending on version:

- In PowerShell 6+, the default encoding is UTF-8 without BOM on all platforms.
- In Windows PowerShell, the default encoding is usually Windows-1252, an extension of [latin-1][],
  also known as ISO 8859-1.

In PowerShell 5+ you can find your default encoding with this:

```powershell
[psobject].Assembly.GetTypes() | Where-Object { $_.Name -eq 'ClrFacade'} |
  ForEach-Object {
    $_.GetMethod('GetDefaultEncoding', [System.Reflection.BindingFlags]'nonpublic,static').Invoke($null, @())
  }
```

The following [script](https://gist.github.com/rjmholt/3d8dd4849f718c914132ce3c5b278e0e) can be
used to determine what encoding your PowerShell session infers for a script without a BOM.

```powershell
$badBytes = [byte[]]@(0xC3, 0x80)
$utf8Str = [System.Text.Encoding]::UTF8.GetString($badBytes)
$bytes = [System.Text.Encoding]::ASCII.GetBytes('Write-Output "') + [byte[]]@(0xC3, 0x80) + [byte[]]@(0x22)
$path = Join-Path ([System.IO.Path]::GetTempPath()) 'encodingtest.ps1'

try
{
    [System.IO.File]::WriteAllBytes($path, $bytes)

    switch (& $path)
    {
        $utf8Str
        {
            return 'UTF-8'
            break
        }

        default
        {
            return 'Windows-1252'
            break
        }
    }
}
finally
{
    Remove-Item $path
}
```

It's possible to configure PowerShell to use a given encoding more generally using profile settings.
See the following articles:

- [@mklement0]'s [answer about PowerShell encoding on StackOverflow](https://stackoverflow.com/a/40098904).
- [@rkeithhill]'s [blog post about dealing with BOM-less UTF-8 input in PowerShell](https://rkeithhill.wordpress.com/2010/05/26/handling-native-exe-output-encoding-in-utf8-with-no-bom/).

It's not possible to force PowerShell to use a specific input encoding. PowerShell 5.1 and below,
running on Windows with the locale set to en-US, defaults to Windows-1252 encoding when there's no
BOM. Other locale settings may use a different encoding. To ensure interoperability, it's best to
save scripts in a Unicode format with a BOM.

> [!IMPORTANT]
> Any other tools you have that touch PowerShell scripts may be affected by your encoding choices or
> re-encode your scripts to another encoding.

### Existing scripts

Scripts already on the file system may need to be re-encoded to your new chosen encoding. In the
bottom bar of VS Code, you'll see the label UTF-8. Click it to open the action bar and select **Save
with encoding**. You can now pick a new encoding for that file. See [VS Code's encoding][] for full
instructions.

If you need to re-encode multiple files, you can use the following script:

```powershell
Get-ChildItem *.ps1 -Recurse | ForEach-Object {
    $content = Get-Content -Path $_
    Set-Content -Path $_.Fullname -Value $content -Encoding UTF8 -PassThru -Force
}
```

### The PowerShell Integrated Scripting Environment (ISE)

If you also edit scripts using the PowerShell ISE, you need to synchronize your encoding
settings there.

The ISE should honor a BOM, but it's also possible to use reflection to
[set the encoding](https://bensonxion.wordpress.com/2012/04/25/powershell-ise-default-saveas-encoding/).
Note that this wouldn't be persisted between startups.

### Source control software

Some source control tools, such as git, ignore encodings; git just tracks the bytes. Others, like
Azure DevOps or Mercurial, may not. Even some git-based tools rely on decoding text.

When this is the case, make sure you:

- Configure the text encoding in your source control to match your VS Code configuration.
- Ensure all your files are checked into source control in the relevant encoding.
- Be wary of changes to the encoding received through source control. A key sign of this is a diff
  indicating changes but where nothing seems to have changed (because bytes have but characters have
  not).

### Collaborators' environments

On top of configuring source control, ensure that your collaborators on any files you share don't
have settings that override your encoding by re-encoding PowerShell files.

### Other programs

Any other program that reads or writes a PowerShell script may re-encode it.

Some examples are:

- Using the clipboard to copy and paste a script. This is common in scenarios like:
  - Copying a script into a VM
  - Copying a script out of an email or webpage
  - Copying a script into or out of a Microsoft Word or PowerPoint document
- Other text editors, such as:
  - Notepad
  - vim
  - Any other PowerShell script editor
- Text editing utilities, like:
  - `Get-Content`/`Set-Content`/`Out-File`
  - PowerShell redirection operators like `>` and `>>`
  - `sed`/`awk`
- File transfer programs, like:
  - A web browser, when downloading scripts
  - A file share

Some of these tools deal in bytes rather than text, but others offer encoding configurations. In
those cases where you need to configure an encoding, you need to make it the same as your editor
encoding to prevent problems.

## Other resources on encoding in PowerShell

There are a few other nice posts on encoding and configuring encoding in PowerShell that are worth a
read:

- [about_Character_Encoding](/powershell/module/microsoft.powershell.core/about/about_character_encoding)
- [@mklement0]'s [summary of PowerShell encoding on StackOverflow](https://stackoverflow.com/questions/40098771/changing-powershells-default-output-encoding-to-utf-8)
- Previous issues opened on VS Code-PowerShell for encoding problems:
  - [#1308](https://github.com/PowerShell/VSCode-powershell/issues/1308)
  - [#1628](https://github.com/PowerShell/VSCode-powershell/issues/1628)
  - [#1680](https://github.com/PowerShell/VSCode-powershell/issues/1680)
  - [#1744](https://github.com/PowerShell/VSCode-powershell/issues/1744)
  - [#1751](https://github.com/PowerShell/VSCode-powershell/issues/1751)
- [The classic _Joel on Software_ write up about Unicode](https://www.joelonsoftware.com/2003/10/08/the-absolute-minimum-every-software-developer-absolutely-positively-must-know-about-unicode-and-character-sets-no-excuses/)
- [Encoding in .NET Standard](https://github.com/dotnet/standard/issues/260#issuecomment-289549508)

[@mklement0]: https://github.com/mklement0
[@rkeithhill]: https://github.com/rkeithhill
[Windows-1252]: https://wikipedia.org/wiki/Windows-1252
[latin-1]: https://wikipedia.org/wiki/ISO/IEC_8859-1
[UTF-8]: https://wikipedia.org/wiki/UTF-8
[byte-order mark]: https://wikipedia.org/wiki/Byte_order_mark
[UTF-16]: https://wikipedia.org/wiki/UTF-16
[Language Server Protocol]: https://microsoft.github.io/language-server-protocol/
[VS Code's encoding]: https://code.visualstudio.com/docs/editor/codebasics#_file-encoding-support
[Gremlins tracker]: https://marketplace.visualstudio.com/items?itemName=nhoizey.gremlins

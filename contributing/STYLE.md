# Style guide for PowerShell-Docs

## Product Terminology

There are several variants of PowerShell.
This table defines some of the different terms used to discuss PowerShell.

| Terminology | Definition |
| ----- | -----|
| PowerShell | This is the default. We are shipping PowerShell. The term PowerShell can be legitimately used to indicate any of the particular editions. This can be used to refer to the language, framework and default cmdlets, etc. |
| PowerShell Core (PSCore) | PowerShell built on .NET Core Common Language Runtime (CoreCLR) for any of the platforms. |
| Windows PowerShell | PowerShell built on .NET Common Language Runtime (CLR). Windows PowerShell ships only on Windows and requires the complete CLR. |

In general, references to "Windows PowerShell" in documentation can be changed to "PowerShell".
"Windows PowerShell" should **not** be changed when Windows-specific technology is being discussed.

## About_ file formatting
We are changing the way we process about_ files.
About_* files are being reformatted for the best compatibility across PowerShell versions and our publishing tools.
For details, see [issue #1806][issue1806].
Please do not alter the formatting of about_ files without checking in with a repo maintainer.

Basic formatting guidelines:

- Limit lines to 80 characters
- Code blocks should be limited to 76 characters
- Within a paragraph, the following characters must be escaped using a leading `\` character: $,\`,\<
- Tables need fit withing 76 characters
  - Manually wrap contents of cells across multiple lines
  - Use opening and closing `|` characters on each line
  - See a working example in [about_Comparison_Operators][about-example]

## Use semantic line breaks

Add a single newline after each sentence or a clause boundary near the 100 character limit.
This simplifies the command-line output of diffs and history.

* You must include semantic line breaks
* Limit lines to 100 characters
* If a sentence is longer than 100 characters, break the line at a clause boundary
  near the 100 character limit

For a good explanation of semantic line breaks, see [Semantic Linefeeds by Rhodes Mill][semantics].

This is not currently adopted across all of PowerShell-Docs, but we will be working towards it over time.
Feel free to help out.

## Blank lines & Spaces vs Tabs

Remove duplicate blank lines.
Multiple blank lines render as a single blank line in HTML.
Blank lines can also signal the end of a block in Markdown.
There should be a single blank between Markdown blocks of different types (for example,
between a paragraph and a list).

**NOTE:** Spacing is significant in Markdown.
Always uses spaces instead of hard tabs.
Remove extra spaces at the end of lines.

## Titles/Headings

Only use [ATX headings][atx] (as opposed to = or \- style headers).

* Titles/headings should be surrounded by blank lines
* Only the first letter of a title and any proper nouns in that title should be capitalized
* Only one H1 per document

When editing reference content, the H2s are prescribed by platyPS and must not be added or removed.
Adding or removing H2 causes a build break.

## Formatting syntax elements

* PowerShell cmdlets are "[Pascal Cased][pascal-case]".
  Verbs are seperated from nouns by a hyphen.

* When talking about a cmdlet in paragraph, use \` to highlight cmdlet names

* Property names and parameter names should be in **bold**

* When writing an article (as opposed to reference content), the first instance of a cmdlet name should be a link to the cmdlet documentation.

  For example:

  This [`Write-Host`](..\reference\6\Microsoft.PowerShell.Utility\Write-Host.md) cmdlet uses the **-Object** parameter to ...

## Formatting code blocks

* All PowerShell syntax blocks should use &#96;&#96;&#96;powershell code fence marker.

* Do **NOT** start PowerShell commands with the PowerShell prompt ("`PS C:\>`").

* Avoid using line continuation characters (\`) in PowerShell code examples.
  These are a hard to see and can cause problems if there are extra spaces on the end of the line.

* Output emitted by PowerShell commands should be enclosed in a naked code block to prevent it from recieving syntax highlighting.

  For example:

      ```powershell
      Get-Command -Module Microsoft.PowerShell.Security
      ```

      ```
      CommandType     Name                                               Version    Source
      -----------     ----                                               -------    ------
      Cmdlet          ConvertFrom-SecureString                           3.0.0.0    Microsoft.PowerShell.Security
      Cmdlet          ConvertTo-SecureString                             3.0.0.0    Microsoft.PowerShell.Security
      Cmdlet          Get-Acl                                            3.0.0.0    Microsoft.PowerShell.Security
      Cmdlet          Get-AuthenticodeSignature                          3.0.0.0    Microsoft.PowerShell.Security
      Cmdlet          Get-CmsMessage                                     3.0.0.0    Microsoft.PowerShell.Security
      Cmdlet          Get-Credential                                     3.0.0.0    Microsoft.PowerShell.Security
      Cmdlet          Get-ExecutionPolicy                                3.0.0.0    Microsoft.PowerShell.Security
      Cmdlet          Get-PfxCertificate                                 3.0.0.0    Microsoft.PowerShell.Security
      Cmdlet          New-FileCatalog                                    3.0.0.0    Microsoft.PowerShell.Security
      Cmdlet          Protect-CmsMessage                                 3.0.0.0    Microsoft.PowerShell.Security
      Cmdlet          Set-Acl                                            3.0.0.0    Microsoft.PowerShell.Security
      Cmdlet          Set-AuthenticodeSignature                          3.0.0.0    Microsoft.PowerShell.Security
      Cmdlet          Set-ExecutionPolicy                                3.0.0.0    Microsoft.PowerShell.Security
      Cmdlet          Test-FileCatalog                                   3.0.0.0    Microsoft.PowerShell.Security
      Cmdlet          Unprotect-CmsMessage                               3.0.0.0    Microsoft.PowerShell.Security
      ```

## Lists

* Do not end list items with a period (unless they contain multiple sentences)
* If your list contains multiple sentences, consider using a header 3/4/5 (as applicable) underneath your primary idea.

If you want multiple lines within a single list element, format your list as follows:

```markdown
1. For the first element (like this one), insert a space after the 1.

   To include a second element (like this one), insert a line break after the first and align indentations.
   The indentation of the second element must line up with the first character after the numbered list marker.

1. The next numbered item starts here.
```

to get this output:

1. For the first element (like this one), insert a space after the 1.

   To include a second element (like this one), insert a line break after the first and align indentations.
   The indentation of the second element must line up with the first character after the numbered list marker.

1. The next numbered item starts here.

## Links

* Avoid using bare URLs. Links should use MarkDown syntax `[friendlyname](url)`
* Links should have a a friendly name when applicable, most likely the title of the linked page
  * **Exception**: Links to non-Microsoft sites can be bare URLs
* All items in the "related links" section at the bottom should be hyperlinked.

## Using relative links

You should use relative links when linking to other content that is hosted on **docs.microsoft.com**.
When the content is in the same repo, the relative links are simple to calculate.
Note that the path to cmdlet reference is created by our publishing system.
There are special rules for linking to reference topics from conceptual topics.

\[TO DO\] - document special rules

<!-- External URLs -->
[pascal-case]: https://en.wikipedia.org/wiki/PascalCase
[issue1806]: https://github.com/PowerShell/PowerShell-Docs/issues/1806
[atx]: https://github.github.com/gfm/#atx-headings
[about-example]: https://github.com/PowerShell/PowerShell-Docs/blob/staging/reference/5.1/Microsoft.PowerShell.Core/About/about_Comparison_Operators.md
[links]: https://help.github.com/articles/relative-links-in-readmes/
[gfm-spec]: https://github.github.com/gfm/
[semantics]: http://rhodesmill.org/brandon/2012/one-sentence-per-line/
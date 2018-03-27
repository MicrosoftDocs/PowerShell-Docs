# Style guide for PowerShell-Docs

## Product Terminology

There are several variants of PowerShell.
This table defines some of the different terms used to discuss PowerShell.

| Terminology | Definition |
| ----- | ----- |
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
- Within a paragraph, the following characters must be escaped using a leading `\` character:
  <code>$</code>, <code>\`</code>, <code>\<</code>
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

Only use [ATX headings][atx] (# style, as opposed to = or \- style headers).

* Titles/headings should be surrounded by blank lines
* Only the first letter of a title and any proper nouns in that title should be capitalized
* Only one H1 per document

When editing reference content, the H2s are prescribed by [platyPS][platyPS] and must not be added or removed.
Adding or removing H2 causes a build break.

## Formatting syntax elements

* PowerShell cmdlets are "[Pascal Cased][pascal-case]".
  Verbs are seperated from nouns by a hyphen.

* When talking about a cmdlet in paragraph, use \` to highlight cmdlet names

* Property names and parameter names should be in **bold**

* When writing an article (as opposed to reference content), the first instance of a cmdlet name should be a link to the cmdlet documentation.

  For example:

  This [`Write-Host`](..\reference\6\Microsoft.PowerShell.Utility\Write-Host.md) cmdlet uses the **-Object** parameter to ...

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

* Avoid using bare URLs. Links should use MarkDown syntax `[friendlyname](url-or-path)`
  * **Exception**: Links to non-Microsoft sites can be bare URLs for transparency
* Links must have a friendly name, usually the title of the linked topic
* All items in the "related links" section at the bottom should be hyperlinked.
* Use relative links when linking to other content that is hosted on **docs.microsoft.com**.

### Structure of links on docs.microsoft.com

Content presented on docs.microsoft.com has the following URL structure:

```
https://docs.microsoft.com/<locale>/<product-service>/[<feature-service>]/[<subfolder>]/<topic>[?view=<view-name>]
```

Examples:

```
https://docs.microsoft.com/en-us/azure/load-balancer/load-balancer-overview
https://docs.microsoft.com/en-us/powershell/azure/overview?view=azurermps-5.1.1
```

- **\<locale>** - identifies the language of the article (example: en-us or de-de)
- **\<product-service>** - the name of the product or service being documented (example: powerShell, dotnet, or azure)
- **[\<feature-service>]** - (optional) the name of the product's feature or subservice (for example, csharp or load-balancer)
- **[\<subfolder>]** - (optional) the name of a subfolder within a feature
- \<topic> - the name of the article file for the topic (example: load-balancer-overview or overview)
- **[?view=\<view-name>]** - (optional) the view name used by the version selector for content that has multiple versions available (example: azurermps-5.1.1)

### Linking to content in the same repo

When the content is in the same repo, the relative links are simple to calculate.
The link target must be the path to the _Markdown file_ in the repo.
For example, the following markdown links to the about_Arrays topic in this repo.

```Markdown
[about_Arrays](../reference/5.1/Microsoft.PowerShell.Core/About/about_Arrays.md)
```

Here is the live link:

[about_Arrays](../reference/5.1/Microsoft.PowerShell.Core/About/about_Arrays.md)

Note that the live link works within the GitHub view of this content.

### Linking to content in a different repo

When the content is in a different repo, the relative links are more complicated.
The link target must be the URL path to the _published article_ on **docs.microsoft.com**.
The relative link starts with the **\<product-service>** portion of the URL as described above.
You should omit the **[?view=\<view-name>]** portion unless you need to link to a specific version of the content.

For example, the following markdown links to the Overview topic for Azure PowerShell.

```Markdown
[Overview of Azure PowerShell](/powershell/azure/overview)
```

Here is the live link:

[Overview of Azure PowerShell](/powershell/azure/overview)

Note that the live link does not resolve within the GitHub view of this content.
This link only works on the webpage published to **docs.microsoft.com**.

## Markdown extensions supported by Open Publishing
The following sections describe supported extensions in Open Publishing.

### Note, warning, tip, important
Use specific syntax inside a block quote to indicate that the content is a type of note.

```Markdown
> [!NOTE]
> This is a note.

> [!WARNING]
> This is a warning.

> [!TIP]
> This is a tip.

> [!IMPORTANT]
> This is important.

```

And it will be rendered like this:

![alert boxes](./images/alert-boxes.png)

## Next steps

See [Formatting code blocks](FORMATTING-CODE.md).

<!-- External URLs -->
[pascal-case]: https://en.wikipedia.org/wiki/PascalCase
[issue1806]: https://github.com/PowerShell/PowerShell-Docs/issues/1806
[atx]: https://github.github.com/gfm/#atx-headings
[about-example]: https://github.com/PowerShell/PowerShell-Docs/blob/staging/reference/5.1/Microsoft.PowerShell.Core/About/about_Comparison_Operators.md
[links]: https://help.github.com/articles/relative-links-in-readmes/
[gfm-spec]: https://github.github.com/gfm/
[semantics]: http://rhodesmill.org/brandon/2012/one-sentence-per-line/
[platyPS]: https://github.com/PowerShell/platyPS
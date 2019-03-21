# Style guide for PowerShell-Docs

This article provides some style guidance specific to the PowerShell-Docs content.
There is some limited guidance on specific Markdown formatting.
Markdown specifics are covered in the [Next steps](#next-steps).

For other writing style guidance, see the [Microsoft Style Guide](https://docs.microsoft.com/style-guide/welcome/).

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

## Use semantic line breaks

Add a single newline after each sentence or a clause boundary near the 100 character limit.
This simplifies the command-line output of diffs and history.

- You must include semantic line breaks
- Limit lines to 100 characters
- If a sentence is longer than 100 characters, break the line at a clause boundary
  near the 100 character limit

For a good explanation of semantic line breaks, see [Semantic Linefeeds by Rhodes Mill][semantics].

This is not currently adopted across all of PowerShell-Docs, but we will be working towards it over time.
Feel free to help out.

## Formatting syntax elements

- PowerShell cmdlet names are [Pascal Cased][pascal-case].
  Verbs are separated from nouns by a hyphen.
  Always use the full Pascal Case name for cmdlets and parameters.
  Avoid using aliases unless you are specifically talking about an alias.

- Property, parameter, and class names should be **bold**

- Within a paragraph, language keywords, cmdlet names, and variable references should be wrapped in
  backtick (\`)   characters. For example:

  The following code assigns the output of `Get-ChildItem` to the `$files` variable.

  ```powershell
  $files = Get-ChildItem C:\Windows
  ```

- When writing an article (as opposed to reference content), the first instance of a cmdlet name
  should be a link to the cmdlet documentation.

  For example:

  This [Write-Host](..\reference\6\Microsoft.PowerShell.Utility\Write-Host.md) cmdlet uses the
  **Object** parameter to ...

  > [!NOTE]
  > Never use backticks or bold inside the brackets of a hyperlink. This is an exception to the previous
  > rule.

- When referring to a parameter by name, the name should be **bold**. When illustrating the use of
  a parameter with the hyphen prefix, the parameter should be wrapped in backticks. For example:

  > The parameter's name is **Name**, but it is typed as `-Name` when used on the command line as a
  > parameter.

- When referring to external commands (EXEs, scripts, etc.), the command name should be bold, all
  lowercase (or capitalized if at the beginning of a sentence), and include the appropriate file
  extension. For example:

  > For example, on Windows systems, you can use the `net start` and `net stop` commands to start
  > and stop a service. **Sc.exe** is another service control tool for Windows. That name does not
  > fit into the naming pattern for the **net.exe** service commands.

- When showing example usage of an external command, the example should be wrapped in backticks.
  When there is a name collisions with an alias you must include the file extension in the command
  example. For example:

  > To start the spooler service on a remote computer named DC01, you type `sc.exe \\DC01 start spooler`.

## Links

- Avoid using bare URLs. Links should use Markdown syntax `[friendlyname](url-or-path)`
- Links must have a friendly name, usually the title of the linked topic
- All items in the "related links" section at the bottom should be hyperlinked.
- Use relative links when linking to other content that is hosted on **docs.microsoft.com**.

### Understanding Docsets

The PowerShell-Doc repo hosts several docsets. Docsets are defined in the `docfx.json` file. The
PowerShell-Docs repo contains the following docsets:

- developer - conceptual docs the PowerShell SDK
- dsc - conceptual docs for DSC
- gallery - conceptual docs for the PowerShell Gallery
- jea - conceptual docs for Just-in-Enough Administration
- reference - conceptual docs for using PowerShell and cmdlet reference docs
- wmf - conceptual docs and release notes for WMF

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
- **\<product-service>** - the name of the product or service (example: powershell, dotnet, or
  azure)
- **[\<feature-service>]** - (optional) the name of the product's feature or subservice (example:
  csharp or load-balancer)
- **[\<subfolder>]** - (optional) the name of a subfolder within a feature
- \<topic> - the name of the article file for the topic (example: load-balancer-overview or
  overview)
- **[?view=\<view-name>]** - (optional) the view name used by the version selector for content that
  has multiple versions available (example: azurermps-5.1.1)

### Linking to content in the same Docset

When the content is in the same Docset, the relative links are simple to calculate. The link target
must be the path to the _Markdown file_ in the repo. For example, the following markdown links to
the about_Arrays topic in this repo.

```Markdown
[about_Arrays](../reference/5.1/Microsoft.PowerShell.Core/About/about_Arrays.md)
```

Here is the live link:

[about_Arrays](../reference/5.1/Microsoft.PowerShell.Core/About/about_Arrays.md)

Note that the live link works within the GitHub view of this content.

### Linking to content in a different Docset

When the content is in a different Docset, the relative links are more complicated. The link target
must be the URL path to the _published article_ on **docs.microsoft.com**. The relative link starts
with the `<product-service>` portion of the URL as described above. You should omit the
`?view=\<view-name>` portion unless you need to link to a specific version of the content.

For example, the following Markdown links to the Overview topic for Azure PowerShell.

```Markdown
[Overview of Azure PowerShell](/powershell/azure/overview)
```

Here is the live link:

[Overview of Azure PowerShell](/powershell/azure/overview)

Note that the live link does not resolve within the GitHub view of this content.
This link only works on the webpage published to **docs.microsoft.com**.

## Next Steps

See [Markdown Specifics](4-MARKDOWN-SPECIFICS.md).

<!-- External URLs -->
[pascal-case]: https://en.wikipedia.org/wiki/PascalCase
[semantics]: http://rhodesmill.org/brandon/2012/one-sentence-per-line/

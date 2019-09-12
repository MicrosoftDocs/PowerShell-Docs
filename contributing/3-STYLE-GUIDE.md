# Style guide for PowerShell-Docs

This article provides some style guidance specific to the PowerShell-Docs content.

For other writing style guidance, see the [Microsoft Style Guide](https://docs.microsoft.com/style-guide/welcome/).

## Product Terminology

There are several variants of PowerShell.
This table defines some of the different terms used to discuss PowerShell.

- **PowerShell** - This is the default. We are shipping PowerShell. The term PowerShell can be
  legitimately used to describe any edition of the product. This name can refer to the language,
  framework, default cmdlets, etc.
- **PowerShell Core** - PowerShell built on .NET Core Common Language Runtime (CoreCLR) for any of
  the platforms.
- **Windows PowerShell** - PowerShell built on .NET Common Language Runtime (CLR). Windows
  PowerShell ships only on Windows and requires the complete CLR.

In general, references to "Windows PowerShell" in documentation can be changed to "PowerShell".
"Windows PowerShell" should **not** be changed when Windows-specific technology is being discussed.

## Hyperlinks

- Avoid using bare URLs. Links should use Markdown syntax `[friendlyname](url-or-path)`
- Links must have a friendly name, usually the title of the linked topic
- All items in the "related links" section at the bottom should be hyperlinked.
- Use relative links when linking to other content that is hosted on **docs.microsoft.com**.
- Do not use backticks, bold, or other markup inside the brackets of a hyperlink.

### Understanding Docsets

The PowerShell-Doc repo hosts several docsets. Docsets are defined in the `docfx.json` file. The
PowerShell-Docs repo contains the following docsets:

- developer - conceptual docs the PowerShell SDK
- dsc - conceptual docs for DSC
- gallery - conceptual docs for the PowerShell Gallery
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

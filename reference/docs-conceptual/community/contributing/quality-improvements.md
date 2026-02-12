---
description: >-
    This article describes the process for contributing quality improvements to the documentation.
ms.date: 02/12/2026
title: Contributing quality improvements
---

# Contributing quality improvements

You don't have to be a subject matter expert or a documentation expert to contribute. If you see an
opportunity to improve the documentation, submit a pull request with your proposed improvement. This
guide outlines several simple ways that anyone can contribute quality improvements to the
documentation.

We're focusing on these quality areas:

- [Formatting code samples][03]
- [Formatting command syntax][04]
- [Link References][05]
- [Markdown linting][06]
- [Spelling][07]

## Formatting code samples

All code samples should follow the [style guidelines][02] for PowerShell content. Those rules are
repeated in abbreviated form here for convenience:

- All code blocks should be contained in a triple-backtick code fence (`` ``` ``).
- Line length for code blocks is limited to `90` characters for cmdlet reference articles.
- Line length for code blocks is limited to `76` characters for `about_*` articles.
- Avoid using line continuation characters (`` ` ``) in PowerShell code examples.
  - Use splatting or natural line break opportunities, like after pipe (`|`) characters, opening
    braces (`}`), parentheses (`(`), and brackets (`[`) to limit line length.
- Only include the PowerShell prompt for illustrative examples where the code isn't intended for
  copy-pasting.
- Don't use aliases in examples unless you're specifically documenting the alias.
- Avoid using positional parameters. Use the parameter name, even if the parameter is positional.

## Formatting command syntax

All prose should follow the [style guidelines][02] for PowerShell content. Those rules are repeated
here for convenience:

- Always use the full name for cmdlets and parameters. Avoid using aliases unless you're
  specifically demonstrating the alias.
- Property, parameter, object, type names, class names, class methods should be **bold**.
  - Property and parameter values should be wrapped in backticks (`` ` ``).
  - When referring to types using the bracketed style, use backticks. For example:
    `[System.Io.FileInfo]`
- PowerShell module names should be **bold**.
- PowerShell keywords and operators should be all lowercase.
- Use proper (Pascal) casing for cmdlet names and parameters.
- When you refer to a parameter by name, the name should be **bold**.
- Use parameter name with the hyphen if you're illustrating syntax. Wrap the parameter in backticks.
- When you show example usage of an external command, the example should be wrapped in backticks.
  Always include the file extension of the external command.

## Link references

For maintainability and readability of the markdown source for our documentation, we're converting
our conceptual documentation to use link references instead of inline links.

For example, instead of:

```md
The [Packages tab](https://www.powershellgallery.com/packages) displays all available
packages in the PowerShell Gallery.
```

It should be:

```md
The [Packages tab][01] displays all available packages in the PowerShell Gallery.
```

> [!NOTE]
> When you replace an inline link, reflow the content to wrap at 100 characters. You can use the
> [reflow-markdown][09] VS Code extension to quickly reflow the paragraph.

At the bottom of the file, add a markdown comment before the definition of the links.

```md
<!-- Link references -->
[01]: https://www.powershellgallery.com/packages
```

Make sure that:

1. Every link points to the correct location.
1. Don't duplicate link reference definitions. If a link reference definition already exists for a
   URL, reuse the existing reference instead of creating a new one.
1. The link reference definitions are at the bottom of the file after the markdown comment and are
   in the numeric order.

## Markdown linting

For any article in one of the participating repositories, opening the article in VS Code displays
linting warnings. Address any of these warnings you find, except:

- [MD022/blanks-around-headings/blanks-around-headers][08] for the `Synopsis` header in cmdlet
  reference documents. For those items, the rule violation is intentional to ensure the
  documentation builds correctly with PlatyPS.

Make sure of the line lengths and use the [Reflow Markdown][09] extension to fix any long lines.

## Spelling

Despite our best efforts, typos and misspellings get through and end up in the documentation. These
mistakes make documentation harder to follow and localize. Fixing these mistakes makes the
documentation more readable, especially for non-English speakers who rely on accurate translations.

<!-- Link References -->
[02]: powershell-style-guide.md#markdown-for-code-samples
[03]: #formatting-code-samples
[04]: #formatting-command-syntax
[05]: #link-references
[06]: #markdown-linting
[07]: #spelling
[08]: https://github.com/DavidAnson/markdownlint/blob/main/doc/Rules.md#md022
[09]: https://marketplace.visualstudio.com/items?itemName=marvhen.reflow-markdown

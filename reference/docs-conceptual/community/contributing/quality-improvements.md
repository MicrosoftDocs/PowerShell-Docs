---
description: >-
    This article describes the process for contributing quality improvements to the documentation.
ms.date: 06/28/2023
title: Contributing quality improvements
---

# Contributing quality improvements

For [Hacktoberfest 2022][31], we [piloted a process][19] for contributing quality improvements to
the PowerShell content. This guide continues and generalizes that process, providing a low-friction
way for community members to contribute and collaborate on GitHub through enhancing the quality of
documentation.

We're focusing on these quality areas:

<!-- - [Aliases][04] -->
- [Formatting code samples][05]
- [Formatting command syntax][06]
- [Link References][07]
- [Markdown linting][08]
- [Spelling][09]

## Project Tracking

We're tracking contributions with the [PowerShell Docs Quality Contributions][23] GitHub Project.

The project page has several views for the issues and PRs related to this effort:

<!-- markdownlint-disable MD044 -->

- The [Open issues][24] view shows all open issues.
- The [Completed][25] view shows merged PRs.
- The [PowerShell][26] view shows open issues for documentation in the [PowerShell-Docs][14],
  [PowerShell-Docs-DSC][15], and [PowerShell-Docs-Modules][17] repositories.
- The [Windows PowerShell][27] view shows open issues for documentation in the
  [windows-powershell-docs repository][21].
- The [Azure PowerShell][28] view shows open issues for documentation in the
  [azure-docs-powershell repository][12].
- The [Open PRs][29] view shows all open PRs.

<!-- markdownlint-enable MD044 -->

<!-- ## Aliases

We're working through documenting the aliases for every cmdlet.

In the Notes section, add the information to the beginning of the section using this format:

```md
PowerShell includes the following aliases for `<Cmdlet-Name>`:

- All platforms:
  - `<alias>`
- Linux:
  - `<alias>`
- macOS:
  - `<alias>`
- Windows:
  - `<alias>`
```

If there is more than one alias for a platform, add it on a separate line as a new list item. If a
platform has no aliases, omit it from the list.

For Windows PowerShell, use one of these formats instead:

1. When the cmdlet has at least one alias

   ```md
   Windows PowerShell includes the following aliases for `<Cmdlet-Name>`:

   - `<alias>`
   ```

1. When the cmdlet haas no aliases

   ```md
   Windows Powershell includes no aliases for `<Cmdlet-Name>`.
   ```
-->
## Formatting code samples

All code samples should follow the [style guidelines][03] for PowerShell content. Those rules are
repeated in abbreviated form here for convenience:

- All code blocks should be contained in a triple-backtick code fence (`` ``` ``).
- Line length for code blocks is limited to `90` characters except in About topics, where it's
  limited to `76` characters.
- Avoid using line continuation characters (`` ` ``) in PowerShell code examples.
  - Use splatting or natural line break opportunities, like after pipe (`|`) characters, opening
    braces (`}`), parentheses (`(`), and brackets (`[`) to limit line length.
- Only include the PowerShell prompt for illustrative examples where the code is not intended for
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
- When referring to a parameter by name, the name should be **bold**. When illustrating the use of
  a parameter with the hyphen prefix, the parameter should be wrapped in backticks.
- When showing example usage of an external command, the example should be wrapped in backticks.
  Always include the file extension of the external command.

## Link references

For maintainability and readability of the markdown source for our documentation, we're converting
our conceptual documentation to use link references instead of inline links.

For example, instead of:

```md
The [Packages tab][31] displays all available
packages in the PowerShell Gallery.
```

It should be:

```md
The [Packages tab][31] displays all available packages in the PowerShell Gallery.
```

> [!NOTE]
> When you replace an inline link, reflow the content to wrap at 100 characters. You can use the
> [reflow-markdown][30] VS Code extension to do this quickly.

At the bottom of the file, add a markdown comment before the definition of the links.

```md
<!-- Link references -->
[01]: https://www.powershellgallery.com/packages
```

Make sure that:

1. The links are defined in the order they appear in the document.
1. Every link points to the correct location.
1. The link reference definitions are at the bottom of the file after the markdown comment and are
   in the correct order.

## Markdown linting

For any article in one of the participating repositories, opening the article in VS Code displays
linting warnings. Address any of these warnings you find, except:

- [MD022/blanks-around-headings/blanks-around-headers][11] for the `Synopsis` header in cmdlet
  reference documents. For those items, the rule violation is intentional to ensure the
  documentation builds correctly with PlatyPS.

Make sure of the line lengths and use the [Reflow Markdown][30] extension to fix any long lines.

## Spelling

Sometimes, despite our best efforts, typos and misspellings get through and end up in the
documentation. These mistakes make documentation harder to follow and localize. Fixing these
mistakes makes the documentation more readable, especially for non-English speakers who rely on
accurate translations.

## Process

We encourage you to choose one or more of the quality areas and an article (or group of articles)
to improve. Once you've decided what articles and content areas you want to work on, follow these
steps:

<!-- markdownlint-disable MD044 -->

1. Check the [project][23] for issues filed for this effort to avoid duplicating efforts.
1. Open a new issue in the appropriate repository:
   - Open an issue in [MicrosoftDocs/PowerShell-Docs][20] for PowerShell reference and conceptual
     content.
   - Open an issue in [MicrosoftDocs/PowerShell-Docs-Dsc][16] for DSC content
   - Open an issue in [MicrosoftDocs/PowerShell-Docs-Modules][18] for Crescendo, PlatyPS,
     PSScriptAnalyzer, SecretManagement, and SecretStore content.
   - Open an issue in [MicrosoftDocs/azure-docs-powershell][13] for Azure PowerShell content.
   - Open an issue in [MicrosoftDocs/windows-powershell-docs][22] for Windows PowerShell module
     content.
1. Follow our [contributor's guide][01] to get setup for making your changes.
1. Submit your pull request. Ensure:

   1. Your PR title has the `Quality:` prefix.
   1. Your PR body references the issue it resolves as an unordered list item and uses one of the
      [linking keywords][10].

      For example, if you're working on issue `123`, the body of your PR should include the
      following Markdown:

      ```md
      - resolves #123
      ```

   The content developers will review your work as soon as they can to help you get it merged.

<!-- markdownlint-enable MD044 -->

<!-- Link References -->
[01]: /powershell/scripting/community/contributing/overview#prepare-to-make-a-contribution
[02]: /powershell/scripting/community/contributing/powershell-style-guide#formatting-command-syntax-elements
[03]: /powershell/scripting/community/contributing/powershell-style-guide#markdown-for-code-samples
<!-- [04]: #aliases -->
[05]: #formatting-code-samples
[06]: #formatting-command-syntax
[07]: #link-references
[08]: #markdown-linting
[09]: #spelling
[10]: https://docs.github.com/en/issues/tracking-your-work-with-issues/linking-a-pull-request-to-an-issue#linking-a-pull-request-to-an-issue-using-a-keyword
[11]: https://github.com/DavidAnson/markdownlint/blob/main/doc/Rules.md#md022
[12]: https://github.com/MicrosoftDocs/azure-docs-powershell
[13]: https://github.com/MicrosoftDocs/azure-docs-powershell/issues/new?template=02-quality.yml&title=Quality%3A+
[14]: https://github.com/MicrosoftDocs/PowerShell-Docs
[15]: https://github.com/MicrosoftDocs/PowerShell-Docs-Dsc
[16]: https://github.com/MicrosoftDocs/PowerShell-Docs-Dsc/issues/new?template=02-quality.yml&title=Quality%3A+
[17]: https://github.com/MicrosoftDocs/PowerShell-Docs-Modules
[18]: https://github.com/MicrosoftDocs/PowerShell-Docs-Modules/issues/new?template=02-quality.yml&title=Quality%3A+
[19]: https://github.com/MicrosoftDocs/PowerShell-Docs/issues/9257
[20]: https://github.com/MicrosoftDocs/PowerShell-Docs/issues/new?template=02-quality.yml&title=Quality%3A+
[21]: https://github.com/MicrosoftDocs/windows-powershell-docs
[22]: https://github.com/MicrosoftDocs/windows-powershell-docs/issues/new?template=02-quality.yml&title=Quality%3A+
[23]: https://github.com/orgs/MicrosoftDocs/projects/15
[24]: https://github.com/orgs/MicrosoftDocs/projects/15/views/1
[25]: https://github.com/orgs/MicrosoftDocs/projects/15/views/2
[26]: https://github.com/orgs/MicrosoftDocs/projects/15/views/3
[27]: https://github.com/orgs/MicrosoftDocs/projects/15/views/4
[28]: https://github.com/orgs/MicrosoftDocs/projects/15/views/5
[29]: https://github.com/orgs/MicrosoftDocs/projects/15/views/6
[30]: https://marketplace.visualstudio.com/items?itemName=marvhen.reflow-markdown
[31]: https://www.powershellgallery.com/packages

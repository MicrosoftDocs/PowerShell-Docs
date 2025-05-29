---
description: This article describes how we manage and support hack-a-thon events like Hacktoberfest.
ms.date: 05/29/2025
title: Hacktoberfest and other hack-a-thon events
---
# Hacktoberfest and other hack-a-thon events

Hacktoberfest is an annual worldwide event held during October. The event encourages open source
developers to contribute to repositories through pull requests (PR). GitHub hosts many open source
repositories that contribute to Microsoft Learn content. Several repositories actively participate
in Hacktoberfest.

## How to contribute

Before you can contribute to an open source repo, you must first configure your account to
contribute to Microsoft Learn. If you're new to this process, start by signing up for a
[GitHub account][01]. Be sure to [install Git and the Markdown tools][02].

To get credit for participation, register with [Hacktoberfest][14] and read their participation
guide.

## Find a repo that needs your help

The PowerShell-Docs team is supporting Hacktoberfest contributions for several PowerShell
documentation repositories. We defined a set of cleanup tasks designed to be simple for first time
contributors. Full information can be found in the [Hacktoberfest meta-issue][11].

To be successful with these tasks, you should:

- Have a general understanding of PowerShell syntax
- Have an understanding of [splatting][04]
- Be able to read and follow the [PowerShell-Docs style guide][06] and [Editorial checklist][05]
- Have basic familiarity with Markdown

Before contributing should read the meta-issue. When you're ready to start, open a new Hacktoberfest
using one of the following links:

- [MicrosoftDocs/PowerShell-Docs][12]
- [MicrosoftDocs/PowerShell-Docs-DSC][09]
- [MicrosoftDocs/PowerShell-Docs-Modules][10]
- [MicrosoftDocs/windows-powershell-docs][13]
- [MicrosoftDocs/azure-docs-powershell][08]

### Quality expectations

To have a successful contribution to an open source Microsoft Learn repository, create a meaningful
and impactful PR. The following examples from the official Hacktoberfest site are considered
**_low-quality contributions_**:

- PRs containing bulk automated changes
  - Example: scripted PRs to remove whitespace, fix common spelling, or optimize images
  - Submit an issue first describing the automated changes you want to make
- PRs deemed disruptive (for example, taking someone else's branch or commits and making a PR)
- PRs deemed a hindrance vs. helping
- PRs that are clearly an attempt to increment your PR count for October

### Open a PR

A _PR_ provides a convenient way for a contributor to propose a set of changes. Successful PRs have
these common characteristics:

- The PR adds value.
- The contributor is receptive to feedback.
- The intended changes are well articulated.
- The changes are related to an existing issue.

If you're proposing a PR without a corresponding issue, create an issue first. For more information,
see [GitHub: About pull requests][07].

## See also

- [Git and GitHub essentials for Microsoft Learn documentation][03]
- [Official Hacktoberfest site][14]

<!-- link references -->
[01]: /contribute/get-started-setup-github
[02]: /contribute/get-started-setup-tools
[03]: /contribute/git-github-fundamentals
[04]: /powershell/module/microsoft.powershell.core/about/about_splatting
[05]: /powershell/scripting/community/contributing/editorial-checklist
[06]: /powershell/scripting/community/contributing/powershell-style-guide
[07]: https://docs.github.com/github/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests
[08]: https://github.com/MicrosoftDocs/azure-docs-powershell/issues/new?assignees=&labels=&template=00-hacktoberfest.yml&title=%F0%9F%8E%83+2022%3A+
[09]: https://github.com/MicrosoftDocs/PowerShell-Docs-DSC/issues/new?assignees=&labels=&template=00-hacktoberfest.yml&title=%F0%9F%8E%83+2022%3A+
[10]: https://github.com/MicrosoftDocs/PowerShell-Docs-Modules/issues/new?assignees=&labels=&template=00-hacktoberfest.yml&title=%F0%9F%8E%83+2022%3A+
[11]: https://github.com/MicrosoftDocs/PowerShell-Docs/issues/9257
[12]: https://github.com/MicrosoftDocs/PowerShell-Docs/issues/new?assignees=&labels=&template=00-hacktoberfest.yml&title=%F0%9F%8E%83+2022%3A+
[13]: https://github.com/MicrosoftDocs/windows-powershell-docs/issues/new?assignees=&labels=&template=00-hacktoberfest.yml&title=%F0%9F%8E%83+2022%3A+
[14]: https://hacktoberfest.com/

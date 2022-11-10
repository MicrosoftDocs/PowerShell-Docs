---
description: This article explains how the PowerShell-Docs team uses labels in GitHub.
ms.date: 11/09/2022
ms.topic: conceptual
title: Labelling in GitHub
---

# Labelling in GitHub

This article documents how we label issues and pull requests in the PowerShell-Docs repository.
This article is designed to be a job aid for members of the PowerShell-Docs team. It's published
here to provide process transparency for our public contributors.

Labels always have a name and a description that is prefixed with their type.

## Area labels

Area labels identify the parts of PowerShell or the documentation that the issue relates to.

|        Label        |                                     Related Content                                      |
| :------------------ | :--------------------------------------------------------------------------------------- |
| `about`             | The `about_*` topic articles.                                                            |
| `archive`           | The [Microsoft.PowerShell.Archive][03] module.                                           |
| `cim`               | The [CimCmdlets][01] module.                                                             |
| `community`         | Community-facing projects, including the contributor's guide and monthly updates.        |
| `conceptual`        | Conceptual (non-reference) articles.                                                     |
| `console`           | The console host                                                                         |
| `core`              | The [Microsoft.PowerShell.Core][04] module.                                              |
| `crescendo`         | The [Crescendo][02] module.                                                              |
| `debugging`         | Debugging PowerShell.                                                                    |
| `diagnostics`       | The [Microsoft.PowerShell.Diagnostics][05] module.                                       |
| `dsc`               | PowerShell Desired State Configuration.                                                  |
| `editorsvcs`        | The PowerShell editor services.                                                          |
| `engine`            | The PowerShell engine.                                                                   |
| `error-handling`    | Error handling in PowerShell                                                             |
| `experimental`      | PowerShell's experimental features                                                       |
| `gallery`           | The PowerShell Gallery.                                                                  |
| `helpsystem`        | The Help services, including the pipeline and `*-Help` cmdlets.                          |
| `host`              | The [Microsoft.PowerShell.Host][06] module.                                              |
| `ise`               | The PowerShell ISE.                                                                      |
| `jea`               | The Just Enough Administration feature.                                                  |
| `language`          | The PowerShell syntax and keywords.                                                      |
| `learn`             | The structured [training content][18] for PowerShell.                                    |
| `localaccounts`     | The [Microsoft.PowerShell.LocalAccounts][07] module.                                     |
| `localization`      | Localization problems or opportunities for the content.                                  |
| `management`        | The [Microsoft.PowerShell.Management][08] module.                                        |
| `native-cmds`       | Using native commands in PowerShell.                                                     |
| `omi`               | Open Management Infrastructure & CDXML.                                                  |
| `ops-issue`         | Building and rendering the content on the site.                                          |
| `other`             | Miscellaneous modules. <!-- Should we keep this? -->                                     |
| `overview`          | The overview section in the conceptual content.                                          |
| `packagemanagement` | The [PackageManagement][11] module.                                                      |
| `parallelism`       | Content covering parallel processing, such as using `ForEach-Object` or PowerShell Jobs. |
| `platyps`           | The [PlatyPS][12] module.                                                                |
| `portability`       | Cross-platform compatibility.                                                            |
| `powershellget`     | The [PowerShellGet][13] module.                                                          |
| `providers`         | PowerShell providers.                                                                    |
| `psreadline`        | The [PSReadline][14] module.                                                             |
| `release-notes`     | The PowerShell release notes.                                                            |
| `remoting`          | The PowerShell remoting feature and cmdlets.                                             |
| `scriptanalyzer`    | The [PSScriptAnalyzer][15] module.                                                       |
| `sdk-docs`          | The conceptual documentation for the PowerShell SDK.                                     |
| `sdk-ref`           | The .NET API reference documentation for the PowerShell SDK.                             |
| `security`          | The [Microsoft.PowerShell.Security][09] module and security concepts in general.         |
| `setup`             | Installing and configuring PowerShell.                                                   |
| `threadjob`         | The [ThreadJob][16] module.                                                              |
| `utility`           | The [Microsoft.PowerShell.Utility][10] module.                                           |
| `versions`          | Issues with the versioning of the documentation.                                         |
| `vscode`            | The VS Code PowerShell extension.                                                        |
| `wincompat`         | The Windows Compatibility feature.                                                       |
| `wmf`               | The Windows Management Framework.                                                        |
| `workflow`          | The Windows PowerShell Workflow feature.                                                 |

## Issue labels

Issue labels distinguish issues by purpose.

|       Label        |                       Issue Category                        |
| :----------------- | :---------------------------------------------------------- |
| `doc-bug`          | Errors or ambiguities in the content                        |
| `doc-idea`         | Requests for new content                                    |
| `kudos`            | Praise, positive feedback, or thanks rather than work items |
| `product-feedback` | Feedback or problems with the product itself                |
| `question`         | Support questions                                           |

## Priority labels

Priority labels rank which work items need to be worked on before others. These labels are only
used when needed to manage large sets of work items.

| Label  | Priority Level |
| -----: | :------------- |
| `Pri0` | Highest        |
| `Pri1` | High           |
| `Pri2` | Medium         |
| `Pri3` | Low            |

## Quality labels

Quality labels categorize work items for the [quality improvement][19] effort.

|              Label              |                               Improvement                               |
| :------------------------------ | :---------------------------------------------------------------------- |
| `quality-aliases`               | Ensure cmdlet aliases are documented                                    |
| `quality-format-code-samples`   | Ensure proper casing, line length, and other formatting in code samples |
| `quality-format-command-syntax` | Ensure proper casing and formatting for command syntax                  |
| `quality-link-references`       | Ensure links in conceptual docs are defined as numbered references      |
| `quality-markdownlint`          | Ensure content follows markdownlint rules                               |
| `quality-spelling`              | Ensure proper casing and spelling for words                             |

## Status labels

Status labels indicate why a work item was closed or shouldn't be merged. Issues are only given
status labels when they're closed without a related PR.

|         Label         |                          Status                          |
| :-------------------- | :------------------------------------------------------- |
| `code-of-conduct`     | Closed for spam, trolling, or code of conduct violations |
| `do-not-merge`        | The PR isn't meant to be merged                          |
| `doc-provided`        | Closed by existing documentation                         |
| `duplicate`           | Closed as duplicate issue                                |
| `moved-to-wiki`       | Closed by move to the wiki                               |
| `referred-to-support` | Closed and referred to community or product support      |
| `resolved-external`   | Closed by customer or outside resource                   |
| `wont-fix`            | Closed as work that was declined for implementation      |

## Tag labels

Tag labels add independent context for work items.

|           Label           |                                  Purpose                                  |
| :------------------------ | :------------------------------------------------------------------------ |
| `in-progress`             | Someone is actively working on the item                                   |
| `go-live`                 | The work item is related to a specific release                            |
| `doc-a-thon`              | The work item is related to a doc-a-thon                                  |
| `up-for-grabs`            | Any contributor may volunteer to resolve the work item                    |
| `hacktoberfest-accepted`  | The PR is accepted for inclusion in [#hacktoberfest][17]                  |
| `hacktoberfest-candidate` | The PR is a candidate for inclusion in [#hacktoberfest][17]               |
| `needs-triage`            | The issue needs to be triaged by the team before it is ready to be worked |

## Waiting labels

Waiting labels indicate that a work item can't be resolved until an external condition is met.

|       Label        |                        Waiting For                        |
| :----------------- | :-------------------------------------------------------- |
| `shiproom`         | Shiproom discussion with the PowerShell team              |
| `needs-response`   | Response from work item author                            |
| `needs-more-info`  | Additional details or clarification from work item author |
| `needs-review`     | PR review                                                 |
| `hold-for-pr`      | Upstream PR to be merged                                  |
| `hold-for-release` | Upstream product to release                               |

<!-- link references -->
[01]: /powershell/module/cimcmdlets
[02]: /powershell/module/crescendo
[03]: /powershell/module/microsoft.powershell.archive
[04]: /powershell/module/microsoft.powershell.core
[05]: /powershell/module/microsoft.powershell.diagnostics
[06]: /powershell/module/microsoft.powershell.host
[07]: /powershell/module/microsoft.powershell.localaccounts
[08]: /powershell/module/microsoft.powershell.management
[09]: /powershell/module/microsoft.powershell.security
[10]: /powershell/module/microsoft.powershell.utility
[11]: /powershell/module/packagemanagement
[12]: /powershell/module/platyps
[13]: /powershell/module/powershellget
[14]: /powershell/module/psreadline
[15]: /powershell/module/psscriptanalyzer
[16]: /powershell/module/threadjob
[17]: hackathons.md
[18]: /training
[19]: quality-improvements.md

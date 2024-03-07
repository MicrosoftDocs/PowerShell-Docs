---
description: This article explains how the PowerShell-Docs team uses labels in GitHub.
ms.date: 12/16/2022
title: Labelling in GitHub
---

# Labelling in GitHub

This article documents how we label issues and pull requests in the PowerShell-Docs repository.
This article is designed to be a job aid for members of the PowerShell-Docs team. It's published
here to provide process transparency for our public contributors.

Labels always have a name and a description that is prefixed with their type.

## Area labels

Area labels identify the parts of PowerShell or the documentation that the issue relates to.

|          Label           |                                     Related Content                                      |
| :----------------------- | :--------------------------------------------------------------------------------------- |
| `area-about`             | The `about_*` topic articles.                                                            |
| `area-archive`           | The [Microsoft.PowerShell.Archive][03] module.                                           |
| `area-cim`               | The [CimCmdlets][01] module.                                                             |
| `area-community`         | Community-facing projects, including the contributor's guide and monthly updates.        |
| `area-conceptual`        | Conceptual (non-reference) articles.                                                     |
| `area-console`           | The console host                                                                         |
| `area-core`              | The [Microsoft.PowerShell.Core][04] module.                                              |
| `area-crescendo`         | The [Crescendo][02] module.                                                              |
| `area-debugging`         | Debugging PowerShell.                                                                    |
| `area-diagnostics`       | The [Microsoft.PowerShell.Diagnostics][05] module.                                       |
| `area-dsc`               | PowerShell Desired State Configuration.                                                  |
| `area-editorsvcs`        | The PowerShell editor services.                                                          |
| `area-engine`            | The PowerShell engine.                                                                   |
| `area-error-handling`    | Error handling in PowerShell                                                             |
| `area-experimental`      | PowerShell's experimental features                                                       |
| `area-gallery`           | The PowerShell Gallery.                                                                  |
| `area-helpsystem`        | The Help services, including the pipeline and `*-Help` cmdlets.                          |
| `area-host`              | The [Microsoft.PowerShell.Host][06] module.                                              |
| `area-ise`               | The PowerShell ISE.                                                                      |
| `area-jea`               | The Just Enough Administration feature.                                                  |
| `area-language`          | The PowerShell syntax and keywords.                                                      |
| `area-learn`             | The structured [training content][18] for PowerShell.                                    |
| `area-localaccounts`     | The [Microsoft.PowerShell.LocalAccounts][07] module.                                     |
| `area-localization`      | Localization problems or opportunities for the content.                                  |
| `area-management`        | The [Microsoft.PowerShell.Management][08] module.                                        |
| `area-native-cmds`       | Using native commands in PowerShell.                                                     |
| `area-omi`               | Open Management Infrastructure & CDXML.                                                  |
| `area-ops-issue`         | Building and rendering the content on the site.                                          |
| `area-other`             | Miscellaneous modules. <!-- Should we keep this? -->                                     |
| `area-overview`          | The overview section in the conceptual content.                                          |
| `area-packagemanagement` | The [PackageManagement][11] module.                                                      |
| `area-parallelism`       | Content covering parallel processing, such as using `ForEach-Object` or PowerShell Jobs. |
| `area-platyps`           | The [PlatyPS][12] module.                                                                |
| `area-portability`       | Cross-platform compatibility.                                                            |
| `area-powershellget`     | The [PowerShellGet][13] module.                                                          |
| `area-providers`         | PowerShell providers.                                                                    |
| `area-psreadline`        | The [PSReadline][14] module.                                                             |
| `area-release-notes`     | The PowerShell release notes.                                                            |
| `area-remoting`          | The PowerShell remoting feature and cmdlets.                                             |
| `area-scriptanalyzer`    | The [PSScriptAnalyzer][15] module.                                                       |
| `area-sdk-docs`          | The conceptual documentation for the PowerShell SDK.                                     |
| `area-sdk-ref`           | The .NET API reference documentation for the PowerShell SDK.                             |
| `area-security`          | The [Microsoft.PowerShell.Security][09] module and security concepts in general.         |
| `area-setup`             | Installing and configuring PowerShell.                                                   |
| `area-threadjob`         | The [ThreadJob][16] module.                                                              |
| `area-utility`           | The [Microsoft.PowerShell.Utility][10] module.                                           |
| `area-versions`          | Issues with the versioning of the documentation.                                         |
| `area-vscode`            | The VS Code PowerShell extension.                                                        |
| `area-wincompat`         | The Windows Compatibility feature.                                                       |
| `area-wmf`               | The Windows Management Framework.                                                        |
| `area-workflow`          | The Windows PowerShell Workflow feature.                                                 |

## Issue labels

Issue labels distinguish issues by purpose.

|          Label           |                       Issue Category                        |
| :----------------------- | :---------------------------------------------------------- |
| `issue-doc-bug`          | Errors or ambiguities in the content                        |
| `issue-doc-idea`         | Requests for new content                                    |
| `issue-kudos`            | Praise, positive feedback, or thanks rather than work items |
| `issue-product-feedback` | Feedback or problems with the product itself                |
| `issue-question`         | Support questions                                           |

## Priority labels

Priority labels rank which work items need to be worked on before others. These labels are only
used when needed to manage large sets of work items.

| Label  | Priority Level |
| -----: | :------------- |
| `Pri0` | Highest        |
| `Pri1` | High           |
| `Pri2` | Medium         |
| `Pri3` | Low            |

## Project Labels

Project labels indicate what ongoing GitHub Project a work item is related to. These labels are
used for automatically adding work items to a project on creation.

|       Label       |                Project                |
| ----------------: | :------------------------------------ |
| `project-quality` | The [quality improvement project][19] |

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

|             Label             |                       Status                        |
| :---------------------------- | :-------------------------------------------------- |
| `resolution-answered`         | Closed by existing documentation                    |
| `resolution-duplicate`        | Closed as duplicate issue                           |
| `resolution-external`         | Closed by customer or outside resource              |
| `resolution-no-repro`         | Unable to reproduce the reported issue              |
| `resolution-refer-to-support` | Closed and referred to community or product support |
| `resolution-wont-fix`         | Closed as won't fix                                 |

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
| `code-of-conduct`         | Closed for spam, trolling, or code of conduct violations                  |
| `do-not-merge`            | The PR isn't meant to be merged                                           |

## Waiting labels

Waiting labels indicate that a work item can't be resolved until an external condition is met.

|         Label         |                        Waiting For                        |
| :-------------------- | :-------------------------------------------------------- |
| `hold-for-pr`         | Upstream PR to be merged                                  |
| `hold-for-release`    | Upstream product to release                               |
| `needs-investigation` | Waiting for team member to verify or research             |
| `needs-more-info`     | Additional details or clarification from work item author |
| `needs-response`      | Response from work item author                            |
| `review-shiproom`     | Shiproom discussion with the PowerShell team              |

<!-- link references -->
[01]: /powershell/module/cimcmdlets
[02]: /powershell/module/microsoft.powershell.crescendo
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

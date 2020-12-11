---
title: How we manage issues
description: This article explains how the PowerShell-Docs team manages issues.
ms.date: 12/09/2020
ms.topic: conceptual
---
# How we manage issues

This article documents how we manage issues in the PowerShell-Docs repo. This article is designed to
be a job aid for members of the PowerShell-Docs team. It's published here to provide process
transparency for our public contributors.

## Sources of issues

- Community contributors
- Internal contributors
- Transcriptions of comments from social media channels
- Feedback via the Docs feedback form

## Response time targets

80% of new issues are closed within 3 business days.

- Triaged - 1 business days
- Fix or change - 10 business days

### Labeling & Milestones

#### Label Types

|   Type   | Description                                                         |
| -------- | ------------------------------------------------------------------- |
| Area     | Used to indicate what part of PowerShell or the docs that the issue is discussing.<br>Useful for feature owners to find issues for their feature. |
| Issue    | Indicates the type of issue                                         |
| Priority | Indicates the priority of the issue. Value range 0 (high) -4 (low)  |
| Status   | Indicates the status of the work item or why it was closed          |
| Tag      | Labels used to for additional classification                        |
| Waiting  | Indicates that we're waiting on someone or some other event         |

#### Milestones

Issues and PRs should be tagged with the appropriate milestone. If the issue doesn't apply to a
specific version, then no milestone is used. PRs and related issues for changes that have yet to be
merged into the PowerShell code base should be assigned to the **Future** milestone. After the code
change has been merged, change the milestone to the appropriate version.

|    Milestone     |                    Description                     |
| ---------------- | -------------------------------------------------- |
| 7.0.0            | Work items related to PowerShell 7.0               |
| 7.1.0            | Work items related to PowerShell 7.1               |
| 7.2.0            | Work items related to PowerShell 7.2               |
| Future           | Work items a future version of PowerShell          |

## Triage process

PowerShell docs team members review the issues daily and triage new issues as they arrive. The team
meets weekly to discuss issues that need triage or remain unresolved.

### Misplaced product feedback

- Enter a comment redirecting the customer to the correct feedback channel.
- Optional: Copy the issue to the appropriate product feedback location, add a link to the copied
  item, and close the issue. DO NOT copy issues to UserVoice.

  The default location for PowerShell issues is
  [https://github.com/PowerShell/PowerShell/issues/new/choose](https://github.com/PowerShell/PowerShell/issues/new/choose).

  The following subject areas have different locations for issues:

  | Subjects |                                                     Product Feedback URL                                                     |
  | -------- | ---------------------------------------------------------------------------------------------------------------------------- |
  | dsc      | [https://windowsserver.uservoice.com/forums/301869-powershell](https://windowsserver.uservoice.com/forums/301869-powershell) |
  | gallery  | [https://github.com/powershell/powershellgallery/issues/new](https://github.com/powershell/powershellgallery/issues/new)     |
  | jea      | [https://github.com/powershell/jea/issues/new](https://github.com/powershell/jea/issues/new)                                 |
  | wmf      | [https://windowsserver.uservoice.com/forums/301869-powershell](https://windowsserver.uservoice.com/forums/301869-powershell) |

### Support requests

- If the support question is simple, answer it politely and close the issue.
- If the question is more complicated, or the submitter replies with more questions, redirect them
  to forums and support channels. Suggested text for redirecting to forums:

  ```Markdown
  > This is not the right forum for these kinds of questions. Try posting your question in a
  > community support forum. For a list of community forums see:
  > https://docs.microsoft.com/powershell/scripting/community/community-support
  ```

### Code of conduct violations

- Edit the issue to remove any offensive content, if necessary.
- Enter a comment indicating the issue is spam, close the issue, and then lock it to prevent further
  comments.
- Each violation should be discussed in the weekly triage to determine the need for further action
  (report to GitHub or Microsoft Legal).

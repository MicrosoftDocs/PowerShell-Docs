---
description: This article explains how the PowerShell-Docs team manages issues.
ms.date: 11/09/2022
title: How we manage issues
---
# How we manage issues

This article documents how we manage issues in the PowerShell-Docs repository. This article is
designed to be a job aid for members of the PowerShell-Docs team. It's published here to provide
process transparency for our public contributors.

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

- **Area** - Identifies the part of PowerShell or the docs that the issue is discussing
- **Issue** - The type of issue: like bug, feedback, or idea
- **Priority** - The priority of the issue; value range 0-3 (high-low)
- **Quality** - The [quality improvement][03] effort the issue commits to resolving
- **Status** - The status of the work item or why it was closed
- **Tag** - Used to for additional classification like availability or doc-a-thons
- **Waiting** - Shows that we're waiting on some external person or event

For more information on specific labels, see [Labeling][02].

#### Milestones

Issues and PRs should be tagged with the appropriate milestone. If the issue doesn't apply to a
specific version, then no milestone is used. PRs and related issues for changes that have yet to be
merged into the PowerShell code base should be assigned to the **Future** milestone. After the code
change has been merged, change the milestone to the appropriate version.

| Milestone |                Description                |
| --------- | ----------------------------------------- |
| 7.0.0     | Work items related to PowerShell 7.0      |
| 7.2.0     | Work items related to PowerShell 7.2      |
| 7.3.0     | Work items related to PowerShell 7.3      |
| Future    | Work items a future version of PowerShell |

## Triage process

PowerShell docs team members review the issues daily and triage new issues as they arrive. The team
meets weekly to discuss difficult issues need triage and prioritize the work.

### Misplaced product feedback

- Enter a comment redirecting the customer to the correct feedback channel.
- Optional: Copy the issue to the appropriate product feedback location, add a link to the copied
  item, and close the issue.

  The default location for PowerShell issues is
  [https://github.com/PowerShell/PowerShell/issues/new/choose][01].

### Support requests

- If the support question is simple, answer it politely and close the issue.
- If the question is more complicated, or the submitter replies with more questions, redirect them
  to forums and support channels. Suggested text for redirecting to forums:

  ```Markdown
  > This is not the right forum for these kinds of questions. Try posting your question in a
  > community support forum. For a list of community forums see:
  > https://learn.microsoft.com/powershell/scripting/community/community-support
  ```

### Code of conduct violations

- Edit the issue to remove any offensive content, if necessary
- Enter a comment indicating the issue is spam, close the issue, and then lock it to prevent further
  comments
- Each violation should be discussed in the weekly triage to determine the need for further action

<!-- link references -->
[01]: https://github.com/PowerShell/PowerShell/issues/new/choose
[02]: labelling-in-github.md
[03]: quality-improvements.md

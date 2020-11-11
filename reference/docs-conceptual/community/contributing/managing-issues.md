---
title: How we manage issues
description: This article explains how the PowerShell-Docs team manages issues.
ms.date: 03/05/2020
ms.topic: conceptual
---
# How we manage issues

This article documents how we manage issues in the PowerShell-Docs repo. This article is designed to
be a job aid for members of the PowerShell-Docs team. It is published here to provide process
transparency for our public contributors.

## Sources of issues

- Community contributors
- Internal contributors
- Transcriptions of comments from social media channels
- Feedback via the Docs feedback form

## Response time targets

- Triaged - 5 business days
- Fix or change - no specific target - best effort only

### Labeling & Milestones

#### Label Types

|Prefix  | Description                                                         |
|------- | --------------------------------------------------------------------|
|Area    | Used to indicate what part of PowerShell or the docs that the issue is discussing.<br>Useful for feature owners to find issues for their feature.|
|Pri     | Used to indicate the priority of the issue. Value range 0-4.        |
|Issue   | Used to classify the type of feedback for issue                     |
|Review  | Used for issue that require further review by the team              |
|Status  | Used to indicate the status of the work item                        |
|Waiting | Used to indicate that we are waiting on something                   |

#### Milestones

Issues and PRs should be tagged with the appropriate milestone. If the issue is not targeted for a
specific version then no milestone is used. Issues for Docs PRs for changes that have yet to be
merged into the PowerShell code base should be assigned to the **Future** milestone. After the code
change has been merged, change the milestone to the appropriate version.

|    Milestone     |                    Description                     |
| ---------------- | -------------------------------------------------- |
| 6.x              | Work items related to PowerShell 6.0 through 6.2.x |
| 7.0.0            | Work items related to PowerShell 7.0               |
| 7.1.0            | Work items related to PowerShell 7.1               |
| Future           | Work items a future version of PowerShell          |
| PSReadline-vNext | Work items a future version of PSReadline          |

## Triage process

The PowerShell docs team meets once per week to discuss any issues added since last meeting. An
issue is considered to have been triaged when labels have been assigned or an owner has been
assigned. PowerShell docs team members are encouraged to review the issues daily and triage new
issues as they arrive. The weekly triage meeting can then be used to discuss the new issues in more
detail, as needed.

### Misplaced product feedback

- Enter a comment for the customer indicating it is product feedback and provide a link to the
  appropriate feedback channel.
- Optional: Copy the issue to the appropriate product feedback location, add a link to the copied
  item, and close the issue. DO NOT copy issues to UserVoice.

  | DocSet    | Product Feedback URL                                           |
  | --------- | -------------------------------------------------------------- |
  | developer | `https://github.com/PowerShell/PowerShell/issues/new/choose`   |
  | dsc       | `https://windowsserver.uservoice.com/forums/301869-powershell` |
  | gallery   | `https://github.com/powershell/powershellgallery/issues/new`   |
  | jea       | `https://github.com/powershell/jea/issues/new`                 |
  | reference | `https://github.com/PowerShell/PowerShell/issues/new/choose`   |
  | wmf       | `https://windowsserver.uservoice.com/forums/301869-powershell` |

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
- Each occurrence of this should be discussed in the weekly triage to determine the need for further
  action (report to GitHub or Microsoft Legal).

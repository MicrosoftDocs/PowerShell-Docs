# Managing Issues

## Sources of issues

- Community contributors
- Internal contributors
- Transcriptions of comments from social media channels
- Feedback via the Docs feedback form

## SLA (proposed)

- Triaged - 5 business days
- Fix/change - none

### Labeling & Milestones

#### Label Types

|Prefix  | Description                                                         |
|------- | --------------------------------------------------------------------|
|Area    | Used to indicate what part of PowerShell or the docs that the issue is discussing.<br>Useful for feature owners to find issues for their feature.|
|Pri     | Used to indicate the priority of the issue. Value range 0-4.        |
|Issue   | Used to classify the type of feedback for issue                     |
|Review  | Used for issue that require further review by the team              |
|Status  | Used to indicate the status of the work item                        |
|Waiting | Used to indicate that we are waiting on                             |

#### Milestones

Issues and PRs should be tagged with the appropriate milestone. If the issue is not targeted for a
specific version then no milestone is used. Issues for Docs PRs for changes that have yet to be
merged into the PowerShell code base should be assigned to the **Future** milestone. After the code
change has been merged, change the milestone to the appropriate version.

|    Milestone     |                    Description                     |
| ---------------- | -------------------------------------------------- |
| 6.0.x-6.1.x      | Work items related to PowerShell 6.0 through 6.1.x |
| 6.2.0            | Work items related to PowerShell 6.2.x             |
| 7.0.0            | Work items related to PowerShell 7.x               |
| Future           | Work items a future version of PowerShell          |
| PSReadline-vNext | Work items a future version of PSReadline          |

### Triage process

The PowerShell docs team meets once per week to discuss any issues added since last meeting. An
issue is considered to have been triaged when labels have been assigned or an owner has been
assigned. PowerShell docs team members are encouraged to review the issues daily and triage new
issues as they arrive. The weekly triage meeting can then be used to discuss the new issues in more
detail, as needed.

Misplaced product feedback

- Enter a comment for the customer indicating it is product feedback and provide a link to the
  appropriate feedback channel.
- Optional: Copy the issue to the appropriate product feedback location, add a link to the copied
  item, and close the issue. DO NOT copy issues to UserVoice.

Support requests

- If the support question is simple, answer it politely and close the issue.
- If the question is more complicated, or the submitter replies with more questions, redirect them
  to forums and support channels. Suggested text for redirecting to forums:

    > This is not the right forum for these kinds of questions. Try posting your question in a
    > community support forum. For a list of community forums see:
    > https://docs.microsoft.com/powershell/#pivot=main&panel=community

Code of conduct violations
- Enter a comment indicating the issue is spam, close the issue, and then lock it to remove it
  from the article comments.
- Each occurrence of this should be discussed in the weekly triage so we can decide on the need
  for further action (e. g. report to GitHub or CELA).

| DocSet    | Product Feedback URL                                           |
| --------- | -------------------------------------------------------------- |
| developer | <https://github.com/PowerShell/PowerShell/issues/new/choose>   |
| dsc       | <https://windowsserver.uservoice.com/forums/301869-powershell> |
| gallery   | <https://github.com/powershell/powershellgallery/issues/new>   |
| jea       | <https://github.com/powershell/jea/issues/new>                 |
| reference | <https://github.com/PowerShell/PowerShell/issues/new/choose>   |
| wmf       | <https://windowsserver.uservoice.com/forums/301869-powershell> |

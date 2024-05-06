---
description: This article explains how to submit pull requests to the PowerShell-Docs repository.
ms.date: 07/26/2022
title: How to submit pull requests
---
# How to submit pull requests

To make changes to content, submit a pull request (PR) from your fork. A pull request must be
reviewed before it can be merged. For best results, review the [editorial checklist][1] before
submitting your pull request.

## Using git branches

The default branch for PowerShell-Docs is the `main` branch. Changes made in working branches are
merged into the `main` branch before then being published. The `main` branch is merged into the
`live` branch every weekday at 3:00 PM (Pacific Time). The `live` branch contains the content that
is published to `learn.microsoft.com`.

Before starting any changes, create a working branch in your local copy of the PowerShell-Docs
repository. When working locally, be sure to synchronize your local repository before creating your
working branch. The working branch should be created from an up-to-date copy of the `main`
branch.

All pull requests should target the `main` branch. Don't submit changes to the `live` branch. Changes
made in the `main` branch get merged into `live`, overwriting any changes made to `live`.

## Make the pull request process work better for everyone

The simpler and more focused you can make your PR, the faster it can be reviewed and merged.

### Avoid pull requests that update large numbers of files or contain unrelated changes

Avoid creating PRs that contain unrelated changes. Separate minor updates to existing articles from
new articles or major rewrites. Work on these changes in separate working branches.

Bulk changes create PRs with large numbers of changed files. Limit your PRs to a maximum of 50
changed files. Large PRs are difficult to review and are more prone to contain errors.

### Renaming or deleting files

When renaming or deleting files, there must be an issue associated with the PR. That issue must
discuss the need to rename or delete the files.

Avoid mixing content additions or changes with file renames and deletes. Any file that's renamed or
deleted must be added to the global redirection file. When possible, update any files that link to
the renamed or deleted content, including any TOC files.

### Avoid editing repository configuration files

Avoid modifying repository configuration files. Limit your changes where possible to the Markdown
content files and any supporting image files needed for the content.

Incorrect modifications to repository configuration files can break the build, introduce
vulnerabilities or accessibility issues, or violate organizational standards. Repository
configuration files are any files that match one or more of these patterns:

- `*.yml`
- `.github/**`
- `.localization-config`
- `.openpublishing*`
- `LICENSE*`
- `reference/docfx.json`
- `reference/mapping/**`
- `tests/**`
- `ThirdPartyNotices`
- `tools/**`

For safety and security, if you believe you have discovered a bug or potential improvement for a
repository configuration file, [file an issue][2]. The maintainers will review and implement any
fixes or improvements as needed.

## Use the PR template

When you create a PR, a template is automatically inserted into the PR body for you. It looks like
this:

```md
# PR Summary

<!--
    Delete this comment block and summarize your changes and list
    related issues here. For example:

    This changes fixes problem X in the documentation for Y.

    - Fixes #1234
    - Resolves #1235
-->

## PR Checklist

<!--
    These items are mandatory. For your PR to be reviewed and merged,
    ensure you have followed these steps. As you complete the steps,
    check each box by replacing the space between the brackets with an
    x or by clicking on the box in the UI after your PR is submitted.
-->

- [ ] **Descriptive Title:** This PR's title is a synopsis of the changes it proposes.
- [ ] **Summary:** This PR's summary describes the scope and intent of the change.
- [ ] **Contributor's Guide:** I have read the [contributors guide][contrib].
- [ ] **Style:** This PR adheres to the [style guide][style].

<!--
    If your PR is a work in progress, please mark it as a draft or
    prefix it with "(WIP)" or "WIP:"

    This helps us understand whether or not your PR is ready to review.
-->

[contrib]: /powershell/scripting/community/contributing/overview
[style]: /powershell/scripting/community/contributing/powershell-style-guide
```

In the "PR Summary" section, write a short summary of your changes and list any related issues by
their issue number, like `#1234`. If your PR fixes or resolves the issue, use GitHub's
[autoclose][3] feature so the issue is automatically closed when your PR is merged.

Review the items in the "PR Checklist" section and check them off as you complete each one. You must
follow the directions and check each item for the team to approve your PR.

If your PR is a work-in-progress, set it to [draft mode][4] or prefix your PR title with `WIP`.

## Expectations Comment

After you submit your PR, a bot will comment on your PR to provide you with resources and to set
expectations for the rest of the process. Always review this comment, even if you've contributed
before, because it contains accurate and up-to-date information.

![example expectation comment][5]

## Docs PR validation service

The Docs PR validation service is a GitHub app that runs validation rules on your changes. You must
fix any errors or warnings reported by the validation service.

You'll see the following behavior:

1. You submit a PR.
1. In the GitHub comment that indicates the status of your PR, you'll see the status of "checks"
   enabled on the repository. In this example, there are two checks enabled, "Commit Validation" and
   "OpenPublishing.Build":

   ![validation status - some checks failed][6]

   The build can pass even if commit validation fails.

1. Click **Details** for more information.
1. On the Details page, you'll see all the validation checks that failed, with information about how
   to fix the issues.
1. When validation succeeds, the following comment is added to the PR:

   ![Validation status: success][7]

> [!NOTE]
> If you are an external (not a Microsoft employee) contributor you don't have access to the
> detailed build reports or preview links.

When the PR is reviewed, you may be asked to make changes or fix validation warning messages. The
PowerShell-Docs team can help you understand validation errors and editorial requirements.

## GitHub Actions

Several different GitHub Actions run against your changes to validate and provide context for you
and the reviewers.

### Checklist verification

If your PR is not in [draft mode][4] and is not prefixed with `WIP`, a GitHub Action inspects your
PR to verify that you have checked every item in the PR template's checklist. If this check fails,
the team won't review or merge your PR. The checklist items are mandatory.

### Authorization verification

If your PR targets the `live` branch or modifies any repository configuration files, a GitHub Action
checks your permissions to verify that you are authorized to submit those changes.

Only repository administrators are authorized to target the `live` branch or modify repository
configuration files.

### Versioned content change reporting

If your PR adds, removes, or modifies any versioned content a GitHub Action analyzes your changes
and writes a report summarizing the types of changes made to versioned content.

This report is useful for seeing if there are other versions of the file(s) you modified and whether
or not those versions have also been updated in the changeset.

To find the versioned content report for your PR:

1. Selecting the "Checks" tab on your PR page.
1. Select the "Reporting" job from the list of jobs.
1. Select the "..." button in the top right.
1. Select "View job summary."

![Example of a versioned content change report][8]

## Next steps

[PowerShell-Docs style guide][9]

## Additional resources

[How we manage pull requests][10]

<!--link refs-->
[1]: editorial-checklist.md
[2]: https://github.com/MicrosoftDocs/PowerShell-Docs/issues/new/choose
[3]: https://help.github.com/en/articles/closing-issues-using-keywords
[4]: https://docs.github.com/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/reviewing-proposed-changes-in-a-pull-request
[5]: media/pull-requests/expectations.png
[6]: media/pull-requests/validation-failed.png
[7]: media/pull-requests/build-validation.png
[8]: media/pull-requests/version-report.png
[9]: powershell-style-guide.md
[10]: managing-pull-requests.md

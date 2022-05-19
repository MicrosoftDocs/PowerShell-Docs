# PR Summary
<!--
    Summarize your changes and list related issues here. For example:

    This changes fixes problem X in the documentation for Y.
    - Fixes #1234
    - Resolves #1235
-->

## Affected Files

<!--
    Delete the entries in this list that this PR does not affect:
-->

- Repository documentation and configuration (.git/.github/.vscode etc.)
- Docs build files (.openpublishing.* and build scripts)
- Docset configuration (docfx.json, mapping, bread, module folder)

## PR Checklist

<!--
    These items are mandatory. For your PR to be reviewed and merged,
    ensure you have followed these steps. As you complete the steps,
    check each box by replacing the space between the brackets with an
    x or by clicking on the box in the UI after your PR is submitted.
-->

- [ ] I have read the [contributors guide][contrib] and followed the style and process guidelines.
- [ ] This PR has a meaningful title.
- [ ] This PR targets the `main` branch.
- [ ] This PR includes content related to an issue - see [Closing issues using keywords][gh-key].
- [ ] This PR is **Ready to Merge** and is not **Work in Progress** or **Draft**. If the PR is work
  in progress, please add the prefix `WIP:` or `[WIP]` to the beginning of the title and remove the
  prefix when the PR is ready. You can also mark the [PR as a draft][gh-make-draft] in the UI.

## Expectations

To see our process for reviewing PRs, please read our [editor's checklist][contrib-checklist] and
process for [managing pull requests][contrib-managing-prs] in particular. Below is a brief,
high-level summary of what to expect, but our contributor guide has expanded details.

The docs team begins to review your PR if you [request them to][gh-review-request] or if your PR
meets these conditions:

- It is not a [draft PR][gh-drafts].
- It does not have a `WIP` prefix in the title.
- It passes validation and build steps.
- It does not have any merge conflicts.
- You have checked every box in the [PR Checklist](#pr-checklist), indicating you have completed all
  required steps and marked your PR as **Ready to Merge**.

You can **always** request a review at any stage in your authoring process, the docs team is here to
help! You do not need to submit a fully polished and finished draft; the docs team can help you get
content ready for merge.

While reviewing your PR, the docs team may make suggestions, write comments, and ask questions. When
all requirements are satisfied, the docs team marks your PR as **Approved** and merges it. Once your
PR is merged, it is included the next time the documentation is published. For this project, the
documentation is published daily at 3pm Pacific Standard Time (PST).

[contrib-checklist]: https://docs.microsoft.com/powershell/scripting/community/contributing/editorial-checklist
[contrib-managing-prs]: https://docs.microsoft.com/powershell/scripting/community/contributing/managing-pull-requests
[contrib]: https://docs.microsoft.com/powershell/scripting/community/contributing/overview
[gh-drafts]: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests#draft-pull-requests
[gh-key]: https://help.github.com/en/articles/closing-issues-using-keywords
[gh-make-draft]: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/changing-the-stage-of-a-pull-request#converting-a-pull-request-to-a-draft
[gh-review-request]: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/requesting-a-pull-request-review
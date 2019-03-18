# Contributing to PowerShell Documentation

Thank you for your interest in PowerShell documentation!

See below for details on how you can contribute to our technical documentation.

> For general information about getting started with Git and GitHub, see [GitHub Help][git-help].

## Sign a CLA

Before you can contribute to any PowerShell repositories, you must sign a [Microsoft Contribution Licensing Agreement (CLA)][cla].
If you've already contributed to PowerShell repositories in the past, congratulations! You've
already completed this step.

## Providing feedback on PowerShell documentation

Point out errors, suggest changes, or request new topics by [creating an issue][new-issue] on the [PowerShell-Docs repository issues page][doc-issues].

Issues are reviewed regularly by members of the PowerShell documentation team. The issues are
triaged, assigned, and addressed accordingly.

## Making minor edits to existing topics

To [edit an existing file][edit-file], navigate to it and click the "Edit" button. GitHub will
automatically create your own fork of our repository where you can make your changes. Once you are
finished, save your edits and submit a [pull request][pull] to the *staging* branch of the [PowerShell-Docs][docs-repo]
repository. After your pull request is created, someone on the PowerShell documentation team reviews
your changes before merging them into the *staging* branch.

## Making major edits to existing topics

If you are making substantial changes, adding or changing images, or contributing a new article, you
will need to create a GitHub fork and clone it to your computer. A fork is a GitHub-based replica of
the main repository, under your GitHub account, that provides you with a working copy which you can
use in isolation. You will create pull requests from your fork. Similarly, a clone is a local-based
replica of the repository which, in this case, will be a clone of your fork. The clone allows you to
work on Git repositories offline, and using more powerful native software/tools.

Here is the workflow for making major edits to existing documentation:

1. [Create a fork][fork] of the [PowerShell-Docs][docs-repo] repository.
2. [Create a clone of your fork][clone] on your local computer.
3. Create a new local branch in your cloned repository.
4. Make changes to the file(s) you want to update in a Markdown editor.
5. [Push your local branch][push] to your fork.
6. [Create a pull request][pull] to the *staging* branch of the [PowerShell-Docs][docs-repo]
   repository.

## Next steps

See [Writing PowerShell documentation](2-WRITING.md).

<!-- External URLs -->
[git-help]: https://help.github.com/
[cla]: https://cla.microsoft.com/
[new-issue]: https://help.github.com/articles/creating-an-issue/
[doc-issues]: https://github.com/PowerShell/PowerShell-Docs/issues
[edit-file]: https://help.github.com/articles/editing-files-in-another-user-s-repository/
[docs-repo]: https://github.com/PowerShell/PowerShell-Docs
[fork]: https://help.github.com/articles/fork-a-repo/
[clone]: https://help.github.com/articles/cloning-a-repository/
[push]: https://help.github.com/articles/pushing-to-a-remote/
[pull]: https://help.github.com/articles/creating-a-pull-request/

# Contributing to PowerShell Documentation

Thank you for your interest in PowerShell documentation!
See below for details on how you can contribute to our technical documentation.

>For general information about getting started with Git and GitHub, see [GitHub Help](https://help.github.com/).

## Sign a CLA

Before you can contribute to any PowerShell repositories, you must [sign a Microsoft Contribution Licensing Agreement (CLA)](https://cla.microsoft.com/).
If you've already contributed to PowerShell repositories in the past, congratulations!
You've already completed this step.

## Providing feedback on PowerShell documentation

You can point out errors, suggest changes, or request new topics by [creating an issue](https://help.github.com/articles/creating-an-issue/) on the
[PowerShell-Docs repository issues page](https://github.com/PowerShell/PowerShell-Docs/issues).

Issues are reviewed regularly by members of the PowerShell documentation team, and are triaged, assigned, and addressed accordingly.

## Making minor edits to existing topics

To [edit an existing file](https://help.github.com/articles/editing-files-in-another-user-s-repository/), simply navigate to it and click the "Edit" button.
GitHub will automatically create your own fork of our repository where you can make your changes.
Once you're finished, save your edits and submit a [pull request](https://help.github.com/articles/creating-a-pull-request/) to the *staging* branch of the [PowerShell-Docs](https://github.com/PowerShell/PowerShell-Docs) repository.
After your pull request is created, someone on the PowerShell documentation team reviews your changes before merging them into the *staging* branch.

## Making major edits to existing topics

If you are making substantial changes to an existing article, adding or changing images, or contributing a new article, you will need to manually create your GitHub fork, then clone the fork down to your local computer.
A fork is a GitHub-based replica of the main repository, under your GitHub account, which provides you with a working copy which you can use in isolation.
You will create pull requests from your fork.
Similarly, a clone is a local-based replica of the repository which, in this case, will be a clone of your fork.
The clone allows you to work on Git repositories offline, and using more powerful native software/tools.

Here is the workflow for making major edits to existing documentation:

1. [Create a fork](https://help.github.com/articles/fork-a-repo/) of the [PowerShell-Docs](https://github.com/PowerShell/PowerShell-Docs) repository.
2. [Create a clone of your fork](https://help.github.com/articles/cloning-a-repository/) on your local computer.
3. Create a new local branch in your cloned repository.
4. Make changes to the file(s) you want to update in a Markdown editor.
   See below for commonly used Markdown editors.
5. [Push your local branch](https://help.github.com/articles/pushing-to-a-remote/) to your fork.
6. [Create a pull request](https://help.github.com/articles/creating-a-pull-request/) to the *staging* branch of the [PowerShell-Docs](https://github.com/PowerShell/PowerShell-Docs) repository.

## Creating new topics

If you want to contribute new documentation, first check for [issues tagged as "in progress"](https://github.com/PowerShell/PowerShell-Docs/labels/in%20progress) to make sure you're not duplicating efforts.
If no one seems to be working on what you have planned:

* Open a new issue and label it as "in progress" (if you are a member of the PowerShell organization) or add "in progress" as a comment to tell others what you're working on.
* Follow the same workflow as described above for making major edits to existing topics.
* Do not edit the `TOC.md` or `TOC.yml` files (located in the top-level folder for each documentation set).
* Create an issue requesting that your new article be added table of contents.
  Include a suggestion about where you think it show appear in the TOC.
  Someone on the PowerShell documentation team will make the appropriate changes to the TOC files.

## Updating topics that exist in multiple versions

Most reference topics are duplicated across all versions of PowerShell.
When reporting an issue about cmdlet reference or an About_ topic, you must specify which versions are affected by the issue.
The default issue template in GitHub includes a [GFM task list](https://github.github.com/gfm/#task-list-items-extension-) so that you can specify which versions are affected.
When you submit a change to a topic for an issue affects multiple versions of the content, you must apply the appropriate change to each version of the file.

## Next steps

See [Writing PowerShell documentation](WRITING.md).
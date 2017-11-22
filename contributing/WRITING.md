# Writing PowerShell documentation

One of the easiest ways to contribute to PowerShell is by helping to write and edit documentation.
All of our documentation hosted on GitHub is written using GitHub Flavored Markdown (GFM).

## Markdown editors

Here are some Markdown editors you can try out:

* [Visual Studio Code](https://code.visualstudio.com)
* [Markdown Pad](http://markdownpad.com/)
* [Atom](https://atom.io/)
* [Sublime Text](http://www.sublimetext.com/)

## Using GitHub Flavored Markdown

To get started using GFM, see GitHub's Help topics for [Writing on GitHub][gfm-help].

**NOTE:** GitHub recently adopted the CommonMark specification (with GFM extensions) for its Markdown syntax.
In the new specification, many spacing rules have changed.
Spaces are significant in GFM.
Do not use hard tabs in Markdown.
For more detailed information about the Markdown specification, see the [GitHub Flavored Markdown Spec][gfm-spec].

## Creating new topics

If you want to contribute new documentation, first check for [issues tagged as "in progress"][labels]
to make sure you're not duplicating efforts.
If no one seems to be working on what you have planned:

* Open a new issue and label it as "in progress" (if you are a member of the PowerShell organization)
  or add "in progress" as a comment to tell others what you're working on.
* Follow the same workflow as described above for making major edits to existing topics.
* Do not edit the `TOC.md` or `TOC.yml` files (located in the top-level folder for each documentation set).
* Create an issue requesting that your new article be added table of contents.
  Include a suggestion about where you think it show appear in the TOC.
  Someone on the PowerShell documentation team will make the appropriate changes to the TOC files.

## Updating topics that exist in multiple versions

Most reference topics are duplicated across all versions of PowerShell.
When reporting an issue about a cmdlet reference or an About_ topic, you must specify which versions are affected by the issue.
The default issue template in GitHub includes a [GFM task list][gfm-task].
Use the checkboxes in the task list to specify which versions of the content are affected.
When you submit a change to a topic for an issue that affects multiple versions of the content,
you must apply the appropriate change to each version of the file.

## Next Steps

Read the [Style Guide](STYLE.md).

<!-- External URLs -->
[gfm-help]: https://help.github.com/categories/writing-on-github/
[gfm-spec]: https://github.github.com/gfm/
[labels]: https://github.com/PowerShell/PowerShell-Docs/labels/in%20progress
[gfm-task]: https://github.github.com/gfm/#task-list-items-extension-
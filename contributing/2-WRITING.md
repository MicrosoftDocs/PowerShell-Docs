# Writing PowerShell documentation

One of the easiest ways to contribute to PowerShell is by helping to write and edit documentation.
All of our documentation hosted on GitHub is written using *Markdown*.
Markdown is a lightweight markup language with plain text formatting syntax.
Markdown forms the basis of our documentation's conceptual authoring language.
Creating new articles is as easy as writing a simple text file by using your favorite text editor.

## Markdown editors

Here are some Markdown editors you can try out:

* [Visual Studio Code](https://code.visualstudio.com)
* [Atom](https://atom.io/)
* [Sublime Text](http://www.sublimetext.com/)

## Get started using Markdown

To get started using Markdown, see GitHub's Help topics for [Writing on GitHub][gfm-help].

**NOTE:** GitHub recently adopted the CommonMark specification (with GFM extensions) for its Markdown syntax.
In the new specification, many spacing rules have changed.
Spaces are significant in Markdown.
Do not use hard tabs in Markdown.
For more detailed information about the Markdown specification, see the [Markdown Specifics](4-MARKDOWN-SPECIFICS.md) article.

DocFX, used by OPS, supports DocFX Flavored Markdown (DFM).
DFM is highly compatible with GitHub Flavored Markdown (GFM) and adds some functionality, including cross-reference and file inclusion.
There are [differences between DFM and GFM][dfm-diffs] that can affect content preview in GitHub or your editor.

## Creating new topics

If you want to contribute new documentation, first check for [issues tagged as "in progress"][labels]
to make sure you're not duplicating efforts.
If no one seems to be working on what you have planned:

* Open a new issue and label it as "in progress" (if you are a member of the PowerShell organization)
  or add "in progress" as a comment to tell others what you're working on.
* Follow the same workflow as described above for making major edits to existing topics.
* Do not edit the `TOC.yml` files (located in the top-level folder for each documentation set).
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

Read the [Style Guide](3-STYLE-GUIDE.md).

<!-- External URLs -->
[gfm-help]: https://help.github.com/categories/writing-on-github/
[labels]: https://github.com/PowerShell/PowerShell-Docs/labels/in%20progress
[gfm-task]: https://github.github.com/gfm/#task-list-items-extension-
[dfm-diffs]: http://dotnet.github.io/docfx/spec/docfx_flavored_markdown.html#differences-between-dfm-and-gfm
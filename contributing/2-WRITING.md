# Writing PowerShell documentation

One of the easiest ways to contribute to PowerShell is by helping to write and edit documentation.
All of our documentation hosted on GitHub is written using *Markdown*. Markdown is a lightweight
markup language with plain text formatting syntax. Markdown forms the basis of our documentation's
conceptual authoring language. Creating new articles is as easy as writing a simple text file by
using your favorite text editor.

## Markdown editors

Here are some Markdown editors you can try out:

- [Visual Studio Code](https://code.visualstudio.com)
- [Atom](https://atom.io/)
- [Sublime Text](http://www.sublimetext.com/)

## Get started using Markdown

To get started using Markdown, see [How to use Markdown for writing Docs](https://docs.microsoft.com/contribute/how-to-write-use-markdown).

The Open Publishing System (OPS) is the platform used by docs.microsoft.com. OPS uses DocFX
Flavored Markdown (DFM). DFM supports all GitHub Flavored Markdown (GFM) syntax and is compatible
with CommonMark. There are some [differences between DFM and GFM][dfm-diffs] that can affect
content preview in GitHub or your editor.

The default Markdown engine in OPS is built on the top of [markdig][]. This engine is based on the
CommonMark specification and supports extensions for DocFX. In the latest version of the
[CommonMark][] specification, many spacing rules have changed. Spaces are significant in Markdown.
Don't use hard tabs in Markdown. For more detailed information about the Markdown specification,
see the [Markdown Specifics](4-MARKDOWN-SPECIFICS.md) article.

## Creating new topics

To contribute new documentation, check for issues tagged as ["in progress"][labels] to make
sure you're not duplicating efforts. If no one seems to be working on what you have planned:

- Open a new issue and label it as "in progress". If you don't have rights to assign labels, add "in
  progress" as a comment to tell others what you're working on.
- Follow the same workflow as described above for making major edits to existing topics.
- Add your new article to the `TOC.yml` file (located in the top-level folder of each
  documentation set).

## Updating topics that exist in multiple versions

Most reference topics are duplicated across all versions of PowerShell. When reporting an issue
about a cmdlet reference or an About_ article, you must specify which versions are affected by the
issue. The default issue template in GitHub includes a [GFM task list][gfm-task]. Use the checkboxes
in the task list to specify which versions of the content are affected. When you submit a change to
a article for an issue that affects multiple versions of the content, you must apply the appropriate
change to each version of the file.

## Next Steps

Read the [Style Guide](3-STYLE-GUIDE.md).

<!-- External URLs -->
[markdig]: https://github.com/lunet-io/markdig
[CommonMark]: https://spec.commonmark.org/
[gfm-help]: https://help.github.com/categories/writing-on-github/
[labels]: https://github.com/PowerShell/PowerShell-Docs/labels/in%20progress
[gfm-task]: https://github.github.com/gfm/#task-list-items-extension-
[dfm-diffs]: https://dotnet.github.io/docfx/spec/docfx_flavored_markdown.html#differences-between-dfm-and-gfm
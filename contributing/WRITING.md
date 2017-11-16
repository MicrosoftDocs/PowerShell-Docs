# Writing PowerShell documentation

One of the easiest ways to contribute to PowerShell is by helping to write and edit documentation.
All of our documentation hosted on GitHub is written using GitHub Flavored Markdown (GFM).
To get started using GFM, see GitHub's Help topics for [Writing on GitHub](https://help.github.com/categories/writing-on-github/).

## Markdown editors

Here are some Markdown editors you can try out:

* [Visual Studio Code](https://code.visualstudio.com)
* [Markdown Pad](http://markdownpad.com/)
* [Atom](https://atom.io/)
* [Sublime Text](http://www.sublimetext.com/)

## Using GitHub Flavored Markdown

Some of the basic GFM syntax includes:

* **Line breaks vs. paragraphs:** In Markdown there is no HTML `<br />` or `<p />` element.
Instead, a new paragraph is designated by an empty line between two blocks of text.

> **Note**: Please add a single newline after each sentence to simplify the command-line output of diffs and history.
This is not currently adopted across all of PowerShell-Docs, but we will be working towards it over time.
Feel free to help out.

* **Italics:** The HTML `<em>some text</em>` element is written as `*some text*`

* **Bold:** The HTML `<strong>some text</strong>` element is written as `**some text**`

* **Headings:** HTML headings are designated using `#` characters at the start of the line.
  The number of `#` characters corresponds to the hierarchical level of the heading (for example, `#` = `<h1>` and `###` = ```<h3>```).

* **Numbered lists:** To make a numbered (ordered) list, start the line with `1. `.
  If you want multiple lines within a single list element, format your list as follows:

```markdown
1. For the first element (like this one), insert a space after the 1.

   To include a second element (like this one), insert a line break after the first and align indentations.
   The indentation of the second element must line up with the first character after the numbered list marker.

2. The next numbered item starts here.
```

to get this output:

1. For the first element (like this one), insert a tab stop after the 1.

   To include a second element (like this one), insert a line break after the first and align indentations.
   The indentation of the second element must line up with the first character after the numbered list marker.

2. The next numbered item starts here.

* **Bulleted lists:** Bulleted (unordered) lists are almost identical to ordered lists except that the list marker can be any of these three patterns: `* `, `- `, or `+ `.
  Multiple element lists work the same way as with ordered lists.

* **Links:** The syntax for a hyperlink is `[visible link text](link URL)`.

* **Link to another topic within the same docset:** A docset is a top-level folder in this repository (for example, "dsc", "scripting").
  The syntax for a hyperlink to a topic within the same docset is `[topic title](relative path to topic)`.
  For more information, see [Relative links in READMEs](https://help.github.com/articles/relative-links-in-readmes/).
  To link to a topic in a different top-level folder, use the URL of the published page, as described above.

> [!NOTE] Spacing is significant in Markdown.
Always uses spaces instead of hard tabs.

For more detailed information about the Markdown specification, see the [GitHub Flavored Markdown Spec](https://github.github.com/gfm/).

## Next Steps

Read the [Style Guide](STYLE.md).

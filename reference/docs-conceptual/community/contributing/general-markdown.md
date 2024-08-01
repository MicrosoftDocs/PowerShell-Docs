---
description: This article provides specific guidance for using Markdown in our documentation.
ms.date: 08/01/2024
title: Markdown best practices
---
# Markdown best practices

This article provides specific guidance for using Markdown in our documentation. This is not a
tutorial for Markdown, but lists specific rules and best practices for Markdown in the PowerShell
docs. If you need a tutorial for Markdown, see this [Markdown cheatsheet][12].

The Microsoft Open Publishing System (OPS) that builds our documentation uses [markdig][06] to
process the Markdown documents. Markdig parses the documents based on the rules of the latest
[CommonMark][10] specification. OPS follows the CommonMark specification and adds some extensions
for platform-specific features, such as tables and alerts.

The CommonMark specification is much stricter about the construction of some Markdown elements. Pay
close attention to the details provided in this document.

We use the [markdownlint][08] extension in VS Code to enforce our style and formatting rules. This
extension is installed as part of the **Learn Authoring Pack**.

## Blank lines, spaces, and tabs

Blank lines also signal the end of a block in Markdown.

- There should be a single blank between Markdown blocks of different types -- for example, between
  a paragraph and a list or header.
- Don't use more than one blank line. Multiple blank lines render as a single blank line in HTML,
  therefore the extra blank lines are unnecessary.
- Within a code block, consecutive blank lines break the code block.

Spacing is significant in Markdown.

- Remove extra spaces at the end of lines. Trailing spaces can change how Markdown renders.
- Always use spaces instead of tabs (hard tabs).

## Titles and headings

Only use [ATX headings][07] (`#` style, as opposed to `=` or `-` style headers).

- Use sentence case - only proper nouns and the first letter of a title or header should be
  capitalized
- There must be a single space between the `#` and the first letter of the heading
- Headings should be surrounded by a single blank line
- Only one H1 per document
- Header levels should increment by one -- don't skip levels
- Limit depth to H3 or H4
- Avoid using bold or other markup in headers

## Limit line length to 100 characters

This applies to conceptual articles and cmdlet reference. For `about_` topics, limit the line
length to 79 characters. Limiting the line length improves the readability of `git` diffs and
history. It also makes it easier for other writers to make contributions.

Use the [Reflow Markdown][09] extension in VS Code to reflow paragraphs to fit the prescribed line
length.

Some content types can't be easily reflowed. For example, the code inside of code blocks may also be
difficult to reflow, depending on the content and the code language. And you can't reflow a table.
In these cases, use your best judgment to keep the content as close to the 100-character limit as
possible.

## Emphasis

For emphasis, Markdown supports bold and italics. Markdown allows you to use either `*` or `_` to
mark the emphasis. However, to be consistent and show intent:

- Use `**` for bold
- Use `_` for italics

Following this pattern makes it easier for others to understand the intent of the markup when there
is a mix of bold and italics in a document.

## Lists

If your list has multiple sentences or paragraphs, consider using a sublevel header rather than a
list.

List should be surrounded by a single blank line.

### Unordered lists

- Don't end list items with a period unless they contain multiple sentences.
- Use the hyphen character (`-`) for list item bullets. This avoids confusion with emphasis markup
  that uses the asterisk (`*`).
- To include a paragraph or other elements under a bullet item, insert a line break and align
  indentation with the first character after the bullet.

For example:

```Markdown
This is a list that contains child elements under a bullet item.

- First bullet item

  Sentence explaining the first bullet.

  - Child bullet item

    Sentence explaining the child bullet.

- Second bullet item
- Third bullet item
```

This is a list that contains child elements under a bullet item.

- First bullet item

  Sentence explaining the first bullet.

  - Child bullet item

    Sentence explaining the child bullet.

- Second bullet item
- Third bullet item

### Ordered lists

- All items in a numbered list should use the number `1.` rather than incrementing each item.
  - Markdown rendering increments the value automatically.
  - This makes reordering items easier and standardizes the indentation of subordinate content.
- To include a paragraph or other elements under a numbered item, align indentation with the first
  character after the item number.

For example:

```Markdown
1. For the first element, insert a single space after the 1. Long sentences should be wrapped to the
   next line and must line up with the first character after the numbered list marker.

   To include a second element, insert a line break after the first and align indentations. The
   indentation of the second element must line up with the first character after the numbered list
   marker.

1. The next numbered item starts here.
```

The resulting Markdown is rendered as follows:

1. For the first element, insert a single space after the 1. Long sentences should be wrapped to the
   next line and must line up with the first character after the numbered list marker.

   To include a second element, insert a line break after the first and align indentations. The
   indentation of the second element must line up with the first character after the numbered list
   marker.

1. The next numbered item starts here.

## Images

The syntax to include an image is:

```Markdown
![[alt text]](<folderPath>)

Example:
![Introduction](./media/overview/Introduction.png)
```

Where `alt text` is a brief description of the image and `<folderPath>` is a relative path to the
image.

- Alternate text is required to support screen readers for the visually impaired.
- Images should be stored in a `media/<article-name>` folder within the folder containing the
  article.
  - Create a folder that matches the filename of your article under the `media` folder. Copy the
    images for that article to that new folder.
- Don't share images between articles.
  - If an image is used by multiple articles, each folder must have a copy of that image.
  - This prevents a change to an image in one article from affecting another article.

The following image file types are supported: `*.png`, `*.gif`, `*.jpeg`, `*.jpg`, `*.svg`

## Markdown extension - Alert boxes

The [Learn Authoring Pack][01] contains tools that support features unique to our publishing
system. Alerts are a Markdown extension to create blockquotes that render with colors and icons
highlighting the significance of the content. The following alert types are supported:

```Markdown
> [!NOTE]
> Information the user should notice even if skimming.

> [!TIP]
> Optional information to help a user be more successful.

> [!IMPORTANT]
> Essential information required for user success.

> [!CAUTION]
> Negative potential consequences of an action.

> [!WARNING]
> Dangerous certain consequences of an action.
```

These alerts look like this on Microsoft Learn:

Note block

> [!NOTE]
> Information the user should notice even if skimming.

Tip block

> [!TIP]
> Optional information to help a user be more successful.

Important block

> [!IMPORTANT]
> Essential information required for user success.

Caution block

> [!CAUTION]
> Negative potential consequences of an action.

Warning block

> [!WARNING]
> Dangerous certain consequences of an action.

## Markdown extension - Tables

A table is an arrangement of data with rows and columns, consisting of a single header row, a
delimiter row separating the header from the data, and zero or more data rows.

Each row consists of cells containing arbitrary text separated by pipes (`|`). A leading and
trailing pipe is also recommended for clarity. Spaces between pipes and cell content are trimmed.
Block-level elements can't be inserted in a table. All content of a row must be on a single line.

The delimiter row consists of cells whose only content are hyphens (`-`), and optionally, a leading
or trailing colon (`:`), or both, to indicate left, right, or center alignment respectively.

For small tables, consider using a list instead. Lists are easier to maintain and read, can be
reflowed to fit within the 100-character line limit, and are more accessible for users that use
screen readers for visual assistance.

For more information, see _Tables_ section of [Markdown reference for Microsoft Learn][05].

## Hyperlinks

- Hyperlinks must use Markdown syntax `[friendlyname](url-or-path)`.
- The publishing system supports three types of links:
  - URL links
  - File links
  - Cross-reference links
- All URLs to external websites should use HTTPS unless that isn't valid for the target site.
- Links must have a friendly name, usually the title of the linked article
- Avoid using backticks, bold, or other markup inside the brackets of a hyperlink.
- Bare URLs may be used when you're documenting a specific URI but must be enclosed in backticks.
  For example:

  ```Markdown
  By default, if you don't specify this parameter, the DMTF standard resource URI
  `http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/` is used and the class name is appended to it.
  ```
- Use [link references][11] where allowed. Link references within paragraphs make the paragraphs
  more readable.

  Link references divide a Markdown link into two parts:

  - the link reference - `[friendlyname][id]`
  - the link definition - `[id]: url-or-path`

### URL-type Links

- URL links to other articles on `learn.microsoft.com` must use site-relative paths. The simplest
  way to create a site-relative link is to copy the URL from your browser then remove
  `https://learn.microsoft.com/en-us` from the value you paste into markdown.
- Don't include locales in URLs on Microsoft properties (remove `/en-us` from URL) or Wikipedia
  links.
- Remove any unnecessary query parameters from the URL. Examples that should be removed:
  - `?view=powershell-5.1` - used to link to a specific version of PowerShell
  - `?redirectedfrom=MSDN` - added to the URL when you get redirected from an old article to its new
    location
- If you need to link to a specific version of a document, you must add the `&preserve-view=true`
  parameter to the query string. For example: `?view=powershell-5.1&preserve-view=true`
- On Microsoft sites, URL links don't contain file extensions (for example, no `.md`)

### File-type links

- A file link is used to link from one reference article to another, or from one conceptual
  article to another in the same docset.
  - If you need to link from a conceptual article to a reference article you must use a URL link.
  - If you need to link to an article in another docset or across repositories you must use a URL
    link.
- Use relative filepaths (for example: `../folder/file.md`)
- All file paths use forward-slash (`/`) characters
- Include the file extension (for example, `.md`)

### Cross-reference links

Cross-reference links are a special feature supported by the publishing system. You can use
cross-reference links in conceptual articles to link to .NET API or cmdlet reference.

- For links to .NET API reference, see [Use links in documentation][03] in the central Contributor
  Guide.
- Links to cmdlet reference have the following format: `xref:<module-name>.<cmdlet-name>`. For
  example, to link to the `Get-Content` cmdlet in the **Microsoft.PowerShell.Management** module.

  `[Get-Content](xref:Microsoft.PowerShell.Management.Get-Content)`

### Deep linking

Deep linking is allowed on both URL and file links.

- The anchor text must be lowercase
- Add the anchor to the end of the target path. For example:
  - `[about_Splatting](about_Splatting.md#splatting-with-arrays)`
  - `[custom key bindings](https://code.visualstudio.com/docs/getstarted/keybindings#_custom-keybindings-for-refactorings)`

For more information, see [Use links in documentation][02].

## Code spans

Code spans are used for inline code snippets within a paragraph. Use single backticks to indicate a
code span. For example:

```Markdown
PowerShell cmdlet names use the `Verb-Noun` naming convention.
```

This example renders as:

PowerShell cmdlet names use the `Verb-Noun` naming convention.

## Code blocks

Code blocks are used for command examples, multi-line code samples, query languages, and outputs.
There are two ways to indicate a section of text in an article file is a code block: by fencing it
in triple-backticks (` ``` `) or by indenting it.

Never use indentation because it's too easy to get wrong and it may be difficult for another writer to
understand your intent when they need to edit your article.

Fenced code blocks can include an optional tag that indicates the language syntax contained in the
block. The publishing platform supports a list of [language tags][04]. The language tag is used to
provide syntax highlighting when the article is rendered on the webpage. The language tag is not
case-sensitive, but you should use lowercase except for a few special cases.

- Code fences without tags can be used for syntax blocks or other types of content where syntax
highlighting is not required.
- When showing output from a command, use a tagged code fence with the language tag `Output`. The
  rendered box is labeled as **Output** and doesn't have syntax highlighting.
- If the output is in a specific supported language, use the appropriate language tag. For example,
  many commands output JSON, so use the `json` tag.
- If you use an unsupported language tag, the code block will render without syntax highlighting.
  The language tag becomes the label for the rendered code box on the webpage. Capitalize the tag so
  that the label is capitalized on the webpage.

## Next steps

[PowerShell style guide][13]

<!-- link references -->
[01]: /contribute/content/how-to-write-docs-auth-pack
[02]: /contribute/content/how-to-write-links
[03]: /contribute/content/how-to-write-links#xref-cross-reference-links
[04]: /contribute/content/code-in-docs#supported-languages
[05]: /contribute/content/markdown-reference#tables
[06]: https://github.com/lunet-io/markdig
[07]: https://github.github.com/gfm/#atx-headings
[08]: https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint
[09]: https://marketplace.visualstudio.com/items?itemName=marvhen.reflow-markdown
[10]: https://spec.commonmark.org/
[11]: https://github.github.com/gfm/#reference-link
[12]: https://www.markdownguide.org/cheat-sheet/
[13]: powershell-style-guide.md

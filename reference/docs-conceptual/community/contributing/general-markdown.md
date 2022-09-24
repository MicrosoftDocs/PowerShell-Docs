---
description: This article provides specific guidance for using Markdown in our documentation.
ms.date: 07/26/2022
ms.topic: conceptual
title: Markdown best practices
---
# Markdown best practices

This article provides specific guidance for using Markdown in our documentation. This is not a
tutorial for Markdown, but list specific rules and best practice for Markdown in the PowerShell
docs. If you need a tutorial for Markdown, see this [Markdown cheatsheet][1].

## Markdown specifics

The Microsoft Open Publishing System (OPS) that builds our documentation uses [markdig][2] to
process the Markdown documents. Markdig parses the documents based on the rules of the latest
[CommonMark][3] specification.

The CommonMark spec is much stricter about the construction of some Markdown elements. Pay close
attention to the details provided in this document.

We use the [markdownlint][4] extension in VS Code to enforce our style and formatting rules. This
extension is installed as part of the **Docs Authoring Pack**.

### Blank lines, spaces, and tabs

Blank lines also signal the end of a block in Markdown.

- There should be a single blank between Markdown blocks of different types -- for example, between
  a paragraph and a list or header.
- Don't use more than one blank line. Multiple blank lines render as a single blank line in HTML
  and serve no purpose.
- Within a code block, consecutive blank lines break the code block.

Spacing is significant in Markdown.

- Remove extra spaces at the end of lines. Trailing spaces can change how Markdown renders.
- Always uses spaces instead of hard tabs.

### Titles and headings

Only use [ATX headings][5] (# style, as opposed to `=` or `-` style headers).

- Use sentence case - only proper nouns and the first letter of a title or header should be
  capitalized
- There must be a single space between the `#` and the first letter of the heading
- Headings should be surrounded by a single blank line
- Only one H1 per document
- Header levels should increment by one -- don't skip levels
- Avoid using bold or other markup in headers

### Limit line length to 100 characters

This applies to conceptual articles and cmdlet reference. Limiting the line length improves the
readability of git diffs and history. It also makes it easier for other writers to make
contributions.

Use the [Reflow Markdown][6] extension in VS Code to reflow paragraphs to fit the prescribed line
length.

About_topics are limited to 80 characters. For more specific information, see
[Formatting About_ files][7].

### Lists

If your list has multiple sentences or paragraphs, consider using a sublevel header rather than a
list.

List should be surrounded by a single blank line.

#### Unordered lists

- Don't end list items with a period unless they contain multiple sentences.
- Use the hyphen character (`-`) for list item bullets. This avoids confusion with bold or italic
  markup that uses the asterisk (`*`).
- To include a paragraph or other elements under a bullet item, insert a line break and align
  indentation with the first character after the bullet.

For example:

```markdown
This is a list that contain child elements under a bullet item.

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

#### Ordered lists

- All items in a numbered listed should use the number `1.` rather than incrementing each item.
  - Markdown rendering increments the value automatically.
  - This makes reordering items easier and standardizes the indentation of subordinate content.
- To include a paragraph or other elements under a numbered item, align indentation with the first
  character after the item number.

For example:

```markdown
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

### Images

The syntax to include an image is:

```markdown
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
  - This prevents a change to an image in one article affecting another article.

The following image file types are supported: `*.png`, `*.gif`, `*.jpeg`, `*.jpg`, `*.svg`

### Markdown extensions supported by Open Publishing

The [Docs Authoring Pack][8] contains tools that support features unique to our publishing
system. Alerts are a Markdown extension to create blockquotes that render with colors and icons
highlighting the significance of the content. The following alert types are supported:

```markdown
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

### Hyperlinks

- Hyperlinks must use Markdown syntax `[friendlyname](url-or-path)`.
- [Link references][9] are supported.
- The publishing system supports three types of links:
  - URL links
  - File links
  - Cross-reference links
- All URLs to external websites should use HTTPS unless that isn't valid for the target site.
- Links must have a friendly name, usually the title of the linked article
- Don't use backticks, bold, or other markup inside the brackets of a hyperlink.
- Bare URLs may be used when you're documenting a specific URI and must be enclosed in backticks.
  For example:

  ```markdown
  By default, if you don't specify this parameter, the DMTF standard resource URI
  `http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/` is used and the class name is appended to it.
  ```

#### URL-type Links

- URL links to other articles on `learn.microsoft.com` must use site-relative paths. The simplest
  way to create a relative link is to copy the URL from your browser then remove
  `https://learn.microsoft.com/en-us` from the value you paste into markdown.
- Don't include locales in URLs on Microsoft properties (remove `/en-us` from URL).
- Remove any unnecessary query parameters from the URL. Examples that should be removed:
  - `?view=powershell-5.1` - used to link to a specific version of PowerShell
  - `?redirectedfrom=MSDN` - added to the URL when you get redirected from an old article to its new
    location
- If you need to link to a specific version of a document, you must add the `&preserve-view=true`
  parameter to the query string. For example: `?view=powershell-5.1&preserve-view=true`
- URL links don't contain file extensions (for example, no `.md`)

#### File-type links

- A file link is used to link from one reference article to another, or from one conceptual
  article to another. If you need to link from a conceptual article to a reference article you must
  use a URL link.
- Use relative filepaths (for example: `../folder/file.md`)
- All file paths use forward-slash (`/`) characters
- Include the file extension (for example, `.md`)

#### Cross-reference links

Cross-reference links are a special feature supported by the publishing system. You can use
cross-reference links in conceptual articles to link to .NET API or cmdlet reference.

- For links to .NET API reference, see [Use links in documentation][10] in the central Contributor
  Guide.
- Links to cmdlet reference have the following format: `xref:<module-name>.<cmdlet-name>`. For
  example, to link to the `Get-Content` cmdlet in the **Microsoft.PowerShell.Management** module.

  `[Get-Content](xref:Microsoft.PowerShell.Management.Get-Content)`

#### Deep linking

Deep linking is allowed on both URL and file links.

- The anchor text must be lowercase
- Add the anchor to the end of the target path. For example:
  - `[about_Splatting](about_Splatting.md#splatting-with-arrays)`
  - `[custom key bindings](https://code.visualstudio.com/docs/getstarted/keybindings#_custom-keybindings-for-refactorings)`

For more information, see [Use links in documentation][11].

## Next steps

[PowerShell style guide][12]

<!-- link references -->
[1]: https://www.markdownguide.org/cheat-sheet/
[2]: https://github.com/lunet-io/markdig
[3]: https://spec.commonmark.org/
[4]: https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint
[5]: https://github.github.com/gfm/#atx-headings
[6]: https://marketplace.visualstudio.com/items?itemName=marvhen.reflow-markdown
[7]: powershell-style-guide.md#formatting-about_-files
[8]: /contribute/how-to-write-docs-auth-pack
[9]: https://spec.commonmark.org/0.29/#link-reference-definitions
[10]: /contribute/how-to-write-links#xref-cross-reference-links
[11]: /contribute/how-to-write-links
[12]: powershell-style-guide.md

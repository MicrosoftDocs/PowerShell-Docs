# Markdown Specifics

The Microsoft Open Publishing System (OPS) that builds our documentation uses [markdig](https://github.com/lunet-io/markdig)
to process the Markdown documents. Markdig parses the documents based on the rules of the latest
[CommonMark specification](https://spec.commonmark.org/).

The new CommonMark spec is much stricter about the construction of some Markdown elements.
Pay close attention to the details provided in this document.

## Blank lines & Spaces vs Tabs

Remove duplicate blank lines.
Multiple blank lines render as a single blank line in HTML.
Blank lines can also signal the end of a block in Markdown.
There should be a single blank between Markdown blocks of different types (for example,
between a paragraph and a list).

**NOTE:** Spacing is significant in Markdown.
Always uses spaces instead of hard tabs.
Remove extra spaces at the end of lines.

## Titles/Headings

Only use [ATX headings][atx] (# style, as opposed to = or \- style headers).

- There must be a single space between the # and the first letter of the heading
- Titles/headings should be surrounded by blank lines
- Only the first letter of a title and any proper nouns in that title should be capitalized
- Only one H1 per document

When editing reference content, the H2s are prescribed by [platyPS][platyPS].
Adding or removing H2 causes a build break.

## Lists

If your list contains multiple sentences or paragraphs,
consider using a sub-level header rather than a list.
CommonMark

### Unordered lists

Do not end list items with a period (unless they contain multiple sentences).
Use the hyphen character [-] as for list item bullets. This avoids confusion with bold or
italic markup that uses the asterisk [*].
To include a paragraph or other elements under a bullet item, insert a line break and
align indentation with the first character after the bullet.

For example:

```markdown
This is a list that contain sub-elements under a bullet item.

- First bullet item

  Sentence explaining the first bullet.

  - Sub-bullet item

    Sentence explaining the sub-bullet.

- Second bullet item
- Third bullet item
```

This is a list that contains sub-elements under a bullet item.

- First bullet item

  Sentence explaining the first bullet.

  - Sub-bullet item

    Sentence explaining the sub-bullet.

- Second bullet item
- Third bullet item

### Ordered lists

If you want multiple lines within a single list element, format your list as follows:

```markdown
1. For the first element, insert a single space after the 1.

   To include a second element (like this one), insert a line break after the first and align indentations.
   The indentation of the second element must line up with the first character after the numbered list marker.
   For single digit items, like this one, you indent to column 4.
   For double digits items, for example item number 10, you indent to column 5.

2. The next numbered item starts here.
```

to get this output:

1. For the first element (like this one), insert a space after the 1.

   To include a second element (like this one), insert a line break after the first and align indentations.
   The indentation of the second element must line up with the first character after the numbered list marker.

2. The next numbered item starts here.

## Markdown extensions supported by Open Publishing
The following sections describe supported extensions in Open Publishing.

### Note, warning, tip, important
Use specific syntax inside a block quote to indicate that the content is a type of note.

```Markdown
> [!NOTE]
> This is a note.

> [!WARNING]
> This is a warning.

> [!TIP]
> This is a tip.

> [!IMPORTANT]
> This is important.
```

And it will be rendered like this:

![alert boxes](./images/alert-boxes.png)

## Next steps

See [Formatting code blocks](5-FORMATTING-CODE.md).

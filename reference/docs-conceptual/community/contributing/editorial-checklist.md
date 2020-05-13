---
title: Editorial checklist
description: This is a summarized list of rules for editing PowerShell documentation.
ms.date: 03/05/2020
ms.topic: conceptual
---
# Editor's checklist

This is a summary of rules to apply when writing new or updating existing articles. See other
articles in the Contributor's Guide for detailed explanations and examples of these rules.

## Metadata

- `ms.date`: must be in the format **MM/DD/YYYY**
  - Change the date when there is a significant or factual update
    - Reorganizing the article
    - Fixing factual errors
    - Adding new information
  - Do not change the date if the update is insignificant
    - Fixing typos and formatting
- `title`: unique string of 43-59 chars including spaces
  - Do not include site identifier (it is auto-generated)
  - Use sentence case - capitalize only the first word and any proper nouns
- `description`: 115-145 characters including spaces - this abstract displays in the search result

## Formatting

- Backtick syntax elements that appear, inline, within a paragraph
  - Cmdlet names `Verb-Noun`
  - Variable `$counter`
  - Syntactic examples `Verb-Noun -Parameter`
  - File paths `C:\Program Files\PowerShell`, `/usr/bin/pwsh`
  - URLs that are not meant to be clickable in the document
  - Property or parameter values
- Use bold for property names, parameter names, class names, module names, entity names, object or
  type names
  - Bold is used for semantic markup, not emphasis
  - Bold - use asterisks `**`
- Italic - use underscore `_`
  - Only used for emphasis, not for semantic markup
- Line breaks at 100 columns (or at 80 for **about_Topics**)
- No hard tabs - use spaces only
- No trailing spaces on lines

### Headers

- H1 is first - only one H1 per article
- Use [ATX Headers](https://github.github.com/gfm/#atx-headings) only
- Use sentence case for all headers
- Do not skip levels - no H3 without an H2
- Max depth of H3 or H4
- Blank line before and after
- PlatyPS enforces specific headers in its schema - do not add or remove headers

### Code blocks

- Blank line before and after
- Use tagged code fences - **powershell**, **Output**, or other appropriate language ID
- Untagged fence - syntax blocks or other shells
- Put output in separate code block except for simple examples where you don't intend the for the
  reader to use the **Copy** button
- See list of [supported languages](/contribute/code-in-docs#supported-languages)

### Lists

- Indented properly
- Blank line before first item and after last item
- Bullet - use hyphen (`-`) not asterisk (`*`) - too easy to confuse with emphasis
- For numbered lists, all numbers are "1."

## Terminology

- PowerShell vs. Windows PowerShell vs. PowerShell Core
- See [Product Terminology](powershell-style-guide.md#product-terminology)

## Cmdlet reference examples

- Must have at least one example in cmdlet reference
- Examples should be just enough code to demonstrate the usage
- PowerShell syntax
  - Use full names of cmdlets and parameters - no aliases
  - Use splatting for parameters when the command line gets too long
  - Avoid using line continuation backticks - only use when necessary
- Remove or simplify the PowerShell prompt (`PS>`) except where required for the example
- Cmdlet reference example must follow the following PlatyPS schema

  ~~~Markdown
  ### Example 1 - Descriptive title

  Zero or more short descriptive paragraphs explaining the context of the example followed by one or
  more code blocks. Recommend at least one and no more than two.

  ```powershell
  ... one or more PowerShell code statements ...
  ```

  ```Output
  Example output of the code above.
  ```

  Zero or more optional follow up paragraphs that explain the details of the code and output.
  ~~~

- Do not put paragraphs between the code blocks. All descriptive content must come before or after
  the code blocks.

## Linking to other documents

- Linking outside the docset or between cmdlet reference and conceptual
  - Use relative URLs when linking to docs.microsoft.com (remove `https://docs.microsoft.com/en-us`)
  - Do not include locales in URLs on Microsoft properties (eg. remove `/en-us` from URL)
  - All URLs to external websites should use HTTPS unless that is not valid for the target site
- Within docset
  - Link to file path (e.g. `../folder/file.md`)
  - All file paths use forward-slash (`/`) characters
- Image links should have unique alt text

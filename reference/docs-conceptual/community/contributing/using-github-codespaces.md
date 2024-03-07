---
description: >-
    This article describes the process for contributing to the documentation using GitHub
    Codespaces as an authoring environment.
ms.date: 05/10/2023
title: Contribute using GitHub Codespaces
---

# Contribute using GitHub Codespaces

GitHub has a feature called [Codespaces][01] that you can use to contribute to the PowerShell
documentation without having to install or configure any software locally. When you use a
codespace, you get the same authoring tools the team uses for writing and editing.

You can use a codespace in your browser, making your contributions in VS Code hosted over the
internet. If you have VS Code installed locally, you can connect to the codespace there too.

## Available tools

When you use a codespace to contribute to the PowerShell documentation, your editor has these tools
already available for you:

- [Markdownlint][02] for checking your Markdown syntax.
- [cSpell][03] for checking your spelling.
- [Vale][04] for checking your prose.
- The [Learn Authoring Pack][05] for inserting platform-specific syntax, previewing your
  contribution, and more.
- The [Reflow Markdown][06] extension for wrapping your Markdown as needed, making reading and
  editing easier.
- The [Table Formatter][07] extension for making your tables more readable without having to
  manually align columns.
- The [change-case][08] extension for converting the casing of your headings and prose.
- The [GitLens][09] extension for reviewing historical file changes.
- The [PowerShell][10] extension for interacting authoring PowerShell examples.
- The [Gremlins tracker for Visual Studio Code][11] for finding problematic characters in your
  Markdown.

## Cost

GitHub Codespaces can be used for free up to 120 core-hours per month. With the configuration we
recommend in this article, that means up to 60 hours of free usage per month. The monthly usage is
calculated across all your repositories, not just documentation.

For more information about pricing, see [About billing for GitHub Codespaces][12].

> [!TIP]
> If you're comfortable using containers and Docker, you can get the same experience as using
> GitHub Codespaces in VS Code by using the devcontainer defined for the PowerShell documentation
> repositories. There's no cost associated with using devcontainers. For more information, see
> the [Dev Containers tutorial][13].

## Creating your GitHub Codespace

To create your GitHub Codespace for contributing to PowerShell documentation, follow these steps:

1. Open [https://github.com/codespaces][14] in your browser.
1. Select the "New codespace" button in the top right of the page.
1. In the "Create a new codespace" page, select the "Select a repository" button and type the name
   of the repository you want to contribute to, like `MicrosoftDocs/PowerShell-Docs`.
1. Leave all other settings as their default.
1. Select the "Create codespace" button.

After following these steps, GitHub creates a new codespace for that repository and sets it up for
you. When the codespace is ready, the page refreshes and shows the web editor UI for the codespace.
The UI is based on VS Code and works the same way.

## Opening your GitHub Codespace

To open your GitHub Codespace in the browser, follow these steps:

1. Open [https://github.com/codespaces][14] in your browser.
1. The page lists your codespaces. Find the created codespace for the repository you want to
   contribute to and select it.

After you select your codespace, GitHub opens it in the same window. From here, you're ready to
contribute.

To open your GitHub Codespace in VS Code, follow the steps in
[Using GitHub Codespaces in Visual Studio Code][15].

## Authoring in your GitHub Codespace

Once you have your GitHub Codespace open in your browser or VS Code, contributing to the
documentation follows the same process.

The rest of this article describes a selection of tasks you can do in your GitHub Codespace while
writing or editing your contribution.

### Extract a reference link

When you want to turn an inline link, like `[some text](destination.md)`, into a reference link like
`[some text][01]`, select the link destination in the editor. Then you can either:

1. Right click on the link destination and select "Refactor..." in the context menu.
1. Press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>R</kbd>.

Either action raises the refactoring context menu. Select "Extract to link definition" in the
context menu. This replaces the `(destination.md)` in the link with `[def]`. You can rename the
definition by typing a name in.

For the PowerShell documentation, we use two-digit numerical reference link definitions, like
`[01]` or `[31]`. Only use reference link definitions in about topics and conceptual documentation.
Don't use reference link definitions in cmdlet reference documentation.

### Fix prose style violations

When you review an article in your codespace, Vale automatically checks the article when you first
open it and every time you save it. If Vale finds any style violations, it highlights them in the
document with colored squiggles.

Hover over a violation to see more information about it.

Select the rule's name in the hover information to open a web page that explains the rule. Select
the rule's filename (ending in `.yml`) to open the rule and review its implementation.

If the rule supports a quick fix, you can select "Quick Fix..." in the hover information for the
violation and apply one of the suggested fixes by selecting it from the context menu. You can also
press <kbd>Ctrl</kbd>+<kbd>.</kbd> when your cursor is on a highlighted problem to apply a quick
fix if the rule supports it.

If the rule doesn't support quick fixes, read the rule's message and fix it if you can. If
you're not sure how to fix it, the editors can make a suggestion when reviewing your PR.

### Fix syntax problems

When you review an article in your codespace, Markdownlint automatically checks the article when
you open it and as you type. If Markdownlint finds any syntax problems, it highlights them in the
document with colored squiggles.

Hover over a violation to see more information about it.

Select the rule's ID in the hover information to open a web page that explains the rule.

If the rule supports a quick fix, you can select "Quick Fix..." in the hover information for the
violation and apply one of the suggested fixes by selecting it from the context menu. You can also
press <kbd>Ctrl</kbd>+<kbd>.</kbd> when your cursor is on a highlighted problem to apply a quick
fix if the rule supports it.

If the rule doesn't support quick fixes, read the rule's message and fix it if you can. If
you're not sure how to fix it, the editors can make a suggestion when reviewing your PR.

You can also apply fixes to all syntax violations in an article. To do so, open the command palette
and type `Fix all supported markdownlint violations in the document`. As you type, the command
palette filters the available commands. Select the "Fix all supported markdownlint violations in
the document" command. When you do, Markdownlint updates the document to resolve any violations it
has a quick fix for.

### Format a table

To format a Markdown table, place your cursor in or on the table in your Markdown. Open the Command
Palette and search for the `Table: Format Current` command. When you select that command, it
updates the Markdown for your table to align and pad the table for improved readability.

It converts a table defined like this:

```markdown
| foo | bar | baz |
|:--:|:--|-:|
| a | b | c |
```

Into this:

```markdown
|  foo  | bar  | baz  |
| :---: | :--- | ---: |
|   a   | b    |    c |
```

### Insert an alert

The documentation uses [alerts][16] to make information more notable to a reader.

To insert an alert, you can, open the Command Palette and search for the `Learn: Alert` command.
When you select that command, it opens a context menu. Select the alert type you want to add. When
you do, the command inserts the alert's Markdown at your cursor in the document.

### Make a heading use sentence casing

To convert a heading's casing, highlight the heading's text except for the leading `#` symbols,
which set the heading level. When you have the text highlighted, open the Command Palette and
search for the `Change case sentence` command. When you select that command, it converts the casing
of the highlighted text.

You can also use the casing commands for any text in the document.

### Open the Command Palette

You can use VS Code's [Command Palette][17] to run many helpful commands.

To open the Command Palette in the UI, select "View" in the top menu bar. Then select "Command
Palette..." in the context menu.

To open the Command Palette with your keyboard, press the key combination for your operating system:

- Windows and Linux: <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd>
- macOS: <kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd>

### Preview your contribution

To preview your contribution, open the Command Palette and search for the `Markdown: Open Preview`
command. When you select that command, VS Code opens a preview of the active document. The
preview's style matches the Learn platform.

> [!NOTE]
> Site-relative and cross-reference links won't work in the preview.

### Reflow your content

To limit the line lengths for a paragraph in a document, place your cursor on the paragraph. Then
open the Command Palette and search for the `Reflow Markdown` command. When you select the command,
it updates the current paragraph's line lengths to the configured length. For our repositories,
that length is 99 characters.

When using this command for block quotes, make sure the paragraph in the block quote you're
reflowing is surrounded by blank lines. Otherwise, the command reflows every paragraph together.

> [!CAUTION]
> Don't use this command when editing about topics. The lines in those documents must not be
> longer than 80 characters. There's currently no way for a repository to configure different line
> lengths by folder or filename, so reflow doesn't work for about topic documents.

### Review all problems in a document

To review all syntax and style rule violations in a document, open the Problems View.

To open the Problems View in the UI, select "View" in the top menu bar. Then select "Problems" in
the context menu.

To open the Problems View with your keyboard, press the key combination for your operating system:

- Windows and Linux: <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>M</kbd>
- macOS: <kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>M</kbd>

The Problems View displays all errors, warnings, and suggestions for the open document. Select a
problem to scroll to it in the document.

You can filter the problems by type or text matching.

### Updating the ms.date metadata

To update the `ms.date` metadata for an article, open the Command Palette and search for the
`Learn: Update "ms.date" Metadata Value` command. When you select the command, it updates the
metadata to the current date.

## Additional resources

The tasks and commands described in this article don't cover everything you can do with VS Code or
the installed extensions.

For more information on using VS Code, see these articles:

- [Visual Studio Code Tips and Tricks][18]
- [Basic Editing][19]
- [Using Git source control in VS Code][20]
- [Markdown and Visual Studio Code][21]

For more information about the installed extensions, see their documentation:

- [change-case][08]
- [GitLens][09]
- [Gremlins tracker for Visual Studio Code][11]
- [Learn Authoring Pack][05]
- [markdownlint][02]
- [Reflow Markdown][06]
- [Table Formatter][07]

<!-- Reference link definitions -->
[01]: https://github.com/features/codespaces
[02]: https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint
[03]: https://cspell.org/
[04]: https://vale.sh/
[05]: https://marketplace.visualstudio.com/items?itemName=docsmsft.docs-authoring-pack
[06]: https://marketplace.visualstudio.com/items?itemName=marvhen.reflow-markdown
[07]: https://marketplace.visualstudio.com/items?itemName=shuworks.vscode-table-formatter
[08]: https://marketplace.visualstudio.com/items?itemName=wmaurer.change-case
[09]: https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens
[10]: https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell
[11]: https://marketplace.visualstudio.com/items?itemName=nhoizey.gremlins
[12]: https://docs.github.com/en/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces
[13]: https://code.visualstudio.com/docs/devcontainers/tutorial
[14]: https://github.com/codespaces
[15]: https://docs.github.com/codespaces/developing-in-codespaces/using-github-codespaces-in-visual-studio-code
[16]: /contribute/markdown-reference#alerts-note-tip-important-caution-warning
[17]: https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette
[18]: https://code.visualstudio.com/docs/getstarted/tips-and-tricks
[19]: https://code.visualstudio.com/docs/editor/codebasics
[20]: https://code.visualstudio.com/docs/sourcecontrol/overview
[21]: https://code.visualstudio.com/docs/languages/markdown

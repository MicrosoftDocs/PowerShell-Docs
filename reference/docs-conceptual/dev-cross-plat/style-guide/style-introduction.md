---
description: The PowerShell best practices and style guide
ms.date: 07/11/2022
title: The PowerShell best practices and style guide
---
# The PowerShell best practices and style guide

This guide documents a baseline for code structure, command design, programming, formatting, and
style that help you to avoid common problems and help you write more readable and maintainable code.

> [!NOTE]
> The contents of this guide is based on the
> [The PowerShell Best Practices and Style Guide][psguide] licensed under a
> [Creative Commons Attribution-ShareAlike 4.0 International License][CC4] by Don Jones, Matt Penny,
> Carlos Perez, Joel Bennett and the PowerShell Community.

## The intent of this guide

Like spelling and grammar rules, PowerShell programming best practices and style rules always have
exceptions. The points in this guide are referred to as _practices_ and _guidelines_, not rules. If
you're having trouble getting something done because you're trying to avoid _breaking_ a style or
best practice rule, you've misunderstood the point. This document is pragmatic, rather than
dogmatic. These guidelines were influenced by accepted community practices, recommendations from the
PowerShell development team, rules defined in [PSScriptAnalyzer][pssa], and the needs of the
documentation team.

While we recommend you use this guide for any PowerShell code you write, consistency within a
project is more important. Always follow the style of the project to which you are contributing.
Microsoft documentation endeavors to follow this guide to ensure consistency.

Sometimes style guide recommendations just aren't applicable. When in doubt, use your best judgment.
Look at other examples and decide what looks best.

Some reasons to ignore a particular guideline:

1. When applying the guideline would make the code less readable, even for someone who is used to
   reading code that follows this guide.
1. To be consistent with surrounding code that also breaks it (maybe for historic reasons). Although
   this is also an opportunity to clean up the older code.
1. Because the code in question predates the introduction of the guideline and there is no other
   reason to be modifying that code.
1. When the code needs to remain compatible with older versions of PowerShell that don't support the
   feature recommended by the style guide.

<!-- reference links -->

[CC4]: http://creativecommons.org/licenses/by-sa/4.0/
[psguide]: https://github.com/PoshCode/PowerShellPracticeAndStyle
[pssa]: /powershell/utility-modules/psscriptanalyzer/rules/readme

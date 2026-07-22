---
description: Quickly review PowerShell concepts with concise answers to end-of-chapter questions, reinforcing key skills in scripting, remoting, modules, and automation.
ms.custom: Contributor-mikefrobbins
ms.date: 05/4/2026
ms.reviewer: mirobb
title: Answers to Review Questions
---

# Appendix - Answers to Review Questions

This appendix provides concise answers to the review questions found at the end of each chapter. Use
it to validate your understanding and reinforce key concepts.

## Chapter 1 - Getting started with PowerShell

1. Use the `$PSVersionTable` automatic variable.
1. Only when you need to bypass User Account Control (UAC) for tasks that require elevation on the
   local computer.
1. The default execution policy on Windows client systems is `Restricted`, which prevents running
   scripts.
1. Use `Get-ExecutionPolicy` to determine the current execution policy.
1. Use `Set-ExecutionPolicy` (for example, `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned`).

## Chapter 2 - The Help system

1. No. The **DisplayName** parameter of `Get-Service` is named, not positional.
1. `Get-Process` has six parameter sets.
1. Use `Get-Command -Noun EventLog`.
1. Use `Get-Process -Name powershell`.
1. Run `Update-Help` (elevated as an administrator in Windows PowerShell) to download and install
   the latest help content.

## Chapter 3 - Discovering objects, properties, and methods

1. `Get-Process` produces a `System.Diagnostics.Process` object.
1. Pipe the command to `Get-Member`.
1. Check whether the object has a method that performs the action.
1. Use the command's `PassThru` parameter, if it has one.
1. Run the command once and store the results in a variable to avoid repeatedly generating large
   amounts of output while prototyping.

## Chapter 4 - One-Liners and the pipeline

1. A PowerShell one-liner is a single continuous pipeline, regardless of how many physical lines it
   spans.
1. Natural line breaks can occur at characters such as the pipe (`|`), comma (`,`), opening brackets
   (`[ ]`), braces (`{ }`), and parentheses (`( )`).
1. You should filter left to improve performance and efficiency by reducing the amount of data
   passed through the pipeline.
1. A command can accept pipeline input by value (by type) or by property name.
1. Because most content in the PowerShell Gallery is community-contributed and may not be vetted, it
   should be reviewed and tested before use.

## Chapter 5 - Formatting, aliases, providers, comparison

1. Because formatting cmdlets produce format objects, which break the pipeline and can't be used by
   most other commands.
1. Use `Get-Alias -Name %` to determine the actual cmdlet.
1. Because aliases reduce readability and portability, making scripts more difficult for others to
   understand.
1. Use `Get-ChildItem -Path HKLM:\, HKCU:\` to list registry keys in both hives.
1. The `-replace` operator is case-insensitive by default, whereas the `.Replace()` method is
   case-sensitive.

## Chapter 6 - Flow control

1. `ForEach-Object` processes items one at a time from the pipeline (streaming), while the `foreach`
   statement processes items from a collection that's already loaded into memory.
1. A `while` loop evaluates its condition before running, so it may not run at all if the condition
   is false, unlike `do while` and `do until`, which run at least once.
1. `break` exits the loop entirely, while `continue` skips the current iteration and proceeds to the
   next one.

## Chapter 7 - Working with WMI

1. WMI cmdlets (for example, `Get-WmiObject`) are older and use DCOM, while CIM cmdlets (for
   example, `Get-CimInstance`) are newer and use WSMan by default.
1. WSMan (Windows Remote Management).
1. CIM sessions allow reuse of connections, support alternate credentials, improve performance, and
   simplify managing multiple remote connections.
1. Create a session option with `New-CimSessionOption`, for example, to use DCOM, and pass it to
   `New-CimSession`, then use that session with `Get-CimInstance`.
1. Use `Remove-CimSession`.

## Chapter 8 - PowerShell remoting

1. Use `Enable-PSRemoting`.
1. Use `Enter-PSSession`.
1. It allows you to use a persistent session instead of specifying the computer name and credentials
   with each command.
1. Yes, you can use a PowerShell session (PSSession) in a one-to-one interactive remoting scenario.
1. Locally run cmdlets return live objects with methods, while remote commands return deserialized
   objects without methods.

## Chapter 9 - Functions

1. Use `Get-Verb`.
1. Add the `[CmdletBinding()]` attribute to the function.
1. When the function makes changes to system state or performs potentially impactful actions.
1. Specify `-ErrorAction Stop`.
1. To document how to use the function so you and others can easily understand it and access help
   with `Get-Help`.

## Chapter 10 - Script modules

1. Create a `.psm1` file and place your functions in it.
1. Using approved verbs ensures consistency, avoids warnings, and improves discoverability.
1. Use `New-ModuleManifest`.
1. Use `Export-ModuleMember` in the `.psm1` file or specify functions in the `FunctionsToExport`
   field of the `.psd1` file.
1. The module must be in a folder named the same as the module, located in a path listed in
   `$env:PSModulePath`, and contain the appropriate module file (`.psm1` or manifest).

## Final Notes

- These answers are intentionally concise to reinforce key concepts.
- Revisit the chapters for deeper understanding.

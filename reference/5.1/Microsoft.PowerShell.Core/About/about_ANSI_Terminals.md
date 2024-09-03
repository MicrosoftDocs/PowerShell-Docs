---
description: Describes the features of PowerShell that use ANSI escape sequences and the terminal hosts that support them.
Locale: en-US
ms.date: 03/01/2023
schema: 2.0.0
title: about_ANSI_terminals
---
# about_ANSI_Terminals

## Short description
Describes the support available for ANSI escape sequences in Windows PowerShell.

## Long description

Unlike newer versions of PowerShell, the Windows PowerShell 5.1 engine and core
cmdlets don't output ANSI escape sequences to format the text displayed on your
screen. However, that doesn't prevent you from using ANSI escape sequences for
text formatting in terminals that support it.

## ANSI Terminal support

On Windows 10 and higher, the Windows Console Host is [xterm][02] compatible.
The [Windows Terminal][03] application is also xterm compatible. These
terminals support ANSI escape sequences.

The PSReadLine module uses ANSI sequences to colorize PowerShell syntax
elements on the command line. The colors can be managed using
[Get-PSReadLineOption][04] and [Set-PSReadLineOption][05].

The default colors were chosen for use with terminals that have a dark
background. You can change the colors needed for your environment. For more
information, see [Customizing your shell experience][01].

## Redirecting output

You should be careful about creating output that's decorated with ANSI escape
sequences. The formatting is intended for display in the terminal. When you
pipe that output to another command or redirect the output to a file, the
output contains the ANSI escape sequences. This formatting may not be
understood by the downstream command in your pipeline or be rendered correctly
in the output file.

PowerShell 7.2 and higher removes ANSI decorations when redirecting and
provides tools that make using ANSI escape sequences easier.

<!-- link references -->
[01]: /powershell/scripting/learn/shell/creating-profiles
[02]: https://wikipedia.org/wiki/Xterm
[03]: https://www.microsoft.com/p/windows-terminal/9n0dx20hk701
[04]: xref:PSReadLine.Get-PSReadLineOption
[05]: xref:PSReadLine.Set-PSReadLineOption

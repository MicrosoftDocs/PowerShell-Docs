---
description: Describes the built-in functions in PowerShell.
Locale: en-US
ms.date: 07/17/2023
online version: https://learn.microsoft.com/powershell/module/Microsoft.PowerShell.Core/about/about_built-in_functions?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about Built-in Functions
---
# about_Built-in_Functions

## Short description

Describes the built-in functions in PowerShell.

## Long description

PowerShell includes a set of functions that are loaded into every PowerShell
session. These functions are similar to cmdlets but they're not included in any
module. They're defined in the PowerShell engine itself.

These functions are provided as shorthand helpers for common tasks. In many
cases, these functions call an existing cmdlet with an additional parameter.

## `cd..`

In the Windows CMD shell it's common to run the `cd` command without any spaces
between the command and the destination path. This function runs
`Set-Location ..` to change to the parent folder.

## `cd\`

In the Windows CMD shell it's common to run the `cd` command without any spaces
between the command and the destination path. This function runs
`Set-Location \` to change to the root folder.

## `Clear-Host`

This function clears the screen. For more information, see
[Clear-Host](xref:Microsoft.PowerShell.Core.Clear-Host).

## `Get-Verb`

This function lists PowerShell verbs and the category group they belong to. For
more information, see [Get-Verb](xref:Microsoft.PowerShell.Core.Get-Verb)

## `help`

This function invokes `Get-Help` with your parameters and passes the output to
the systems pager command, `more.com`.

## `ImportSystemModules`

This function has been deprecated. It is an empty function that does nothing.

## `mkdir`

This function provides a short hand way to run `New-Item -Type Directory` with
your parameters.

## more

This function is a wrapper around the `more.com` native command.

## `oss`

This function provides a short hand way to run `Out-String -Stream` in a
pipeline.

## `Pause`

This function replicates the behavior of CMD's `pause` command. The script
pauses execution and prompts the user to hit a key to continue.

## `prompt`

This is the function that creates the default prompt for the PowerShell command
line. You can customize your prompt by overriding this function with your own.
For more information see [about_Prompts](about_Prompts.md).

## `TabExpansion2`

This is the default function to use for tab expansion.

## Windows drive letter functions

In Windows, drive mount points are associated with a drive letter like `C:`.
You can switch to the current location on another drive just by entering that
drive letter on the command line.

PowerShell create a function for every possible drive letter, `A:` through
`Z:`.

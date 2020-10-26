---
ms.date: 09/13/2016
ms.topic: reference
title: Cmdlet Aliases
description: Cmdlet Aliases
---
# Cmdlet Aliases

You can use cmdlet aliases to improve the cmdlet user experience. You can add aliases to frequently used cmdlets to reduce typing and to make it easier to complete tasks quickly. You can include built-in aliases in your cmdlets, or users can define their own custom aliases.

For example, the [Get-Command](/powershell/module/microsoft.powershell.core/get-command) cmdlet has a built-in `gcm` alias. You can also use aliases to add command names from other languages so that users do not have to learn new commands.

## Alias Guidelines

Follow these guidelines when you create built-in aliases for your cmdlets:

- Before you assign aliases, start Windows PowerShell, and then run the [Get-Alias](/powershell/module/Microsoft.PowerShell.Utility/Get-Alias) cmdlet to see the aliases that are already used.

- Include an alias prefix that references the verb of the cmdlet name and an alias suffix that references the noun of the cmdlet name. For example, the alias for the `Import-Module` cmdlet is "ipmo". For a list of all the verbs and their aliases, see [Cmdlet Verbs](./approved-verbs-for-windows-powershell-commands.md).

- For cmdlets that have the same verb, include the same alias prefix. For example, the aliases for all the Windows PowerShell cmdlets that have the "Get" verb in their name use the "g" prefix.

- For cmdlets that have the same noun, include the same alias suffix. For example, the aliases for all the Windows PowerShell cmdlets that have the "Session" noun in their name use the "sn" suffix.

- For cmdlets that are equivalent to commands in other languages, use the name of the command.

- In general, make aliases as short as possible. Make sure the alias has at least one distinct character for the verb and one distinct character for the noun. Add more characters as needed to make the alias unique.

## See Also

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)

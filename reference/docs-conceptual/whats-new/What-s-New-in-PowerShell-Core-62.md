---
title: What's New in PowerShell Core 6.2
description: New features and changes released in PowerShell Core 6.2
ms.date: 03/28/2019
---

# What's New in PowerShell Core 6.2

Below is a selection of some of the major new features and changes that have been introduced
in PowerShell Core 6.2.

There's also **tons** of "boring stuff" that make PowerShell faster and more stable (plus lots and lots of bug fixes)!
For a full list of changes, check out our [changelog on GitHub](https://github.com/PowerShell/PowerShell/blob/master/CHANGELOG.md).

And while we call out some names below, thank you to
[all of the community contributors](https://github.com/PowerShell/PowerShell/graphs/contributors)
that made this release possible.

## Engine Updates and Fixes

- Add PowerShell remoting enable/disable cmdlet warning messages ([#9203][])
- Fix for `FormatTable` remote deserialization regression ([#9116][])
- Update the task-based `async` APIs added to PowerShell to return a Task object directly ([#9079][])
- Add 5 `InvokeAsync` overloads and `StopAsync` to the `PowerShell` type ([#8056][]) (Thanks @KirkMunro!)

## General Cmdlet Updates and Fixes

- Enable `SecureString` cmdlets for non-Windows by storing the plain text ([#9199][])
- Add Obsolete message to `Send-MailMessage` ([#9178][])
- Fix `Restart-Computer` to work on `localhost` when WinRM is not present ([#9160][])
- Make `Start-Job` throw terminating error when PowerShell is being hosted ([#9128][])
- Update version for `PowerShell.Native` and hosting tests ([#8983][])

## Breaking Changes

Fix -NoEnumerate behavior in Write-Output to be consistent with Windows PowerShell ([#9069][]) (Thanks @vexx32!)

<!-- Link references -->
[#8056]: https://github.com/PowerShell/PowerShell/pull/8056
[#8983]: https://github.com/PowerShell/PowerShell/pull/8983
[#9069]: https://github.com/PowerShell/PowerShell/pull/9069
[#9079]: https://github.com/PowerShell/PowerShell/pull/9079
[#9116]: https://github.com/PowerShell/PowerShell/pull/9116
[#9128]: https://github.com/PowerShell/PowerShell/pull/9128
[#9160]: https://github.com/PowerShell/PowerShell/pull/9160
[#9178]: https://github.com/PowerShell/PowerShell/pull/9178
[#9199]: https://github.com/PowerShell/PowerShell/pull/9199
[#9203]: https://github.com/PowerShell/PowerShell/pull/9203

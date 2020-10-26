---
ms.date:  06/12/2017
title:  Console Improvements in WMF 5.1
description: WMF 5.1 adds new features to the console experience for Windows PowerShell 5.1.
---
# Console Improvements in WMF 5.1

## PowerShell console improvements

The following changes have been made to powershell.exe in WMF 5.1 to improve the console experience:

### VT100 support

Windows 10 added support for [VT100 escape sequences](/windows/console/console-virtual-terminal-sequences).
PowerShell will ignore certain VT100 formatting escape sequences when calculating table widths.

PowerShell also added a new API that can be used in formatting code to determine if VT100 is
supported. For example:

```powershell
if ($host.UI.SupportsVirtualTerminal)
{
    $esc = [char]0x1b
    "A yellow ${esc}[93mhello${esc}[0m"
}
else
{
    "A default hello"
}
```

Here is a complete [example](https://gist.github.com/lzybkr/dcb973dccd54900b67783c48083c28f7) that
can be used to highlight matches from `Select-String`. Save the example in a file named
`MatchInfo.format.ps1xml`, then to use it, in your profile or elsewhere, run
`Update-FormatData -Prepend MatchInfo.format.ps1xml`.

Note that VT100 escape sequences are only supported starting with the Windows 10 Anniversary update.
They are not supported on earlier systems.

### Vi mode support in PSReadline

[PSReadline](https://github.com/PowerShell/PSReadLine) adds support for vi mode. To use vi mode, run `Set-PSReadlineOption -EditMode Vi`.

### Redirected stdin with interactive input

In earlier versions, starting PowerShell with `powershell -File -` was required when stdin was
redirected and you wanted to enter commands interactively.

With WMF 5.1, this hard to discover option is no longer necessary. You can start PowerShell without
any options.

Note that PSReadline does not support redirected stdin, and the built-in command-line editing
experience with redirected stdin is extremely limited, for example, arrow keys don't work. A future
release of PSReadline should address this issue.

---
description: Explains the availability and purpose of output streams in PowerShell.
Locale: en-US
ms.date: 01/22/2023
no-loc: [Success, Error, Warning, Verbose, Debug, Information, Progress]
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_output_streams?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Output_Streams
---
# about_Output_Streams

## Short description

Explains the availability and purpose of output streams in PowerShell.

## Long description

PowerShell provides multiple output streams. The streams provide channels for
different types of messages. You can write to these streams using the
associated cmdlet or redirection. For more information, see
[about_Redirection][03].

PowerShell supports the following output streams.

| Stream # |      Description       | Introduced in  |    Write Cmdlet     |
| -------- | ---------------------- | -------------- | ------------------- |
| 1        | **Success** stream     | PowerShell 2.0 | `Write-Output`      |
| 2        | **Error** stream       | PowerShell 2.0 | `Write-Error`       |
| 3        | **Warning** stream     | PowerShell 2.0 | `Write-Warning`     |
| 4        | **Verbose** stream     | PowerShell 2.0 | `Write-Verbose`     |
| 5        | **Debug** stream       | PowerShell 2.0 | `Write-Debug`       |
| 6        | **Information** stream | PowerShell 5.0 | `Write-Information` |
| n/a      | **Progress** stream    | PowerShell 2.0 | `Write-Progress`    |

> [!NOTE]
> The **Progress** stream doesn't support redirection.

## Success stream

The **Success** stream is the default stream for normal, successful results.
Use the `Write-Output` cmdlet to explicitly write objects to this stream. This
stream is used for passing objects through the PowerShell pipeline. The
**Success** stream is connected to the **stdout** stream for native
applications.

## Error stream

The **Error** stream is the default stream for error results. Use the
`Write-Error` cmdlet to explicitly write to this stream. The **Error** stream
is connected to the **stderr** stream for native applications. Under most
conditions, these errors can terminate the execution pipeline. Errors written
to this stream are also added to the `$Error` automatic variable. For more
information, see [about_Automatic_Variables][01].

## Warning stream

The **Warning** stream is intended for error conditions that are less severe
than errors written to the **Error** stream. Under normal conditions, these
warnings don't terminate execution. Warnings aren't written to the `$Error`
automatic variable. Use the `Write-Warning` cmdlet to explicitly write to this
stream.

## Verbose stream

The **Verbose** stream is intended for messages that help users troubleshoot
commands as they're run interactively or from a script. Use the `Write-Verbose`
cmdlet to explicitly write messages to this stream. Many cmdlets provide
verbose output that's useful for understanding the internal workings of the
cmdlet. The verbose messages are output only when you use the `-Verbose` common
parameter. For more information, see [about_CommonParameters][02].

## Debug stream

The **Debug** stream is used for messages that help scripters understand why
their code is failing. Use the `Write-Debug` cmdlet to explicitly write to this
stream. The debug messages are output only when you use the `-Debug` common
parameter. For more information, see [about_CommonParameters][02].

Debug messages are intended for script and cmdlet developers more than end
users. These debug messages can contain internal details necessary for deep
troubleshooting.

## Information stream

The **Information** stream is intended to provide messages that help a user
understand what a script is doing. It can also be used by developers as an
additional stream used to pass information through PowerShell. The developer
can tag stream data and have specific handling for that stream. Use the
`Write-Information` cmdlet to explicitly write to this stream.

`Write-Host` also writes to the **Information** stream. The difference between
the cmdlets is that `Write-Host` also writes to the host console unless you
redirect the **Information** stream. `Write-Information` only writes to the
**Information** stream.

## Progress stream

The **Progress** stream is used for messages that communicate progress in
longer running commands and scripts. Use the `Write-Progress` cmdlet to
explicitly write messages to this stream. The **Progress** stream doesn't
support redirection.

## See also

- [about_CommonParameters][02]
- [about_Redirection][03]
- [Write-Debug][04]
- [Write-Error][05]
- [Write-Host][06]
- [Write-Information][07]
- [Write-Output][08]
- [Write-Progress][09]
- [Write-Verbose][10]
- [Write-Warning][11]

<!-- link references -->
[01]: about_Automatic_Variables.md
[02]: about_CommonParameters.md
[03]: about_Redirection.md
[04]: xref:Microsoft.PowerShell.Utility.Write-Debug
[05]: xref:Microsoft.PowerShell.Utility.Write-Error
[06]: xref:Microsoft.PowerShell.Utility.Write-Host
[07]: xref:Microsoft.PowerShell.Utility.Write-Information
[08]: xref:Microsoft.PowerShell.Utility.Write-Output
[09]: xref:Microsoft.PowerShell.Utility.Write-Progress
[10]: xref:Microsoft.PowerShell.Utility.Write-Verbose
[11]: xref:Microsoft.PowerShell.Utility.Write-Warning

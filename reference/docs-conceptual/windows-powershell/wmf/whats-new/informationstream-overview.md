---
ms.date:  06/12/2017
title: Information Stream
description: PowerShell 5.0 adds a new structured **Information** stream to transmit structured data between a script and its host.
---

# Information Stream

PowerShell 5.0 adds a new structured **Information** stream to transmit structured data between a
script and its host. `Write-Host` has also been updated to emit its output to the **Information**
stream where you can now capture or silence it. The new `Write-Information` cmdlet used with
**InformationVariable** and **InformationAction** common parameters enables more flexibility and
capability.

The following function uses cmdlets that take advantage of the new **Information** stream.

```powershell
function OutputGusher {
  [CmdletBinding()]
  param()
  Write-Host -ForegroundColor Green 'Preparing to give you output!'
  Write-Host '============================='
  Write-Host 'I ' -ForegroundColor White -NoNewline
  Write-Host '<3 ' -ForegroundColor Red -NoNewline
  Write-Host 'Output' -ForegroundColor White
  Write-Host '============================='

  $p = Get-Process -id $pid
  $p

  Write-Information $p -Tag Process
  Write-Information 'Some spammy logging information' -Tag LogLow
  Write-Information 'Some important logging information' -Tag LogHigh

  Write-Host
  Write-Host -ForegroundColor Green 'SCRIPT COMPLETE!!'
}
```

The following examples show the results of running this function.

```powershell
$r = OutputGusher
```

```Output
Preparing to give you output!
=============================
I <3 Output
=============================

SCRIPT COMPLETE!!
```

The `$r` variable has captured the process information in the script variable `$p`.

```powershell
$r.Id
4008
```

Unlike the `Write-Host` cmdlet, using the **InformationVariable** parameter of `Write-Information`
allows you to capture the output in a variable. Using the **Tag**, you can create separate channels
for message sent to the **Information** stream.

```powershell
$r = OutputGusher -InformationVariable iv
$ivOutput = $iv | Group-Object -AsHash { $_.Tags[0] } -AsString
$ivOutput
```

```Output
Preparing to give you output!
=============================
I <3 Output
=============================
SCRIPT COMPLETE!!

Name                 Value
----                 -----
LogLow               {Some spammy logging information}
LogHigh              {Some important logging information}
Process              {System.Diagnostics.Process (powershell)}
PSHOST               {Preparing to give you output!, =============================, I , <3 ...}
```

When you send a message to the **Information** stream with a tag, that message is not displayed in
the host application but can be retrieved using the tag name. For example:

```powershell
$iv | where Tags -eq 'LogHigh'
```

```Output
Some important logging information
```

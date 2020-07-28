---
title: Displaying progress across multiple threads
description: How to use Write-Progress across multiple threads with Foreach-Object -Parallel
ms.date: 07/27/2020
---

# Writing Progress across multiple threads with Foreach Parallel

Starting in PowerShell 7.0, the ability to work in multiple threads simultaneously is possible using
the **Parallel** parameter in the `Foreach-Object` cmdlet. Monitoring the progress of these threads
can be a challenge though. Normally, you can monitor the progress of a process using
`Write-Progress`. However, since PowerShell uses a separate runspace for each thread when using
**Parallel**, reporting the progress back to the host isn't as straight forward as normal use of
`Write-Progress`.


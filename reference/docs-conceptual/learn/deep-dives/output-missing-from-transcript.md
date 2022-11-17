---
description: This articles explains the limitations of PowerShell transcripts and the cases than can cause data to be logged out of order or be missing from the transcript.
ms.custom: wiki-migration
ms.date: 11/16/2022
title: Limitations of PowerShell transcripts
---
# Limitations of PowerShell transcripts

Mixing `Write-Host` output with the output objects, strings, and PowerShell transcription is
complicated. There is a subtle interaction between the script and how transcription works with
PowerShell pipelines that can have unexpected results.

When you emit objects from your script the formatting of those objects is handled by `Out-Default`.
But the formatting can occur after the script has completed and transcription has stopped. This
means that the output doesn't get transcribed. Strings are handled differently. Sometimes string
output is passed through formatting, but not always. `Write-Host` makes an immediate write to the
host process. `Write-Object` is sent through the formatting system. Combining the output of complex
objects with writes to the host makes it difficult to predict what gets logged in the transcript.

## Scenario 1 - Output of a structured object at the end of all of the other operations

Consider the following script and its output:

```powershell
PS> Get-Content scenario1.ps1
Start-Transcript scenario1.log -UseMinimalHeader
Write-Host '1'
Write-Output '2'
Get-Location
Write-Host '4'
Write-Output '5'
Stop-Transcript

PS> ./scenario1.ps1
Transcript started, output file is scenario1.log
1
2

4
Path
----
/Users/user1/src/projects/transcript
5
Transcript stopped, output file is /Users/user1/src/projects/transcript/scenario1.log
```

The output to the console shows the output you expect, but not in the order you expect it.
`Write-Host 4` is visible before `Get-Location` because `Write-Host` is optimized to write directly
to the host. There's code in transcription that copies the output to the transcript file and the
console. Then we have the regular output of `Get-Location` and `Write-Output 5` sent as output of
the script.

```powershell
PS> Get-Content scenario1.log
**********************
PowerShell transcript start
Start time: 20191106114858
**********************
Transcript started, output file is s2
1
2

4
**********************
PowerShell transcript end
End time: 20191106114858
**********************
```

Since transcription is turned off before the script exits, it's not rendered in the transcript. The
objects were sent to the next consumer in the pipeline. In this case, it's `Out-Default`, which
PowerShell inserted automatically. To complicate things further, the output of strings is also
optimized in the formatting system. The first `Write-Output 2` gets emitted and captured by the
transcript. But the insertion of the `Get-Location` object causes its output to be pushed into the
stack of things that need actual formatting, which sets a bit of state for any remaining objects
that also may need formatting. This is why the second `Write-Output 5` doesn't get added to the
transcript.

## Scenario 2 - Move the object emission to the beginning

Consider the following script and its output:

```powershell
PS> Get-Content scenario2.ps1
Start-Transcript scenario2.log -UseMinimalHeader
Get-Location
Write-Host '1'
Write-Output '2'
Get-Location
Write-Host '4'
Write-Output '5'
Stop-Transcript

PS> ./scenario2.ps1
Transcript started, output file is scenario2.log

1
4
Path
----
/Users/user1/src/projects/transcript
2
5
Transcript stopped, output file is /Users/user1/src/projects/transcript/scenario2.log
```

We can see that the `Write-Host` commands happen before anything, and then the objects start to come
out. The `Write-Output` of a string forces the object to be rendered to the screen, but notice that
the transcript contains only the output of `Write-Host`. That's because those string objects are
piped to `Out-Default` for formatting after the script turned off transcription.

```powershell
PS> Get-Content scenario2.log
**********************
PowerShell transcript start
Start time: 20220606094609
**********************
Transcript started, output file is s3

1
4
**********************
PowerShell transcript end
End time: 20220606094609
**********************
```

## Scenario 3 - Object emitted at the end of the script

For this scenario, the output of the complex object is at the end of the script.

```powershell
PS> Get-Content scenario3.ps1
Start-Transcript scenario3.log -UseMinimalHeader
Write-Host '1'
Write-Output '2'
Write-Host '4'
Write-Output '5'
Get-Location
Stop-Transcript

PS> ./scenario3.ps1
Transcript started, output file is scenario3.log
1
2
4
5

Path
----
/Users/user1/src/projects/transcript
Transcript stopped, output file is /Users/user1/src/projects/transcript/scenario3.log
```

The string output from both `Write-Host` and `Write-Object` makes it into the transcript. However,
the output from `Get-Location` occurs after transcription has stopped.

```
**********************
PowerShell transcript start
Start time: 20220606100342
**********************
Transcript started, output file is scenario3.log
1
2
4
5

**********************
PowerShell transcript end
End time: 20220606100342
**********************
```

## A way to ensure full transcription

This example is a slight variation on the original scenario, but now everything is logged to the
transcript. The original code is wrapped in a script block and the formatter explicitly invoked via
`Out-Default`.

```powershell
PS> Get-Content scenario4.ps1
Start-Transcript scenario4.log -UseMinimalHeader
. {
    Write-Host '1'
    Write-Output '2'
    Get-Location
    Write-Host '4'
    Write-Output '5'
} | Out-Default
Stop-Transcript

PS> ./scenario4.ps1
Transcript started, output file is scenario4.log
1
2

4
Path
----
/Users/user1/src/projects/transcript
5

Transcript stopped, output file is /Users/user1/src/projects/transcript/scenario4.log
```

Notice that the last `Write-Host` call is still out of order, that's because of the
optimization in `Write-Host` that doesn't go into the output stream.

```powershell
PS> Get-Content scenario4.log
**********************
PowerShell transcript start
Start time: 20220606101038
**********************
Transcript started, output file is s5
1
2

4
Path
----
/Users/user1/src/projects/transcript
5

**********************
PowerShell transcript end
End time: 20220606101038
**********************
```

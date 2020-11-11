---
ms.date:  06/12/2017
title: Script Tracing and Logging
description: Windows PowerShell 5.x adds new event logging that allows you to audit script block execution.
---
# Script Tracing and Logging

While PowerShell already has the **LogPipelineExecutionDetails** Group Policy setting to log the
invocation of cmdlets, PowerShell's scripting language has several features that you might want to
log and audit. The new Detailed Script Tracing feature provides detailed tracking and analysis of
PowerShell script activity on a system. After enabling detailed script tracing, PowerShell logs all
script blocks to the ETW event log, **Microsoft-Windows-PowerShell/Operational**. If a script block
creates another script block, for example, by calling `Invoke-Expression`, the invoked script block
also logged.

Logging is enabled through the **Turn on PowerShell Script Block Logging** Group Policy setting in
**Administrative Templates** -> **Windows Components** -> **Windows PowerShell**.

The events are:

| Channel |                               Operational                               |
| ------- | ----------------------------------------------------------------------- |
| Level   | Verbose                                                                 |
| Opcode  | Create                                                                  |
| Task    | CommandStart                                                            |
| Keyword | Runspace                                                                |
| EventId | Engine_ScriptBlockCompiled (0x1008 = 4104)                              |
| Message | Creating Scriptblock text (%1 of %2): </br> %3 </br> ScriptBlock ID: %4 |

The text embedded in the message is the extent of the script block compiled. The ID is a GUID that
is retained for the life of the script block.

When you enable verbose logging, the feature writes begin and end markers:

| Channel |                                 Operational                                |
| ------- | -------------------------------------------------------------------------- |
| Level   | Verbose                                                                    |
| Opcode  | Open / Close                                                               |
| Task    | CommandStart / CommandStop                                                 |
| Keyword | Runspace                                                                   |
| EventId | ScriptBlock\_Invoke\_Start\_Detail (0x1009 = 4105) / </br> ScriptBlock\_Invoke\_Complete\_Detail (0x100A = 4106) |
| Message | Started / Completed invocation of ScriptBlock ID: %1 </br> Runspace ID: %2 |

The ID is the GUID representing the script block (that can be correlated with event ID 0x1008), and
the Runspace ID represents the runspace in which this script block was run.

Percent signs in the invocation message represent structured ETW properties. While they are replaced
with the actual values in the message text, a more robust way to access them is to retrieve the
message with the Get-WinEvent cmdlet, and then use the **Properties** array of the message.

Here's an example of how this functionality can help unwrap a malicious attempt to encrypt and
obfuscate a script:

```powershell
## Malware
function SuperDecrypt
{
    param($script)
    $bytes = [Convert]::FromBase64String($script)

    ## XOR "encryption"
    $xorKey = 0x42
    for($counter = 0; $counter -lt $bytes.Length; $counter++)
    {
        $bytes[$counter] = $bytes[$counter] -bxor $xorKey
    }
    [System.Text.Encoding]::Unicode.GetString($bytes)
}

$decrypted = SuperDecrypt "FUIwQitCNkInQm9CCkItQjFCNkJiQmVCEkI1QixCJkJlQg=="
Invoke-Expression $decrypted
```

Running this generates the following log entries:

```Output
Compiling Scriptblock text (1 of 1):
function SuperDecrypt
{
    param($script)
    $bytes = [Convert]::FromBase64String($script)
    ## XOR "encryption"
    $xorKey = 0x42
    for($counter = 0; $counter -lt $bytes.Length; $counter++)
    {
        $bytes[$counter] = $bytes[$counter] -bxor $xorKey
    }
    [System.Text.Encoding]::Unicode.GetString($bytes)

}
ScriptBlock ID: ad8ae740-1f33-42aa-8dfc-1314411877e3

Compiling Scriptblock text (1 of 1):
$decrypted = SuperDecrypt "FUIwQitCNkInQm9CCkItQjFCNkJiQmVCEkI1QixCJkJlQg=="
ScriptBlock ID: ba11c155-d34c-4004-88e3-6502ecb50f52

Compiling Scriptblock text (1 of 1):
Invoke-Expression $decrypted
ScriptBlock ID: 856c01ca-85d7-4989-b47f-e6a09ee4eeb3

Compiling Scriptblock text (1 of 1):
Write-Host 'Pwnd'
ScriptBlock ID: 5e618414-4e77-48e3-8f65-9a863f54b4c8
```

If the script block length exceeds the capacity of a single event, PowerShell breaks the script into
multiple parts. Here is sample code to recombine a script from its log messages:

```powershell
$created = Get-WinEvent -FilterHashtable @{ ProviderName="Microsoft-Windows-PowerShell"; Id = 4104 } |
  Where-Object { $_.<...> }
$sortedScripts = $created | sort { $_.Properties[0].Value }
$mergedScript = -join ($sortedScripts | % { $_.Properties[2].Value })
```

As with all logging systems that have a limited retention buffer, one way to attack this
infrastructure is to flood the log with spurious events to hide earlier evidence. To protect
yourself from this attack, ensure that you have some form of event log collection set up Windows
Event Forwarding. For more information, see
[Spotting the Adversary with Windows Event Log Monitoring](https://apps.nsa.gov/iaarchive/library/reports/spotting-the-adversary-with-windows-event-log-monitoring.cfm).

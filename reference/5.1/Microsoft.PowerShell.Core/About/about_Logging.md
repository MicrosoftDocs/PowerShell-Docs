---
ms.date:  12/14/2018
schema:  2.0.0
locale:  en-us
keywords:  powershell
title:  about_Logging
---

# About Logging

## Short Description

PowerShell logs internal operations from the engine, providers, and cmdlets.

## Long Description

PowerShell logs details of PowerShell operations, such as starting and
stopping the engine and starting and stopping providers. It will also log
details about PowerShell commands.

## Viewing the PowerShell event log entries on Windows

PowerShell logs can be viewed using the Event Viewer. The event log is located
in the Application and Services Logs group and is named
`Microsoft-Windows-PowerShell`. The associated ETW provider `GUID` is
`{A0C1853B-5C40-4B15-8766-3CF1C58F985A}`.

When script block logging is enabled, PowerShell will log the following events
to the `Microsoft-Windows-PowerShell/Operational` log:

|Field| Value|
|-|-|
|EventId|`4104` / `0x1008`|
|Channel|`Operational`|
|Level|`Verbose`|
|Opcode|`Create`|
|Task|`CommandStart`|
|Keyword|`Runspace`|

## Enabling Script Block Logging

Any new PowerShell session will pick up the new setting after making one of the
following changes.

> [!NOTE]
> It is recommended to enable Protected Event Logging (as described below) when
> using Script Block logging for anything other than diagnostics purposes.

### Using Group Policy

To enable automatic transcription, enable the 'Turn on PowerShell Script Block
Logging' feature in Group Policy through `Administrative Templates ->
Windows Components -> Windows PowerShell`.

### Using the Registry

Run the following function:

```powershell
function Enable-PSScriptBlockLogging
{
    $basePath = 'HKLM:\Software\Policies\Microsoft\Windows' +
      '\PowerShell\ScriptBlockLogging'

    if(-not (Test-Path $basePath))
    {
        $null = New-Item $basePath -Force
    }

    Set-ItemProperty $basePath -Name EnableScriptBlockLogging -Value "1"
}
```

## Protected Event Logging

One concern when increasing the amount of logging on a system is the danger
that logged content may contain sensitive data. For example, if you log the
content of every PowerShell script that was run, there is the possibility that
a script may contain credentials or other sensitive data.

If an attacker later compromises a machine that has logged this data, it may
provide them with additional information with which to extend their reach.

To prevent this dilemma, Windows 10 introduces Protected Event Logging.
Protected Event Logging lets participating applications encrypt sensitive data
as they write it to the event log. You can then decrypt and process these logs
once you've moved them to a more secure and centralized log collector.

Protected Event Logging protects event log content through the IETF
Cryptographic Message Syntax (CMS) standard. The CMS encryption standard
implements public key cryptography, where the keys used to encrypt content
(the public key) and the keys used to decrypt content (the private key) are
separate.

Your public key can be shared widely, and is not sensitive data. If any
content is encrypted with this public key, only your private key can decrypt
it. For more information about Public Key Cryptography, see
[Wikipedia - Public Key Cryptography](https://en.wikipedia.org/wiki/Public-key_cryptography).

When you implement a protected event logging policy, you deploy a public key
to all machines that have event log data you want to protect. You retain the
corresponding private key to post-process the event logs at a more secure
location such as a central event log collector,
or [SIEM](https://en.wikipedia.org/wiki/Security_information_and_event_management) aggregator.

### Enabling Protected Event Logging via Group Policy

To enable Protected Event Logging, enable the `Enable Protected Event Logging`
feature in Group Policy through `Administrative Templates ->
Windows Components -> Event Logging`. This setting requires an encryption certificate,
which you can provide in one of several forms:

- The content of a base-64 encoded X.509 certificate (for example, as offered
  by the `Export` option in Certificate Manager)
- The thumbprint of a certificate that can be found in the Local Machine
  certificate store (can be deployed by PKI infrastructure)
- The full path to a certificate (can be local, or a remote share)
- The path to a directory containing a certificate or certificates (can be
  local, or a remote share)
- The subject name of a certificate that can be found in the Local Machine
  certificate store (can be deployed by PKI infrastructure)

The resulting certificate must have `Document Encryption` as an enhanced key
usage (`1.3.6.1.4.1.311.80.1`), as well as either `Data Encipherment` or `Key
Encipherment` key usages enabled.

> [!WARNING]
> The private key should not be deployed to machines logging.
> It should be kept in a secure location where you decrypt the messages.

### Decrypting Protected Event Log Messages

The following script will retrieve and decrypt (assuming you have the private key):

```powershell
Get-WinEvent Microsoft-Windows-PowerShell/Operational |
  Where-Object Id -eq 4104 | Unprotect-CmsMessage
```

## See Also

[PowerShell the Blue Team](https://blogs.msdn.microsoft.com/powershell/2015/06/09/powershell-the-blue-team/)
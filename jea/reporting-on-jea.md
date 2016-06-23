---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet,jea
ms.date:  2016-06-22
title:  reporting on jea
ms.technology:  powershell
---

# Reporting on JEA
Because JEA allows non-privileged users to run in a privileged context, logging and auditing are extremely important.
In this section, we'll run through the tools you can use to help you with logging and reporting.

## Reporting on JEA Actions
### Over-the-Shoulder Transcription
One of the quickest ways to get a summary of what's happening in a PowerShell session is to look over the shoulder of the person typing.
You see their commands, the output of those commands, and all is well.
Or it's not, but at least you'll know.
PowerShell transcription is designed to give you a similar view after the fact.

When using the "TranscriptDirectory" field in your Session Configuration, PowerShell will automatically record a transcript of all actions taken in a given session.
You can find transcripts from your sessions in this document here: "$env:ProgramData\JEAConfiguration\Transcripts"

As you can tell, the transcript records information about the "Connected" user, the "Run As" user, the commands run in the session, and more.
For more information about PowerShell transcription, check out [this blog post](http://blogs.msdn.com/b/powershell/archive/2015/06/09/powershell-the-blue-team.aspx).

### PowerShell Event Logs
When you have module logging turned on, all PowerShell actions are also recorded in regular Windows Event logs.
This is slightly messier to deal with when compared to transcripts, but the level of detail it gives you can be useful.

In the "PowerShell" operational log, Event ID 4104 will record each command invoked if you have enabled module logging.

### Other Event Logs
Unlike PowerShell logs and transcripts, other logging mechanisms will not capture the "Connected User".
You will need to do some correlation between other logs and PowerShell logs to match up actions taken.

In the "Windows Remote Management" operational log, Event ID 193 will record the Connecting User's SID and Name, as well as the RunAs Virtual Account's SID to assist with this correlation.
You may have also noticed that the name of the RunAs Virtual Account includes the connecting user's domain and username at the end.

## Reporting on JEA Configuration
### Get-PSSessionConfiguration
In order to accurately report on the state of your environment, it's important to know how many JEA endpoints you have set up on your machine.
`Get-PSSessionConfiguration` does just that.

### Get-PSSessionCapability
Manually reporting on the capabilities of any given user through a JEA endpoint can be quite complex.
You would potentially need to inspect several role capabilities.
Fortunately, the "Get-PSSessionCapability" cmdlet does this.

To test this out, run the following command from an administrator PowerShell prompt:
```PowerShell
Get-PSSessionCapability -Username 'CONTOSO\OperatorUser' -ConfigurationName JEADemo
```


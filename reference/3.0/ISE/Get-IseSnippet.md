---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  Get IseSnippet
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/?LinkID=238787
external help file:   ISE-help.xml
---


# Get-IseSnippet
## SYNOPSIS
Gets snippets that the user created.
## SYNTAX

```
Get-IseSnippet [<CommonParameters>]
```

## DESCRIPTION
The **Get-ISESnippet** cmdlet gets the PS1XML files that contain reusable text "snippets" that the user created.
It works only in Windows PowerShell ISE.

When you use the New-IseSnippet cmdlet to create a snippet, New-IseSnippet creates a \<SnippetTitle\>.Snippets.ps1xml file in the $home\Documents\WindowsPowerShell\Snippets directory.
**Get-ISESnippet** gets the snippet files in the Snippets directory.

**Get-IseSnippet** does not get built-in snippets or snippets that are imported from modules by using the Import-IseSnippet cmdlet.

This cmdlet is introduced in Windows PowerShell 3.0.
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> Get-ISESnippet
```

This command gets all user-define snippets in the Snippets directory.
### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\> Invoke-Command -Computer (Get-Content Servers.txt) {Get-ISESnippet | Copy-Item -Destination \\Server01\Share01\Snippets}
```

This command copies all of the user-created snippets from a group of remote computers to a shared Snippets directory.

The command uses the Invoke-Command cmdlet to run a **Get-ISESnippet** command on the computers in the Servers.txt file.
A pipeline operator (|) sends the snippet files to the Copy-Item cmdlet, which copies them to the directory that is specified by the **Destination** parameter.
### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\> #Parse-Snippet Function

function Parse-Snippet
{
  $a = Get-ISESnippet
  $snippetNamespace = @{x="http://schemas.microsoft.com/PowerShell/Snippets"}
  foreach ($snippetFile in $a)
   {
     Write-Host ""
     $Title = Select-Xml -Path $snippetFile.FullName -Namespace $snippetNamespace -XPath "//x:Title" | foreach {$_.Node.InnerXML}
     $Text =  Select-Xml -Path $snippetFile.FullName -Namespace $snippetNamespace -XPath "//x:Script" | foreach {$_.Node.InnerText}
     Write-Host "Title: $Title"
     Write-Host "Text: $Text"
   }
}

# Sample Output

Title: Mandatory
Text:
Param
(
  [parameter(Mandatory=True)]
  [String[]]
  $<ParameterName>
)

Title: Copyright
Text:  (c) Fabrikam, Inc. 2012
```

This function uses the **Get-ISESnippet** and Select-Xml cmdlets to display the Title and Text of each snippet on the local computer.
### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\> $psISE.CurrentPowerShellTab.Snippets | Format-Table DisplayTitle, Description
```

This command displays the title and description of all snippets in the session, including built-in snippets, user-defined snippets, and imported snippets.

The command uses the Windows PowerShell ISE object model.
The **$psISE** variable represents the Windows PowerShell ISE host program.
The **CurrentPowerShellTab** property of **$psISE** represent the current session.
The **Snippets** property represents snippets in the current session.

The **$psISE.CurrentPowerShellTab.Snippets** command returns a  **Microsoft.PowerShell.Host.ISE.ISESnippet** object that represents a snippet, unlike the **Get-IseSnippet** cmdlet, which returns a file object (System.Io.FileInfo) that represents a snippet file.

The command also uses the Format-Table cmdlet to display the **DisplayTitle** and **Description** properties of the snippets in a table.
## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

## OUTPUTS

### System.IO.FileInfo
**Get-ISESnippet** returns a file object that represents the snippet file.
## NOTES
* The **New-IseSnippet** cmdlet stores new user-created snippets in unsigned .ps1xml files. As such, Windows PowerShell cannot add them to a session in which the execution policy is **AllSigned** or **Restricted**. In a **Restricted** or **AllSigned** session, you can create, get, and import unsigned user-created snippets, but you cannot use them in the session.

  To use unsigned user-created snippets that the **Get-IseSnippet** cmdlet returns, change the execution policy, and then restart Windows PowerShell ISE.

  For more information about Windows PowerShell execution policies, see about_Execution_Policies.
## RELATED LINKS

[New-IseSnippet](New-IseSnippet.md)

[Import-IseSnippet](Import-IseSnippet.md)


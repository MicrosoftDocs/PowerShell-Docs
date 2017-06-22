---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821534
external help file:  ISE-help.xml
title:  Get-IseSnippet
---

# Get-IseSnippet

## SYNOPSIS
Gets snippets that the user created.

## SYNTAX

```
Get-IseSnippet [<CommonParameters>]
```

## DESCRIPTION
The **Get-ISESnippet** cmdlet gets the PS1XML files that contain reusable text snippets that the user created.
It works only in Windows PowerShell Integrated Scripting Environment (ISE).

When you use the New-IseSnippet cmdlet to create a snippet, New-IseSnippet creates a \<SnippetTitle\>.Snippets.ps1xml file in the $home\Documents\WindowsPowerShell\Snippets directory.
**Get-ISESnippet** gets the snippet files in the Snippets directory.

This cmdlet does not get built-in snippets or snippets that are imported from modules through the Import-IseSnippet cmdlet.

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Get all user-defined snippets
```
PS C:\> Get-ISESnippet
```

This command gets all user-define snippets in the Snippets directory.

### Example 2: Copy all user-defined snippets from remote computers to a shared directory
```
PS C:\> Invoke-Command -Computer (Get-Content Servers.txt) {Get-ISESnippet | Copy-Item -Destination \\Server01\Share01\Snippets}
```

This command copies all of the user-created snippets from a group of remote computers to a shared Snippets directory.

The command uses the Invoke-Command cmdlet to run a **Get-ISESnippet** command on the computers in the Servers.txt file.
A pipeline operator (|) sends the snippet files to the Copy-Item cmdlet, which copies them to the directory that is specified by the **Destination** parameter.

### Example 3: Display the title and text of each snippet on a local computer
```
PS C:\> #Parse-Snippet Function

function Parse-Snippet
{
  $A = Get-ISESnippet
  $SnippetNamespace = @{x="http://schemas.microsoft.com/PowerShell/Snippets"}
  foreach ($SnippetFile in $A)
   {
     Write-Host ""
     $Title = Select-Xml -Path $SnippetFile.FullName -Namespace $SnippetNamespace -XPath "//x:Title" | foreach {$_.Node.InnerXML}
     $Text =  Select-Xml -Path $SnippetFile.FullName -Namespace $SnippetNamespace -XPath "//x:Script" | foreach {$_.Node.InnerText}
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

This example uses the **Get-ISESnippet** and Select-Xml cmdlets to display the title and text of each snippet on the local computer.

### Example 4: Display the title and description of all snippets in the session
```
PS C:\> $PSISE.CurrentPowerShellTab.Snippets | Format-Table DisplayTitle, Description
```

This command displays the title and description of all snippets in the session, including built-in snippets, user-defined snippets, and imported snippets.

The command uses the Windows PowerShell ISE object model.
The $PSISE variable represents the Windows PowerShell ISE host program.
The **CurrentPowerShellTab** property of the $PSISE variable represent the current session.
The **Snippets** property represents snippets in the current session.

The $PSISE.CurrentPowerShellTab.Snippets command returns a  **Microsoft.PowerShell.Host.ISE.ISESnippet** object that represents a snippet, unlike the **Get-IseSnippet** cmdlet, which returns a file object (System.Io.FileInfo) that represents a snippet file.

The command also uses the Format-Table cmdlet to display the **DisplayTitle** and **Description** properties of the snippets in a table.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.IO.FileInfo
This cmdlet returns a file object that represents the snippet file.

## NOTES
* The **New-IseSnippet** cmdlet stores new user-created snippets in unsigned .ps1xml files. As such, Windows PowerShell cannot add them to a session in which the execution policy is **AllSigned** or **Restricted**. In a **Restricted** or **AllSigned** session, you can create, get, and import unsigned user-created snippets, but you cannot use them in the session.

  To use unsigned user-created snippets that the **Get-IseSnippet** cmdlet returns, change the execution policy, and then restart Windows PowerShell ISE.

  For more information about Windows PowerShell execution policies, see about_Execution_Policies.

## RELATED LINKS

[New-IseSnippet](New-IseSnippet.md)

[Import-IseSnippet](Import-IseSnippet.md)

[Select-Xml](../Microsoft.PowerShell.Utility/Select-Xml.md)

[Format-Table](../Microsoft.PowerShell.Utility/Format-Table.md)

[about_Execution_Policies](../Microsoft.PowerShell.Core/About/about_Execution_Policies.md)


---
external help file: ISE-help.xml
Locale: en-US
Module Name: ISE
ms.date: 12/13/2022
online version: https://learn.microsoft.com/powershell/module/ise/get-isesnippet?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-IseSnippet
---

# Get-IseSnippet

## SYNOPSIS
Gets snippets that the user created.

## SYNTAX

```
Get-IseSnippet [<CommonParameters>]
```

## DESCRIPTION

The `Get-IseSnippet` cmdlet gets the PS1XML files that contain reusable text snippets that the user
created. It works only in Windows PowerShell Integrated Scripting Environment (ISE).

When you use the `New-IseSnippet` cmdlet to create a snippet, `New-IseSnippet` creates a
`<SnippetTitle>.Snippets.ps1xml` file in the `$HOME\Documents\WindowsPowerShell\Snippets` directory.
`Get-IseSnippet` gets the snippet files in the Snippets directory.

This cmdlet does not get built-in snippets or snippets that are imported from modules through the
`Import-IseSnippet` cmdlet.

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Get all user-defined snippets

This example gets all user-define snippets in the Snippets directory.

```powershell
Get-IseSnippet
```

### Example 2: Copy all user-defined snippets from remote computers to a shared directory

This example copies all of the user-created snippets from a group of remote computers to a shared Snippets directory.

```powershell
Invoke-Command -Computer (Get-Content Servers.txt) {Get-IseSnippet | Copy-Item -Destination \\Server01\Share01\Snippets}
```

`Invoke-Command` runs `Get-IseSnippet` on the computers in the `Servers.txt` file. A pipeline
operator (`|`) sends the snippet files to the `Copy-Item` cmdlet, which copies them to the directory
that is specified by the **Destination** parameter.

### Example 3: Display the title and text of each snippet on a local computer

This example uses the `Get-IseSnippet` and `Select-Xml` cmdlets to display the title and text of each
snippet on the local computer.

```powershell
#Parse-Snippet Function
function Parse-Snippet {
  $SnippetFiles = Get-IseSnippet
  $SnippetNamespace = @{x="http://schemas.microsoft.com/PowerShell/Snippets"}
  foreach ($SnippetFile in $SnippetFiles) {
     Write-Host ""
     $Title = Select-Xml -Path $SnippetFile.FullName -Namespace $SnippetNamespace -XPath "//x:Title" |
       ForEach-Object {$_.Node.InnerXML}
     $Text = Select-Xml -Path $SnippetFile.FullName -Namespace $SnippetNamespace -XPath "//x:Script" |
       ForEach-Object {$_.Node.InnerText}
     Write-Host "Title: $Title"
     Write-Host "Text: $Text"
   }
}
```

```Output
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

### Example 4: Display the title and description of all snippets in the session

This example displays the title and description of all snippets in the session, including built-in snippets, user-defined snippets, and imported snippets.

```powershell
$PSISE.CurrentPowerShellTab.Snippets | Format-Table DisplayTitle, Description
```

The `$PSISE` variable represents the Windows PowerShell ISE host program. The
**CurrentPowerShellTab** property of the `$PSISE` variable represent the current session. The
**Snippets** property represents snippets in the current session.

The `$PSISE.CurrentPowerShellTab.Snippets` command returns a
**Microsoft.PowerShell.Host.ISE.ISESnippet** object that represents a snippet, unlike the
`Get-IseSnippet` cmdlet. `Get-IseSnippet` returns a file object (System.Io.FileInfo) that represents
a snippet file.

The `Format-Table` cmdlet displays the **DisplayTitle** and **Description** properties of the
snippets in a table.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You can't pipe objects to this cmdlet.

## OUTPUTS

### System.IO.FileInfo

This cmdlet returns a file object representing the snippet file.

## NOTES

- The `New-IseSnippet` cmdlet stores new user-created snippets in unsigned .ps1xml files. As such,
  Windows PowerShell cannot add them to a session in which the execution policy is **AllSigned** or
  **Restricted**. In a **Restricted** or **AllSigned** session, you can create, get, and import
  unsigned user-created snippets, but you cannot use them in the session.

  To use unsigned user-created snippets that the `Get-IseSnippet` cmdlet returns, change the
  execution policy, and then restart Windows PowerShell ISE.

  For more information about Windows PowerShell execution policies, see
  [about_Execution_Policies](../Microsoft.PowerShell.Core/About/about_Execution_Policies.md).

## RELATED LINKS

[New-IseSnippet](New-IseSnippet.md)

[Import-IseSnippet](Import-IseSnippet.md)

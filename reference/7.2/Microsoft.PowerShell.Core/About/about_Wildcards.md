---
description: Describes how to use wildcard characters in PowerShell.
Locale: en-US
ms.date: 03/28/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_wildcards?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Wildcards
---

# About Wildcards

## SHORT DESCRIPTION

Describes how to use wildcard characters in PowerShell.

## LONG DESCRIPTION

Wildcard characters represent one or many characters. You can use them to
create word patterns in commands. For example, to get all the files in the
`C:\Techdocs` directory with a `.ppt` file name extension, type:

```powershell
Get-ChildItem C:\Techdocs\*.ppt
```

In this case, the asterisk (`*`) wildcard character represents any characters
that appear before the `.ppt` file name extension.

PowerShell supports the following wildcard characters:

|Wildcard|Description               |Example |Match        |No Match|
|--------|--------------------------|--------|-------------|--------|
|\*      |Match zero or more characters | a\*  | aA, ag, Apple | banana |
|?       |Match one character in that position | ?n | an, in, on | ran |
|\[ \]   |Match a range of characters | \[a-l\]ook | book, cook, look | took |
|\[ \]   |Match specific characters | \[bc\]ook | book, cook | hook |

You can include multiple wildcard characters in the same word pattern. For
example, to find text files with names that begin with the letters **a**
through **l**, type:

```powershell
Get-ChildItem C:\Techdocs\[a-l]*.txt
```

Many cmdlets accept wildcard characters in parameter values. The Help topic for
each cmdlet describes which parameters accept wildcard characters. For
parameters that accept wildcard characters, their use is case-insensitive.

You can use wildcard characters in commands and script blocks, such as to
create a word pattern that represents property values. For example, the
following command gets services in which the **ServiceType** property value
includes **Interactive**.

```powershell
Get-Service | Where-Object {$_.ServiceType -Like "*Interactive*"}
```

In the following example, the `If` statement includes a condition that uses
wildcard characters to find property values. If the restore point's
**Description** includes **PowerShell**, the command adds the value of the
restore point's **CreationTime** property to a log file.

```powershell
$p = Get-ComputerRestorePoint
foreach ($point in $p) {
  if ($point.description -like "*PowerShell*") {
    Add-Content -Path C:\TechDocs\RestoreLog.txt "$($point.CreationTime)"
  }
}
```

## SEE ALSO

[about_Language_Keywords](about_Language_Keywords.md)

[about_If](about_If.md)

[about_Script_Blocks](about_Script_Blocks.md)


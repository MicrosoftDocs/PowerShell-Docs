---
description: Describes how to use wildcard characters in PowerShell.
Locale: en-US
ms.date: 01/18/2026
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_wildcards?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Wildcards
---
# about_Wildcards

## Short description

Describes how to use wildcard characters in PowerShell.

## Long description

Wildcard characters represent one or many characters. You can use them to
create word patterns in commands. Wildcard expressions are used with the
`-like` operator or with any parameter that accepts wildcards.

For example, to match all the files in the `C:\Techdocs` directory with a
`.ppt` file name extension, type:

```powershell
Get-ChildItem C:\Techdocs\*.ppt
```

In this case, the asterisk (`*`) wildcard character represents any characters
that appear before the `.ppt` file name extension.

Wildcard expressions are simpler than regular expressions. For more
information, see [about_Regular_Expressions][01].

PowerShell supports the following wildcard characters:

- `*` - Match zero or more characters
  - `a*` matches `aA`, `ag`, and `Apple`
  - `a*` doesn't match `banana`
- `?` - For strings, match one character in that position
  - `?n` matches `an`, `in`, and `on`
  - `?n` doesn't match `ran`
- `?` - For files and directories, match zero or one character in that position
  - `?.txt` matches `a.txt` and `b.txt`
  - `?.txt` doesn't match `ab.txt`
- `[ ]` - Match a range of characters
  - `[a-l]ook` matches `book`, `cook`, and `look`
  - `[a-l]ook` doesn't match `took`
- `[ ]` - Match specific characters
  - `[bc]ook` matches `book` and `cook`
  - `[bc]ook` doesn't match `hook`
- `` `* `` - Match any character as a literal (not a wildcard character)
  - ``12`*4`` matches `12*4`
  - ``12`*4`` doesn't match `1234`

You can include multiple wildcard characters in the same word pattern. For
example, to find text files with names that begin with the letters **a**
through **l**, type:

```powershell
Get-ChildItem C:\Techdocs\[a-l]*.txt
```

There may be cases where you want to match the literal character rather than
treat it as a wildcard character. In those cases you can use the backtick
(`` ` ``) character to escape the wildcard character so that it is compared
using the literal character value. For example, ``'*hello`?*'`` matches strings
containing "hello?".

Many cmdlets accept wildcard characters in parameter values. The Help topic for
each cmdlet describes which parameters accept wildcard characters. For
parameters that accept wildcard characters, their use is case-insensitive.

You can use wildcard characters in commands and scriptblocks, such as to
create a word pattern that represents property values. For example, the
following command gets services in which the **ServiceType** property value
includes **Interactive**.

```powershell
Get-Service | Where-Object {$_.ServiceType -like "*Interactive*"}
```

In the following example, the `if` statement includes a condition that uses
wildcard characters to find property values. If the restore point's
**Description** includes **PowerShell**, the command adds the value of the
restore point's **CreationTime** property to a log file.

```powershell
$p = Get-ComputerRestorePoint
foreach ($point in $p) {
  if ($point.Description -like "*PowerShell*") {
    Add-Content -Path C:\TechDocs\RestoreLog.txt "$($point.CreationTime)"
  }
}
```

## Escaping wildcard characters in file and directory names

> [!NOTE]
> Wildcard matching for filesystem items works differently than for strings.
> For more information, see the _Remarks_ section of the
> [DirectoryInfo.GetFiles(String, EnumerationOptions)][05] method.

When you try to access a file or directory that contains wildcard characters
the name, you must escape the wildcard characters. Consider the following files:

```powershell
PS> Get-ChildItem

    Directory: D:\temp\test

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---           11/3/2025  3:39 PM             41 file[1].txt
-a---           11/3/2025  3:39 PM             41 file[2].txt
-a---           11/3/2025  3:39 PM             41 file[3].txt
```

The square-bracket (`[]`) characters are wildcards so they must be escaped when
trying to get the file using one of the Item cmdlets, such as `Get-Item`.

```powershell
PS> Get-Item file`[1`].txt
```

However, this example failed because the filename value is bound to the
**Path** parameter, which supports wildcard characters. In this case, the
`` `[ `` pattern resolves to plain `[`, which the **Path** parameter interprets
as a wildcard. There are three ways to resolve this:

- Escape the backtick characters.

  ```powershell
  PS> Get-Item -Path file``[1``].txt

      Directory: D:\temp\test

  Mode                 LastWriteTime         Length Name
  ----                 -------------         ------ ----
  -a---           11/3/2025  3:39 PM             41 file[1].txt
  ```

- Put the filename in single quotes so that the backticks aren't expanded
  before being bound to the **Path** parameter.

  ```powershell
  PS> Get-Item -Path 'file`[1`].txt'

      Directory: D:\temp\test

  Mode                 LastWriteTime         Length Name
  ----                 -------------         ------ ----
  -a---           11/3/2025  3:39 PM             41 file[1].txt
  ```

- Use the **LiteralPath** parameter

  ```powershell
  PS> Get-Item -LiteralPath file[1].txt

      Directory: D:\temp\test

  Mode                 LastWriteTime         Length Name
  ----                 -------------         ------ ----
  -a---           11/3/2025  3:39 PM             41 file[1].txt
  ```

## See also

- [about_If][02]
- [about_Language_Keywords][03]
- [about_Script_Blocks][04]

<!-- link references -->
[01]: about_Regular_Expressions.md
[02]: about_If.md
[03]: about_Language_Keywords.md
[04]: about_Script_Blocks.md
[05]: xref:System.IO.DirectoryInfo.GetFiles%2A#system-io-directoryinfo-getfiles(system-string-system-io-enumerationoptions)

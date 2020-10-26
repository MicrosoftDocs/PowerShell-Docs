---
ms.date: 08/26/2019
ms.topic: reference
title: Supporting Wildcard Characters in Cmdlet Parameters
description: Supporting Wildcard Characters in Cmdlet Parameters
---
# Supporting Wildcard Characters in Cmdlet Parameters

Often, you will have to design a cmdlet to run against a group of resources rather than against a
single resource. For example, a cmdlet might need to locate all the files in a data store that have
the same name or extension. You must provide support for wildcard characters when you design a
cmdlet that will be run against a group of resources.

> [!NOTE]
> Using wildcard characters is sometimes referred to as *globbing*.

## Windows PowerShell Cmdlets That Use Wildcards

 Many Windows PowerShell cmdlets support wildcard characters for their parameter values. For
 example, almost every cmdlet that has a `Name` or `Path` parameter supports wildcard characters for
 these parameters. (Although most cmdlets that have a `Path` parameter also have a `LiteralPath`
 parameter that does not support wildcard characters.) The following command shows how a wildcard
 character is used to return all the cmdlets in the current session whose name contains the Get
 verb.

 `Get-Command get-*`

## Supported Wildcard Characters

Windows PowerShell supports the following wildcard characters.

| Wildcard |                             Description                             |  Example   |     Matches      | Does not match |
| -------- | ------------------------------------------------------------------- | ---------- | ---------------- | -------------- |
| *        | Matches zero or more characters, starting at the specified position | `a*`       | A, ag, Apple     |                |
| ?        | Matches any character at the specified position                     | `?n`       | An, in, on       | ran            |
| [ ]      | Matches a range of characters                                       | `[a-l]ook` | book, cook, look | nook, took     |
| [ ]      | Matches the specified characters                                    | `[bn]ook`  | book, nook       | cook, look     |

When you design cmdlets that support wildcard characters, allow for combinations of wildcard
characters. For example, the following command uses the `Get-ChildItem` cmdlet to retrieve all the
.txt files that are in the c:\Techdocs folder and that begin with the letters "a" through "l."

`Get-ChildItem c:\techdocs\[a-l]\*.txt`

The previous command uses the range wildcard `[a-l]` to specify that the file name should begin
with the characters "a" through "l" and uses the `*` wildcard character as a placeholder
for any characters between the first letter of the filename and the **.txt** extension.

The following example uses a range wildcard pattern that excludes the letter "d" but includes all
the other letters from "a" through "f."

`Get-ChildItem c:\techdocs\[a-cef]\*.txt`

## Handling Literal Characters in Wildcard Patterns

If the wildcard pattern you specify contains literal characters that should not be interpretted as
wildcard characters, use the backtick character (`` ` ``) as an escape character. When you specify
literal characters int the PowerShell API, use a single backtick. When you specify literal
characters at the PowerShell command prompt, use two backticks.

For example, the following pattern
contains two brackets that must be taken literally.

When used in the PowerShell API use:

- "John Smith \`[*`]"

When used from the PowerShell command prompt:

- "John Smith \`\`[*\``]"

This pattern matches "John Smith [Marketing]" or "John Smith [Development]". For example:

```
PS> "John Smith [Marketing]" -like "John Smith ``[*``]"
True

PS> "John Smith [Development]" -like "John Smith ``[*``]"
True
```

## Cmdlet Output and Wildcard Characters

When cmdlet parameters support wildcard characters, the operation usually generates an array output.
Occasionally, it makes no sense to support an array output because the user might use only a single
item. For example, the `Set-Location` cmdlet does not support array output because the user sets
only a single location. In this instance, the cmdlet still supports wildcard characters, but it
forces resolution to a single location.

## See Also

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)

[WildcardPattern Class](/dotnet/api/system.management.automation.wildcardpattern)

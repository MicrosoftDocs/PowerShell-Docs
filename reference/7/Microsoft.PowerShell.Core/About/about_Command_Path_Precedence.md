---
ms.date:  05/17/2019
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Execution_Search
---

# Command Path Precedence

## Short description

When you run command by path,
such as `./myScript.ps1` PowerShell has a process that it uses to search for the script.
This document describes how PowerShell does that search.

## Long description

### Limiting the search to the current directory

To tell PowerShell that you want to search for the script in the current folder,
you should specify the prefix `.\`.
This will limit the search for commands to files in the current folder.
Without this prefix,
other PowerShell syntax may conflict and there are few guarantees that the file will be found.

### Using Wildcards in a Command Path

> [!NOTE]
> Using wildcard characters is sometimes referred to as *globbing*.

You may use wildcards in command execution.
PowerShell supports the following wildcards.

| Wildcard character | Description                                                         | Example  | Matches          | Does not match |
|--------------------|---------------------------------------------------------------------|----------|------------------|----------------|
| *                  | Matches zero or more characters, starting at the specified position | a*       | A, ag, Apple     |                |
| ?                  | Matches any character at the specified position                      | ?n       | An, in, on       | ran            |
| [ ]                | Matches a range of characters                                       | [a-l]ook | book, cook, look | took           |
| [ ]                | Matches the specified characters                                    | [bc]ook  | book, cook       | look           |

### Path Precedence

PowerShell will execute a file that has a literal match before a wildcard match.

For example, consider a directory with the following files:

```
a.ps1
[a1].ps1
```

Then, you are in PowerShell and have `Set-Location` to this folder.
You run `[a1].ps1`, the file `[a1].ps1`, even though the file `a.ps1` matches this based on the wildcards.

However, if the directory looked like this:

```
b.ps1
[a1].ps1
```

and you execute `[b1].ps1` because there is no literal match,
but `b.ps1` matches based on the wildcard, `b.ps1` will be executed.

## See also

- [about_Command_Precedence](about_Command_Precedence.md)

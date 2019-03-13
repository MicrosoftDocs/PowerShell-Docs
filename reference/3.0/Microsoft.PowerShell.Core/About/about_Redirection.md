---
ms.date:  12/01/2017
schema:  2.0.0
locale:  en-us
keywords: PowerShell,cmdlet
title:  about_Redirection
---
# About Redirection

## Short description

Explains how to redirect output from PowerShell to text files.

## Long description

By default, PowerShell sends its command output to the PowerShell console.
However, you can direct the output to a text file, and you can redirect error
output to the regular output stream.

You can use the following methods to redirect output:

- Use the `Out-File` cmdlet, which sends command output to a text file.
  Typically, you use the `Out-File` cmdlet when you need to use its parameters,
  such as the `Encoding`, `Force`, `Width`, or `NoClobber` parameters.

- Use the `Tee-Object` cmdlet, which sends command output to a text file and
  then sends it to the pipeline.

- Use the PowerShell redirection operators.

### PowerShell redirection operators

The redirection operators enable you to send streams of data to a file or the
**Success** output stream.

The PowerShell redirection operators use the following numbers to represent
the available output streams:

|Stream # |Description  |Introduced in |
|---------|---------|---------|
|1|**Success** Stream|PowerShell 2.0|
|2|**Error** Stream|PowerShell 2.0|
|3|**Warning** Stream|PowerShell 3.0|
|4|**Verbose** Stream|PowerShell 3.0|
|5|**Debug** Stream|PowerShell 3.0|
|*|All Streams|PowerShell 3.0|

> [!NOTE]
> There is also a **Progress** stream in PowerShell, but it is not used for
> redirection.

The PowerShell redirection operators are as follows, where `n` represents
the stream number. The **Success** stream ( `1` ) is the default if no stream
is specified.

|Operator|Description| Syntax|
|---------|---------|--------|
|`>`|Send specified stream to a file.|`n>`|
|`>>`|**Append** specified stream to a file.|`n>>`|
|`>&1`|*Redirects* the specified stream to the **Success** stream.|`n>&1`|

## Examples

### Example 1: Redirect errors and output to a file

```powershell
dir 'C:\', 'fakepath' 2>&1 > .\dir.log
```

This example runs `dir` on one item that will succeed, and one that will error.

It uses `2>&1` to redirect the **Error** stream to the **Success** stream, and
`>` to send the resultant **Success** stream to a file called `dir.log`

### Example 2: Send all Success stream data to a file

```powershell
.\script.ps1 > script.log
```

This command sends all **Success** stream data to a file called `script.log`

### Example 3: Send Success, Warning, and Error streams to a file

```powershell
&{
   Write-Warning "hello"
   Write-Error "hello"
   Write-Output "hi"
} 3>&1 2>&1 > P:\Temp\redirection.log
```

This example shows how you can combine redirection operators to achieve a
desired result.

- `3>&1` redirects the **Warning** stream to the **Success** stream.
- `2>&1` redirects the **Error** stream to the **Success** stream (which also
  now includes all **Warning** stream data)
- `>` redirects the **Success** stream (which now contains both **Warning**
  and **Error** streams) to a file called `C:\temp\redirection.log`)

### Example 4: Redirect all streams to a file

```powershell
.\script.ps1 *> script.log
```

This example sends all streams output from a script called `script.ps1` to a
file called `script.log`

## Notes

The redirection operators that do not append data (`>` and `n>`) overwrite the
current contents of the specified file without warning.

However, if the file is a read-only, hidden, or system file, the
redirection **fails**. The append redirection operators (`>>` and `n>>`) do not write
to a read-only file, but they append content to a system or hidden file.

To force the redirection of content to a read-only, hidden, or system file,
use the `Out-File` cmdlet with its `Force` parameter.

When you are writing to files, the redirection operators use Unicode encoding.
If the file has a different encoding, the output might not be formatted
correctly. To redirect content to non-Unicode files, use the `Out-File` cmdlet
with its `Encoding` parameter.

### Potential confusion with comparison operators 

The `>` operator is not to be confused with the
[greater-than](about_Comparison_Operators.md#-gt) comparison operator often
used in other programming languages.

Depending on the objects being compared, the output using `>` can appear to be
correct. For example:

```powershell
PS> if (36 > 42) { "true" } else { "false" }
false
```

However, the local filesystem now has a file named `42` that contains was
the string `36`.

```powershell
PS> Get-ChildItem

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
------          1/02/20  10:10 am              3 42

PS> Get-Content 42
36
```

Attempting a *less-than* comparison using `<` yields the following error: 

```powershell
PS> if (36 < 42) { "true" } else { "false" }
At line:1 char:8
+ if (36 < 42) { "true" } else { "false" }
+        ~
The '<' operator is reserved for future use.
+ CategoryInfo          : ParserError: (:) [], ParentContainsErrorRecord
Exception
+ FullyQualifiedErrorId : RedirectionNotSupported
```

For more information, see about_Comparison_Operators](about_Comparison_Operators.md#-gt).

## See also

[Out-File](../../microsoft.powershell.utility/Out-File.md)

[Tee-Object](../../microsoft.powershell.utility/Tee-Object.md)

[about_Operators](about_Operators.md)

[about_Command_Syntax](about_Command_Syntax.md)

[about_Path_Syntax](about_Path_Syntax.md)

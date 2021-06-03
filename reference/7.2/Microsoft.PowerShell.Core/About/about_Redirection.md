---
description: Explains how to redirect output from PowerShell to text files.
Locale: en-US
ms.date: 05/04/2021
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_redirection?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about Redirection
---
# about_Redirection

## Short description
Explains how to redirect output from PowerShell to text files.

## Long description

By default, PowerShell sends output to the PowerShell host. Usually this is the
console application. However, you can redirect the output to a text file and you
can redirect error output to the regular output stream.

You can use the following methods to redirect output:

- Use the `Out-File` cmdlet, which sends command output to a text file.
  Typically, you use the `Out-File` cmdlet when you need to use its parameters,
  such as the `Encoding`, `Force`, `Width`, or `NoClobber` parameters.

- Use the `Tee-Object` cmdlet, which sends command output to a text file and
  then sends it to the pipeline.

- Use the PowerShell redirection operators. Using the redirection operator with
  a file target is functionally equivalent to piping to `Out-File` with no
  extra parameters.

For more information about streams, see
[about_Output_Streams](about_Output_Streams.md).

### Redirectable output streams

PowerShell supports redirection of the following output streams.

| Stream # |      Description       | Introduced in  |    Write Cmdlet     |
| -------- | ---------------------- | -------------- | ------------------- |
| 1        | **Success** Stream     | PowerShell 2.0 | `Write-Output`      |
| 2        | **Error** Stream       | PowerShell 2.0 | `Write-Error`       |
| 3        | **Warning** Stream     | PowerShell 3.0 | `Write-Warning`     |
| 4        | **Verbose** Stream     | PowerShell 3.0 | `Write-Verbose`     |
| 5        | **Debug** Stream       | PowerShell 3.0 | `Write-Debug`       |
| 6        | **Information** Stream | PowerShell 5.0 | `Write-Information` |
| *        | All Streams            | PowerShell 3.0 |                     |

There is also a **Progress** stream in PowerShell, but it does not support
redirection.

> [!IMPORTANT]
> The **Success** and **Error** streams are similar to the stdout and stderr
> streams of other shells. However, stdin is not connected to the PowerShell
> pipeline for input.

### PowerShell redirection operators

The PowerShell redirection operators are as follows, where `n` represents
the stream number. The **Success** stream ( `1` ) is the default if no stream
is specified.

| Operator |                         Description                         | Syntax |
| -------- | ----------------------------------------------------------- | ------ |
| `>`      | Send specified stream to a file.                            | `n>`   |
| `>>`     | **Append** specified stream to a file.                      | `n>>`  |
| `>&1`    | _Redirects_ the specified stream to the **Success** stream. | `n>&1` |

> [!NOTE]
> Unlike some Unix shells, you can only redirect other streams to the
> **Success** stream.

## Examples

### Example 1: Redirect errors and output to a file

This example runs `dir` on one item that will succeed, and one that will error.

```powershell
dir 'C:\', 'fakepath' 2>&1 > .\dir.log
```

It uses `2>&1` to redirect the **Error** stream to the **Success** stream, and
`>` to send the resultant **Success** stream to a file called `dir.log`

### Example 2: Send all Success stream data to a file

This example sends all **Success** stream data to a file called `script.log`.

```powershell
.\script.ps1 > script.log
```

### Example 3: Send Success, Warning, and Error streams to a file

This example shows how you can combine redirection operators to achieve a
desired result.

```powershell
&{
   Write-Warning "hello"
   Write-Error "hello"
   Write-Output "hi"
} 3>&1 2>&1 > C:\Temp\redirection.log
```

- `3>&1` redirects the **Warning** stream to the **Success** stream.
- `2>&1` redirects the **Error** stream to the **Success** stream (which also
  now includes all **Warning** stream data)
- `>` redirects the **Success** stream (which now contains both **Warning**
  and **Error** streams) to a file called `C:\temp\redirection.log`)

### Example 4: Redirect all streams to a file

This example sends all streams output from a script called `script.ps1` to a
file called `script.log`

```powershell
.\script.ps1 *> script.log
```

### Example 5: Suppress all Write-Host and Information stream data

This example suppresses all information stream data. To read more about
**Information** stream cmdlets, see
[Write-Host](xref:Microsoft.PowerShell.Utility.Write-Host) and
[Write-Information](xref:Microsoft.PowerShell.Utility.Write-Information)

```powershell
&{
   Write-Host "Hello"
   Write-Information "Hello" -InformationAction Continue
} 6> $null
```

### Example 6: Show the effect of Action Preferences

Action Preference variables and parameters can change what gets written to a
particular stream. The script in this example shows how the value of
`$ErrorActionPreference` affects what gets written to the **Error** stream.

```powershell
$ErrorActionPreference = 'Continue'
$ErrorActionPreference > log.txt
get-item /not-here 2>&1 >> log.txt

$ErrorActionPreference = 'SilentlyContinue'
$ErrorActionPreference >> log.txt
get-item /not-here 2>&1 >> log.txt

$ErrorActionPreference = 'Stop'
$ErrorActionPreference >> log.txt
Try {
    get-item /not-here 2>&1 >> log.txt
}
catch {
    "`tError caught!" >> log.txt
}
$ErrorActionPreference = 'Ignore'
$ErrorActionPreference >> log.txt
get-item /not-here 2>&1 >> log.txt

$ErrorActionPreference = 'Inquire'
$ErrorActionPreference >> log.txt
get-item /not-here 2>&1 >> log.txt

$ErrorActionPreference = 'Continue'
```

When we run this script we get prompted when `$ErrorActionPreference` is set to
`Inquire`.

```powershell
PS C:\temp> .\test.ps1

Confirm
Cannot find path 'C:\not-here' because it does not exist.
[Y] Yes  [A] Yes to All  [H] Halt Command  [S] Suspend  [?] Help (default is "Y"): H
Get-Item: C:\temp\test.ps1:23
Line |
  23 |  get-item /not-here 2>&1 >> log.txt
     |  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     | The running command stopped because the user selected the Stop option.
```

When we examine the log file we see the following:

```
PS C:\temp> Get-Content .\log.txt
Continue

Get-Item: C:\temp\test.ps1:3
Line |
   3 |  get-item /not-here 2>&1 >> log.txt
     |  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     | Cannot find path 'C:\not-here' because it does not exist.

SilentlyContinue
Stop
    Error caught!
Ignore
Inquire
```

## Notes

The redirection operators that do not append data (`>` and `n>`) overwrite the
current contents of the specified file without warning.

However, if the file is a read-only, hidden, or system file, the redirection
**fails**. The append redirection operators (`>>` and `n>>`) do not write to a
read-only file, but they append content to a system or hidden file.

To force the redirection of content to a read-only, hidden, or system file,
use the `Out-File` cmdlet with its `Force` parameter.

When you are writing to files, the redirection operators use `UTF8NoBOM`
encoding. If the file has a different encoding, the output might not be
formatted correctly. To write to files with a different encoding, use the
`Out-File` cmdlet with its `Encoding` parameter.

### Width of output when writing to a file

When you are writing to a file using either `Out-File` or the redirection
operators, PowerShell formats table output to the file based on the width of
the console it is running within. For instance, when logging table output
to file using a command like `Get-ChildItem Env:\Path > path.log` on a system
where the console width is set to 80 columns, the output in the file is
truncated to 80 characters:

```Output
Name                         Value
----                         -----
Path                         C:\Program Files\PowerShell\7-preview;C:\WINDOWS…
```

Considering that the console width may be set arbitrarily on systems where
your script is run, you may prefer that PowerShell format table output to
files based on a width that you specify instead.

The `Out-File` cmdlet provides a **Width** parameter that allows you to set
the width you would like for table output. Rather than having to add
`-Width 2000` everywhere you invoke `Out-File`, you can use the
`$PSDefaultParameterValues` variable to set this value for all usages of the
`Out-File` cmdlet in a script. And since the redirection operators (`>` and
`>>`) are effectively aliases for `Out-File`, setting the `Out-File:Width`
parameter for the whole script impacts the formatting width for the
redirection operators as well. Put the following command near the top of your
script to set `Out-File:Width` for the whole script:

```powershell
$PSDefaultParameterValues['out-file:width'] = 2000
```

Increasing the output width will increase memory consumption when logging
table formatted output. If you are logging a lot of tabular data to file and
you know you can get by with a smaller width, use the smaller width.

In some cases, such as `Get-Service` output, in order to use the extra width
you will need to pipe the output through `Format-Table -AutoSize` before
outputting to file.

```powershell
$PSDefaultParameterValues['out-file:width'] = 2000
Get-Service | Format-Table -AutoSize > services.log
```

### Potential confusion with comparison operators

The `>` operator is not to be confused with the
[Greater-than](about_Comparison_Operators.md#-gt--ge--lt-and--le) comparison
operator (often denoted as `>` in other programming languages).

Depending on the objects being compared, the output using `>` can appear to be
correct (because 36 is not greater than 42).

```powershell
PS> if (36 > 42) { "true" } else { "false" }
false
```

However, a check of the local filesystem can see that a file called `42` was
written, with the contents `36`.

```powershell
PS> dir

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
------          1/02/20  10:10 am              3 42

PS> cat 42
36
```

Attempting to use the reverse comparison `<` (less than), yields a system error:

```powershell
PS> if (36 < 42) { "true" } else { "false" }
ParserError:
Line |
   1 |  if (36 < 42) { "true" } else { "false" }
     |         ~
     | The '<' operator is reserved for future use.
```

If numeric comparison is the required operation, `-lt` and `-gt` should be
used. For more information, see the `-gt` operator in
[about_Comparison_Operators](about_Comparison_Operators.md#-gt--ge--lt-and--le).

## See also

- [Out-File](xref:Microsoft.PowerShell.Utility.Out-File)
- [Tee-Object](xref:Microsoft.PowerShell.Utility.Tee-Object)
- [Write-Debug](xref:Microsoft.PowerShell.Utility.Write-Debug)
- [Write-Error](xref:Microsoft.PowerShell.Utility.Write-Error)
- [Write-Host](xref:Microsoft.PowerShell.Utility.Write-Host)
- [Write-Information](xref:Microsoft.PowerShell.Utility.Write-Information)
- [Write-Output](xref:Microsoft.PowerShell.Utility.Write-Output)
- [Write-Progress](xref:Microsoft.PowerShell.Utility.Write-Progress)
- [Write-Verbose](xref:Microsoft.PowerShell.Utility.Write-Verbose)
- [Write-Warning](xref:Microsoft.PowerShell.Utility.Write-Warning)
- [about_Output_Streams](about_Output_Streams.md)
- [about_Operators](about_Operators.md)
- [about_Command_Syntax](about_Command_Syntax.md)
- [about_Path_Syntax](about_Path_Syntax.md)

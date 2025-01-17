---
description: Explains how to redirect output from PowerShell to text files.
Locale: en-US
ms.date: 11/29/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_redirection?view=powershell-7.6&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Redirection
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

- Use the PowerShell redirection operators. Redirecting the output of a
  PowerShell command (cmdlet, function, script) using the redirection operator
  (`>`) is functionally equivalent to piping to `Out-File` with no extra
  parameters. PowerShell 7.4 changed the behavior of the redirection operator
  when used to redirect the **stdout** stream of a native command.

For more information about streams, see [about_Output_Streams][04].

## Redirectable output streams

PowerShell supports redirection of the following output streams.

| Stream # |      Description       | Introduced in  |    Write Cmdlet     |
| -------- | ---------------------- | -------------- | ------------------- |
| 1        | **Success** Stream     | PowerShell 2.0 | `Write-Output`      |
| 2        | **Error** Stream       | PowerShell 2.0 | `Write-Error`       |
| 3        | **Warning** Stream     | PowerShell 3.0 | `Write-Warning`     |
| 4        | **Verbose** Stream     | PowerShell 3.0 | `Write-Verbose`     |
| 5        | **Debug** Stream       | PowerShell 3.0 | `Write-Debug`       |
| 6        | **Information** Stream | PowerShell 5.0 | `Write-Information`, `Write-Host` |
| *        | All Streams            | PowerShell 3.0 |                     |

There is also a **Progress** stream in PowerShell, but it doesn't support
redirection.

> [!IMPORTANT]
> The **Success** and **Error** streams are similar to the stdout and stderr
> streams of other shells. However, stdin isn't connected to the PowerShell
> pipeline for input.

## PowerShell redirection operators

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

## Redirecting output from native commands

PowerShell 7.4 changed the behavior of the redirection operators when used to
redirect the **stdout** stream of a native command. The redirection operators
now preserve the byte-stream data when redirecting output from a native
command. PowerShell doesn't interpret the redirected data or add any additional
formatting. For more information, see
[Example #7](#example-7-redirecting-binary-data-from-a-native-command).

## Examples

### Example 1: Redirect errors and output to a file

This example runs `dir` on one item that succeeds, and one that fails.

```powershell
dir C:\, fakepath 2>&1 > .\dir.log
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
  and **Error** streams) to a file called `C:\temp\redirection.log`.

### Example 4: Redirect all streams to a file

This example sends all streams output from a script called `script.ps1` to a
file called `script.log`.

```powershell
.\script.ps1 *> script.log
```

### Example 5: Suppress all Write-Host and Information stream data

This example suppresses all information stream data. To read more about
**Information** stream cmdlets, see
[Write-Host][11] and
[Write-Information][12]

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
Can't find path 'C:\not-here' because it doesn't exist.
[Y] Yes  [A] Yes to All  [H] Halt Command  [S] Suspend  [?] Help (default is "Y"): H
Get-Item: C:\temp\test.ps1:23
Line |
  23 |  get-item /not-here 2>&1 >> log.txt
     |  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     | The running command stopped because the user selected the Stop option.
```

When we examine the log file we see the following:

```powershell
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

### Example 7: Redirecting binary data from a native command

Beginning in PowerShell 7.4, PowerShell preserves the byte-stream data when
redirecting the **stdout** stream of a native command to a file or when piping
byte-stream data to the **stdin** stream of a native command.

For example, using the native command `curl` you can download a binary file and
save it to disk using redirection.

```powershell
$uri = 'https://github.com/PowerShell/PowerShell/releases/download/v7.3.7/powershell-7.3.7-linux-arm64.tar.gz'

# native command redirected to a file
curl -s -L $uri > powershell.tar.gz
```

You can also pipe the byte-stream data to the **stdin** stream of another
native command. The following example downloads a zipped TAR file using `curl`.
The downloaded file data is streamed to the `tar` command to extract the
contents of the archive.

```powershell
# native command output piped to a native command
curl -s -L $uri | tar -xzvf - -C .
```

You can also pipe the byte-stream output of a PowerShell command to the input
of native command. The following examples use `Invoke-WebRequest` to download
the same TAR file as the previous example.

```powershell
# byte stream piped to a native command
(Invoke-WebRequest $uri).Content | tar -xzvf - -C .

# bytes piped to a native command (all at once as byte[])
,(Invoke-WebRequest $uri).Content | tar -xzvf - -C .
```

This feature doesn't support byte-stream data when redirecting **stderr**
output to **stdout**. When you combine the **stderr** and **stdout** streams,
the combined streams are treated as string data.

## Notes

The redirection operators that don't append data (`>` and `n>`) overwrite the
current contents of the specified file without warning.

However, if the file is a read-only, hidden, or system file, the redirection
**fails**. The append redirection operators (`>>` and `n>>`) don't write to a
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
the console it's running within. For instance, when logging table output
to file using a command like `Get-ChildItem Env:\Path > path.log` on a system
where the console width is set to 80 columns, the output in the file is
truncated to 80 characters:

```Output
Name                         Value
----                         -----
Path                         C:\Program Files\PowerShell\7;C:\WINDOWS…
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

For more information about `$PSDefaultParameterValues`, see
[about_Preference_Variables][06].

### Potential confusion with comparison operators

The `>` operator isn't to be confused with the [Greater-than][02] comparison
operator (often denoted as `>` in other programming languages).

Depending on the objects being compared, the output using `>` can appear to be
correct (because 36 isn't greater than 42).

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
[about_Comparison_Operators][02].

## See also

- [about_Command_Syntax][01]
- [about_Operators][03]
- [about_Output_Streams][04]
- [about_Path_Syntax][05]
- [Out-File][07]
- [Tee-Object][08]
- [Write-Debug][09]
- [Write-Error][10]
- [Write-Host][11]
- [Write-Information][12]
- [Write-Output][13]
- [Write-Progress][14]
- [Write-Verbose][15]
- [Write-Warning][16]

<!-- link references -->
[01]: about_Command_Syntax.md
[02]: about_Comparison_Operators.md#-gt--ge--lt-and--le
[03]: about_Operators.md
[04]: about_Output_Streams.md
[05]: about_Path_Syntax.md
[06]: about_preference_variables.md#psdefaultparametervalues
[07]: xref:Microsoft.PowerShell.Utility.Out-File
[08]: xref:Microsoft.PowerShell.Utility.Tee-Object
[09]: xref:Microsoft.PowerShell.Utility.Write-Debug
[10]: xref:Microsoft.PowerShell.Utility.Write-Error
[11]: xref:Microsoft.PowerShell.Utility.Write-Host
[12]: xref:Microsoft.PowerShell.Utility.Write-Information
[13]: xref:Microsoft.PowerShell.Utility.Write-Output
[14]: xref:Microsoft.PowerShell.Utility.Write-Progress
[15]: xref:Microsoft.PowerShell.Utility.Write-Verbose
[16]: xref:Microsoft.PowerShell.Utility.Write-Warning

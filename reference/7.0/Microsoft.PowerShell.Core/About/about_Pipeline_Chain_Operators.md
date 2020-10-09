---
description:  Describes chaining pipelines with the `&&` and `||` operators in PowerShell. 
ms.date:  09/30/2019
schema:  2.0.0
Locale: en-US
keywords:  powershell,cmdlet
title:  about_Pipeline_Chain_Operators
---

# About Pipeline Chain Operators

## Short description

Describes chaining pipelines with the `&&` and `||` operators in PowerShell.

## Long description

Beginning in PowerShell 7, PowerShell implements the `&&` and `||` operators to
conditionally chain pipelines. These operators are known in PowerShell as
*pipeline chain operators*, and are similar to
[AND-OR lists](https://pubs.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_09_03)
in POSIX shells like bash, zsh and sh, as well as
[conditional processing symbols](/previous-versions/windows/it-pro/windows-xp/bb490954(v=technet.10)#using-multiple-commands-and-conditional-processing-symbols)
in the Windows Command Shell (cmd.exe).

The `&&` operator executes the right-hand pipeline, if the left-hand pipeline
succeeded. Conversely, the `||` operator executes the right-hand pipeline if
the left-hand pipeline failed.

These operators use the `$?` and `$LASTEXITCODE` variables to determine if a
pipeline failed. This allows you to use them with native commands and not just
with cmdlets or functions. For example:

```powershell
# Create an SSH key pair - if successful copy the public key to clipboard
ssh-keygen -t rsa -b 2048 && Get-Content -Raw ~\.ssh\id_rsa.pub | clip
```

### Examples

#### Two successful commands

```powershell
Write-Output 'First' && Write-Output 'Second'
```

```Output
First
Second
```

#### First command fails, causing second not to be executed

```powershell
Write-Error 'Bad' && Write-Output 'Second'
```

```Output
Write-Error: Bad
```

#### First command succeeds, so the second command is not executed

```powershell
Write-Output 'First' || Write-Output 'Second'
```

```Output
First
```

#### First command fails, so the second command is executed

```powershell
Write-Error 'Bad' || Write-Output 'Second'
```

```Output
Write-Error: Bad
Second
```

Pipeline success is defined by the value of the `$?` variable, which PowerShell
automatically sets after executing a pipeline based on its execution status.
This means that pipeline chain operators have the following equivalence:

```powershell
Test-Command '1' && Test-Command '2'
```

works the same as

```powershell
Test-Command '1'; if ($?) { Test-Command '2' }
```

and

```powershell
Test-Command '1' || Test-Command '2'
```

works the same as

```powershell
Test-Command '1'; if (-not $?) { Test-Command '2' }
```

### Assignment from pipeline chains

Assigning a variable from a pipeline chain takes the concatenation of all the
pipelines in the chain:

```powershell
$result = Write-Output '1' && Write-Output '2'
$result
```

```Output
1
2
```

If a script-terminating error occurs during assignment from a pipeline chain, the assignment does
not succeed:

```powershell
try
{
    $result = Write-Output 'Value' && $(throw 'Bad')
}
catch
{
    # Do nothing, just squash the error
}

"Result: $result"
```

```Output
Result:
```

### Operator syntax and precedence

Unlike other operators, `&&` and `||` operate on pipelines, rather than on
expressions like `+` or `-and`, for example.

`&&` and `||` have a lower precedence than piping (`|`) or redirection (`>`),
but a higher precedence than job operators (`&`), assignment (`=`) or
semicolons (`;`). This means that pipelines within a pipeline chain can be
individually redirected, and that entire pipeline chains can be backgrounded,
assigned to variables, or separated as statements.

To use lower precedence syntax within a pipeline chain,
consider the use of parentheses `(...)`.
Similarly, to embed a statement within a pipeline chain,
a subexpression `$(...)` can be used.
This can be useful for combining native commands with control flow:

```powershell
foreach ($file in 'file1','file2','file3')
{
    # When find succeeds, the loop breaks
    find $file && Write-Output "Found $file" && $(break)
}
```

```Output
find: file1: No such file or directory
file2
Found file2
```

As of PowerShell 7, the behaviour of these syntaxes has been changed
so that `$?` is set as expected when a command succeeds or fails
within parentheses or a subexpression.

Like most other operators in PowerShell, `&&` and `||` are also *left-associative*,
meaning they group from the left. For example:

```powershell
Get-ChildItem -Path ./file.txt || Write-Error "file.txt does not exist" && Get-Content -Raw ./file.txt
```

will group as:

```
[Get-ChildItem -Path ./file.txt || Write-Error "file.txt does not exist"] && Get-Content -Raw ./file.txt
```

being equivalent to:

```powershell
Get-ChildItem -Path ./file.txt

if (-not $?) { Write-Error "file.txt does not exist" }

if ($?) { Get-Content -Raw ./file.txt }
```

### Error interaction

Pipeline chain operators do not absorb errors. When a statement in a pipeline
chain throws a script-terminating error, the pipeline chain is terminated.

For example:

```powershell
$(throw 'Bad') || Write-Output '2'
```

```Output
Exception: Bad
```

Even when the error is caught, the pipeline chain is still terminated:

```powershell
try
{
    $(throw 'Bad') || Write-Output '2'
}
catch
{
    Write-Output "Caught: $_"
}
Write-Output 'Done'
```

```Output
Caught: Bad
Done
```

If an error is non-terminating, or only terminates a pipeline, the pipeline
chain continues, respecting the value of `$?`:

```powershell
function Test-NonTerminatingError
{
    [CmdletBinding()]
    param()

    $exception = [System.Exception]::new('BAD')
    $errorId = 'BAD'
    $errorCategory = 'NotSpecified'

    $errorRecord = [System.Management.Automation.ErrorRecord]::new($exception, $errorId, $errorCategory, $null)

    $PSCmdlet.WriteError($errorRecord)
}

Test-NonTerminatingError || Write-Output 'Second'
```

```Output
Test-NonTerminatingError: BAD
Second
```

### Chaining pipelines rather than commands

Pipeline chain operators, by their name, can be used to chain pipelines, rather
than just commands. This matches the behavior of other shells, but can make
*success* harder to determine:

```powershell
function Test-NotTwo
{
    [CmdletBinding()]
    param(
      [Parameter(ValueFromPipeline)]
      $Input
    )

    process
    {
        if ($Input -ne 2)
        {
            return $Input
        }

        $exception = [System.Exception]::new('Input is 2')
        $errorId = 'InputTwo'
        $errorCategory = 'InvalidData'

        $errorRecord = [System.Management.Automation.ErrorRecord]::new($exception, $errorId, $errorCategory, $null)

        $PSCmdlet.WriteError($errorRecord)
    }
}

1,2,3 | Test-NotTwo && Write-Output 'All done!'
```

```Output
1
Test-NotTwo : Input is 2
3
```

Note that `Write-Output 'All done!'` is not executed, since `Test-NotTwo` is
deemed to have failed after generating the non-terminating error.

## See also

- [about_Operators](about_Operators.md)
- [about_Automatic_Variables](about_Automatic_Variables.md)
- [about_pipelines](about_pipelines.md)

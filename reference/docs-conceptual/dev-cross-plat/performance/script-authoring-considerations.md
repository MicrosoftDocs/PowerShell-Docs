---
description: Scripting for Performance in PowerShell
ms.date: 03/17/2023
title: PowerShell scripting performance considerations
---

# PowerShell scripting performance considerations

PowerShell scripts that leverage .NET directly and avoid the pipeline tend to be faster than
idiomatic PowerShell. Idiomatic PowerShell uses cmdlets and PowerShell functions, often leveraging
the pipeline, and resorting to .NET only when necessary.

>[!NOTE]
> Many of the techniques described here aren't idiomatic PowerShell and may reduce the readability
> of a PowerShell script. Script authors are advised to use idiomatic PowerShell unless performance
> dictates otherwise.

## Suppressing output

There are many ways to avoid writing objects to the pipeline.

Assignment to `$null` or casting to `[void]` are roughly equivalent and should be preferred where
performance matters.

```powershell
$null = $arrayList.Add($item)
[void]$arrayList.Add($item)
```

File redirection to `$null` is almost as fast as the previous alternatives. You won't notice a
performance difference for most scripts. However, file redirection does introduce some overhead.

```powershell
$arrayList.Add($item) > $null
```

You can also pipe to `Out-Null`. In PowerShell 7.x, this is a bit slower than redirection but
probably not noticeable for most scripts.

```powershell
$arrayList.Add($item) | Out-Null
```

However, calling `Out-Null` in a large loop can be significantly slower, even in PowerShell 7.x.

```powershell
$d = Get-Date
Measure-Command { for($i=0; $i -lt 1mb; $i++) { $null=$d } } |
    Select-Object TotalSeconds

TotalSeconds
------------
   1.0549325

$d = Get-Date
Measure-Command { for($i=0; $i -lt 1mb; $i++) { $d | Out-Null } } |
    Select-Object TotalSeconds

TotalSeconds
------------
   5.9572186
```

Windows PowerShell 5.1 doesn't have the same optimizations for `Out-Null` as PowerShell 7.x, so you
should avoid using `Out-Null` in performance sensitive code.

Creating a script block and calling it (using dot sourcing or `Invoke-Command`) then assigning the
result to `$null` is a convenient technique for suppressing the output of a large block of script.

```powershell
$null = . {
    $arrayList.Add($item)
    $arrayList.Add(42)
}
```

This technique performs about the same as piping to `Out-Null` and should be avoided in performance
sensitive script. The extra overhead in this example comes from the creation of and invoking a
script block that was previously inline script.

## Array addition

Generating a list of items is often done using an array with the addition operator:

```powershell
$results = @()
$results += Do-Something
$results += Do-SomethingElse
$results
```

Array addition is inefficient because arrays are immutable. Each addition to the array creates a new
array big enough to hold all elements of both the left and right operands. The elements of both
operands are copied into the new array. For small collections, this overhead may not matter.
Performance can suffer for large collections.

There are a couple of alternatives. If you don't actually require an array, instead consider using
an ArrayList:

```powershell
$results = [System.Collections.ArrayList]::new()
$results.AddRange((Do-Something))
$results.AddRange((Do-SomethingElse))
$results
```

If you do require an array, you can call the `ToArray()` method or you can let PowerShell create the
array for you:

```powershell
$results = @(
    Do-Something
    Do-SomethingElse
)
```

In this example, PowerShell creates an `ArrayList` to hold the results written to the pipeline
inside the array expression. Just before assigning to `$results`, PowerShell converts the
`ArrayList` to an `object[]`.

## String addition

Like arrays, strings are immutable. Each addition to the string actually creates a new string big
enough to hold the contents of both the left and right operands, then copies the elements of both
operands into the new string. For small strings, this overhead may not matter. For large strings,
this can affect performance and memory consumption.

```powershell
$string = ''
Measure-Command {
      foreach( $i in 1..10000)
      {
          $string += "Iteration $i`n"
      }
      $string
  } | Select-Object TotalMilliseconds

TotalMilliseconds
-----------------
         641.8168
```

There are a couple of alternatives. You can use the `-join` operator to concatenate strings.

```powershell
Measure-Command {
      $string = @(
          foreach ($i in 1..10000) { "Iteration $i" }
      ) -join "`n"
      $string
  } | Select-Object TotalMilliseconds

TotalMilliseconds
-----------------
          22.7069
```

In this example, using the `-join` operator is 30 times faster than string addition.

You can also use the .NET **StringBuilder** class.

```powershell
$sb = [System.Text.StringBuilder]::new()
Measure-Command {
      foreach( $i in 1..10000)
      {
          [void]$sb.Append("Iteration $i`n")
      }
      $sb.ToString()
  } | Select-Object TotalMilliseconds

TotalMilliseconds
-----------------
          13.4671
```

In this example, using the **StringBuilder** is 50 times faster than string addition.

## Processing large files

The idiomatic way to process a file in PowerShell might look something like:

```powershell
Get-Content $path | Where-Object { $_.Length -gt 10 }
```

This can be an order of magnitude slower than using .NET APIs directly:

```powershell
try
{
    $stream = [System.IO.StreamReader]::new($path)
    while ($line = $stream.ReadLine())
    {
        if ($line.Length -gt 10)
        {
            $line
        }
    }
}
finally
{
    $stream.Dispose()
}
```

### Looking up entries by property in large collections

It's common to need to use a shared property to identify the same record in different collections,
like using a name to retrieve an ID from one list and an email from another. Iterating over the
first list to find the matching record in the second collection is slow. In particular, the
repeated filtering of the second collection has a large overhead.

Given two collections, one with an **ID** and **Name**, the other with **Name** and **Email**:

```powershell
$Employees = 1..10000 | ForEach-Object {
    [PSCustomObject]@{
        Id   = $_
        Name = "Name$_"
    }
}

$Accounts = 2500..7500 | ForEach-Object {
    [PSCustomObject]@{
        Name = "Name$_"
        Email = "Name$_@fabrikam.com"
    }
}
```

The usual way to reconcile these collections to return a list of objects with the **ID**, **Name**,
and **Email** properties might look like this:

```powershell
$Results = $Employees | ForEach-Object -Process {
    $Employee = $_

    $Account = $Accounts | Where-Object -FilterScript {
        $_.Name -eq $Employee.Name
    }

    [pscustomobject]@{
        Id    = $Employee.Id
        Name  = $Employee.Name
        Email = $Account.Email
    }
}
```

However, that implementation has to filter all 5000 items in the `$Accounts` collection once for
every item in the `$Employee` collection. That can take minutes, even for this single-value lookup.

Instead, you can make a [hash table][02] that uses the shared **Name** property as a key and the
matching account as the value.

```powershell
$LookupHash = @{}
foreach ($Account in $Accounts) {
    $LookupHash[$Account.Name] = $Account
}
```

Looking up keys in a hash table is much faster than filtering a collection by property values.
Instead of checking every item in the collection, PowerShell can check if the key is defined and
use its value.

```powershell
$Results = $Employees | ForEach-Object -Process {
    $Email = $HashTable[$Employee.Name].Email
    [pscustomobject]@{
        Id    = $Employee.Id
        Name  = $Employee.Name
        Email = $Email
    }
}
```

This is much faster. While the looping filter took minutes to complete, the hash lookup takes less
than a second.

## Avoid Write-Host

It's generally considered poor practice to write output directly to the console, but when it makes
sense, many scripts use `Write-Host`.

If you must write many messages to the console, `Write-Host` can be an order of magnitude slower
than `[Console]::WriteLine()` for specific hosts like `pwsh.exe`, `powershell.exe`, or
`powershell_ise.exe`. However, `[Console]::WriteLine()` isn't guaranteed to work in all hosts. Also,
output written using `[Console]::WriteLine()` doesn't get written to transcripts started by
`Start-Transcript`.

Instead of using `Write-Host`, consider using [Write-Output][01].

### JIT compilation

PowerShell compiles the script code to bytecode that's interpreted. Beginning in PowerShell 3, for
code that's repeatedly executed in a loop, PowerShell can improve performance by Just-in-time (JIT)
compiling the code into native code.

Loops that have fewer than 300 instructions are eligible for JIT-compilation. Loops larger than that
are too costly to compile. When the loop has executed 16 times, the script is JIT-compiled in the
background. When the JIT-compilation completes, execution is transferred to the compiled code.

## Avoid repeated calls to a function

Calling a function can be an expensive operation. If you calling a function in a long running tight
loop, consider moving the loop inside the function.

Consider the following examples:

```powershell
$ranGen = New-Object System.Random
$RepeatCount = 10000

'Basic for-loop = {0}ms' -f (Measure-Command -Expression {
    for ($i = 0; $i -lt $RepeatCount; $i++) {
        $Null = $ranGen.Next()
    }
}).TotalMilliseconds

'Wrapped in a function = {0}ms' -f (Measure-Command -Expression {
    function Get-RandNum_Core {
        param ($ranGen)
        $ranGen.Next()
    }

    for ($i = 0; $i -lt $RepeatCount; $i++) {
        $Null = Get-RandNum_Core $ranGen
    }
}).TotalMilliseconds

'For-loop in a function = {0}ms' -f (Measure-Command -Expression {
    function Get-RandNum_All {
        param ($ranGen)
        for ($i = 0; $i -lt $RepeatCount; $i++) {
            $Null = $ranGen.Next()
        }
    }

    Get-RandNum_All $ranGen
}).TotalMilliseconds
```

The **Basic for-loop** example is the base line for performance. The second example wraps the random
number generator in a function that's called in a tight loop. The third example moves the loop
inside the function. The function is only called once but the code still generates 10000 random
numbers. Notice the difference in execution times for each example.

```Output
Basic for-loop = 47.8668ms
Wrapped in a function = 820.1396ms
For-loop in a function = 23.3193ms
```

## Avoid wrapping cmdlet pipelines

Most cmdlets are implemented for the pipeline, which is a sequential syntax and process. For
example:

```powershell
cmdlet1 | cmdlet2 | cmdlet3
```

Initializing a new pipeline can be expensive, therefore you should avoid wrapping a cmdlet
pipeline into another existing pipeline.

Consider the following example. The `Input.csv` file contains 2100 lines. The `Export-Csv` command
is wrapped inside the `ForEach-Object` pipeline. The `Export-Csv` cmdlet is invoked for every
iteration of the `ForEach-Object` loop.

```powershell
'Wrapped = {0:N2} ms' -f (Measure-Command -Expression {
    Import-Csv .\Input.csv | ForEach-Object -Begin { $Id = 1 } -Process {
        [PSCustomObject]@{
            Id = $Id
            Name = $_.opened_by
        } | Export-Csv .\Output1.csv -Append
    }
}).TotalMilliseconds

Wrapped = 15,968.78 ms
```

For the next example, the `Export-Csv` command was moved outside of the `ForEach-Object` pipeline.
In this case, `Export-Csv` is invoked only once, but still processes all objects passed out of
`ForEach-Object`.

```powershell
'Unwrapped = {0:N2} ms' -f (Measure-Command -Expression {
      Import-Csv .\Input.csv | ForEach-Object -Begin { $Id = 2 } -Process {
          [PSCustomObject]@{
              Id = $Id
              Name = $_.opened_by
          }
      } | Export-Csv .\Output2.csv
  }).TotalMilliseconds

Unwrapped = 42.92 ms
```

The unwrapped example is 372 times faster. Also, notice that the first implementation requires the
**Append** parameter, which isn't required for the later implementation.

<!-- Link reference definitions -->
[01]: /powershell/module/Microsoft.PowerShell.Utility/Write-Output
[02]: /powershell/scripting/learn/deep-dives/everything-about-hashtable

---
description: Scripting for Performance in PowerShell
ms.date: 01/05/2022
title: PowerShell scripting performance considerations
---

# PowerShell scripting performance considerations

PowerShell scripts that leverage .NET directly and avoid the pipeline tend to be faster than
idiomatic PowerShell. Idiomatic PowerShell typically uses cmdlets and PowerShell functions heavily,
often leveraging the pipeline, and dropping down into .NET only when necessary.

>[!NOTE]
> Many of the techniques described here are not idiomatic PowerShell and may reduce the readability
> of a PowerShell script. Script authors are advised to use idiomatic PowerShell unless performance
> dictates otherwise.

## Suppressing output

There are many ways to avoid writing objects to the pipeline:

```powershell
$null = $arrayList.Add($item)
[void]$arrayList.Add($item)
```

Assignment to `$null` or casting to `[void]` are roughly equivalent and should generally be
preferred where performance matters.

```powershell
$arrayList.Add($item) > $null
```

File redirection to `$null` is nearly as good as the previous alternatives, most scripts would never
notice the difference. Depending on the scenario, file redirection does introduce a little bit of
overhead though.

```powershell
$arrayList.Add($item) | Out-Null
```

You can also pipe to `Out-Null`. In PowerShell 7.x, this is a bit slower than redirection but
probably not noticeable for most scripts. However, calling `Out-Null` in a large loop is can be
significantly slower, even in PowerShell 7.x.

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

Windows PowerShell 5.1 does not have the same optimizations for `Out-Null` as PowerShell 7.x, so you
should avoid using `Out-Null` in performance sensitive code.

Introducing a script block and calling it (using dot sourcing or otherwise) then assigning the
result to `$null` is a convenient technique for suppressing the output of a large block of script.

```powershell
$null = . {
    $arrayList.Add($item)
    $arrayList.Add(42)
}
```

This technique performs roughly as well as piping to `Out-Null` and should be avoided in performance
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

This can be very inefficient because arrays are immutable. Each addition to the array actually
creates a new array big enough to hold all elements of both the left and right operands, then copies
the elements of both operands into the new array. For small collections, this overhead may not
matter. For large collections, this can definitely be an issue.

There are a couple of alternatives. If you don't actually require an array, instead consider using
an ArrayList:

```powershell
$results = [System.Collections.ArrayList]::new()
$results.AddRange((Do-Something))
$results.AddRange((Do-SomethingElse))
$results
```

If you do require an array, you can use your own `ArrayList` and simply call `ArrayList.ToArray`
when you want the array. Alternatively, you can let PowerShell create the `ArrayList` and `Array`
for you:

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
this can definitely be an issue.

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

In this example, using the `-join` operator is nearly 30-times faster than string addition.

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

In this example, using the **StringBuilder** is nearly 50-times faster than string addition.

## Processing large files

The idiomatic way to process a file in PowerShell might look something like:

```powershell
Get-Content $path | Where-Object { $_.Length -gt 10 }
```

This can be nearly an order of magnitude slower than using .NET APIs directly:

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

## Avoid Write-Host

It is generally considered poor practice to write output directly to the console, but when it makes
sense, many scripts use `Write-Host`.

If you must write many messages to the console, `Write-Host` can be an order of magnitude slower
than `[Console]::WriteLine()`. However, be aware that `[Console]::WriteLine()` is only a suitable
alternative for specific hosts like `pwsh.exe`, `powershell.exe`, or `powershell_ise.exe`. It's not
guaranteed to work in all hosts. Also, output written using `[Console]::WriteLine()` does not get
written to transcripts started by `Start-Transcript`.

Instead of using `Write-Host`, consider using
[Write-Output](/powershell/module/Microsoft.PowerShell.Utility/Write-Output).

### JIT compilation

PowerShell compiles the script code to bytecode that is interpreted. Beginning in PowerShell 3, for
code that is executed repeatedly in a loop, PowerShell can improve performance by Just-in-time (JIT)
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
number generator in a function that is called in a tight loop. The third example moves the loop
inside the function. The function is only called once but the code still generates 10000 random
numbers. Notice the difference in execution times for each example.

```Output
Basic for-loop = 47.8668ms
Wrapped in a function = 820.1396ms
For-loop in a function = 23.3193ms
```

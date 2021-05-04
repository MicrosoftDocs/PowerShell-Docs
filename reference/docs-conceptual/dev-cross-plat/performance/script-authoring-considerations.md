---
title: PowerShell scripting performance considerations
description: Scripting for Performance in PowerShell
ms.date: 10/16/2017
---

# PowerShell scripting performance considerations

PowerShell scripts that leverage .NET directly and avoid the pipeline tend to be faster than
idiomatic PowerShell. Idiomatic PowerShell typically uses cmdlets and PowerShell functions heavily,
often leveraging the pipeline, and dropping down into .NET only when necessary.

>[!NOTE]
> Many of the techniques described here are not idiomatic PowerShell and may reduce the readability
> of a PowerShell script. Script authors are advised to use idiomatic PowerShell unless performance
> dictates otherwise.

## Suppressing Output

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

Piping to `Out-Null` has significant overhead when compared to the alternatives. It should be
avoiding in performance sensitive code.

```powershell
$null = . {
    $arrayList.Add($item)
    $arrayList.Add(42)
}
```

Introducing a script block and calling it (using dot sourcing or otherwise) then assigning the
result to `$null` is a convenient technique for suppressing the output of a large block of script.
This technique performs roughly as well as piping to `Out-Null` and should be avoided in performance
sensitive script. The extra overhead in this example comes from the creation of and invoking a
script block that was previously inline script.


## Array Addition

Generating a list of items is often done using an array with the addition operator:

```powershell
$results = @()
$results += Do-Something
$results += Do-SomethingElse
$results
```

This can be very inefficent because arrays are immutable. Each addition to the array actually
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

## Processing Large Files

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
guaranteed to work in all hosts.

Instead of using `Write-Host`, consider using
[Write-Output](/powershell/module/Microsoft.PowerShell.Utility/Write-Output).

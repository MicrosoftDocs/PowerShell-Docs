---
description: Scripting for Performance in PowerShell
ms.date: 06/23/2023
title: PowerShell scripting performance considerations
---

# PowerShell scripting performance considerations

PowerShell scripts that leverage .NET directly and avoid the pipeline tend to be faster than
idiomatic PowerShell. Idiomatic PowerShell uses cmdlets and PowerShell functions, often leveraging
the pipeline, and resorting to .NET only when necessary.

> [!NOTE]
> Many of the techniques described here aren't idiomatic PowerShell and may reduce the readability
> of a PowerShell script. Script authors are advised to use idiomatic PowerShell unless performance
> dictates otherwise.

## Suppressing output

There are many ways to avoid writing objects to the pipeline.

- Assignment or File Redirection to [`$null`][03]
- Casting to [`[void]`][04]
- Pipe to [`Out-Null`][05]

The speeds of assigning to `$null`, casting to `[void]`, and file redirection to `$null` are almost
identical. However, calling `Out-Null` in a large loop can be significantly slower, especially in
PowerShell 5.1.

```powershell
$tests = @{
    'Assign to $null' = {
        $arrayList = [System.Collections.ArrayList]::new()
        foreach ($i in 0..$args[0]) {
            $null = $arraylist.Add($i)
        }
    }
    'Cast to [void]' = {
        $arrayList = [System.Collections.ArrayList]::new()
        foreach ($i in 0..$args[0]) {
            [void] $arraylist.Add($i)
        }
    }
    'Redirect to $null' = {
        $arrayList = [System.Collections.ArrayList]::new()
        foreach ($i in 0..$args[0]) {
            $arraylist.Add($i) > $null
        }
    }
    'Pipe to Out-Null' = {
        $arrayList = [System.Collections.ArrayList]::new()
        foreach ($i in 0..$args[0]) {
            $arraylist.Add($i) | Out-Null
        }
    }
}

10kb, 50kb, 100kb | ForEach-Object {
    $groupResult = foreach ($test in $tests.GetEnumerator()) {
        $ms = (Measure-Command { & $test.Value $_ }).TotalMilliseconds

        [pscustomobject]@{
            Iterations        = $_
            Test              = $test.Key
            TotalMilliseconds = [math]::Round($ms, 2)
        }

        [GC]::Collect()
        [GC]::WaitForPendingFinalizers()
    }

    $groupResult = $groupResult | Sort-Object TotalMilliseconds
    $groupResult | Select-Object *, @{
        Name       = 'RelativeSpeed'
        Expression = {
            $relativeSpeed = $_.TotalMilliseconds / $groupResult[0].TotalMilliseconds
            [math]::Round($relativeSpeed, 2).ToString() + 'x'
        }
    }
}
```

These tests were run on a Windows 11 machine in PowerShell 7.3.4. The results are shown below:

```Output
Iterations Test              TotalMilliseconds RelativeSpeed
---------- ----              ----------------- -------------
     10240 Assign to $null               36.74 1x
     10240 Redirect to $null             55.84 1.52x
     10240 Cast to [void]                62.96 1.71x
     10240 Pipe to Out-Null              81.65 2.22x
     51200 Assign to $null              193.92 1x
     51200 Cast to [void]               200.77 1.04x
     51200 Redirect to $null            219.69 1.13x
     51200 Pipe to Out-Null             329.62 1.7x
    102400 Redirect to $null            386.08 1x
    102400 Assign to $null              392.13 1.02x
    102400 Cast to [void]               405.24 1.05x
    102400 Pipe to Out-Null             572.94 1.48x
```

The times and relative speeds can vary depending on the hardware, the version of PowerShell, and the
current workload on the system.

## Array addition

Generating a list of items is often done using an array with the addition operator:

```powershell
$results = @()
$results += Get-Something
$results += Get-SomethingElse
$results
```

Array addition is inefficient because arrays have a fixed size. Each addition to the array creates
a new array big enough to hold all elements of both the left and right operands. The elements of
both operands are copied into the new array. For small collections, this overhead may not matter.
Performance can suffer for large collections.

There are a couple of alternatives. If you don't actually require an array, instead consider using
a typed generic list (**[`List<T>`][06]**):

```powershell
$results = [System.Collections.Generic.List[object]]::new()
$results.AddRange((Get-Something))
$results.AddRange((Get-SomethingElse))
$results
```

The performance impact of using array addition grows exponentially with the size of the collection
and the number additions. This code compares explicitly assigning values to an array with using
array addition and using the [`.Add(T)` Method][07] on a **`List<T>`**. It defines explicit assignment as
the baseline for performance.

```powershell
$tests = @{
    'PowerShell Explicit Assignment' = {
        param($count)

        $result = foreach($i in 1..$count) {
            $i
        }
    }
    '.Add(T) to List<T>' = {
        param($count)

        $result = [Collections.Generic.List[int]]::new()
        foreach($i in 1..$count) {
            $result.Add($i)
        }
    }
    '+= Operator to Array' = {
        param($count)

        $result = @()
        foreach($i in 1..$count) {
            $result += $i
        }
    }
}

5kb, 10kb, 100kb | ForEach-Object {
    $groupResult = foreach($test in $tests.GetEnumerator()) {
        $ms = (Measure-Command { & $test.Value -Count $_ }).TotalMilliseconds

        [pscustomobject]@{
            CollectionSize    = $_
            Test              = $test.Key
            TotalMilliseconds = [math]::Round($ms, 2)
        }

        [GC]::Collect()
        [GC]::WaitForPendingFinalizers()
    }

    $groupResult = $groupResult | Sort-Object TotalMilliseconds
    $groupResult | Select-Object *, @{
        Name       = 'RelativeSpeed'
        Expression = {
            $relativeSpeed = $_.TotalMilliseconds / $groupResult[0].TotalMilliseconds
            [math]::Round($relativeSpeed, 2).ToString() + 'x'
        }
    }
}
```

These tests were run on a Windows 11 machine in PowerShell 7.3.4.

```Output
CollectionSize Test                           TotalMilliseconds RelativeSpeed
-------------- ----                           ----------------- -------------
          5120 PowerShell Explicit Assignment             26.65 1x
          5120 .Add(T) to List<T>                        110.98 4.16x
          5120 += Operator to Array                      402.91 15.12x
         10240 PowerShell Explicit Assignment              0.49 1x
         10240 .Add(T) to List<T>                        137.67 280.96x
         10240 += Operator to Array                     1678.13 3424.76x
        102400 PowerShell Explicit Assignment             11.18 1x
        102400 .Add(T) to List<T>                       1384.03 123.8x
        102400 += Operator to Array                   201991.06 18067.18x
```

When you're working with large collections, array addition is dramatically slower than adding to
a **`List<T>`**.

When using a **`List<T>`**, you need to create the list with a specific type, like [**`String`**][08] or
[**`Int`**][09]. When you add objects of a different type to the list, they are cast to the specified type.
If they can't be cast to the specified type, the method raises an exception.

```powershell
$intList = [System.Collections.Generic.List[int]]::new()
$intList.Add(1)
$intList.Add('2')
$intList.Add(3.0)
$intList.Add('Four')
$intList
```

```Output
MethodException:
Line |
   5 |  $intList.Add('Four')
     |  ~~~~~~~~~~~~~~~~~~~~
     | Cannot convert argument "item", with value: "Four", for "Add" to type
     "System.Int32": "Cannot convert value "Four" to type "System.Int32".
     Error: "The input string 'Four' was not in a correct format.""

1
2
3
```

When you need the list to be a collection of different types of objects, create it with [**`Object`**][10]
as the list type. You can enumerate the collection inspect the types of the objects in it.

```powershell
$objectList = [System.Collections.Generic.List[object]]::new()
$objectList.Add(1)
$objectList.Add('2')
$objectList.Add(3.0)
$objectList | ForEach-Object { "$_ is $($_.GetType())" }
```

```Output
1 is int
2 is string
3 is double
```

If you do require an array, you can call the [`.ToArray()` Method][11] on the list or you can let
PowerShell create the array for you:

```powershell
$results = @(
    Get-Something
    Get-SomethingElse
)
```

In this example, PowerShell creates an [**`ArrayList`**][12] to hold the results written to the pipeline
inside the array expression. Just before assigning to `$results`, PowerShell converts the
**`ArrayList`** to an **`object[]`**.

## String addition

Strings are immutable. Each addition to the string actually creates a new string big enough to hold
the contents of both the left and right operands, then copies the elements of both operands into
the new string. For small strings, this overhead may not matter. For large strings, this can affect
performance and memory consumption.

There are at least two alternatives:

- The [`-join` operator][13] concatenates strings
- The .NET [**`StringBuilder`** Class][14] provides a mutable string

The following example compares the performance of these three methods of building a string.

```powershell
$tests = @{
    'StringBuilder' = {
        $sb = [System.Text.StringBuilder]::new()
        foreach ($i in 0..$args[0]) {
            $sb = $sb.AppendLine("Iteration $i")
        }
        $sb.ToString()
    }
    'Join operator' = {
        $string = @(
            foreach ($i in 0..$args[0]) {
                "Iteration $i"
            }
        ) -join "`n"
        $string
    }
    'Addition Assignment +=' = {
        $string = ''
        foreach ($i in 0..$args[0]) {
            $string += "Iteration $i`n"
        }
        $string
    }
}

10kb, 50kb, 100kb | ForEach-Object {
    $groupResult = foreach ($test in $tests.GetEnumerator()) {
        $ms = (Measure-Command { & $test.Value $_ }).TotalMilliseconds

        [pscustomobject]@{
            Iterations        = $_
            Test              = $test.Key
            TotalMilliseconds = [math]::Round($ms, 2)
        }

        [GC]::Collect()
        [GC]::WaitForPendingFinalizers()
    }

    $groupResult = $groupResult | Sort-Object TotalMilliseconds
    $groupResult | Select-Object *, @{
        Name       = 'RelativeSpeed'
        Expression = {
            $relativeSpeed = $_.TotalMilliseconds / $groupResult[0].TotalMilliseconds
            [math]::Round($relativeSpeed, 2).ToString() + 'x'
        }
    }
}
```

These tests were run on a Windows 10 machine in PowerShell 7.3.4. The output shows that the `-join`
operator is the fastest, followed by the **`StringBuilder`** Class.

```Output
Iterations Test                   TotalMilliseconds RelativeSpeed
---------- ----                   ----------------- -------------
     10240 Join operator                       7.08 1x
     10240 StringBuilder                      54.10 7.64x
     10240 Addition Assignment +=            724.16 102.28x
     51200 Join operator                      41.76 1x
     51200 StringBuilder                     318.06 7.62x
     51200 Addition Assignment +=          17693.06 423.68x
    102400 Join operator                     106.98 1x
    102400 StringBuilder                     543.84 5.08x
    102400 Addition Assignment +=          90693.13 847.76x
```

The times and relative speeds can vary depending on the hardware, the version of PowerShell, and the
current workload on the system.

## Processing large files

The idiomatic way to process a file in PowerShell might look something like:

```powershell
Get-Content $path | Where-Object Length -GT 10
```

This can be an order of magnitude slower than using .NET APIs directly, for example [`StreamReader`][15]:

```powershell
try {
    $reader = [System.IO.StreamReader]::new($path)
    while (-not $reader.EndOfStream) {
        $line = $reader.ReadLine()
        if ($line.Length -gt 10) {
            $line
        }
    }
}
finally {
    if ($reader) {
        $reader.Dispose()
    }
}
```

Or [`File.ReadLines` Method][16], which wraps `StreamReader` making the reading process simpler:

```powershell
foreach ($line in [System.IO.File]::ReadLines($path)) {
    if ($line.Length -gt 10) {
        $line
    }
}
```

### Looking up entries by property in large collections

It's common to need to use a shared property to identify the same record in different collections,
like using a name to retrieve an ID from one list and an email from another. Iterating over the
first list to find the matching record in the second collection is slow. In particular, the
repeated filtering of the second collection has a large overhead.

Given two collections, one with an **`ID`** and **`Name`**, the other with **`Name`** and **`Email`**:

```powershell
$Employees = 1..10000 | ForEach-Object {
    [PSCustomObject]@{
        Id   = $_
        Name = "Name$_"
    }
}

$Accounts = 2500..7500 | ForEach-Object {
    [PSCustomObject]@{
        Name  = "Name$_"
        Email = "Name$_@fabrikam.com"
    }
}
```

The usual way to reconcile these collections to return a list of objects with the **`ID`**, **`Name`**,
and **`Email`** properties might look like this:

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

Instead, you can make a [Hash Table][02] that uses the shared **`Name`** property as a key and the
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
    $Email = $LookupHash[$_.Name].Email
    [pscustomobject]@{
        Id    = $_.Id
        Name  = $_.Name
        Email = $Email
    }
}
```

This is much faster. While the looping filter took minutes to complete, the hash lookup takes less
than a second.

## Avoid Write-Host

It's generally considered poor practice to write output directly to the console, but when it makes
sense, many scripts use [`Write-Host`][17].

If you must write many messages to the console, `Write-Host` can be an order of magnitude slower
than `[Console]::WriteLine()` for specific hosts like `pwsh.exe`, `powershell.exe`, or
`powershell_ise.exe`. However, `[Console]::WriteLine()` isn't guaranteed to work in all hosts. Also,
output written using `[Console]::WriteLine()` doesn't get written to transcripts started by
`Start-Transcript`.

Instead of using `Write-Host`, consider using [`Write-Output`][01].

### JIT compilation

PowerShell compiles the script code to bytecode that's interpreted. Beginning in PowerShell 3, for
code that's repeatedly executed in a loop, PowerShell can improve performance by Just-in-time (JIT)
compiling the code into native code.

Loops that have fewer than 300 instructions are eligible for JIT-compilation. Loops larger than that
are too costly to compile. When the loop has executed 16 times, the script is JIT-compiled in the
background. When the JIT-compilation completes, execution is transferred to the compiled code.

## Avoid repeated calls to a function

Calling a function can be an expensive operation. If you're calling a function in a long running tight
loop, consider moving the loop inside the function.

Consider the following examples:

```powershell
$tests = @{
    'Simple for-loop'       = {
        param([int] $RepeatCount, [random] $RanGen)

        for ($i = 0; $i -lt $RepeatCount; $i++) {
            $null = $RanGen.Next()
        }
    }
    'Wrapped in a function' = {
        param([int] $RepeatCount, [random] $RanGen)

        function Get-RandomNumberCore {
            param ($rng)

            $rng.Next()
        }

        for ($i = 0; $i -lt $RepeatCount; $i++) {
            $null = Get-RandomNumberCore -rng $RanGen
        }
    }
    'for-loop in a function' = {
        param([int] $RepeatCount, [random] $RanGen)

        function Get-RandomNumberAll {
            param ($rng, $count)

            for ($i = 0; $i -lt $count; $i++) {
                $null = $rng.Next()
            }
        }

        Get-RandomNumberAll -rng $RanGen -count $RepeatCount
    }
}

5kb, 10kb, 100kb | ForEach-Object {
    $rng = [random]::new()
    $groupResult = foreach ($test in $tests.GetEnumerator()) {
        $ms = Measure-Command { & $test.Value -RepeatCount $_ -RanGen $rng }

        [pscustomobject]@{
            CollectionSize    = $_
            Test              = $test.Key
            TotalMilliseconds = [math]::Round($ms.TotalMilliseconds,2)
        }

        [GC]::Collect()
        [GC]::WaitForPendingFinalizers()
    }

    $groupResult = $groupResult | Sort-Object TotalMilliseconds
    $groupResult | Select-Object *, @{
        Name       = 'RelativeSpeed'
        Expression = {
            $relativeSpeed = $_.TotalMilliseconds / $groupResult[0].TotalMilliseconds
            [math]::Round($relativeSpeed, 2).ToString() + 'x'
        }
    }
}
```

The **Basic for-loop** example is the base line for performance. The second example wraps the random
number generator in a function that is called in a tight loop. The third example moves the loop
inside the function. The function is only called once but the code still generates the same amount of random
numbers. Notice the difference in execution times for each example.

```Output
Iterations Test                   TotalMilliseconds RelativeSpeed
---------- ----                   ----------------- -------------
      5120 Simple for-loop                     9.99 1x
      5120 for-loop in a function             23.19 2.32x        
      5120 Wrapped in a function             348.34 34.87x       
     10240 Simple for-loop                     5.03 1x
     10240 for-loop in a function              8.26 1.64x        
     10240 Wrapped in a function             621.09 123.48x      
    102400 Simple for-loop                    24.19 1x
    102400 for-loop in a function             43.38 1.79x  
    102400 Wrapped in a function            3522.96 145.64x
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
$measure = Measure-Command -Expression {
    Import-Csv .\Input.csv | ForEach-Object -Begin { $Id = 1 } -Process {
        [PSCustomObject]@{
            Id   = $Id
            Name = $_.opened_by
        } | Export-Csv .\Output1.csv -Append
    }
}

'Wrapped = {0:N2} ms' -f $measure.TotalMilliseconds

# Outputs:
# Wrapped = 15.968,78 ms
```

For the next example, the `Export-Csv` command was moved outside of the `ForEach-Object` pipeline.
In this case, `Export-Csv` is invoked only once, but still processes all objects passed out of
`ForEach-Object`.

```powershell
$measure = Measure-Command -Expression {
    Import-Csv .\Input.csv | ForEach-Object -Begin { $Id = 2 } -Process {
        [PSCustomObject]@{
            Id   = $Id
            Name = $_.opened_by
        }
    } | Export-Csv .\Output2.csv
}

'Unwrapped = {0:N2} ms' -f $measure.TotalMilliseconds

# Outputs:
# Unwrapped = 42.92 ms
```

The unwrapped example is **372 times faster**. Also, notice that the first implementation requires the
**`-Append`** Parameter, which isn't required for the later implementation.

<!-- Link reference definitions -->
[01]: /powershell/module/Microsoft.PowerShell.Utility/Write-Output
[02]: /powershell/scripting/learn/deep-dives/everything-about-hashtable
[03]: /powershell/scripting/learn/deep-dives/everything-about-null
[04]: /dotnet/api/system.void
[05]: /powershell/module/microsoft.powershell.core/out-null
[06]: /dotnet/api/system.collections.generic.list-1
[07]: /dotnet/api/system.collections.generic.list-1.add#system-collections-generic-list-1-add(-0)
[08]: /dotnet/api/system.string
[09]: /dotnet/api/system.int32
[10]: /dotnet/api/system.object
[11]: /dotnet/api/system.collections.generic.list-1.toarray#system-collections-generic-list-1-toarray
[12]: /dotnet/api/system.collections.arraylist
[13]: /powershell/module/microsoft.powershell.core/about/about_join
[14]: /dotnet/api/system.text.stringbuilder
[15]: /dotnet/api/system.io.streamreader
[16]: /dotnet/api/system.io.file.readlines
[17]: /powershell/module/microsoft.powershell.utility/write-host

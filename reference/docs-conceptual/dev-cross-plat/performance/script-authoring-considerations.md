---
description: Scripting for Performance in PowerShell
ms.date: 12/05/2024
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

- Assignment or file redirection to `$null`
- Casting to `[void]`
- Pipe to `Out-Null`

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
a typed generic list (`[List<T>]`):

```powershell
$results = [System.Collections.Generic.List[object]]::new()
$results.AddRange((Get-Something))
$results.AddRange((Get-SomethingElse))
$results
```

The performance impact of using array addition grows exponentially with the size of the collection
and the number additions. This code compares explicitly assigning values to an array with using
array addition and using the `Add(T)` method on a `[List<T>]` object. It defines explicit assignment
as the baseline for performance.

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

When using a `[List<T>]` object, you need to create the list with a specific type, like `[String]`
or `[Int]`. When you add objects of a different type to the list, they are cast to the specified
type. If they can't be cast to the specified type, the method raises an exception.

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

When you need the list to be a collection of different types of objects, create it with `[Object]`
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

If you do require an array, you can call the `ToArray()` method on the list or you can let
PowerShell create the array for you:

```powershell
$results = @(
    Get-Something
    Get-SomethingElse
)
```

In this example, PowerShell creates an `[ArrayList]` to hold the results written to the pipeline
inside the array expression. Just before assigning to `$results`, PowerShell converts the
`[ArrayList]` to an `[Object[]]`.

## String addition

Strings are immutable. Each addition to the string actually creates a new string big enough to hold
the contents of both the left and right operands, then copies the elements of both operands into
the new string. For small strings, this overhead may not matter. For large strings, this can affect
performance and memory consumption.

There are at least two alternatives:

- The [`-join` operator][13] concatenates strings
- The .NET `[StringBuilder]` class provides a mutable string

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

These tests were run on a Windows 11 machine in PowerShell 7.4.2. The output shows that the `-join`
operator is the fastest, followed by the `[StringBuilder]` class.

```Output
Iterations Test                   TotalMilliseconds RelativeSpeed
---------- ----                   ----------------- -------------
     10240 Join operator                      14.75 1x
     10240 StringBuilder                      62.44 4.23x
     10240 Addition Assignment +=            619.64 42.01x
     51200 Join operator                      43.15 1x
     51200 StringBuilder                     304.32 7.05x
     51200 Addition Assignment +=          14225.13 329.67x
    102400 Join operator                      85.62 1x
    102400 StringBuilder                     499.12 5.83x
    102400 Addition Assignment +=          67640.79 790.01x
```

The times and relative speeds can vary depending on the hardware, the version of PowerShell, and the
current workload on the system.

## Processing large files

The idiomatic way to process a file in PowerShell might look something like:

```powershell
Get-Content $path | Where-Object Length -GT 10
```

This can be an order of magnitude slower than using .NET APIs directly. For example, you can use the
.NET `[StreamReader]` class:

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

You could also use the `ReadLines` method of `[System.IO.File]`, which wraps `StreamReader`,
simplifies the reading process:

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
        Name  = "Name$_"
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

Instead, you can make a [Hash Table][02] that uses the shared **Name** property as a key and the
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

## Use Write-Host carefully

The `Write-Host` command should only be used when you need to write formatted text to the host
console, rather than writing objects to the **Success** pipeline.

`Write-Host` can be an order of magnitude slower than `[Console]::WriteLine()` for specific hosts
like `pwsh.exe`, `powershell.exe`, or `powershell_ise.exe`. However, `[Console]::WriteLine()` isn't
guaranteed to work in all hosts. Also, output written using `[Console]::WriteLine()` doesn't get
written to transcripts started by `Start-Transcript`.

### JIT compilation

PowerShell compiles the script code to bytecode that's interpreted. Beginning in PowerShell 3, for
code that's repeatedly executed in a loop, PowerShell can improve performance by Just-in-time (JIT)
compiling the code into native code.

Loops that have fewer than 300 instructions are eligible for JIT-compilation. Loops larger than that
are too costly to compile. When the loop has executed 16 times, the script is JIT-compiled in the
background. When the JIT-compilation completes, execution is transferred to the compiled code.

## Avoid repeated calls to a function

Calling a function can be an expensive operation. If you're calling a function in a long running
tight loop, consider moving the loop inside the function.

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
number generator in a function that's called in a tight loop. The third example moves the loop
inside the function. The function is only called once but the code still generates the same amount
of random numbers. Notice the difference in execution times for each example.

```Output
CollectionSize Test                   TotalMilliseconds RelativeSpeed
-------------- ----                   ----------------- -------------
          5120 for-loop in a function              9.62 1x
          5120 Simple for-loop                    10.55 1.1x
          5120 Wrapped in a function              62.39 6.49x
         10240 Simple for-loop                    17.79 1x
         10240 for-loop in a function             18.48 1.04x
         10240 Wrapped in a function             127.39 7.16x
        102400 for-loop in a function            179.19 1x
        102400 Simple for-loop                   181.58 1.01x
        102400 Wrapped in a function            1155.57 6.45x
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
```

```Output
Wrapped = 15,968.78 ms
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
```

```Output
Unwrapped = 42.92 ms
```

The unwrapped example is **372 times faster**. Also, notice that the first implementation requires
the **Append** parameter, which isn't required for the later implementation.

## Object creation

Creating objects using the `New-Object` cmdlet can be slow. The following code compares the
performance of creating objects using the `New-Object` cmdlet to the `[pscustomobject]` type
accelerator.

```powershell
Measure-Command {
    $test = 'PSCustomObject'
    for ($i = 0; $i -lt 100000; $i++) {
        $resultObject = [PSCustomObject]@{
            Name = 'Name'
            Path = 'FullName'
        }
    }
} | Select-Object @{n='Test';e={$test}},TotalSeconds

Measure-Command {
    $test = 'New-Object'
    for ($i = 0; $i -lt 100000; $i++) {
        $resultObject = New-Object -TypeName PSObject -Property @{
            Name = 'Name'
            Path = 'FullName'
        }
    }
} | Select-Object @{n='Test';e={$test}},TotalSeconds
```

```Output
Test           TotalSeconds
----           ------------
PSCustomObject         0.48
New-Object             3.37
```

PowerShell 5.0 added the `new()` static method for all .NET types. The following code compares the
performance of creating objects using the `New-Object` cmdlet to the `new()` method.

```powershell
Measure-Command {
    $test = 'new() method'
    for ($i = 0; $i -lt 100000; $i++) {
        $sb = [System.Text.StringBuilder]::new(1000)
    }
} | Select-Object @{n='Test';e={$test}},TotalSeconds

Measure-Command {
    $test = 'New-Object'
    for ($i = 0; $i -lt 100000; $i++) {
        $sb = New-Object -TypeName System.Text.StringBuilder -ArgumentList 1000
    }
} | Select-Object @{n='Test';e={$test}},TotalSeconds
```

```Output
Test         TotalSeconds
----         ------------
new() method         0.59
New-Object           3.17
```

## Use OrderedDictionary to dynamically create new objects

There are situations where we may need to dynamically create objects based on some input, the
perhaps most commonly used way to create a new **PSObject** and then add new properties using the
`Add-Member` cmdlet. The performance cost for small collections using this technique may be
negligible however it can become very noticeable for big collections. In that case, the recommended
approach is to use an `[OrderedDictionary]` and then convert it to a **PSObject** using the
`[pscustomobject]` type accelerator. For more information, see the _Creating ordered dictionaries_
section of [about_Hash_Tables][19].

Assume you have the following API response stored in the variable `$json`.

```json
{
  "tables": [
    {
      "name": "PrimaryResult",
      "columns": [
        { "name": "Type", "type": "string" },
        { "name": "TenantId", "type": "string" },
        { "name": "count_", "type": "long" }
      ],
      "rows": [
        [ "Usage", "63613592-b6f7-4c3d-a390-22ba13102111", "1" ],
        [ "Usage", "d436f322-a9f4-4aad-9a7d-271fbf66001c", "1" ],
        [ "BillingFact", "63613592-b6f7-4c3d-a390-22ba13102111", "1" ],
        [ "BillingFact", "d436f322-a9f4-4aad-9a7d-271fbf66001c", "1" ],
        [ "Operation", "63613592-b6f7-4c3d-a390-22ba13102111", "7" ],
        [ "Operation", "d436f322-a9f4-4aad-9a7d-271fbf66001c", "5" ]
      ]
    }
  ]
}
```

Now, suppose you want to export this data to a CSV. First you need to create new objects and add the
properties and values using the `Add-Member` cmdlet.

```powershell
$data = $json | ConvertFrom-Json
$columns = $data.tables.columns
$result = foreach ($row in $data.tables.rows) {
    $obj = [psobject]::new()
    $index = 0

    foreach ($column in $columns) {
        $obj | Add-Member -MemberType NoteProperty -Name $column.name -Value $row[$index++]
    }

    $obj
}
```

Using an `OrderedDictionary`, the code can be translated to:

```powershell
$data = $json | ConvertFrom-Json
$columns = $data.tables.columns
$result = foreach ($row in $data.tables.rows) {
    $obj = [ordered]@{}
    $index = 0

    foreach ($column in $columns) {
        $obj[$column.name] = $row[$index++]
    }

    [pscustomobject] $obj
}
```

In both cases the `$result` output would be same:

```output
Type        TenantId                             count_
----        --------                             ------
Usage       63613592-b6f7-4c3d-a390-22ba13102111 1
Usage       d436f322-a9f4-4aad-9a7d-271fbf66001c 1
BillingFact 63613592-b6f7-4c3d-a390-22ba13102111 1
BillingFact d436f322-a9f4-4aad-9a7d-271fbf66001c 1
Operation   63613592-b6f7-4c3d-a390-22ba13102111 7
Operation   d436f322-a9f4-4aad-9a7d-271fbf66001c 5
```

The latter approach becomes exponentially more efficient as the number of objects and member
properties increases.

Here is a performance comparison of three techniques for creating objects with 5 properties:

```powershell
$tests = @{
    '[ordered] into [pscustomobject] cast' = {
        param([int] $iterations, [string[]] $props)

        foreach ($i in 1..$iterations) {
            $obj = [ordered]@{}
            foreach ($prop in $props) {
                $obj[$prop] = $i
            }
            [pscustomobject] $obj
        }
    }
    'Add-Member'                           = {
        param([int] $iterations, [string[]] $props)

        foreach ($i in 1..$iterations) {
            $obj = [psobject]::new()
            foreach ($prop in $props) {
                $obj | Add-Member -MemberType NoteProperty -Name $prop -Value $i
            }
            $obj
        }
    }
    'PSObject.Properties.Add'              = {
        param([int] $iterations, [string[]] $props)

        # this is how, behind the scenes, `Add-Member` attaches
        # new properties to our PSObject.
        # Worth having it here for performance comparison

        foreach ($i in 1..$iterations) {
            $obj = [psobject]::new()
            foreach ($prop in $props) {
                $obj.PSObject.Properties.Add(
                    [psnoteproperty]::new($prop, $i))
            }
            $obj
        }
    }
}

$properties = 'Prop1', 'Prop2', 'Prop3', 'Prop4', 'Prop5'

1kb, 10kb, 100kb | ForEach-Object {
    $groupResult = foreach ($test in $tests.GetEnumerator()) {
        $ms = Measure-Command { & $test.Value -iterations $_ -props $properties }

        [pscustomobject]@{
            Iterations        = $_
            Test              = $test.Key
            TotalMilliseconds = [math]::Round($ms.TotalMilliseconds, 2)
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

And these are the results:

```output
Iterations Test                                 TotalMilliseconds RelativeSpeed
---------- ----                                 ----------------- -------------
      1024 [ordered] into [pscustomobject] cast             22.00 1x
      1024 PSObject.Properties.Add                         153.17 6.96x
      1024 Add-Member                                      261.96 11.91x
     10240 [ordered] into [pscustomobject] cast             65.24 1x
     10240 PSObject.Properties.Add                        1293.07 19.82x
     10240 Add-Member                                     2203.03 33.77x
    102400 [ordered] into [pscustomobject] cast            639.83 1x
    102400 PSObject.Properties.Add                       13914.67 21.75x
    102400 Add-Member                                    23496.08 36.72x
```

## Related links

- [`$null`][03]
- [`[void]`][04]
- [Out-Null][05]
- [`List<T>`][06]
- [`Add(T)` method][07]
- [`[String]`][08]
- [`[Int]`][09]
- [`[Object]`][10]
- [`ToArray()` method][11]
- [`[ArrayList]`][12]
- [`[StringBuilder]`][14]
- [`[StreamReader]`][15]
- [`[File]::ReadLines()` method][16]
- [Write-Host][17]
- [Add-Member][18]

<!-- Link reference definitions -->
[02]: ../../learn/deep-dives/everything-about-hashtable.md
[03]: ../../learn/deep-dives/everything-about-null.md
[04]: xref:System.Void
[05]: xref:Microsoft.PowerShell.Core.Out-Null
[06]: xref:System.Collections.Generic.List`1
[07]: xref:System.Collections.Generic.List`1.Add*
[08]: xref:System.String
[09]: xref:System.Int32
[10]: xref:System.Object
[11]: xref:System.Collections.Generic.List`1.ToArray*#system-collections-generic-list-1-toarray
[12]: xref:System.Collections.ArrayList
[13]: /powershell/module/microsoft.powershell.core/about/about_join
[14]: xref:System.Text.StringBuilder
[15]: xref:System.IO.StreamReader
[16]: xref:System.IO.File.ReadLines*
[17]: xref:Microsoft.PowerShell.Utility.Write-Host
[18]: xref:Microsoft.PowerShell.Utility.Add-Member
[19]: /powershell/module/microsoft.powershell.core/about/about_hash_tables#creating-ordered-dictionaries

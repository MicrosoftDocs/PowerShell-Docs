# PERF-01 If performance matters, test it

PowerShell comes equipped with 3.2 million performance quirks. Approximately.

If you're aware of multiple techniques to accomplish something, and you're writing a production
script that will be dealing with large data sets (meaning performance will become a cumulative
factor), then test the performance using Measure-Command or the Profiler module, or some other tool.

For example:

```PowerShell
foreach($result in Do-Something) { $result.PropertyOne + $result.PropertyTwo }
Do-Something | ForEach-Object { $_.PropertyOne + $_.PropertyTwo }
```

In this case, the `foreach` language construct is faster than piping to the `ForEach-Object` cmdlet
-- but the point is that you should measure, and do so on the hardware and PowerShell version where
the performance matters to you.

# PERF-02 Consider trade-offs between performance and readability

Performance is not the only reason you write a script. If a script is expected to deal with ten
pieces of data, a 30% performance improvement will not add up to a lot of actual time. It's okay to
use a slower-performing technique that is easier to read, understand, and maintain - although
"easier" is a very subjective term. Of the two commands above, any given person might select either
of them as being "easier" to understand or read.

This is an important area for people in the PowerShell community. While everyone agrees that
aesthetics are important - they help make scripts more readable, more maintainable, and so on -
performance can also be important. However, the advantages of a really tiny performance gain do not
always outweigh the "soft" advantages of nice aesthetics.

For example:

```PowerShell
$content = Get-Content -Path file.txt

foreach ($line in $content) {
    Do-Something -Input $line
}
```

Most folks will agree that the basic aesthetics of that example are good. This snippet uses a native
PowerShell approach, is easy to follow, and because it uses a structural programming approach, is
easy to expand (say, if you needed to execute several commands again each line of content). However,
this approach could offer extremely poor performance. If file.txt was a few hundred kilobytes, no
problem; if it was several hundred megabytes, potential problem. Get-Content is forced to read the
entire file into memory at once, storing it in memory (in the $content variable).

Now consider this alternate approach:

```PowerShell
Get-Content -Path file.txt |
ForEach-Object -Process {
    Do-Something -Input $_
}
```

As described elsewhere in this guide, many folks in the community would dislike this approach for
aesthetic reasons. However, this approach has the advantage of utilizing PowerShell's pipeline to
"stream" the content in file.txt. Provided that the fictional "Do-Something" command isn't blocking
the pipeline (a la Sort-Object), the shell can send lines of content (String objects, technically)
through the pipeline in a continuous stream, rather than having to buffer them all into memory.

Some would argue that this second approach is always a poor one, and that if performance is an issue
then you should devolve from a PowerShell-native approach into a lower-level .NET Framework
approach:

```PowerShell
$sr = New-Object -TypeName System.IO.StreamReader -ArgumentList file.txt

while ($sr.Peek() -ge 0) {
    $line = $sr.ReadLine()
    Do-Something -Input $line
}
```

There are myriad variations to this approach, of course, but it solves the performance problem by
reading one line at a time, instead of buffering the entire file into memory. It maintains the
structured programming approach of the first example, at the expense of using a potentially
harder-to-follow .NET Framework model instead of native PowerShell commands. Many regard this third
example as an intermediate step, and suggest that a truly beneficial approach would be to write
PowerShell commands as "wrappers" around the .NET code. For example (noting that this fourth example
uses fictional commands by way of illustration):

```PowerShell
$handle = Open-TextFile -Path file.txt

while (-not (Test-TextFile -Handle $handle)) {
    Do-Something -Input (Read-TextFile -Handle $handle)
}
```

This example reverts back to a native PowerShell approach, using commands and parameters. The
proposed commands (`Open-TextFile`, `Test-TextFile`, and `Read-TextFile`) are just wrappers around
.NET Framework classes, such as the StreamReader class shown in the third example.

You will generally find that it is possible to conform with the community's general aesthetic
preferences while still maintaining a good level of performance. Doing so may require more work -
such as writing PowerShell wrapper commands around underlying .NET Framework classes. Most would
argue that, for a tool that is intended for long-term use, the additional work is a worthwhile
investment.

The moral here is that both aesthetic and performance are important considerations, and without some
work context, neither is inherently more important than the other. It is often possible, with the
right technique, to satisfy both. As a general practice, you should avoid giving up on aesthetics
solely because of performance concerns - when possible, make the effort to satisfy both performance
and aesthetics.

# PERF-03 Language > Framework > Script > Pipeline

This is just a rough guideline, but as a general rule:

1. Language features are faster than features of the .net framework
2. Compiled methods on objects and .net classes are still faster than script
3. Simple PowerShell script is still faster than calling functions or cmdlets

It's counter-intuitive that script is faster than calling cmdlets that are compiled, but it's
frequently true, unless there is a lot of work being done by each cmdlet. The overhead of calling
cmdlets and passing data around is significant. Of course, this is just a guideline, and you should
always **measure**.

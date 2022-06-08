TODO: This section should probably be merged to
[Code Layout and Formatting](Code-Layout-and-Formatting.md), and based on the
[#15](https://github.com/PoshCode/PowerShellPracticeAndStyle/issues/15), we should remove or rewrite
the backticks section.

# READ-01 Indent your code

Consider this code example:

```PowerShell
if ($this -gt $that) {
    Do-Something -with $that
}
```

And now consider this one:

```PowerShell
if ($this -gt $that)
{
    Do-Something -with $that
}
```

Neither of these is better than the other. Ask 100 coders which they prefer and you'll get roughly
half liking either one. Now, when you start dealing with commands that accept script blocks as
parameters, things can get trickier because of the way PowerShell parses syntax. "Wrong" is wrong.
With scripting constructs, like the two examples above, there's no functional difference.

Continuing in that vein, understand that the following are basically guidelines from mass consensus;
they're not hard-and-fast rules. That said, there are arguments in favor of these, and you should
consider the arguments before dismissing these ideas.

First, format your code properly. The convention is to indent within constructs, to make it clearer
what "belongs to" the construct.

```PowerShell
foreach ($computer in $computers) {
    Do-This
    Get-Those
}
```

You will probably be reviled if you don't format carefully.

# READ-02 Avoid backticks

Consider this:

```PowerShell
Get-WmiObject -Class Win32_LogicalDisk `
              -Filter "DriveType=3" `
              -ComputerName SERVER2
```

In general, the community feels you should avoid using those backticks as "line continuation
characters" when possible. They're hard to read, easy to miss, and easy to mistype. Also, if you add
an extra whitespace after the backtick in the above example, then the command won't work. The
resulting error is hard to correlate to the actual problem, making debugging the issue harder.

Here's an alternative:

```PowerShell
$GetWmiObjectParams = @{
    Class = "Win32_LogicalDisk"
    Filter = "DriveType=3"
    ComputerName = "SERVER2"
}
Get-WmiObject @GetWmiObjectParams
```

The technique is called _splatting_. It lets you get the same nice, broken-out formatting without
using the backtick. You can also line break after almost any comma, pipe character, or semicolon
without using a backtick.

The backtick is not universally hated - but it can be inconvenient. If you have to use it for line
breaks, well then, use it. Just try not to have to.

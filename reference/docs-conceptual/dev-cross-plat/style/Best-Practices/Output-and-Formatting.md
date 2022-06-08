### Formatting Output

TODO: This whole document is STILL ROUGH DRAFT

## Don't use Write-Host unless you really mean it

Previous to PowerShell 5, Write-Host has no functionality at all in non-interactive scripts. It
cannot be captured or redirected, and therefore should only be used in functions which are "Show"ing
or "Format"ing output, or to display something as part of an interactive prompt to the user.

That is: you should not use Write-Host to create script output unless your script (or function, or
whatever) uses the Show verb (as in, Show-Performance) or the Format verb (as in, Format-Hex), or
has a `-Formatted` switch parameter. You may also use it to build a interactions with the user in
other cases (e.g. to write extra information to the screen before prompting the user for a choice or
input).

Generally, you should consider the other Write-* commands first when trying to give information to
the user.

## Use Write-Progress to give progress information to someone running your script

When you're letting the user know how far through the script they are, or just making sure they know
that _something_ is happening, Write-Progress is the right command to use. In the case of graphical
hosts or remote jobs, this output can be shown to the user in real time, even when verbose and other
streams are being collected and logged.

Progress output is ephemeral, however, in that it doesn't stick around. You should not put anything
exclusively in the progress stream that the user _needs_ to see, or might want to review after the
script finishes.

## Use Write-Verbose to give details to someone running your script

You should use verbose output for information that contains details about the value of computation,
or the reason why a certain execution path was chosen. It should be information that is useful _but
not necessary_ for anyone running the script, providing status information such as "Server1
processed", or logic information such as "Server2 up-to-date, skipped", but shouldn't be used for
actual results or important information.

## Use Write-Debug to give information to someone maintaining your script

You should use the debug output stream for output that is useful for script debugging (ie: "Now
entering main loop" or "Result was null, skipping to end of loop"), or to display the value of a
variable before a conditional statement, so the maintainer can break into the debugger if necessary.

> TIP: When debugging you should be aware that you can set `$DebugPreference = "Continue"` to see
> this information on screen without entering a breakpoint prompt.

## Use CmdletBinding if you are using output streams

As we've already written elsewhere, you should probably
[always use CmdletBinding](../Style-Guide/Code-Layout-and-Formatting.md#always-start-with-cmdletbinding).

Using CmdletBinding is particularly important, however, when you're using Write-Verbose and
Write-Debug, as the Verbose and Debug output streams are off by default, and the
`[CmdletBinding()]` attribute enables the common `-Verbose` and `-Debug` switches which turn those
streams on.

CmdletBinding also enables the switches for the Warning and Error streams, as well as ways of
collecting those streams into variables. You should read the
[always use CmdletBinding](../Style-Guide/Code-Layout-and-Formatting.md#always-start-with-cmdletbinding)
topic for more information.

## Use Format Files for your custom objects

You should not use format commands inside functions. Instead you should include a
`modulename.format.ps1xml` file in the FormatsToProcess field of your module's PSD1 manifest, and
define a `PSTypeName` on your objects, so that PowerShell will format your output the way you want,
automatically.

## Only output one "kind" of thing at a time

You should avoid mixing different types of objects in the output of a single command, because you
may get empty rows in your output or cause table output to break into list output, etc.

For the sake of tools and command-search, you should indicate with the `[OutputType()]` attribute
the output type(s) of your scripts, functions or cmdlets (see about_Functions_OutputTypeAttribute
for more information).

When you combine the output of multiple types objects, they should generally be derived from a
common basetype (like FileInfo and DirectoryInfo come from System.IO.FileSystemInfo), or should have
format or type files which cause them to output the same columns. In particular, you must avoid
outputting strings interspersed in your output.

### Two important exceptions to the single-type rule

**For internal functions** it's ok to return multiple different types because they won't be "output"
to the user/host, and can offer significant savings (e.g. one database call with three table joins,
instead of three database calls with two or three joins each). You can then call these functions and
assign the output to multiple variables, like so:

```PowerShell
$user, $group, $org = Get-UserGroupOrg
```

**When you call Out-Default.** If you must return multiple object types from an external command,
you should name your function in such a way that it's obvious to users that you're returning
multiple things, and you _must_ call `Out-Default` separately for each type of object to ensure that
the outputs don't ever get mixed up by the formatter.

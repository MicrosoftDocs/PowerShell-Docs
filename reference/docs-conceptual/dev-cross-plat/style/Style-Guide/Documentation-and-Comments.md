### Documenting and Comments

Comments that contradict the code are worse than no comments. Always make a priority of keeping the
comments up-to-date when the code changes!

Comments should be in English, and should be complete sentences. If the comment is short, the period
at the end can be omitted.

Remember that comments should serve to your reasoning and decision-making, not attempt to explain
what a command does. With the exception of regular expressions, well-written PowerShell can be
pretty self-explanatory.

```PowerShell
# Do not write:
# Increment Margin by 2
$Margin = $Margin + 2

# Maybe write:
# The rendering box obscures a couple of pixels.
$Margin = $Margin + 2
```

#### Block comments

Don't go overboard with comments. Unless your code is particularly obscure, don't precede each line
with a comment -- doing so breaks up the code and makes it harder to read. Instead, write a single
block comment.

Block comments generally apply to some or all of the code which follows them, and are indented to
the same level as that code. Each line should start with a # and a single space.

If the block is particularly long (as in the case of documentation text) it is recommended to use
the `<# ... #>` block comment syntax, but you should place the comment characters on their own
lines, and indent the comment:

```PowerShell
# Requiring a space makes things legible and prevents confusion.
# Writing comments one-per line makes them stand out more in the console.

<#
    .SYNOPSIS
        Really long comment blocks are tedious to keep commented in single-line mode.
    .DESCRIPTION
        Particularly when the comment must be frequently edited,
        as with the help and documentation for a function or script.
#>
```

#### Inline comments

Comments on the same line as a statement can be distracting, but when they don't state the obvious,
and particularly when you have several short lines of code which need explaining, they can be
useful.

They should be separated from the code statement by at least two spaces, and ideally, they should
line up with any other inline comments in the same block of code.

```PowerShell
$Options = @{
    Margin = 2          # The rendering box obscures a couple of pixels.
    Padding = 2         # We need space between the border and the text.
    FontSize = 24       # Keep this above 16 so it's readable in presentations.
}
```

#### Documentation comments

Comment-based help should be written in simple language.

You're not writing a thesis for your college Technical Writing class - you're writing something that
describes how a function works. Avoid unnecessarily large words, and keep your explanations short.
You're not trying to impress anyone, and the only people who will ever read this are just trying to
figure out how to use the function.

If you're writing in what is, for you, a foreign language, simpler words and simpler sentence
structures are better, and more likely to make sense to a native reader.

Be complete, but be concise.

##### Location

In order to ensure that the documentation stays with the function, documentation comments should be
placed INSIDE the function, rather than above. To make it harder to forget to update them when
changing a function, you should keep them at the top of the function, rather than at the bottom.

Of course, that's not to say that putting them elsewhere is wrong -- but this is easier to do, and
harder to forget to update.

##### Put Details in the Notes

If you want to provide detailed explanations about how your tool works, use the `Notes` section for
that.

##### Describe The Function

Every script function command should have at least a short statement describing it's function. That
is the `Synopsis`.

##### Document Each Parameter

Each parameter should be documented. To make it easier to keep the comments synchronized with
changes to the parameters, the preferred location for parameter documentation comments is _within_
the `param` block, directly above each parameter. Examples can be found in the ISE snippets:

```powershell
param (
    # Param1 help description
    [Parameter(Mandatory = $true,
                ValueFromPipelineByPropertyName = $true,
                Position = 0)]
    $Param1,

    # Param2 help description
    [int]
    $Param2
)
```

It is also possible to write `.PARAMETER` statements with the rest of the documentation comments,
but experience shows they are more likely to be kept up-to-date if you put them closer to the code
they document.

##### Provide Usage Examples

Your help should always provide an example for each major use case. A 'usage example' is just an
example of what you would type in to Powershell to run the script - you can even cut and paste one
from the command line while you're testing your function.

```PowerShell
function Test-Help {
    <#
        .SYNOPSIS
            An example function to display how help should be written.

        .EXAMPLE
            Get-Help -Name Test-Help

            This shows the help for the example function.
    #>
    [CmdletBinding()]
    param (
        # This parameter doesn't do anything.
        # Aliases: MP
        [Parameter(Mandatory = $true)]
        [Alias("MP")]
        [String]$MandatoryParameter
    )

    <# code here ... #>
}
```

### DOC-01 Write comment-based help

You should always write comment-based help in your scripts and functions.

Comment-based help is formatted as follows:

```PowerShell
function Get-Example {
    <#
    .SYNOPSIS
        A brief description of the function or script.

    .DESCRIPTION
        A longer description.

    .PARAMETER FirstParameter
        Description of each of the parameters.
        Note:
        To make it easier to keep the comments synchronized with changes to the parameters,
        the preferred location for parameter documentation comments is not here,
        but within the param block, directly above each parameter.

    .PARAMETER SecondParameter
        Description of each of the parameters.

    .INPUTS
        Description of objects that can be piped to the script.

    .OUTPUTS
        Description of objects that are output by the script.

    .EXAMPLE
        Example of how to run the script.

    .LINK
        Links to further documentation.

    .NOTES
        Detail on what the script does, if this is needed.

    #>
```

Comment-based help is displayed when the user types `help Get-Example` or `Get-Example -?`, etc.

Your help should be helpful. That is, if you've written a tool called `Get-LOBAppUser`, don't write
help that merely says, "Gets LOB App Users." Duh.

**Further information:** You can get more on the use of comment-based help by typing
`help about_Comment_Based_Help` within Powershell.

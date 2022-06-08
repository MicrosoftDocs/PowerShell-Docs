### Code Layout & Formatting

These guidelines are about readability. Some of them are arbitrary rules, but they are based on
decades of traditions in programming, so while you may disagree with some rules (and should always
follow the rules of individual projects), when we ask you to leave an empty line after a closing
function brace, or two lines before functions, we're not being capricious, we're doing so because it
makes it easier for experienced developers to scan your code.

#### Maintain Consistency in Layout

Rules about indentation, line length, and capitalization are about consistency across code bases.
Long practice has shown that it's easier to read and understand code when it looks familiar and
you're not being distracted by details, which means that it's better for everyone in the community
to follow a single set of rules.

We don't expect everyone to follow these guidelines, and rules for individual projects always trump
these. Whether for legacy reasons, or to match guidelines for multiple languages in a single
project, different projects may have different style guidelines. Since the goal is consistency, you
should always abide by any style rules that are in place on the project you are contributing to.

If you do have a legacy project that is in source control and you decide to reformat code to adopt
these rules, try to make all of your whitespace changes in a single commit that does _nothing_ but
edit the whitespace. You should never reformat the whitespace on a file as _part_ of a content
change because it makes the changes hard to spot.

#### Capitalization Conventions

PowerShell is **not** case sensitive, but we follow capitalization conventions to make code easy to
read. They are based on the
[capitalization conventions](https://msdn.microsoft.com/en-us/library/ms229043) Microsoft created
for the .NET framework, since PowerShell is a .NET scripting language, and PowerShell cmdlets are
primarily written in .NET languages following those guidelines.

##### Terminology

* lowercase - all lowercase, no word separation
* UPPERCASE - all capitals, no word separation
* PascalCase - capitalize the first letter of each word
* camelCase - capitalize the first letter of each word _except_ the first.

PowerShell uses PascalCase for _all_ public identifiers: module names, function or cmdlet names,
class, enum, and attribute names, public fields or properties, global variables and constants, etc.
In fact, since the _parameters_ to PowerShell commands are actually _properties_ of .Net classes,
even parameters use PascalCase rather than camelCase.

PowerShell language keywords are written in lower case (yes, even `foreach` and `dynamicparam`), as
well as operators such as `-eq` and `-match`. The keywords in comment-based help are written in
UPPERCASE to make it easy to spot them among the dense prose of documentation.

```powershell
function Write-Host {
    <#
    .SYNOPSIS
        Writes customized output to a host.
    .DESCRIPTION
        The Write-Host cmdlet customizes output. You can specify the color of text by using
        the ForegroundColor parameter, and you can specify the background color by using the
        BackgroundColor parameter. The Separator parameter lets you specify a string to use to
        separate displayed objects. The particular result depends on the program that is
        hosting Windows PowerShell.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromRemainingArguments = $true)]
        [psobject]$Object,

        [switch]$NoNewline,

        [psobject]$Separator,

        [System.ConsoleColor]$ForegroundColor,

        [System.ConsoleColor]$BackgroundColor
    )
    begin {
    ...
```

As stated previously, PowerShell uses PascalCase for _all_ public identifiers. Function names should
follow PowerShell's `Verb-Noun` naming conventions, using PascalCase within both Verb and Noun.

A special case is made for two-letter acronyms in which both letters are capitalized, as in the
variable `$PSBoundParameters` or the command `Get-PSDrive`. Note that
([as specified in the .NET guidelines](https://msdn.microsoft.com/en-us/library/ms229043#Anchor_1))
this does not affect the commonly capitalized (but not acronym) words "OK" and "ID" . You should
also not extend it to compound acronyms, such as when Azure's Resource Manager (RM) meets a Virtual
Machine (VM) in `Start-AzureRmVM`...

> We are aware that there are **many** places where these conventions have not been followed
> properly for various reasons -- you should consider these _exceptions_ (such as for COM interop)
> or _mistakes_ (such as `System.Data.SqlClient.SQLDebugging`), but not a reason for you to
> disregard the conventions.

If you wish, you may use camelCase for variables within your functions (or modules) to distinguish
_private_ variables from parameters, but this is a matter of taste. Shared variables should be
distinguished by using their scope name, such as `$Script:PSBoundParameters` or
`$Global:DebugPreference`. If you are using camelCase for a variable that starts with a two-letter
acronym (where both letters are capitalized), both letters should be set to lowercase (such as
`adComputer`).

#### One True Brace Style

This guide recommends the so-called
["One True Brace Style" variant to K&R](https://github.com/PoshCode/PowerShellPracticeAndStyle/issues/81#issuecomment-285835313),
which requires that every braceable _statement_ should have the opening brace on the _end of a
line_, and the closing brace at the _beginning of a line_.

There is one notable exception when passing small scriptblocks to parameters (where K&R would allow
leaving off the braces entirely), we allow putting the entire statement on a single line.

```powershell
enum Color {
    Black,
    White
}

function Test-Code {
    [CmdletBinding()]
    param (
        [int]$ParameterOne
    )
    end {
        if (10 -gt $ParameterOne) {
            "Greater"
        } else {
            "Lesser"
        }
    }
}

# An Exception case:
Get-ChildItem | Where-Object { $_.Length -gt 10mb }
```

The primary reason for this recommendation is practical: there are no exceptions necessary when
following this rule, and when code is written following this style, _new lines_ of code can be
inserted between any two lines with no risk of accidentally breaking the code by separating braces
from their statement blocks. Thus, it's easier to follow, and makes errors less likely.

Because this choice was somewhat contentious in the community (about 1/3 of voters opposed), it's
worth adding some addition reasoning here: First: in some historical consoles, it was necessary to
write this way, so much of the early PowerShell code follows this style anyway. Second: PowerShell
functions which accept scriptblocks (such as `ForEach-Object` and `Where-Object`) are common, and an
_inherent_ part of the syntax of important PowerShell-based domain-specific languages such as DSC.
Since it's **required** to place the opening brace on the end of the line in those cases, the only
_consistent_ option is to follow OTBS.

#### Always Start With CmdletBinding

All of your scripts or functions should start life as something like this snippet:

```powershell
[CmdletBinding()]
param ()
process {
}
end {
}
```

You can always delete or ignore one of the blocks (or add the `begin` block), add parameters and
necessary validation and so on, but you should **avoid** writing scripts or functions without
`[CmdletBinding()]`, and you should always at least _consider_ making it take pipeline input.

#### Prefer: param (), begin, process, end

Having a script written in the order of execution makes the intent clearer. Since there is no
functional reason to have these blocks out of order (they _will_ still be executed in the normal
order), writing them out of order can be confusing, and makes code more difficult to maintain and
debug.

More explicit code is more maintainable. While PowerShell allows leaving off the explicit name of
the `end` block (and even has a `filter` keyword that converts the anonymous block to a `process`
block), we recommend against using these features as it results in less explicit code.

#### Indentation

##### Use four *spaces* per indentation level

Usually you will press the `[Tab]` key to indent, but most editors can be configured to insert
spaces instead of actual tab characters. For most programming languages and editors (including
PowerShell ISE) the default is four spaces, and that's what we recommend. Different teams and
projects may have different standards, and when contributing to a project, you should abide by the
predominant style, of course.

```powershell
function Test-Code {
    foreach ($exponent in 1..10) {
        [Math]::Pow(2, $exponent)
    }
}
```

Indenting more than 4-spaces is acceptable for continuation lines (when you're wrapping a line which
was too long). In such cases you might indent more than one level, or even indent indent an odd
number of spaces to line up with a method call or parameter block on the line before.

```powershell
function Test-Code {
    foreach ($base in 1,2,4,8,16) {
        foreach ($exponent in 1..10) {
            [System.Math]::Pow($base,
                               $exponent)
    }
}
```

#### Maximum Line Length

Limit lines to 115 characters when possible.

Keeping lines to a small width allows scripts to be read in _one_ direction (top to bottom) without
scrolling back-and-forth horizontally. What, exactly, this width should be is a one of the favorite
arguing points among developers on the internet (more splintered than emacs vs vi or gnu GPL vs
MIT).

In this guide we use two particular sources for the maximum line width:

The PowerShell console is, by default, 120 characters wide, but it allows only 119 characters on
output lines, and when entering multi-line text, PowerShell uses a line continuation prompt: `>>>`
and thus limits your line length to 116 anyway.

Github's current maximum line width varies between 121 and 126 depending on your browser and OS (and
thus, font). However, the 115 line length suggested by PowerShell would be enough to even allow
side-by-side diffs to be displayed without scrolling or wrapping on the current "standard" 1080p
monitor.

Again, this is a particularly flexible rule, and you should always follow the guidelines of projects
when you're contributing to other people's projects. Although most of us work on widescreen
monitors, not everyone can see well without magnification or extremely large fonts.

The preferred way to avoid long lines is to use splatting (see
[Get-Help about_Splatting](https://technet.microsoft.com/en-us/library/jj672955.aspx)) and
PowerShell's implied line continuation inside parentheses, brackets, and braces -- these should
**always** be used in preference to the backtick for line continuation when applicable, even for
strings:

```powershell
Write-Host -Object ("This is an incredibly important, and extremely long message. " +
                         "We cannot afford to leave any part of it out, " +
                         "nor do we want line-breaks in the output. " +
                         "Using string concatenation lets us use short lines here, " +
                         "and still get a long line in the output")
```

#### Blank Lines and Whitespace

Surround function and class definitions with _two_ blank lines.

Method definitions within a class are surrounded by a single blank line.

Blank lines may be omitted between a bunch of related one-liners (e.g. empty functions)

Additional blank lines may be used sparingly to separate groups of related functions, or within
functions to indicate logical sections (e.g. before a block comment).

End each file with a single blank line.

#### Trailing spaces

Lines should not have trailing whitespace. Extra spaces result in future edits where the only change
is a space being added or removed, making the analysis of the changes more difficult for no reason.

#### Spaces around parameters and operators

You should use a single space around parameter names and operators, including comparison operators
and math and assignment operators, even when the spaces are not necessary for PowerShell to
correctly parse the code.

One notable exception is when using colons to pass values to switch parameters:

```PowerShell
# Do not write:
$variable=Get-Content $FilePath -Wait:($ReadCount-gt0) -First($ReadCount*5)

# Instead write:
$variable = Get-Content -Path $FilePath -Wait:($ReadCount -gt 0) -TotalCount ($ReadCount * 5)
```

Another exception is when using
[Unary Operators](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators#unary-operators):

```PowerShell
# Do not write:
$yesterdaysDate = (Get-Date).AddDays( - 1)

$i = 0
$i ++

# Instead write:
$yesterdaysDate = (Get-Date).AddDays(-1)

$i = 0
$i++

# Same principle should be applied when using a variable.
$yesterdaysDate = (Get-Date).AddDays(-$i)
```

#### Spaces around special characters

White-space is (mostly) irrelevant to PowerShell, but its proper use is key to writing easily
readable code.

Use a single space after commas and semicolons, and around pairs of curly braces.

Subexpressions `$( ... )` and scriptblocks `{ ... }` should have a single space on the _inside_ of
the braces or parentheses to improve readability by making code blocks stand out -- and to further
distinguish scriptblocks from variable delimiter braces `${...}`

Avoid unnecessary spaces inside parenthesis or square braces.

```powershell
$Var = 1
"This is a string with one (${Var}) delimited variable."

"There are $( (Get-ChildItem).Count ) files."
```

Obviously, these rules should not be applied in such a way as to affect output.

#### Avoid Using Semicolons (`;`) as Line Terminators

PowerShell will not complain about extra semicolons, but they are unnecessary, and can get in the
way when code is being edited or copy-pasted. They also result in extra do-nothing edits in source
control when someone finally decides to delete them.

They are also unnecessary when declaring hashtables if you are already putting each element on its
own line:

```PowerShell
# This is the preferred way to declare a hashtable if it extends past one line:
$Options = @{
    Margin   = 2
    Padding  = 2
    FontSize = 24
}
```

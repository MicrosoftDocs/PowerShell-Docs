# Writing Parameter Blocks

## Always write Help

For every script and function you should have a comment-based help block (we recommend using a block
comment). The best place for these is _inside_ the `function` above the `param` block, but they can
also be placed _above_ the function, or at the bottom just before closing.

In order for it to register as help, you must provide a `.SYNOPSIS` and/or `.DESCRIPTION`

### Always Write Examples

You should also always provide at least one example (even if your function doesn't take parameters),
where you show the output (or the need to capture it), and explain what happens when the command is
run. Note that examples should have the _code_ first, and the _documentation_ of what it does after
an empty line or two.


```PowerShell
function Test-Help {
    <#
        .SYNOPSIS
            An example function to display how help should be written.

        .EXAMPLE
            Test-Help -Name Test-Help

            This tests the help for the Test-Help function.
    #>
    [CmdletBinding()]
    param (
        # This parameter doesn't do anything, but you must provide a value
        # Aliases: MP
        [Parameter(Mandatory = $true)]
        [Alias("MP")]
        [String]$MandatoryParameter
    )

    <# code here ... #>
}
```
### Always Document Every Parameter

You should always provide at least a brief explanation of each parameter, what it's expected or
allowed values are, etc.

The best place for this is a simple comment directly above the parameter (inside the param block) so
you don't forget to update it if you remove, rename, or otherwise change the parameter, but you can
also place them in the comment help block by using `.PARAMETER ParameterName` and writing the help
on the next line.

## You should specify `[CmdletBinding()]`

CmdletBinding makes functions and scripts behave like the built-in commands, adding support for the
"common" output parameters like `-Verbose` and `-ErrorAction` and supporting `-?` for help. If you
don't support it, you risk someone _accidentally_ running your code when they were just trying to
`Get-Help` on it.

There are a few specific advanced cases where you might want to write an old-fashioned script that
doesn't use CmdletBinding() -- they are very rare, and are all exceptions to the best practices, so
we won't go into them further.

## You should pick a default ParameterSet

If you have more than one ParameterSetName on your parameters, you should specify one of them as the
`DefaultParameterSetName` in the CmdletBinding.

## You should support --whatif

If you write a command that changes state, you should probably add `SupportsShouldProcess` to your
CmdletBinding. This allows users to specify `-WhatIf` and `-Confirm` when calling your command, so
you'll need to actually support those by using `$PSCmdlet.ShouldProcess(...)` or
`$PSCmdlet.ShouldContinue(...)` or by passing the preference variable on to other commands you're
calling (e.g. `-Whatif:$WhatIfPreference`).

Here's an example of what that might look like:

```PowerShell
# NOTE: ConfirmImpact defaults to Medium
# But I recommend setting ConfirmImpact explicitly as a reminder :)
[CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Medium")]
param([switch]$Force)

# You need to pre-define these (because they're passed by [ref])
$RejectAll = $false;
$ConfirmAll = $false;

# Note: please don't actually do this with services, restarting them in non-dependency order would be a nightmare...
foreach ($service in Get-Service | Where Status -eq "Running") {
    # This will normally automatically be TRUE. It will only query if the user:
    # 1. Has their $ConfirmPreference (default High) set LOWER or equal to the ConfirmImpact in the cmdlet binding (default Medium)
    # 2. Passes -Confirm, which sets the $ConfirmPreference in the function's scope to Low
    if ($PSCmdlet.ShouldProcess( "Restarted the service '$($service.Name)'",
                                 "Restart the '$($service.DisplayName)' service ($($service.Name))?",
                                 "Restarting Services" )) {

        # If you use ShouldContinue, have a -Force parameter that bypasses it
        # And if you know there may be multiple prompts, you should use this overload that supports the Confirm/Reject "All" option
        # In this example, we're only prompting when there are dependent services, and otherwise restart without additional prompting
        if ($Force -Or $service.DependentServices.Count -eq 0 -or $PSCmdlet.ShouldContinue(
                                            "$($service.Name) has $($service.DependentServices.Count) dependent services. Are you sure?",
                                            "Restarting the '$($service.DisplayName)' service",
                                            [ref]$ConfirmAll,
                                            [ref]$RejectAll)) {
            "(Not actually) restarting $($service.DisplayName)"
        }
    }
}
```

## You should strongly type parameters

Although PowerShell is a dynamic language, we can specify types, and in parameters, it's
particularly useful.

First, because it hints to users what sort of values they can pass to your command. Is it numeric?
Text? An object?

Second, because using types on parameters helps validate the input, which is crucial because
parameters are where you get your user input. Strong types can help you avoid code injection and
other problems with user inputs, and will allow failures to happen as early as possible (even before
your command is called).

Additionally, when passing on parameters to another command, you should be _at least_ as strongly
typed as the other command, to avoid casting exceptions within your script.

### Be careful with `[string]` or `[object]` (and `[PSObject]`)

Obviously [string] is one of the most common parameter types, and [object] is the default type.
However, because anything can be cast to these types, you should avoid combining these types with
parameters that are designed to differentiate parameter sets, or that accept `ValueFromPipeline`
because PowerShell will coerce _everything_ to that.

Obviously if you want to accept more than one type of object on the same parameter, you have to use
`[object]` or `[PSObject]` as the universal base types. You have to be very careful when doing this,
and normally should use a `ValidateScript` to ensure the objects are one of your _actual_ supported
types.

### Using [pscredential]

When you need to accept credentials, you almost always want to name the parameter `$Credential` and
accept a
[System.Management.Automation.PSCredential](https://docs.microsoft.com/en-us/dotnet/api/System.Management.Automation.PSCredential),
which has special support in PowerShell for automatically coercing user names to credentials and
more.

In old versions of PowerShell, you needed to manually decorate these PSCredential parameters with
`[System.Management.Automation.CmdletAttribute()]` in order to automatically coerce user names to
credentials -- that is, to support the use case where someone writes `-Credential Jaykul` and is
automatically prompted for the password using the secure credential prompt. In current versions,
this is automatically added when you use the PSCredential type.

### Using [switch]

Parameters of type `[switch]` support passing as switches (without a value), and by default cannot be passed by position.

- Switch parameters should not be given default values. They should always default to false.
- Switch parameters should be designed so that setting them moves a command from its default
  functionality to a less common or more complicated mode.
- Switch parameters should be treated as boolean values in your scripts. Corrolary: you should not
  write logic that depends on whether or not the user explicitly passed a value to a switch -- do
  not attempt to treat a switch as having three states!
- When you need to pass the value of a switch on to another command, you can either splat it, or
  specify it using the colon syntax for parameters, as in `-TheirSwitch:$MySwitch`

## Be generous with accept ValueFromPipelineByPropertyName

For the most flexibility, whenever it's practical, you should write your commands to accept their
parameters from the pipeline _by property name_. To enhance your ability to match objects, you can
add aliases for the parameter name using the `[Alias()]` attribute.

Don't forget that values set from the pipeline are only available in the `process` block.

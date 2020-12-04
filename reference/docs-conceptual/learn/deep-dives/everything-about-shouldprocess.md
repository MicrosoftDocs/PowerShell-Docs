---
title: Everything you wanted to know about ShouldProcess
description: ShouldProcess is an important feature that is often overlooked is. The WhatIf and Confirm parameters make it easy to add to your functions.
ms.date: 05/23/2020
ms.custom: contributor-KevinMarquette
---
# Everything you wanted to know about ShouldProcess

PowerShell functions have several features that greatly improve the way users interact with them.
One important feature that is often overlooked is `-WhatIf` and `-Confirm` support and it's easy to
add to your functions. In this article, we dive deep into how to implement this feature.

> [!NOTE]
> The [original version][] of this article appeared on the blog written by [@KevinMarquette][]. The
> PowerShell team thanks Kevin for sharing this content with us. Please check out his blog at
> [PowerShellExplained.com][].

This is a simple feature you can enable in your functions to provide a safety net for the users that
need it. There's nothing scarier than running a command that you know can be dangerous for the
first time. The option to run it with `-WhatIf` can make a big difference.

## CommonParameters

Before we look at implementing these [common parameters][], I want to take a quick look at how
they're used.

## Using -WhatIf

When a command supports the `-WhatIf` parameter, it allows you to see what the command would have
done instead of making changes. it's a good way to test out the impact of a command, especially
before you do something destructive.

```powershell
PS C:\temp> Remove-Item -Path .\myfile1.txt -WhatIf
What if: Performing the operation "Remove File" on target "C:\Temp\myfile1.txt".
```

If the command correctly implements `ShouldProcess`, it should show you all the changes that it
would have made. Here is an example using a wildcard to delete multiple files.

```powershell
PS C:\temp> Remove-Item -Path * -WhatIf
What if: Performing the operation "Remove File" on target "C:\Temp\myfile1.txt".
What if: Performing the operation "Remove File" on target "C:\Temp\myfile2.txt".
What if: Performing the operation "Remove File" on target "C:\Temp\importantfile.txt".
```

## Using -Confirm

Commands that support `-WhatIf` also support `-Confirm`. This gives you a chance confirm an action
before performing it.

```powershell
PS C:\temp> Remove-Item .\myfile1.txt -Confirm

Confirm
Are you sure you want to perform this action?
Performing the operation "Remove File" on target "C:\Temp\myfile1.txt".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"):
```

In this case, you have multiple options that allow you to continue, skip a change, or stop the
script. The help prompt describes each of those options like this.

```Output
Y - Continue with only the next step of the operation.
A - Continue with all the steps of the operation.
N - Skip this operation and proceed with the next operation.
L - Skip this operation and all subsequent operations.
S - Pause the current pipeline and return to the command prompt. Type "exit" to resume the pipeline.
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"):
```

### Localization

This prompt is localized in PowerShell so the language changes based on the language of your
operating system. This is one more thing that PowerShell manages for you.

### Switch parameters

Let's take quick moment to look at ways to pass a value to a switch parameter. The main reason I
call this out is that you often want to pass parameter values to functions you call.

The first approach is a specific parameter syntax that can be used for all parameters but you mostly
see it used for switch parameters. You specify a colon to attach a value to the parameter.

```powershell
Remove-Item -Path:* -WhatIf:$true
```

You can do the same with a variable.

```powershell
$DoWhatIf = $true
Remove-Item -Path * -WhatIf:$DoWhatIf
```

The second approach is to use a hashtable to splat the value.

```powershell
$RemoveSplat = @{
    Path = '*'
    WhatIf = $true
}
Remove-Item @RemoveSplat
```

If you're new to hashtables or splatting, I have another article on that covers
[everything you wanted to know about hashtables][].

## SupportsShouldProcess

The first step to enable `-WhatIf` and `-Confirm` support is to specify `SupportsShouldProcess` in
the `CmdletBinding` of your function.

```powershell
function Test-ShouldProcess {
    [CmdletBinding(SupportsShouldProcess)]
    param()
    Remove-Item .\myfile1.txt
}
```

By specifying `SupportsShouldProcess` in this way, we can now call our function with `-WhatIf` (or
`-Confirm`).

```powershell
PS> Test-ShouldProcess -WhatIf
What if: Performing the operation "Remove File" on target "C:\Temp\myfile1.txt".
```

Notice that I did not create a parameter called `-WhatIf`. Specifying `SupportsShouldProcess`
automatically creates it for us. When we specify the `-WhatIf` parameter on `Test-ShouldProcess`,
some things we call also perform `-WhatIf` processing.

### Trust but verify

There's some danger here trusting that everything you call inherits `-WhatIf` values. For the rest
of the examples, I'm going to assume that it doesn't work and be very explicit when making calls
to other commands. I recommend that you do the same.

```powershell
function Test-ShouldProcess {
    [CmdletBinding(SupportsShouldProcess)]
    param()
    Remove-Item .\myfile1.txt -WhatIf:$WhatIfPreference
}
```

I will revisit the nuances much later once you have a better understanding of all the pieces in
play.

## $PSCmdlet.ShouldProcess

The method that allows you to implement `SupportsShouldProcess` is `$PSCmdlet.ShouldProcess`. You
call `$PSCmdlet.ShouldProcess(...)` to see if you should process some logic and PowerShell takes
care of the rest. Let's start with an example:

```powershell
function Test-ShouldProcess {
    [CmdletBinding(SupportsShouldProcess)]
    param()

    $file = Get-ChildItem './myfile1.txt'
    if($PSCmdlet.ShouldProcess($file.Name)){
        $file.Delete()
    }
}
```

The call to `$PSCmdlet.ShouldProcess($file.name)` checks for the `-WhatIf` (and `-Confirm`
parameter) then handles it accordingly. The `-WhatIf` causes `ShouldProcess` to output a
description of the change and return `$false`:

```powershell
PS> Test-ShouldProcess -WhatIf
What if: Performing the operation "Test-ShouldProcess" on target "myfile1.txt".
```

A call using `-Confirm` pauses the script and prompts the user with the option to continue. It
returns `$true` if the user selected `Y`.

```powershell
PS> Test-ShouldProcess -Confirm
Confirm
Are you sure you want to perform this action?
Performing the operation "Test-ShouldProcess" on target "myfile1.txt".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"):
```

An awesome feature of `$PSCmdlet.ShouldProcess` is that it doubles as verbose output. I depend on
this often when implementing `ShouldProcess`.

```powershell
PS> Test-ShouldProcess -Verbose
VERBOSE: Performing the operation "Test-ShouldProcess" on target "myfile1.txt".
```

### Overloads

There are a few different overloads for `$PSCmdlet.ShouldProcess` with different parameters for
customizing the messaging. We already saw the first one in the example above. Let's take a closer
look at it.

```powershell
function Test-ShouldProcess {
    [CmdletBinding(SupportsShouldProcess)]
    param()

    if($PSCmdlet.ShouldProcess('TARGET')){
        # ...
    }
}
```

This produces output that includes both the function name and the target (value of the parameter).

```powershell
What if: Performing the operation "Test-ShouldProcess" on target "TARGET".
```

Specifying a second parameter as the operation uses the operation value instead of the function
name in the message.

```powershell
## $PSCmdlet.ShouldProcess('TARGET','OPERATION')
What if: Performing the operation "OPERATION" on target "TARGET".
```

The next option is to specify three parameters to fully customize the message. When three parameters
are used, the first one is the entire message. The second two parameters are still used in the
`-Confirm` message output.

```powershell
## $PSCmdlet.ShouldProcess('MESSAGE','TARGET','OPERATION')
What if: MESSAGE
```

### Quick parameter reference

Just in case you came here only to figure out what parameters you should use, here is a quick
reference showing how the parameters change the message in the different `-WhatIf` scenarios.

```powershell
## $PSCmdlet.ShouldProcess('TARGET')
What if: Performing the operation "FUNCTION_NAME" on target "TARGET".

## $PSCmdlet.ShouldProcess('TARGET','OPERATION')
What if: Performing the operation "OPERATION" on target "TARGET".

## $PSCmdlet.ShouldProcess('MESSAGE','TARGET','OPERATION')
What if: MESSAGE
```

I tend to use the one with two parameters.

### ShouldProcessReason

We have a fourth overload that's more advanced than the others. It allows you to get the reason
`ShouldProcess` was executed. I'm only adding this here for completeness because we can just check
if `$WhatIfPreference` is `$true` instead.

```powershell
$reason = ''
if($PSCmdlet.ShouldProcess('MESSAGE','TARGET','OPERATION',[ref]$reason)){
    Write-Output "Some Action"
}
$reason
```

We have to pass the `$reason` variable into the fourth parameter as a reference variable with
`[ref]`. `ShouldProcess` populates `$reason` with the value `None` or `WhatIf`. I didn't say this
was useful and I have had no reason to ever use it.

### Where to place it

You use `ShouldProcess` to make your scripts safer. So you use it when your scripts are making
changes. I like to place the `$PSCmdlet.ShouldProcess` call as close to the change as possible.

```powershell
## general logic and variable work
if ($PSCmdlet.ShouldProcess('TARGET','OPERATION')){
    # Change goes here
}
```

If I'm processing a collection of items, I call it for each item. So the call gets placed inside
the foreach loop.

```powershell
foreach ($node in $collection){
    # general logic and variable work
    if ($PSCmdlet.ShouldProcess($node,'OPERATION')){
        # Change goes here
    }
}
```

The reason why I place `ShouldProcess` tightly around the change, is that I want as much code to
execute as possible when `-WhatIf` is specified. I want the setup and validation to run if possible
so the user gets to see those errors.

I also like to use this in my Pester tests that validate my projects. If I have a piece of logic
that is hard to mock in pester, I can often wrap it in `ShouldProcess` and call it with `-WhatIf` in
my tests. It's better to test some of your code than none of it.

### $WhatIfPreference

The first preference variable we have is `$WhatIfPreference`. This is `$false` by default. If you
set it to `$true` then your function executes as if you specified `-WhatIf`. If you set this in
your session, all commands perform `-WhatIf` execution.

When you call a function with `-WhatIf`, the value of `$WhatIfPreference` gets set to `$true` inside
the scope of your function.

## ConfirmImpact

Most of my examples are for `-WhatIf` but everything so far also works with `-Confirm` to prompt the
user. You can set the `ConfirmImpact` of the function to high and it prompts the user as if it was
called with `-Confirm`.

```powershell
function Test-ShouldProcess {
    [CmdletBinding(
        SupportsShouldProcess,
        ConfirmImpact = 'High'
    )]
    param()

    if ($PSCmdlet.ShouldProcess('TARGET')){
        Write-Output "Some Action"
    }
}
```

This call to `Test-ShouldProcess` is performing the `-Confirm` action because of the `High` impact.

```powershell
PS> Test-ShouldProcess

Confirm
Are you sure you want to perform this action?
Performing the operation "Test-ShouldProcess" on target "TARGET".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): y
Some Action
```

The obvious issue is that now it's harder to use in other scripts without prompting the user. In
this case, we can pass a `$false` to `-Confirm` to suppress the prompt.

```powershell
PS> Test-ShouldProcess -Confirm:$false
Some Action
```

I'll cover how to add `-Force` support in a later section.

### $ConfirmPreference

`$ConfirmPreference` is an automatic variable that controls when `ConfirmImpact` asks you to
confirm execution. Here are the possible values for both `$ConfirmPreference` and `ConfirmImpact`.

- `High`
- `Medium`
- `Low`
- `None`

With these values, you can specify different levels of impact for each function. If you have
`$ConfirmPreference` set to a value higher than `ConfirmImpact`, then you aren't prompted to
confirm execution.

By default, `$ConfirmPreference` is set to `High` and `ConfirmImpact` is `Medium`. If you want your
function to automatically prompt the user, set your `ConfirmImpact` to `High`. Otherwise set it to
`Medium` if its destructive and use `Low` if the command is always safe run in production. If you
set it to `none`, it doesn't prompt even if `-Confirm` was specified (but it still gives you
`-WhatIf` support).

When calling a function with `-Confirm`, the value of `$ConfirmPreference` gets set to `Low` inside
the scope of your function.

### Suppressing nested confirm prompts

The `$ConfirmPreference` can get picked up by functions that you call. This can create scenarios
where you add a confirm prompt and the function you call also prompts the user.

What I tend to do is specify `-Confirm:$false` on the commands that I call when I have already
handled the prompting.

```powershell
function Test-ShouldProcess {
    [CmdletBinding(SupportsShouldProcess)]
    param()

    $file = Get-ChildItem './myfile1.txt'
    if($PSCmdlet.ShouldProcess($file.Name)){
        Remove-Item -Path $file.FullName -Confirm:$false
    }
}
```

This brings us back to an earlier warning: There are nuances as to when `-WhatIf` is not passed to a
function and when `-Confirm` passes to a function. I promise I'll get back to this later.

## $PSCmdlet.ShouldContinue

If you need more control than `ShouldProcess` provides, you can trigger the prompt directly with
`ShouldContinue`. `ShouldContinue` ignores `$ConfirmPreference`, `ConfirmImpact`, `-Confirm`,
`$WhatIfPreference`, and `-WhatIf` because it prompts every time it's executed.

At a quick glance, it's easy to confuse `ShouldProcess` and `ShouldContinue`. I tend to remember to
use `ShouldProcess` because the parameter is called `SupportsShouldProcess` in the `CmdletBinding`.
You should use `ShouldProcess` in almost every scenario. That is why I covered that method first.

Let's take a look at `ShouldContinue` in action.

```powershell
function Test-ShouldContinue {
    [CmdletBinding()]
    param()

    if($PSCmdlet.ShouldContinue('TARGET','OPERATION')){
        Write-Output "Some Action"
    }
}
```

This provides us a simpler prompt with fewer options.

```powershell
Test-ShouldContinue

Second
TARGET
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"):
```

The biggest issue with `ShouldContinue` is that it requires the user to run it interactively because
it always prompts the user. You should always be building tools that can be used by other
scripts. The way you do this is by implementing `-Force`. I'll revisit this idea later.

### Yes to all

This is automatically handled with `ShouldProcess` but we have to do a little more work for
`ShouldContinue`. There's a second method overload where we have to pass in a few values by
reference to control the logic.

```powershell
function Test-ShouldContinue {
    [CmdletBinding()]
    param()

    $collection = 1..5
    $yesToAll = $false
    $noToAll = $false

    foreach($target in $collection) {

        $continue = $PSCmdlet.ShouldContinue(
                "TARGET_$target",
                'OPERATION',
                [ref]$yesToAll,
                [ref]$noToAll
            )

        if ($continue){
            Write-Output "Some Action [$target]"
        }
    }
}
```

I added a `foreach` loop and a collection to show it in action. I pulled the `ShouldContinue` call
out of the `if` statement to make it easier to read. Calling a method with four parameters starts to
get a little ugly, but I tried to make it look as clean as I could.

## Implementing -Force

`ShouldProcess` and `ShouldContinue` need to implement `-Force` in different ways. The trick to
these implementations is that `ShouldProcess` should always get executed, but `ShouldContinue`
should not get executed if `-Force` is specified.

### ShouldProcess -Force

If you set your `ConfirmImpact` to `high`, the first thing your users are going to try is to
suppress it with `-Force`. That's the first thing I do anyway.

```powershell
Test-ShouldProcess -Force
Error: Test-ShouldProcess: A parameter cannot be found that matches parameter name 'force'.
```

If you recall from the `ConfirmImpact` section, they actually need to call it like this:

```powershell
Test-ShouldProcess -Confirm:$false
```

Not everyone realizes they need to do that and `-Force` doesn't suppress `ShouldContinue`.
So we should implement `-Force` for the sanity of our users. Take a look at this full example here:

```powershell
function Test-ShouldProcess {
    [CmdletBinding(
        SupportsShouldProcess,
        ConfirmImpact = 'High'
    )]
    param(
        [Switch]$Force
    )

    if ($Force){
        $ConfirmPreference = 'None'
    }

    if ($PSCmdlet.ShouldProcess('TARGET')){
        Write-Output "Some Action"
    }
}
```

We add our own `-Force` switch as a parameter. The `-Confirm` parameter is automatically added
when using `SupportsShouldProcess` in the `CmdletBinding`.

```powershell
[CmdletBinding(
    SupportsShouldProcess,
    ConfirmImpact = 'High'
)]
param(
    [Switch]$Force
)
```

Focusing in on the `-Force` logic here:

```powershell
if ($Force){
    $ConfirmPreference = 'None'
}
```

If the user specifies `-Force`, we want to suppress the confirm prompt unless they also specify
`-Confirm`. This allows a user to force a change but still confirm the change. Then we set
`$ConfirmPreference` in the local scope. Now, using the `-Force` parameter temporarily sets the
`$ConfirmPreference` to none, disabling prompt for confirmation.

```powershell
if ($Force -or $PSCmdlet.ShouldProcess('TARGET')){
        Write-Output "Some Action"
    }
```

If someone specifies both `-Force` and `-WhatIf`, then `-WhatIf` needs to take priority. This
approach preserves `-WhatIf` processing because `ShouldProcess` always gets executed.

Do not add a check for the `$Force` value inside the `if` statement with the `ShouldProcess`. That is
an anti-pattern for this specific scenario even though that's what I show you in the next section
for `ShouldContinue`.

### ShouldContinue -Force

This is the correct way to implement `-Force` with `ShouldContinue`.

```powershell
function Test-ShouldContinue {
    [CmdletBinding()]
    param(
        [Switch]$Force
    )

    if($Force -or $PSCmdlet.ShouldContinue('TARGET','OPERATION')){
        Write-Output "Some Action"
    }
}
```

By placing the `$Force` to the left of the `-or` operator, it gets evaluated first. Writing it
this way short circuits the execution of the `if` statement. If `$force` is `$true`, then the
`ShouldContinue` is not executed.

```powershell
PS> Test-ShouldContinue -Force
Some Action
```

We don't have to worry about `-Confirm` or `-WhatIf` in this scenario because they're not supported
by `ShouldContinue`. This is why it needs to be handled differently than `ShouldProcess`.

## Scope issues

Using `-WhatIf` and `-Confirm` are supposed to apply to everything inside your functions and
everything they call. They do this by setting `$WhatIfPreference` to `$true` or setting
`$ConfirmPreference` to `Low` in the local scope of the function. When you call another function,
calls to `ShouldProcess` use those values.

This actually works correctly most of the time. Anytime you call built-in cmdlet or a function in
your same scope, it works. It also works when you call a script or a function in a script module
from the console.

The one specific place where it doesn't work is when a script or a script module calls a function in
another script module. This may not sound like a big problem, but most of the modules you create or
pull from the PSGallery are script modules.

The core issue is that script modules do not inherit the values for `$WhatIfPreference` or
`$ConfirmPreference` (and several others) when called from functions in other script modules.

The best way to summarize this as a general rule is that this works correctly for binary modules and
never trust it to work for script modules. If you aren't sure, either test it or just assume it
doesn't work correctly.

I personally feel this is very dangerous because it creates scenarios where you add `-WhatIf`
support to multiple modules that work correctly in isolation, but fail to work correctly when they
call each other.

We do have a GitHub RFC working to get this issue fixed. See
[Propagate execution preferences beyond script module scope][RFC] for more details.

## In closing

I have to look up how to use `ShouldProcess` every time I need to use it. It took me a long time to
distinguish `ShouldProcess` from `ShouldContinue`. I almost always need to look up what parameters
to use. So don't worry if you still get confused from time to time. This article will be here when
you need it. I'm sure I will reference it often myself.

If you liked this post, please share your thoughts with me on Twitter using the link below. I always
like hearing from people that get value from my content.

<!-- link references -->
[original version]: https://powershellexplained.com/2020-03-15-Powershell-shouldprocess-whatif-confirm-shouldcontinue-everything/
[powershellexplained.com]: https://powershellexplained.com/
[@KevinMarquette]: https://twitter.com/KevinMarquette
[common parameters]: /powershell/module/microsoft.powershell.core/about/about_commonparameters
[everything you wanted to know about hashtables]: everything-about-hashtable.md
[RFC]: https://github.com/PowerShell/PowerShell-RFC/pull/221#issuecomment-592954839

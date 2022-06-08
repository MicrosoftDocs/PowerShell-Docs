# ERR-01 Use -ErrorAction Stop when calling cmdlets

When trapping an error, try to use -ErrorAction Stop on cmdlets to generate terminating, trappable
exceptions.

# ERR-02 Use $ErrorActionPreference = 'Stop' or 'Continue' when calling non-cmdlets

When executing something other than a cmdlet, set $ErrorActionPreference = 'Stop' before executing,
and re-set to Continue afterwards. If you're concerned about using -ErrorAction because it will bail
on the entire pipeline, then you've probably over-constructed the pipeline. Consider using a more
scripting-construct-style approach, because those approaches are inherently better for automated
error handling.

Ideally, whatever command or code you think might bomb should be dealing with one thing: querying
one computer, deleting one file, updating one user. That way, if an error occurs, you can handle it
and then get on with the next thing.

# ERR-03 Avoid using flags to handle errors

Try to avoid setting flags:

```PowerShell
try {
    $continue = $true
    Do-Something -ErrorAction Stop
} catch {
    $continue = $false
}

if ($continue) {
    Do-This
    Set-That
    Get-Those
}
```

Instead, put the entire "transaction" into the Try block:

```PowerShell
try {
    Do-Something -ErrorAction Stop
    Do-This
    Set-That
    Get-Those
} catch {
    Handle-Error
}
```

It's a lot easier to follow the logic.

# ERR-04 Avoid using $?

When you need to examine the error that occurred, try to avoid using $?. It actually doesn't mean an
error did or did not occur; it's reporting whether or not the last-run command considered itself to
have completed successfully. You get no details on what happened.


# ERR-05 Avoid testing for a null variable as an error condition

Also try to avoid testing for a null variable as an error condition:

```
$user = Get-ADUser -Identity DonJ

if ($user) {
    $user | Do-Something
} else {
    Write-Warning "Could not get user $user"
}
```

There are times and technologies where that's the only approach that will work, especially if the
command you're running won't produce a terminating, trappable exception. But it's a logically
contorted approach, and it can make debugging trickier.

# ERR-06 Copy $Error[0] to your own variable

Within a `catch` block, `$_` will contain the last error that occurred, as will `$Error[0]`. Use
either - but immediately copy them into your own variable, as executing additional commands can
cause `$_` to get "hijacked" or `$Error[0]` to contain a different error.

It isn't necessary to clear `$Error` in most cases. `$Error[0]` will be the last error, and
PowerShell will maintain the rest of the `$Error` collection automatically.

# VER-01 Write for the lowest version of PowerShell that you can

As a rule, write for the lowest PowerShell version that you can, especially with scripts that you
plan to share with others. Doing so provides the broadest compatibility for other folks.

That said, don't sacrifice functionality or performance just to stick with an older version. If you
can safely write for a higher version (meaning you've deployed it everywhere the script will need to
run), then take advantage of that version. Keep in mind that some newer features that seem like
window dressing might actually have underlying performance benefits. For example, in PowerShell v3:

```PowerShell
Get-Service | Where-Object -FilterScript { $\_.Status -eq 'Running' }
```

Will run significantly slower than:

```PowerShell
Get-Service | Where Status -eq Running
```

because of the way the two different syntaxes have to be processed under the hood.

_Further information:_ You can get some detail on the differences between versions of Powershell by
typing `help about\Windows\PowerShell\2.0` (or 3.0 or 4.0) in Powershell

# VER-02 Document the version of PowerShell the script was written for

All that said, make sure you specify the version of PowerShell you wrote for by using an appropriate
`#requires` statement:

```PowerShell
#requires -version 3.0
```

The `#requires` statement will prevent the script from running on the wrong version of PowerShell.

### PowerShell Supported Version

When working in an environment where there are multiple versions of PowerShell make sure to specify
the lowest version your script will support by prividing a Requires statement at the top of the
script.

```PowerShell
    #Requires -Version 2.0
```

When a _module_ uses specific cmdlets or syntax that is only present on a specific minimum version
of PowerShell in the module manifest ps1d file.

```PowerShell
    PowerShellVersion = '3.0'
```

### Naming Conventions

In general, prefer the use of full explicit names for commands and parameters rather than aliases or
short forms. There are tools like
[PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer)'s `Invoke-Formatter` and scripts
like
[Expand-Alias](https://github.com/PoshCode/ModuleBuilder/blob/master/PotentialContribution/ResolveAlias.psm1)
for fixing many, but not all of these issues.

#### Use the full name of each command.

Every PowerShell scripter learns the actual command names, but different people learn and use
different aliases (e.g.: ls for Linux users, dir for DOS users, gci ...). In your shared scripts you
should use the more universally known full command name. As a bonus, sites like GitHub will
highlight commands properly when you use the full Verb-Noun name:

```PowerShell
# Do not write:
gps -Name Explorer

# Instead write:
Get-Process -Name Explorer
```

#### Use full parameter names.

Because there are so many commands in PowerShell, it's impossible for every scripter to know every
command. Therefore it's useful to be explicit about your parameter names for the sake of readers who
may be unfamiliar with the command you're using. This will also help you avoid bugs if a future
change to the command alters the parameter sets.

```PowerShell
# Do not write:
Get-Process Explorer

# Instead write:
Get-Process -Name Explorer
```

#### Use full, explicit paths when possible.

When writing scripts, it is only safe to use `..` or `.` in a path if you have previously set the
location explicitly (within the current function or script). Even if you _have_ explictly set the
path, you must beware of using relative paths when calling .Net methods or legacy/native
applications, because they will use `[Environment]::CurrentDirectory` which is not automatically
updated to PowerShell's present working directory (`$PWD`).

Because troubleshooting these types of errors is tedious (and they are easy to over-look) it's best
to avoid using relative paths altogether, and instead, base your paths off of $PSScriptRoot (the
folder your script is in) when necessary.

```PowerShell
# Do not write:
Get-Content .\README.md

# Especially do not write:
[System.IO.File]::ReadAllText(".\README.md")


# Although you can write:
Push-Location $PSScriptRoot
Get-Content README.md

# It would be better to write:
Get-Content -Path (Join-Path -Path $PSScriptRoot -ChildPath README.md)
# Or to use string concatenation:
Get-Content "$PSScriptRoot\README.md"

# For calling .net methods, pass full paths:
[System.IO.File]::ReadAllText("$PSScriptRoot\README.md")

# Optionally by calling Convert-Path
Push-Location $PSScriptRoot
[System.IO.File]::ReadAllText((Convert-Path README.md))

```

##### Avoid the use of `~` to represent the home folder.

The meaning of ~ is unfortunately dependent on the "current" provider at the time of execution. This
isn't really a style issue, but it's an important rule for code you intend to share anyway. Instead,
use `${Env:UserProfile}` or `(Get-PSProvider -PSProvider FileSystem).Home` ...

```PowerShell
PS C:\Windows\system32> cd ~
PS C:\Users\Name> cd HKCU:\Software
PS HKCU:\Software> cd ~
cd : Home location for this provider is not set. To set the home location, call "(Get-PSProvider 'Registry').Home = 'path'".
At line:1 char:1
+ cd ~
+ ~~~~
    + CategoryInfo          : InvalidOperation: (:) [Set-Location], PSInvalidOperationException
    + FullyQualifiedErrorId : InvalidOperation,Microsoft.PowerShell.Commands.SetLocationCommand
```


#### See also the Capitalization Conventions

In the Code Layout and Formatting chapter, there is a section on
[capitalization conventions](Code-Layout-and-Formatting.md#Capitalization-Conventions).

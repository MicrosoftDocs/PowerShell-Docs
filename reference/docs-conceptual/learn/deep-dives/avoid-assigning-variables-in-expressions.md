---
description: This article covers the limitations of assigning variables in expressions.
ms.custom: wiki-migration
ms.date: 11/16/2022
title: Avoid assigning variables in expressions
---
# Avoid assigning variables in expressions

PowerShell allows you to use assignments within expressions by enclosing the assignment in
parentheses `()`. PowerShell passes the assigned value through. For example:

```powershell
# In an `if` conditional
if ($foo = Get-Item $PROFILE) { "$foo exists" }

# Property access
($profileFile = Get-Item $PROFILE).LastWriteTime

# You can even *assign* to such expressions.
($profileFile = Get-Item $PROFILE).LastWriteTime = Get-Date
```

> [!NOTE]
> While this syntax is allowed, its use is discouraged. There are cases where this does not work and
> the intent of the code author can be confusing to other code reviewers.

## Limitations

The assignment case doesn't always work. When it doesn't work, the assignment is discarded. If you
create an instance of a _mutable_ value type and attempt to both save the instance in a variable and
modify one of its properties in the same expression, the property assignment is discarded.

```powershell
# create mutable value type
PS> Add-Type 'public struct Foo { public int x; }'

# Create an instance, store it in a variable, and try to modify its property.
# This assignment is effectively IGNORED.
PS> ($var = [Foo]::new()).x = 1
PS> $var.x
0
```

The difference is that you can't return a reference to the value. Essentially,
`($var = [Foo]::new())` is equivalent to `$($var = [Foo]::new(); $var)`. You're no longer performing
a member access on the variable you're performing a member access on the variable's output, which is
a copy.

The workaround is to create the instance and save it in a variable first, and then assign to the
property via the variable:

```powershell
# create mutable value type
PS> Add-Type 'public struct Foo { public int x; }'

# Create an instance and store it in a variable first
# and then modify its property via the variable.
PS> $var = [Foo]::new()
PS> $var.x = 1
PS> $var.x
1
```

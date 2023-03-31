---
description: Explains the concept of scope in PowerShell and shows how to set and change the scope of elements.
Locale: en-US
ms.date: 03/31/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_scopes?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about Scopes
---
# about_Scopes

## Short description
Explains the concept of scope in PowerShell and shows how to set and change
the scope of elements.

## Long description

PowerShell protects access to variables, aliases, functions, and PowerShell
drives (PSDrives) by limiting where they can be read and changed. PowerShell
uses scope rules to ensure that you don't inadvertently change an item that
shouldn't be changed.

The following are the basic rules of scope:

- Scopes may nest. An outer scope is referred to as a parent scope. Any nested
  scopes are child scopes of that parent.

- An item is visible in the scope that it was created in and in any child
  scopes, unless you explicitly make it private.
- You can declare variables, aliases, functions, and PowerShell drives for a
  scope outside of the current scope.
- An item that you created within a scope can be changed only in the scope in
  which it was created, unless you explicitly specify a different scope.

If you create an item in a scope, and the item shares its name with an item in
a different scope, the original item might be hidden by the new item, but it
isn't overridden or changed.

## PowerShell scopes

PowerShell supports the following scopes:

- **Global**: The scope that's in effect when PowerShell starts or when you
  create a new session or runspace. Variables and functions that are present
  when PowerShell starts have been created in the global scope, such as
  automatic variables and preference variables. The variables, aliases, and
  functions in your PowerShell profiles are also created in the global scope.
  The global scope is the root parent scope in a session.
- **Local**: The current scope. The local scope can be the global scope or any
  other scope.
- **Script**: The scope that's created while a script file runs. Only the
  commands in the script run in the script scope. To the commands in a script,
  the script scope is the local scope.

## Parent and child scopes

You can create a new child scope by calling a script or function. The calling
scope is the parent scope. The called script or function is the child scope.
The functions or scripts you call may call other functions, creating a
hierarchy of child scopes whose root scope is the global scope.

Unless you explicitly make the items private, the items in the parent scope
are available to the child scope. However, items that you create and change in
the child scope don't affect the parent scope, unless you explicitly specify
the scope when you create the items.

> [!NOTE]
> Functions from a module don't run in a child scope of the calling scope.
> Modules have their own session state that's linked to the global scope.
> All module code runs in a module-specific hierarchy of scopes that has its
> own root scope.

## Inheritance

A child scope doesn't inherit the variables, aliases, and functions from the
parent scope. Unless an item is private, the child scope can view the items in
the parent scope. And, it can change the items by explicitly specifying the
parent scope, but the items aren't part of the child scope.

However, a child scope is created with a set of items. Typically, it includes
all the aliases that have the **AllScope** option. This option is discussed
later in this article. It includes all the variables that have the **AllScope**
option, plus some automatic variables.

To find the items in a particular scope, use the Scope parameter of
`Get-Variable` or `Get-Alias`.

For example, to get all the variables in the local scope, type:

```powershell
Get-Variable -Scope local
```

To get all the variables in the global scope, type:

```powershell
Get-Variable -Scope global
```

## Scope modifiers

A variable, alias, or function name can include any one of the following
optional scope modifiers:

- `global:` - Specifies that the name exists in the **Global** scope.
- `local:` - Specifies that the name exists in the **Local** scope. The current
  scope is always the **Local** scope.
- `private:` - Specifies that the name is **Private** and only visible to the
  current scope.

  > [!NOTE]
  > `private` isn't a scope. It's an [option][02] that changes the visibility
  > of an item outside of the scope where the item is defined.

- `script:` - Specifies that the name exists in the **Script** scope.
  **Script** scope is the nearest ancestor script file's scope or **Global** if
  there is no nearest ancestor script file.
- `using:` - Used to access variables defined in another scope while running
  scripts via cmdlets like `Start-Job` and `Invoke-Command`.
- `workflow:` - Specifies that the name exists within a workflow. Note:
  Workflows aren't supported in PowerShell v6 and higher.
- `<variable-namespace>` - A modifier created by a PowerShell **PSDrive**
  provider. For example:

  |  Namespace  |                    Description                     |
  | ----------- | -------------------------------------------------- |
  | `Alias:`    | Aliases defined in the current scope               |
  | `Env:`      | Environment variables defined in the current scope |
  | `Function:` | Functions defined in the current scope             |
  | `Variable:` | Variables defined in the current scope             |

The default scope for scripts is the script scope. The default scope for
functions and aliases is the local scope, even if they're defined in a
script.

### Using scope modifiers

To specify the scope of a new variable, alias, or function, use a scope
modifier.

The syntax for a scope modifier in a variable is:

```
$[<scope-modifier>:]<name> = <value>
```

The syntax for a scope modifier in a function is:

```
function [<scope-modifier>:]<name> {<function-body>}
```

The following command, which doesn't use a scope modifier, creates a variable
in the current or **local** scope:

```powershell
$a = "one"
```

To create the same variable in the **global** scope, use the scope `global:`
modifier:

```powershell
$global:a = "one"
Get-Variable a | Format-List *
```

Notice the **Visibility** and **Options** property values.

```Output
Name        : a
Description :
Value       : one
Visibility  : Public
Module      :
ModuleName  :
Options     : None
Attributes  : {}
```

Compare that to a private variable:

```powershell
$private:pVar = 'Private variable'
Get-Variable pVar | Format-List *
```

Using the `private` scope modifier sets the **Options** property to `Private`.

```Output
Name        : pVar
Description :
Value       : Private variable
Visibility  : Public
Module      :
ModuleName  :
Options     : Private
Attributes  : {}
```

To create the same variable in the **script** scope, use the `script:` scope
modifier:

```powershell
$script:a = "one"
```

You can also use a scope modifier with functions. The following function
definition creates a function in the **global** scope:

```powershell
function global:Hello {
  Write-Host "Hello, World"
}
```

You can also use scope modifiers to refer to a variable in a different scope.
The following command refers to the `$test` variable, first in the local scope
and then in the global scope:

```powershell
$test
$global:test
```

### The `using:` scope modifier

Using is a special scope modifier that identifies a local variable in a remote
command. Without a modifier, PowerShell expects variables in remote commands to
be defined in the remote session.

The `using` scope modifier is introduced in PowerShell 3.0.

For any script or command that executes out of session, you need the `using`
scope modifier to embed variable values from the calling session scope, so that
out of session code can access them. The `using` scope modifier is supported in
the following contexts:

- Remotely executed commands, started with `Invoke-Command` using the
  **ComputerName**, **HostName**, **SSHConnection** or **Session** parameters
  (remote session)
- Background jobs, started with `Start-Job` (out-of-process session)
- Thread jobs, started via `Start-ThreadJob` or `ForEach-Object -Parallel`
  (separate thread session)

Depending on the context, embedded variable values are either independent
copies of the data in the caller's scope or references to it. In remote and
out-of-process sessions, they're always independent copies.

For more information, see [about_Remote_Variables][06].

In thread sessions, they're passed by reference. This means it's possible to
modify child scope variables in a different thread. To safely modify variables
requires thread synchronization.

For more information see:

- [Start-ThreadJob][10]
- [ForEach-Object][09]

### Serialization of variable values

Remotely executed commands and background jobs run out-of-process.
Out-of-process sessions use XML-based serialization and deserialization to make
the values of variables available across the process boundaries. The
serialization process converts objects to a **PSObject** that contains the
original objects properties but not its methods.

For a limited set of types, deserialization rehydrates objects back to the
original type. The rehydrated object is a copy of the original object instance.
It has the type properties and methods. For simple types, such as
**System.Version**, the copy is exact. For complex types, the copy is
imperfect. For example, rehydrated certificate objects don't include the
private key.

Instances of all other types are **PSObject** instances. The **PSTypeNames**
property contains the original type name prefixed with **Deserialized**, for
example, **Deserialized.System.Data.DataTable**

### The AllScope Option

Variables and aliases have an **Option** property that can take a value of
**AllScope**. Items that have the **AllScope** property become part of any child
scopes that you create, although they aren't retroactively inherited by parent
scopes.

An item that has the **AllScope** property is visible in the child scope, and
it's part of that scope. Changes to the item in any scope affect all the
scopes in which the variable is defined.

### Managing scope

Several cmdlets have a **Scope** parameter that lets you get or set (create and
change) items in a particular scope. Use the following command to find all the
cmdlets in your session that have a **Scope** parameter:

```powershell
Get-Help * -Parameter scope
```

To find the variables that are visible in a particular scope, use the `Scope`
parameter of `Get-Variable`. The visible variables include global variables,
variables in the parent scope, and variables in the current scope.

For example, the following command gets the variables that are visible in the
local scope:

```powershell
Get-Variable -Scope local
```

To create a variable in a particular scope, use a scope modifier or the
**Scope** parameter of `Set-Variable`. The following command creates a variable
in the global scope:

```powershell
New-Variable -Scope global -Name a -Value "One"
```

You can also use the Scope parameter of the `New-Alias`, `Set-Alias`, or
`Get-Alias` cmdlets to specify the scope. The following command creates an
alias in the global scope:

```powershell
New-Alias -Scope global -Name np -Value Notepad.exe
```

To get the functions in a particular scope, use the `Get-Item` cmdlet when you
are in the scope. The `Get-Item` cmdlet doesn't have a **Scope** parameter.

> [!NOTE]
> For the cmdlets that use the **Scope** parameter, you can also refer to
> scopes by number. The number describes the relative position of one scope to
> another. Scope 0 represents the current, or local, scope. Scope 1 indicates
> the immediate parent scope. Scope 2 indicates the parent of the parent scope,
> and so on. Numbered scopes are useful if you have created many recursive
> scopes.

### Using dot-source notation with scope

Scripts and functions follow the rules of scope. You create them in a
particular scope, and they affect only that scope unless you use a cmdlet
parameter or a scope modifier to change that scope.

But, you can add the contents of a script or function to the current scope
using dot-source notation. When you run a script or function using dot-source
notation, it runs in the current scope. Any functions, aliases, and variables
in the script or function are added to the current scope.

For example, to run the `Sample.ps1` script from the `C:\Scripts` directory in
the script scope (the default for scripts), just enter the full path to the
script file on the command line.

```powershell
c:\scripts\sample.ps1
```

A script file must have a `.ps1` file extension to be executable. Files that
have spaces in their path must be enclosed in quotes. If you try to execute the
quoted path, PowerShell displays the contents of the quoted string in stead of
running the script. The call operator (`&`) allows you to execute the contents
of the string containing the filename.

Using the call operator to run a function or script runs it in script scope.
Using the call operator is no different than running the script by name.

```powershell
& c:\scripts\sample.ps1
```

You can read more about the call operator in [about_Operators][05].

To run the `Sample.ps1` script in the local scope type a dot and a space (`. `)
before the path to the script:

```powershell
. c:\scripts\sample.ps1
```

Now, any functions, aliases, or variables defined in the script are added to
the current scope.

## Restricting without scope

PowerShell has some options and features that are similar to scope and may
interact with scopes. These feature may be confused with scope or the behavior
of scope.

Sessions, modules, and nested prompts are self-contained environments, not
child scopes of the global scope in the session.

### Sessions

A session is an environment in which PowerShell runs. When you create a session
on a remote computer, PowerShell establishes a persistent connection to the
remote computer. The persistent connection lets you use the session for
multiple related commands.

Because a session is a contained environment, it has its own scope, but a
session isn't a child scope of the session in which it was created. The
session starts with its own global scope. This scope is independent of the
global scope of the session. You can create child scopes in the session. For
example, you can run a script to create a child scope in a session.

### Modules

You can use a PowerShell module to share and deliver PowerShell tools. A module
is a unit that can contain cmdlets, scripts, functions, variables, aliases, and
other useful items. Unless explicitly defined, the items in a module aren't
accessible outside the module. Therefore, you can add the module to your
session and use the public items without worrying that the other items might
override the cmdlets, scripts, functions, and other items in your session.

By default, modules are loaded into the top-level of the current _session
state_ not the current _scope_. The current session state could be a module
session state or the global session state. Adding a module to a session does
not change the scope. If you are in the global scope, then modules are loaded
into the global session state. Any exports are placed into the global tables.
If you load module2 from _within_ module1, module2 is loaded into the session
state of module1 not the global session state. Any exports from module2 are
placed at the top of the module1 session state. If you use
`Import-Module -Scope local`, then the exports are placed into the current
scope object rather than at the top level. If you are _in a module_ and use
`Import-Module -Scope global` (or `Import-Module -Global`) to load another
module, that module and its exports are loaded into the global session state
instead of the module's local session state. This feature was designed for
writing module that manipulate modules. The **WindowsCompatibility** module
does this to import proxy modules into the global session state.

Within the session state, modules have their own scope. Consider the following
module `C:\temp\mod1.psm1`:

```powershell
$a = "Hello"

function foo {
    "`$a = $a"
    "`$global:a = $global:a"
}
```

Now we create a global variable `$a`, give it a value and call the function
**foo**.

```powershell
$a = "Goodbye"
foo
```

The module declares the variable `$a` in the module scope then the function
**foo** outputs the value of the variable in both scopes.

```Output
$a = Hello
$global:a = Goodbye
```

### Nested prompts

Nested prompts don't have their own scope. When you enter a nested prompt, the
nested prompt is a subset of the environment. But, you remain within the local
scope.

Scripts do have their own scope. If you are debugging a script, and you reach a
breakpoint in the script, you enter the script scope.

### Private option

Aliases and variables have an **Option** property that can take a value of
`Private`. Items that have the `Private` option can be viewed and changed in
the scope in which they're created, but they can't be viewed or changed outside
that scope.

For example, if you create a variable that has a private option in the global
scope and then run a script, `Get-Variable` commands in the script don't
display the private variable. Using the global scope modifier in this instance
doesn't display the private variable.

You can use the **Option** parameter of the `New-Variable`, `Set-Variable`,
`New-Alias`, and `Set-Alias` cmdlets to set the value of the Option property to
Private.

### Visibility

The **Visibility** property of a variable or alias determines whether you can
see the item outside the container, in which it was created. A container could
be a module, script, or snap-in. Visibility is designed for containers in the
same way that the `Private` value of the **Option** property is designed for
scopes.

The **Visibility** property takes the `Public` and `Private` values. Items that
have private visibility can be viewed and changed only in the container in
which they were created. If the container is added or imported, the items that
have private visibility can't be viewed or changed.

Because visibility is designed for containers, it works differently in a scope.

- If you create an item that has private visibility in the global scope, you
  can't view or change the item in any scope.
- If you try to view or change the value of a variable that has private
  visibility, PowerShell returns an error message.

You can use the `New-Variable` and `Set-Variable` cmdlets to create a variable
that has private visibility.

## Examples

### Example 1: Change a variable value only in a script

The following command changes the value of the `$ConfirmPreference` variable in
a script. The change doesn't affect the global scope.

First, to display the value of the `$ConfirmPreference` variable in the local
scope, use the following command:

```
PS>  $ConfirmPreference
High
```

Create a Scope.ps1 script that contains the following commands:

```powershell
$ConfirmPreference = "Low"
"The value of `$ConfirmPreference is $ConfirmPreference."
```

Run the script. The script changes the value of the `$ConfirmPreference`
variable and then reports its value in the script scope. The output should
resemble the following output:

```output
The value of $ConfirmPreference is Low.
```

Next, test the current value of the `$ConfirmPreference` variable in the current
scope.

```
PS>  $ConfirmPreference
High
```

This example shows that changes to the value of a variable in the script scope
doesn't affect the variable`s value in the parent scope.

### Example 2: View a variable value in different scopes

You can use scope modifiers to view the value of a variable in the local scope
and in a parent scope.

First, define a `$test` variable in the global scope.

```powershell
$test = "Global"
```

Next, create a `Sample.ps1` script that defines the `$test` variable. In the
script, use a scope modifier to refer to either the global or local versions of
the `$test` variable.

In `Sample.ps1`:

```powershell
$test = "Local"
"The local value of `$test is $test."
"The global value of `$test is $global:test."
```

When you run `Sample.ps1`, the output should resemble the following output:

```output
The local value of $test is Local.
The global value of $test is Global.
```

When the script is complete, only the global value of `$test` is defined in the
session.

```
PS> $test
Global
```

### Example 3: Change the value of a variable in a parent scope

Unless you protect an item using the Private option or another method, you can
view and change the value of a variable in a parent scope.

First, define a `$test` variable in the global scope.

```powershell
$test = "Global"
```

Next, create a Sample.ps1 script that defines the `$test` variable. In the
script, use a scope modifier to refer to either the global or local versions of
the `$test` variable.

In Sample.ps1:

```powershell
$global:test = "Local"
"The global value of `$test is $global:test."
```

When the script is complete, the global value of `$test` is changed.

```
PS> $test
Local
```

### Example 4: Creating a private variable

A private variable is a variable that has an **Option** property that has a
value of `Private`. `Private` variables are inherited by the child scope, but
they can only be viewed or changed in the scope in which they were created.

The following command creates a private variable called `$ptest` in the local
scope.

```powershell
New-Variable -Name ptest -Value 1 -Option Private
```

You can display and change the value of `$ptest` in the local scope.

```
PS> $ptest
1

PS> $ptest = 2
PS> $ptest
2
```

Next, create a Sample.ps1 script that contains the following commands. The
command tries to display and change the value of `$ptest`.

In Sample.ps1:

```powershell
"The value of `$Ptest is $Ptest."
"The value of `$Ptest is $global:Ptest."
```

The `$ptest` variable isn't visible in the script scope, the output is empty.

```powershell
"The value of $Ptest is ."
"The value of $Ptest is ."
```

### Example 5: Using a local variable in a remote command

For variables in a remote command created in the local session, use the `using`
scope modifier. PowerShell assumes that the variables in remote commands were
created in the remote session.

The syntax is:

```
$using:<VariableName>
```

For example, the following commands create a `$Cred` variable in the local
session and then use the `$Cred` variable in a remote command:

```powershell
$Cred = Get-Credential
Invoke-Command $s {Remove-Item .\Test*.ps1 -Credential $using:Cred}
```

The `using` scope modifier was introduced in PowerShell 3.0.

## See also

- [about_Variables][08]
- [about_Environment_Variables][03]
- [about_Functions][04]
- [about_Script_Blocks][07]
- [Start-ThreadJob][10]

<!-- link references -->
[02]: #private-option
[03]: about_Environment_Variables.md
[04]: about_Functions.md
[05]: about_Operators.md
[06]: about_Remote_Variables.md
[07]: about_Script_Blocks.md
[08]: about_Variables.md
[09]: xref:Microsoft.PowerShell.Core.ForEach-Object
[10]: xref:ThreadJob.Start-ThreadJob

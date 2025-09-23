---
description: Comment-Based Help Keywords
ms.date: 09/22/2025
no-loc: [FAQ, Function, General, Glossary, Provider, Component, Functionality, Role]
title: Comment-Based Help Keywords
---
# Comment-Based Help Keywords

This topic lists and describes the keywords in comment-based help.

## Keywords in Comment-Based Help

The following are valid comment-based Help keywords. They're listed in the order in which they
typically appear in a Help topic along with their intended use. These keywords can appear in any
order in the comment-based Help, and they're not case-sensitive.

Note that the `.EXTERNALHELP` keyword takes precedence over all other comment-based help keywords.
When `.EXTERNALHELP` is present, the [Get-Help][02] cmdlet doesn't display comment-based help, even
when it can't find a help file that matches the value of the keyword.

## `.SYNOPSIS`

A brief description of the function or script. This keyword can be used only once in each topic.

## `.DESCRIPTION`

A detailed description of the function or script. This keyword can be used only once in each topic.

## `.PARAMETER <Parameter-Name>`

The description of a parameter. You can include a `.PARAMETER` keyword for each parameter in the
function or script.

The `.PARAMETER` keywords can appear in any order in the comment block, but the order in which the
parameters appear in the `param` statement or function declaration determines the order in which the
parameters appear in Help topic. To change the order of parameters in the Help topic, change the
order of the parameters in the `param` statement or function declaration.

You can also specify a parameter description by placing a comment in the `param` statement
immediately before the parameter variable name. If you use both a `param` statement comment and a
`.PARAMETER` keyword, the description associated with the `.PARAMETER` keyword is used, and the
`param` statement comment is ignored.

## `.EXAMPLE`

A sample command that uses the function or script, optionally followed by sample output and a
description. Repeat this keyword for each example.

## `.INPUTS`

The .NET types of objects that can be piped to the function or script. You can also include a
description of the input objects. Repeat this keyword for each input type.

## `.OUTPUTS`

The .NET type of the objects that the cmdlet returns. You can also include a description of the
returned objects. Repeat this keyword for each output type.

## `.NOTES`

Additional information about the function or script.

## `.LINK`

The name of a related topic. Repeat this keyword for each related topic. This content appears in the
Related Links section of the Help topic.

The `.LINK` keyword content can also include a Uniform Resource Identifier (URI) to an online
version of the same help topic. The online version opens when you use the **Online** parameter of
`Get-Help`. The URI must begin with `http` or `https`.

## `.COMPONENT`

The name of the technology or feature that the function or script uses, or to which it's related.
The **Component** parameter of `Get-Help` uses this value to filter the search results returned by
`Get-Help`.

## `.ROLE`

The name of the user role for the help topic. The **Role** parameter of `Get-Help` uses this value
to filter the search results returned by `Get-Help`.

## `.FUNCTIONALITY`

The keywords that describe the intended use of the function. The **Functionality** parameter of
`Get-Help` uses this value to filter the search results returned by `Get-Help`.

## `.FORWARDHELPTARGETNAME <Command-Name>`

Redirects to the help topic for the specified command. You can redirect users to any help topic,
including help content for a function, script, cmdlet, or provider.

```powershell
# .FORWARDHELPTARGETNAME <Command-Name>
```

## `.FORWARDHELPCATEGORY`

Specifies the help category of the item in `.FORWARDHELPTARGETNAME`. Valid values are `Alias`,
`Cmdlet`, `HelpFile`, `Function`, `Provider`, `General`, `FAQ`, `Glossary`, `ScriptCommand`,
`ExternalScript`, `Filter`, or `All`. Use this keyword to avoid conflicts when there are commands
with the same name.

```powershell
# .FORWARDHELPCATEGORY <Category>
```

## `.REMOTEHELPRUNSPACE <PSSession-variable>`

Specifies a session that contains the help topic. Enter a variable that contains a **PSSession**
object. This keyword is used by the [Export-PSSession][09] cmdlet to find the help content for the
exported commands.

```powershell
# .REMOTEHELPRUNSPACE <PSSession-variable>
```

## `.EXTERNALHELP`

Specifies an XML-based help file for the script or function.

```powershell
# .EXTERNALHELP <XML Help File>
```

The `.EXTERNALHELP` keyword is required when a function or script is documented in XML files.
Without this keyword, `Get-Help` can't find the XML-based help file for the function or script.

The `.EXTERNALHELP` keyword takes precedence over other comment-based help keywords. If
`.EXTERNALHELP` is present, `Get-Help` doesn't display comment-based help, even if it can't find a
help topic that matches the value of the `.EXTERNALHELP` keyword.

If the function is exported by a module, set the value of the `.EXTERNALHELP` keyword to a filename
without a path. `Get-Help` looks for the specified filename in a language-specific subdirectory of
the module directory. There are no requirements for the name of the XML-based help file for a
function. Beginning in PowerShell 5.0, functions that are exported by a module can be documented in
a help file that's named for the module. You don't need to use `.EXTERNALHELP` comment keyword. For
example, if the `Test-Function` function is exported by the `MyModule` module, you can name the help
file `MyModule-help.xml`. The `Get-Help` cmdlet looks for help for the `Test-Function` function in
the `MyModule-help.xml` file in the module directory.

If the function isn't included in a module, include a path to the XML-based help file. If the value
includes a path and the path contains UI-culture-specific subdirectories, `Get-Help` searches the
subdirectories recursively for an XML file with the name of the script or function in accordance
with the language fallback standards established for Windows, just as it does in a module directory.

For more information about the cmdlet help XML-based help file format, see
[How to Write Cmdlet Help][01].

<!-- link references -->
[01]: ./writing-help-for-windows-powershell-cmdlets.md
[02]: /powershell/module/Microsoft.PowerShell.Core/Get-Help

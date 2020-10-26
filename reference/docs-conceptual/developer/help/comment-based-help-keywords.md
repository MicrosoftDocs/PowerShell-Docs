---
ms.date: 06/09/2020
ms.topic: reference
title: Comment-Based Help Keywords
description: Comment-Based Help Keywords
---
# Comment-Based Help Keywords

This topic lists and describes the keywords in comment-based help.

## Keywords in Comment-Based Help

The following are valid comment-based Help keywords. They are listed in the order in which they
typically appear in a Help topic along with their intended use. These keywords can appear in any
order in the comment-based Help, and they are not case-sensitive.

Note that the `.EXTERNALHELP` keyword takes precedence over all other comment-based help keywords.
When `.EXTERNALHELP` is present, the
[Microsoft.PowerShell.Commands.GetHelpCommand](/dotnet/api/Microsoft.PowerShell.Commands.gethelpcommand)
cmdlet does not display comment-based help, even when it cannot find a help file that matches the
value of the keyword.

## .SYNOPSIS

A brief description of the function or script. This keyword can be used only once in each topic.

## .DESCRIPTION

A detailed description of the function or script. This keyword can be used only once in each topic.

## .PARAMETER \<Parameter-Name>

The description of a parameter. You can include a `.PARAMETER` keyword for each parameter in the
function or script.

The `.PARAMETER` keywords can appear in any order in the comment block, but the order in which the
parameters appear in the `Param` statement or function declaration determines the order in which the
parameters appear in Help topic. To change the order of parameters in the Help topic, change the
order of the parameters in the `Param` statement or function declaration.

You can also specify a parameter description by placing a comment in the `Param` statement
immediately before the parameter variable name. If you use both a `Param` statement comment and a
`.PARAMETER` keyword, the description associated with the `.PARAMETER` keyword is used, and the
`Param` statement comment is ignored.

## .EXAMPLE

A sample command that uses the function or script, optionally followed by sample output and a
description. Repeat this keyword for each example.

## .INPUTS

The Microsoft .NET Framework types of objects that can be piped to the function or script. You can
also include a description of the input objects.

## .OUTPUTS

The .NET Framework type of the objects that the cmdlet returns. You can also include a description
of the returned objects.

## .NOTES

Additional information about the function or script.

## .LINK

The name of a related topic. Repeat this keyword for each related topic. This content appears in the
Related Links section of the Help topic.

The `.LINK` keyword content can also include a Uniform Resource Identifier (URI) to an online
version of the same Help topic. The online version opens when you use the `Online` parameter of
`Get-Help`. The URI must begin with "http" or "https".

## .COMPONENT

The name of the technology or feature that the function or script uses, or to which it is related.
The **Component** parameter of `Get-Help` uses this value to filter the search results returned by
`Get-Help`.

## .Role

The name of the user role for the help topic. The **Role** parameter of `Get-Help` uses this value
to filter the search results returned by `Get-Help`.

## .FUNCTIONALITY

The keywords that describe the intended use of the function. The **Functionality** parameter of
`Get-Help` uses this value to filter the search results returned by `Get-Help`.

## .FORWARDHELPTARGETNAME \<Command-Name>

Redirects to the Help topic for the specified command. You can redirect users to any Help topic,
including Help topics for a function, script, cmdlet, or provider.

## .FORWARDHELPCATEGORY \<Category>

Specifies the Help category of the item in `.FORWARDHELPTARGETNAME`. Use this keyword to avoid
conflicts when there are commands with the same name.

Valid values are:

- Alias
- Cmdlet
- HelpFile
- Function
- Provider
- General
- FAQ
- Glossary
- ScriptCommand
- ExternalScript
- Filter
- All

## .REMOTEHELPRUNSPACE \<PSSession-variable>

Specifies a session that contains the Help topic. Enter a variable that contains a PSSession. This
keyword is used by the `Export-PSSession` cmdlet to find the Help topics for the exported commands.

## .EXTERNALHELP \<XML Help File>

Specifies the path and/or name of an XML-based Help file for the script or function.

The `.EXTERNALHELP` keyword tells the
[Microsoft.PowerShell.Commands.GetHelpCommand](/dotnet/api/Microsoft.PowerShell.Commands.gethelpcommand)
cmdlet to get help for the script or function in an XML-based file. The `.EXTERNALHELP` keyword is
required when using an XML-based help file for a script or function. Without it, `Get-Help` will not
find a help file for the function or script.

The `.EXTERNALHELP` keyword takes precedence over all other comment-based help keywords. When
`.EXTERNALHELP` is present, the
[Microsoft.PowerShell.Commands.GetHelpCommand](/dotnet/api/Microsoft.PowerShell.Commands.gethelpcommand)
cmdlet does not display comment-based help, even when it cannot find a help file that matches the
value of the keyword.

When the function is exported by a script module, the value of `.EXTERNALHELP` should be a filename
without a path. `Get-Help` looks for the file in a locale-specific subdirectory of the module
directory. There are no requirements for the filename, but a best practice is to use the following
filename format: `<ScriptModule>.psm1-help.xml`.

When the function is not associated with a module, include a path and filename in the value of the
`.EXTERNALHELP` keyword. If the specified path to the XML file contains UI-culture-specific
subdirectories, `Get-Help` searches the subdirectories recursively for an XML file with the name of
the script or function in accordance with the language fallback standards established for Windows,
just as it does for all XML-based Help topics.

For more information about the cmdlet Help XML-based Help file format, see
[Writing Windows PowerShell Cmdlet Help](./writing-help-for-windows-powershell-cmdlets.md).

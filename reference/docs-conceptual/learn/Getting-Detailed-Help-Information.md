---
ms.date:  08/27/2018
keywords:  powershell,cmdlet
title:  Getting Detailed Help Information
ms.assetid:  6fb4daf7-8607-4a3e-b692-f77631adc1b9
---

# Getting detailed help information

PowerShell includes detailed Help articles that explain PowerShell concepts and the PowerShell
language. There are also Help articles for each cmdlet and provider and for many functions and
scripts.

You can display these Help articles at the command prompt or view the most recently updated versions
of these articles in the [PowerShell](/powershell/scripting/overview) documentation
online.

## Getting help for cmdlets

To get Help about PowerShell cmdlets, use the
[Get-Help](/powershell/module/microsoft.powershell.core/Get-Help) cmdlet. For example, to get Help
for the `Get-ChildItem` cmdlet, type:

```powershell
Get-Help Get-ChildItem
```

or

```powershell
Get-ChildItem -?
```

You can even get Help about the Get-Help cmdlet. For example:

```powershell
Get-Help Get-Help
```

To get a list of all the cmdlet Help articles in your session, type:

```powershell
Get-Help -Category Cmdlet
```

To display one page of each Help article at a time, use the `help` function or its alias `man`.
For example, to display Help for the `Get-ChildItem` cmdlet, type

```powershell
man Get-ChildItem
```

or

```powershell
help Get-ChildItem
```

To display detailed information, use the **Detailed** parameter of the `Get-Help` cmdlet. For
example, to get detailed information about the `Get-ChildItem` cmdlet, type:

```powershell
Get-Help Get-ChildItem -Detailed
```

To display all content in the Help article, use the **Full** parameter of the `Get-Help` cmdlet. For
example, to display all content in the Help article for the `Get-ChildItem` cmdlet, type:

```powershell
Get-Help Get-ChildItem -Full
```

To get detailed Help about the parameters of a cmdlet, use the **Parameter** parameter of the
`Get-Help` cmdlet. For example, to get detailed Help for all of the parameters of the
`Get-ChildItem` cmdlet, type:

```powershell
Get-Help Get-ChildItem -Parameter *
```

To display only the examples in a Help article, use the **Examples** parameter of the `Get-Help`.
For example, to display only the examples in the Help article for the `Get-ChildItem` cmdlet, type:

```powershell
Get-Help Get-ChildItem -Examples
```

For information about how to write Help articles for the cmdlets that you write, see
[How to Write Cmdlet Help](/powershell/developer/help/writing-help-for-windows-powershell-cmdlets).

## Getting conceptual help

The `Get-Help` cmdlet also displays information about conceptual articles in PowerShell,
including articles about the PowerShell language. Conceptual Help articles begin with the
"about_" prefix, such as about_line_editing. (The name of the conceptual article must be entered in
English even on non-English versions of PowerShell.)

To display a list of conceptual articles, type:

```powershell
Get-Help about_*
```

To display a particular Help article, type the article name, for example:

```powershell
Get-Help about_command_syntax
```

The parameters of `Get-Help`, such as **Detailed**, **Parameter**, and **Examples**, have no effect
on the display of conceptual Help articles.

## Getting help about providers

The `Get-Help` cmdlet displays information about PowerShell providers. To get Help for a
provider, type `Get-Help` followed by the provider name. For example, to get Help for the Registry
provider, type:

```powershell
Get-Help registry
```

To get a list of all the provider Help articles in your session, type

```powershell
Get-Help -Category provider
```

The parameters of `Get-Help`, such as **Detailed**, **Parameter**, and **Examples**, have no effect
on the display of provider Help articles.

## Getting help about scripts and functions

Many scripts and functions in PowerShell have Help articles. Use the `Get-Help` cmdlet to
display the Help articles for scripts and functions.

To display the Help for a function, type `Get-Help` followed by the function name. For example, to
get Help for the `Disable-PSRemoting` function, type:

```powershell
Get-Help Disable-PSRemoting
```

To display the Help for a script, type the path to the script file. If the script
is not in a path listed in the Path environment variable, you must use the fully qualified path.

For example, if you have a script called "TestScript.ps1" in your C:\\PS-Test directory, to display
the Help article for the script, type:

```powershell
Get-Help c:\ps-test\TestScript.ps1
```

The parameters that are designed for displaying cmdlet Help work for script and function Help,
too. However, help for functions and scripts is not shown when you run `Get-Help *`.

For information about writing Help articles for your functions and scripts, see the following articles:

- [about_Functions](/powershell/module/microsoft.powershell.core/about/about_functions)
- [about_Scripts](/powershell/module/microsoft.powershell.core/about/about_scripts)
- [about_Comment_Based_Help](/powershell/module/microsoft.powershell.core/about/about_comment_based_help)

## Getting help online

Viewing the Help articles online is one of the best ways to get help. Online articles are easier
to update and provide the most current content.

To get Help online, use the **Online** parameter of the `Get-Help` cmdlet. All the Help articles
that come with PowerShell, including provider Help and conceptual (About) Help articles, are
available online in the [PowerShell](/powershell/scripting/powershell-scripting) documentation.

> [!NOTE]
> You can't use the **Online** parameter with conceptual (about_\*) or provider Help articles.
> Online help is optional, so it does not work for every cmdlet, function, or script.

For example, to get the online version of the Help article about the `Get-ChildItem` cmdlet, type:

```powershell
Get-Help Get-ChildItem -Online
```

PowerShell opens the article in your default browser. If online Help is supported for a Help
article, you can also view the URL of the Help article. The URL appears in the Related Links
section of a Help article.

For example, to see the URL for the online version of the Add-Computer cmdlet, type:

```powershell
Get-Help Add-Computer
```

The first line in the Related Links section of the article is shown below.

```Output
Online version: http://go.microsoft.com/fwlink/?LinkId=821564
```

For information about how to provide online support for your Help articles, see
[about_Comment_Based_Help](/powershell/module/microsoft.powershell.core/about/about_comment_based_help).

## See also

- [about_Functions](/powershell/module/microsoft.powershell.core/about/about_functions)
- [about_Scripts](/powershell/module/microsoft.powershell.core/about/about_scripts)
- [about_Comment_Based_Help](/powershell/module/microsoft.powershell.core/about/about_comment_based_help)
- [Get-Help](/powershell/module/microsoft.powershell.core/get-help)

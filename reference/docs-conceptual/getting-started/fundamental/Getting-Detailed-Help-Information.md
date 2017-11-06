---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  Getting Detailed Help Information
ms.assetid:  6fb4daf7-8607-4a3e-b692-f77631adc1b9
---

# Getting Detailed Help Information
Windows PowerShell includes detailed Help topics that explain Windows PowerShell concepts and the Windows PowerShell language. There are also Help topics for each cmdlet and provider and Help topics for many functions and scripts.

You can display these Help topics at the command prompt or view the most recently updated versions of these topics in the Microsoft TechNet Library. Many programs that host Windows PowerShell, such as Windows PowerShell Integrated Scripting Environment, provide additional Help features, such as context-sensitive Help and compiled Help file (.chm).

## Getting Help for Cmdlets
To get Help about Windows PowerShell cmdlets, use the [Get-Help [m2]](https://technet.microsoft.com/en-us/library/2d7fe1b4-0025-4580-a911-d81922dd6cd2) cmdlet. For example, to get Help for the [Get-ChildItem [m2]](https://technet.microsoft.com/en-us/library/4b270d63-c995-45b8-b5b4-3f8887efbfcc) cmdlet, type:

```
get-help get-childitem
```

or

```
get-childitem -?
```

You can even get Help about the Get-Help cmdlet. For example:

```
get-help get-help
```

To get a list of all the cmdlet Help topics in your session, type:

```
get-help -category cmdlet
```

To display one page of each Help topic at a time, use the **help** function or its alias **man**. For example, to display Help for the Get-ChildItem cmdlet, type

```
man get-childitem
```

or

```
help get-childitem
```

To display detailed information about a cmdlet, function, or script, including descriptions of its parameters and examples of its use, use the *Detailed* parameter of the Get-Help cmdlet. For example, to get detailed information about the Get-ChildItem cmdlet, type:

```
get-help get-childitem -detailed
```

To display all content in the Help topic, use the *Full* parameter of the Get-Help cmdlet. For example, to display all content in the Help topic for the Get-ChildItem cmdlet, type:

```
get-help get-childitem -full
```

To get detailed Help about the parameters of a cmdlet, use the *Parameter* parameter of the Get-Help cmdlet. For example, to get detailed Help for all of the parameters of the Get-ChildItem cmdlet, type:

```
get-help get-childitem -parameter *
```

To display only the examples in a Help topic, use the *Example* parameter of the Get-Help. For example, to display only the examples in the Help topic for the Get-ChildItem cmdlet, type:

```
get-help get-childitem -examples
```

For information about how to write Help topics for the cmdlets that you write, see [How to Write Cmdlet Help](https://go.microsoft.com/fwlink/?LinkID=123415) in the MSDN library.

## Getting Conceptual Help
The Get-Help cmdlet also displays information about conceptual topics in Windows PowerShell, including topics about the Windows PowerShell language. Conceptual Help topics begin with the "about_" prefix, such as about_line_editing. (The name of the conceptual topic must be entered in English even on non-English versions of Windows PowerShell.)

To display a list of conceptual topics, type:

```
get-help about_*
```

To display a particular Help topic, type the topic name, for example:

```
get-help about_command_syntax
```

The parameters of Get-Help, such as *Detailed*, *Parameter*, and *Examples*, have no effect on the display of conceptual Help topics.

## Getting Help About Providers
The Get-Help cmdlet displays information about Windows PowerShell providers. To get Help for a provider, type "Get-Help" followed by the provider name. For example, to get Help for the Registry provider, type:

```
get-help registry
```

To get a list of all the provider Help topics in your session, type

```
get-help -category provider
```

The parameters of Get-Help, such as *Detailed*, *Parameter*, and *Examples*, have no effect on the display of provider Help topics.

## Getting Help About Scripts and Functions
Many scripts and functions in Windows PowerShell have Help topics. Use the Get-Help cmdlet to display the Help topics for scripts and functions.

To display the Help for a function, type "get-help" followed by the function name. For example, to get Help for the Disable-PSRemoting function, type:

```
get-help disable-psremoting
```

To display the Help for a script, type the fully qualified path to the script file. If the script is in a path that is listed in the Path environment variable, you can omit the path from the command.

For example, if you have a script called "TestScript.ps1" in your C:\\PS-Test directory, to display the Help topic for the script, type:

```
get-help c:\ps-test\TestScript.ps1
```

The parameters that were designed for displaying cmdlet Help, such as *Detailed*, *Full*, *Examples*, and *Parameter*, work for script Help and function Help, too. However, when you display all Help, by typing "get-help \*", Help for functions and scripts does not appear.

For information about writing Help topics for your functions and scripts, see [about_Functions [m2]](https://technet.microsoft.com/en-us/library/61d40692-5300-4de9-a9b5-bae31815e105), [about_Scripts](https://technet.microsoft.com/en-us/library/7dc08334-dcfe-450b-b949-0554855623af), and [about_Comment_Based_Help](https://technet.microsoft.com/en-us/library/99a81ccc-21a0-49ec-a1b3-9efe2b4c0bbf).

## Getting Help Online
If you are connected to the Internet, one of the best ways to get Help is to view the Help topics online. Because online topics are easy to update, they are likely to provide the most current content.

To get Help online, try the *Online* parameter of the Get-Help cmdlet. The *Online* parameter of the Get-Help cmdlet works only for cmdlet Help, function Help, and script Help. You cannot use the *Online* parameter with conceptual (About) topics or provider Help topics. Also, because this feature is optional, it does not work for every cmdlet, function, or script Help topic.

However, all the Help topics that come with Windows PowerShell, including provider Help and conceptual (About) Help topics, are available online in the [Windows PowerShell](http://go.microsoft.com/fwlink/?LinkID=107116) section of the Microsoft TechNet Library.

To use the *Online* parameter of the Get-Help cmdlet, use the following command format.

```
get-help <command-name> -online
```

For example, to get the online version of the Help topic about the Get-ChildItem cmdlet, type:

```
get-help get-childitem -online
```

If an online version of the Help topic is available, it will open in your default browser.

If online Help is supported for a Help topic, you can also view the Internet address (URL) of the Help topic. The Internet address appears in the Related Links section of a Help topic.

For example, to see the URL for the online version of the Add-Computer cmdlet, type:

```
get-help add-computer
```

The first line in the Related Links section of the topic is shown below.

```
Online version: http://go.microsoft.com/fwlink/?LinkID=135194
```

For information about how to provide online support for your Help topics, see [about_Comment_Based_Help](https://technet.microsoft.com/en-us/library/99a81ccc-21a0-49ec-a1b3-9efe2b4c0bbf), and see [How to Write Cmdlet Help](https://go.microsoft.com/fwlink/?LinkID=123415) in the MSDN library.

## See Also
- [about_Functions [m2]](https://technet.microsoft.com/en-us/library/61d40692-5300-4de9-a9b5-bae31815e105)
- [about_Scripts](https://technet.microsoft.com/en-us/library/7dc08334-dcfe-450b-b949-0554855623af)
- [about_Comment_Based_Help](https://technet.microsoft.com/en-us/library/99a81ccc-21a0-49ec-a1b3-9efe2b4c0bbf)
- [Get-Help [m2]](https://technet.microsoft.com/en-us/library/2d7fe1b4-0025-4580-a911-d81922dd6cd2)


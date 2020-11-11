---
ms.date: 09/13/2016
ms.topic: reference
title: Writing Help for PowerShell Scripts and Functions
description: Writing Help for PowerShell Scripts and Functions
---
# Writing Help for PowerShell Scripts and Functions

PowerShell scripts and functions should be fully documented whenever they are shared with others.
The `Get-Help` cmdlet displays the script and function help topics in the same format as it displays
help for cmdlets, and all of the `Get-Help` parameters work on script and function help topics.

PowerShell scripts can include a help topic about the script and help topics about each functions in
the script. Functions that are shared independently of scripts can include their own help topics.

This document explains the format and correct placement of the help topics, and it suggests
guidelines for the content.

## Types of Script and Function Help

### Comment-Based Help

The help topic that describes a script or function can be implemented as a set of comments within
the script or function. When writing comment-based help for a script and for functions in a script,
pay careful attention to the rules for placing the comment-based help. The placement determines
whether the `Get-Help` cmdlet associates the help topic with the script or a function. For more
information about writing comment-based help topics, see
[about_Comment_Based_Help](/powershell/module/microsoft.powershell.core/about/about_comment_based_help).

### XML-Based Command Help

The help topic that describes a script or function can be implemented in an XML file that uses the
command help schema. To associate the script or function with the XML file, use the `ExternalHelp`
comment keyword followed by the path and name of the XML file.

When the `ExternalHelp` comment keyword is present, it takes precedence over comment-based help,
even when `Get-Help` cannot find a help file that matches the value of the `ExternalHelp` keyword.

### Online Help

You can post your help topics on the internet and then direct `Get-Help` to open the topics. For
more information about writing comment-based help topics, see
[Supporting Online Help](../module/supporting-online-help.md).

There is no established method for writing conceptual ("About") topics for scripts and functions.
However, you can post conceptual topics on the internet list the topics and their URLs in the
Related Links section of a command help topic.

## Content Considerations for Script and Function Help

- If you are writing a very brief help topic with only a few of the available command help sections,
  be sure to include clear descriptions of the script or function parameters. Also include one or
  two sample commands in the examples section, even if you decide to omit example descriptions.

- In all descriptions, refer to the command as a script or function. This information helps the user
  to understand and manage the command.

  For example, the following detailed description states that the New-Topic command is a script.
  This reminds users that they need to specify the path and full name when they run it.

  > "The New-Topic script creates a blank conceptual topic for each topic name in the input file..."

  The following detailed description states that `Disable-PSRemoting` is a function. This
  information is particularly useful to users when the session includes multiple commands with the
  same name, some of which might be hidden by a command with higher precedence.

  > The `Disable-PSRemoting` function disables all session configurations on the local computer...

- In a script help topic, explain how to use the script as a whole. If you are also writing help
  topics for functions in the script, mention the functions in your script help topic and include
  references to the function help topics in the Related Links section of the script help topic.
  Conversely, when a function is part of a script, explain in the function help topic the role that
  the function plays in the script and how it might be used independently. Then list the script help
  topic in the Related Links section of the function help topic.

- When writing examples for a script help topic, be sure to include the path to the script file in
  the example command. This reminds users that they must specify the path explicitly, even when the
  script is in the current directory.

- In a function help topic, remind users that the function exists only in the current session and,
  to use it in other sessions, they need to add it, or add it a PowerShell profile.

- `Get-Help` displays the help topic for a script or function only when the script file and help
  topic files are saved in the correct locations. Therefore, it is not useful to include
  instructions for installing PowerShell, or saving or installing the script or function in a script
  or function help topic. Instead, include any installation instructions in the document that you
  use to distribute the script or function.

## See Also

[Writing Comment-Based Help Topics](./writing-comment-based-help-topics.md)

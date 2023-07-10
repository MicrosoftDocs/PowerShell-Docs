---
description: Writing Help for PowerShell Modules
ms.date: 07/10/2023
ms.topic: reference
title: Writing Help for PowerShell Modules
---
# Writing Help for PowerShell Modules

PowerShell modules can include Help topics about the module and about the module members, such as
cmdlets, providers, functions and scripts. The `Get-Help` cmdlet displays the module Help topics in
the same format as it displays Help for other PowerShell items, and users use standard `Get-Help`
commands to get the Help topics.

This document explains the format and correct placement of module Help topics, and it suggests
guidelines for module Help content.

## Types of Module Help

A module can include the following types of Help.

- **Cmdlet Help**. The Help topics that describe cmdlets in a module are XML files that use the
  command help schema

- **Provider Help**. The Help topics that describe providers in a module are XML files that use the
  provider help schema.

- **Function Help**. The Help topics that describe functions in a module can be XML files that use
  the command help schema or comment-based Help topics within the function, or the script or script
  module

- **Script Help**. The Help topics that describe scripts in a module can be XML files that use the
  command help schema or comment-based Help topics in the script or script module.

- **Conceptual ("About") Help**. You can use a conceptual ("about") Help topic to describe the
  module and its members and to explain how the members can be used together to perform tasks.
  Conceptual Help topics are text files with Unicode (UTF-8) encoding. The filename must use the
  `about_<name>.help.txt` format, such as `about_MyModule.help.txt`. By default, PowerShell includes
  over 100 of these conceptual About Help topics, and they're formatted like the following example.

  ```Output
  TOPIC
      about_<subject or module name>

  SHORT DESCRIPTION
      A short, one-line description of the topic contents.

  LONG DESCRIPTION
      A detailed, full description of the subject or purpose of the module.

  EXAMPLES
      Examples of how to use the module or how the subject feature works in practice.

  KEYWORDS
      Terms or titles on which you might expect your users to search for the information in this topic.

  SEE ALSO
      Text-only references for further reading. Hyperlinks can't work in the PowerShell console.

  ```

All the schema files can be found in the `$PSHOME\Schemas\PSMaml` folder.

## Placement of Module Help

The `Get-Help` cmdlet looks for module Help topic files in language-specific subdirectories of the
module directory.

For example, the following directory structure diagram shows the location of the Help topics for the
SampleModule module.

```
<ModulePath>
    \SampleModule
        \<en-US>
            \about_SampleModule.help.txt
            \SampleModule.dll-help.xml
            \SampleNestedModule.dll-help.xml
        \<fr-FR>
            \about_SampleModule.help.txt
            \SampleModule.dll-help.xml
            \SampleNestedModule.dll-help.xml
```

> [!NOTE]
> In the example, the `<ModulePath>` placeholder represents one of the paths in the `PSModulePath`
> environment variable, such as `$HOME\Documents\Modules`, `$PSHOME\Modules`, or a custom path that
> the user specifies.

## Getting Module Help

When a user imports a module into a session, the Help topics for that module are imported into the
session along with the module. You can list the Help topic files in the value of the FileList key in
the module manifest, but Help topics aren't affected by the `Export-ModuleMember` cmdlet.

You can provide module Help topics in different languages. The `Get-Help` cmdlet automatically
displays module Help topics in the language that's specified for the current user in the Regional
and Language Options item in Control Panel. In Windows Vista and later versions of Windows,
`Get-Help` searches for the Help topics in language-specific subdirectories of the module directory
in accordance with the language fallback standards established for Windows.

Beginning in PowerShell 3.0, running a `Get-Help` command for a cmdlet or function triggers
automatic importing of the module. The `Get-Help` cmdlet immediately displays the contents of the
help topics in the module.

If the module doesn't contain help topics and there are no help topics for the commands in the
module on the user's computer, `Get-Help` displays auto-generated help. The auto-generated help
includes the command syntax, parameters, and input and output types, but doesn't include any
descriptions. The auto-generated help includes text that directs the user to try to use the
`Update-Help` cmdlet to download help for the command from the internet or a file share. It also
recommends using the **Online** parameter of the `Get-Help` cmdlet to get the online version of the
help topic.

## Supporting Updatable Help

Users of PowerShell 3.0 and later versions of PowerShell can download and install updated help files
for a module from the internet or from a local file share. The `Update-Help` and `Save-Help` cmdlets
hide the management details from the user. Users run the `Update-Help` cmdlet and then use the
`Get-Help` cmdlet to read the newest help files for the module at the PowerShell command prompt.
Users don't need to restart Windows or PowerShell.

Users behind firewalls and those without internet access can use Updatable Help, as well.
Administrators with internet access use the `Save-Help` cmdlet to download and install the newest
help files to a file share. Then, users use the **Path** parameter of the `Update-Help` cmdlet to
get the newest help files from the file share.

Module authors can include help files in the module and use Updatable Help to update the help files,
or omit help files from the module and use Updatable Help both to install and to update them.

For more information about Updatable Help, see [Supporting Updatable Help][03].

## Supporting Online Help

Users who can't or don't install updated help files on their computers often rely on the online
version of module help topics. The **Online** parameter of the `Get-Help` cmdlet opens the online
version of a cmdlet or advanced function help topic for the user in their default internet browser.

The `Get-Help` cmdlet uses the value of the **HelpUri** property of the cmdlet or function to find
the online version of the help topic.

Beginning in PowerShell 3.0, you can help users find the online version of cmdlet and function help
topics by defining the HelpUri attribute on the cmdlet class or the **HelpUri** property of the
**CmdletBinding** attribute. The value of the attribute is the value of the **HelpUri** property of
the cmdlet or function.

For more information, see [Supporting Online Help][02].

## See Also

- [Writing a PowerShell Module][01]
- [Supporting Updatable Help][03]
- [Supporting Online Help][02]

<!-- link references -->
[01]: ../module/writing-a-windows-powershell-module.md
[02]: ./supporting-online-help.md
[03]: ./supporting-updatable-help.md

---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821483
external help file:  System.Management.Automation.dll-Help.xml
---

# help

## SYNOPSIS
Displays information about Windows PowerShell commands and concepts.

## SYNTAX

### AllUsersView (Default)
```
help [[-Name] <String>] [-Path <String>] [-Category <String[]>] [-Component <String[]>]
 [-Functionality <String[]>] [-Role <String[]>] [-Full]
```

### DetailedView
```
help [[-Name] <String>] [-Path <String>] [-Category <String[]>] [-Component <String[]>]
 [-Functionality <String[]>] [-Role <String[]>] [-Detailed]
```

### Examples
```
help [[-Name] <String>] [-Path <String>] [-Category <String[]>] [-Component <String[]>]
 [-Functionality <String[]>] [-Role <String[]>] [-Examples]
```

### Parameters
```
help [[-Name] <String>] [-Path <String>] [-Category <String[]>] [-Component <String[]>]
 [-Functionality <String[]>] [-Role <String[]>] -Parameter <String>
```

### Online
```
help [[-Name] <String>] [-Path <String>] [-Category <String[]>] [-Component <String[]>]
 [-Functionality <String[]>] [-Role <String[]>] [-Online]
```

### ShowWindow
```
help [[-Name] <String>] [-Path <String>] [-Category <String[]>] [-Component <String[]>]
 [-Functionality <String[]>] [-Role <String[]>] [-ShowWindow]
```

## DESCRIPTION
The Get-Help cmdlet displays information about Windows PowerShell concepts and commands, including cmdlets, functions, CIM commands, workflows, providers, aliases and scripts.

To get help for a Windows PowerShell command, type \`Get-Help\` followed by the command name, such as: \`Get-Help Get-Process\`.
To get a list of all help topics on your system, type \`Get-Help *\`.
You can display the whole help topic or use the parameters of the Get-Help cmdlet to get selected parts of the topic, such as the syntax, parameters, or examples.

Conceptual help topics in Windows PowerShell begin with "about_", such as "about_Comparison_Operators".
To see all "about_" topics, type \`Get-Help about_*\`.
To see a particular topic, type \`Get-Help about_\<topic-name\>\`, such as \`Get-Help about_Comparison_Operators\`.

To get help for a Windows PowerShell provider, type \`Get-Help\` followed by the provider name.
For example, to get help for the Certificate provider, type \`Get-Help Certificate\`.

In addition to \`Get-Help\`, you can also type \`help\` or \`man\`, which displays one screen of text at a time, or \`\<cmdlet-name\> -?\`, which is identical to Get-Help but works only for commands.
Get-Help gets the help content that it displays from help files on your computer.
Without the help files, Get-Help displays only basic information about commands.
Some Windows PowerShell modules come with help files.
However, starting in Windows PowerShell 3.0, the modules that come with the Windows operating system do not include help files.
To download or update the help files for a module in Windows PowerShell 3.0, use the Update-Help cmdlet.

You can also view the help topics for Windows PowerShell online in the TechNet Library.
To get the online version of a help topic, use the Online parameter, such as: \`Get-Help Get-Process -Online\`.
To read all of the help topics, see Scripting with Windows PowerShellhttp://go.microsoft.com/fwlink/?LinkID=107116 (http://go.microsoft.com/fwlink/?LinkID=107116) in the TechNet library.

If you type \`Get-Help\` followed by the exact name of a help topic, or by a word unique to a help topic, Get-Help displays the topic contents.
If you enter a word or word pattern that appears in several help topic titles, Get-Help displays a list of the matching titles.
If you enter a word that does not appear in any help topic titles, Get-Help displays a list of topics that include that word in their contents.
Get-Help can get help topics for all supported languages and locales.
Get-Help first looks for help files in the locale set for Windows, then in the parent locale, such as "pt" for "pt-BR", and then in a fallback locale.
Beginning in Windows PowerShell 3.0, if Get-Help does not find help in the fallback locale, it looks for help topics in English, "en-US", before it returns an error message or displaying auto-generated help.

For information about the symbols that Get-Help displays in the command syntax diagram, see about_Command_Syntax.
For information about parameter attributes, such as Required and Position , see about_Parameters.
TROUBLESHOOTING NOTE : In Windows PowerShell 3.0 and Windows PowerShell 4.0, Get-Help cannot find About topics in modules unless the module is imported into the current session.
This is a known issue.
To get About topics in a module, import the module, either by using the Import-Module cmdlet or by running a cmdlet in the module.

## EXAMPLES

### Example 1: Display help about the help system
```
PS C:\>Get-Help
```

This command displays help about the Windows PowerShell help system.

### Example 2: Display available help topics
```
PS C:\>Get-Help *
```

This command displays a list of the available help topics.

### Example 3: Display basic information about a cmdlet
```
PS C:\>Get-Help Get-Alias
PS C:\> Help Get-Alias
PS C:\> Get-Alias -?
```

These commands display basic information about the Get-Alias cmdlet.
The Get-Help and ?
commands display the information on a single page.
The Help command displays the information one page at a time.

### Example 4: Display a list of conceptual topics
```
PS C:\>Get-Help about_*
```

This command displays a list of the conceptual topics included in Windows PowerShell help.
All of these topics begin with the characters about_.
To display a particular help file, type get-help \<topic-name\>, for example, \`Get-Help about_Signing\`.

This command displays the conceptual topics only when the help files for those topics are installed on the computer.
For information about downloading and installing help files in Windows PowerShell 3.0, see Update-Help.

### Example 5: Download and install help files
```
The first command uses the **Get-Help** cmdlet to get help for the Get-Command cmdlet. Without help files, **Get-Help** display the cmdlet name, syntax and alias of **Get-Command**, and prompts you to use the **Update-Help** cmdlet to get the newest help files.
PS C:\>Get-Help Get-Command
NAME
    Get-Command


SYNTAX
   
 Get-Command [[-Name] <string[]>] [-CommandType {Alias | Function | Filter | Cmdlet | ExternalScript | Application |

    Script | All}] [[-ArgumentList] <Object[]>] [-Module <string[]>] [-Syntax] [-TotalCount <int>] [<CommonParameters>]


    Get-Command [-Noun <string[]>] [-Verb <string[]>] [[-ArgumentList] <Object[]>] [-Module <string[]>] [-Syntax] 

    [-TotalCount <int>] [<CommonParameters>]



ALIASES
    gcm 


REMARKS
    Get-Help cannot find the help files for this cmdlet on this computer.
    It is displaying only partial help. To download and install help files
    for this cmdlet, use **Update-Help**. 

The second command runs the **Update-Help** cmdlet without parameters. This command downloads help files from the Internet for all of the modules in the current session and installs them on the local computer.This command works only when the local computer is connected to the Internet. If your computer is not connected to the Internet, you might be able to install help files from a network share. For more information, see Save-Help.
PS C:\>Update-Help

Now that the help files are downloaded, we can repeat the first command in the sequence. This command gets help for the **Get-Command** cmdlet. The cmdlet now gets more extensive help for **Get-Command** and you can use the *Detailed*, *Full*, *Example*, and *Parameter* parameters of **Get-Help** to customize the displays.You can use the **Get-Help** cmdlet as soon as the **Update-Help** command finishes. You do not have to restart Windows PowerShell. 
PS C:\>Get-Help Get-Command
```

This example shows how to download and install new or updated help files for a module.
It uses features that were introduced in Windows PowerShell 3.0.

The example compares the help that Get-Help displays for commands when you do not have help files installed on your computer and when you do have help files.
You can use the same command sequence to update the help files on your computer so that your local help content is never obsolete.

To download and install the help files for the commands that come with Windows PowerShell, and for any modules in the $pshome\Modules directory, open Windows PowerShell by using the Run as administrator option.
If you are not a member of the Administrators group on the computer, you cannot download help for these modules.
However, you can use the Online parameter to open the online version of help for a command, and you can read the help for Windows PowerShell in the TechNet library starting at Scripting with Windows PowerShellhttp://go.microsoft.com/fwlink/?LinkID=107116 (http://go.microsoft.com/fwlink/?LinkID=107116).

### Example 6: Display detailed help
```
PS C:\>Get-Help ls -Detailed
```

This command displays detailed help for the Get-ChildItem cmdlet by specifying one of its aliases, ls.
The Detailed parameter of Get-Help gets the detailed view of the help topic, which includes parameter descriptions and examples.
To see the complete help topic for a cmdlet, use the Full parameter.

The Full and Detailed parameters are effective only when help files for the command are installed on the computer.

### Example 7: Display full information for a cmdlet
```
PS C:\>Get-Help Format-Table -Full
```

This command uses the Full parameter of Get-Help to display the full view help for the Format-Table cmdlet.
The full view of help includes parameter descriptions, examples, and a table of technical details about the parameters.

The Full parameter is effective only when help files for the command are installed on the computer.

### Example 8: Display examples for a cmdlet
```
PS C:\>Get-Help Start-Service -Examples
```

This command displays examples of using the Start-Service cmdlet.
It uses the Examples parameter of Get-Help to display only the Examples section of the cmdlet help topics.

The Examples parameter is effective only when help files for the command are installed on the computer.

### Example 9: Display parameter help
```
PS C:\>Get-Help Format-List -Parameter GroupBy
```

This command uses the Parameter parameter of Get-Help to display a detailed description of the GroupBy parameter of the Format-List cmdlet.
For detailed descriptions of all parameters of the Format-List cmdlet, type \`Get-Help Format-List -Parameter *\`.

### Example 10: Search for a word in cmdlet help
```
PS C:\>Get-Help Add-Member -Full | Out-String -Stream | Select-String -Pattern Clixml
```

This example shows how to search for a word in particular cmdlet help topic.
This command searches for the word Clixml in the full version of the help topic for the Add-Member cmdlet.

Because the Get-Help cmdlet generates a MamlCommandHelpInfo object, not a string, you have to use a cmdlet that transforms the help topic content into a string, such as Out-String or Out-File.

### Example 11: Display online version of help
```
PS C:\>Get-Help Get-Member -Online
```

This command displays the online version of the help topic for the Get-Member cmdlet.

### Example 12: Display a list of topics that include a word
```
PS C:\>Get-Help remoting
```

This command displays a list of topics that include the word remoting.

When you enter a word that does not appear in any topic title, Get-Help displays a list of topics that include that word.

### Example 13: Display provider specific help
```
The first command uses the *Path* parameter of **Get-Help** to specify the provider path. This command can be entered at any path location.
PS C:\>Get-Help Get-Item -Path SQLSERVER:\DataCollection

NAME

    Get-Item


SYNOPSIS

    Gets a collection of Server objects for the local computer and any computers

    to which you have made a SQL Server PowerShell connection.

    ...

The second command uses the Set-Location cmdlet (alias = "cd") to navigate to the provider path. From that location, even without the *Path* parameter, the **Get-Help** command gets the provider-specific help for the **Get-Item** cmdlet.
PS C:\>cd SQLSERVER:\DataCollection
SQLSERVER:\DataCollection> Get-Help Get-Item

NAME

    Get-Item


SYNOPSIS

    Gets a collection of Server objects for the local computer and any computers

    to which you have made a SQL Server PowerShell connection.

    ...


The third command shows that a **Get-Help** command in a file system path, and without the *Path* parameter, gets the standard help for the **Get-Item** cmdlet.
PS C:\>Get-Item

NAME

    Get-Item


SYNOPSIS

    Gets the item at the specified location.
    ...
```

This example shows how to get help that explains how to use the Get-Item cmdlet in the DataCollection node of the Windows PowerShellSQL Server provider.
The example shows two ways of getting the provider-specific help for Get-Item .

You can also get provider-specific help for cmdlets online in the section that describes the provider.
For example, for provider-specific online help for the New-Item cmdlet in each WSMan provider path, see New-Item for ClientCertificatehttp://go.microsoft.com/fwlink/?LinkID=158676 in the TechNet library.

### Example 14: Display help for a script
```
PS C:\>Get-Help C:\PS-Test\MyScript.ps1
```

This command gets help for the MyScript.ps1 script.
For information about how to write help for your functions and scripts, see about_Comment_Based_Help.

## PARAMETERS

### -Category
Displays help only for items in the specified category and their aliases.
The acceptable values for this parameter are:

- Alias
- Cmdlet
- Provider
- General
- FAQ
- Glossary
- HelpFile
- ScriptCommand
- Function
- Filter
- ExternalScript
- All
- DefaultHelp
- Workflow
- DscResource
- Class
- Configuration

Conceptual topics are in the HelpFile category.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 
Accepted values: Alias, Cmdlet, Provider, General, FAQ, Glossary, HelpFile, ScriptCommand, Function, Filter, ExternalScript, All, DefaultHelp, Workflow, DscResource, Class, Configuration

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Component
Displays commands with the specified component value, such as "Exchange." Enter a component name.
Wildcard characters are permitted.

This parameter has no effect on displays of conceptual ("About_") help.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Detailed
Adds parameter descriptions and examples to the basic help display.

This parameter is effective only when help files are for the command are installed on the computer.
It has no effect on displays of conceptual ("About_") help.

```yaml
Type: SwitchParameter
Parameter Sets: DetailedView
Aliases: 

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Examples
Displays only the name, synopsis, and examples.
To display only the examples, type \`(Get-Help \<cmdlet-name\>).Examples\`.

This parameter is effective only when help files are for the command are installed on the computer.
It has no effect on displays of conceptual ("About_") help.

```yaml
Type: SwitchParameter
Parameter Sets: Examples
Aliases: 

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Full
Displays the whole help topic for a cmdlet.
This includes parameter descriptions and attributes, examples, input and output object types, and additional notes.

This parameter is effective only when help files are for the command are installed on the computer.
It has no effect on displays of conceptual ("About_") help.

```yaml
Type: SwitchParameter
Parameter Sets: AllUsersView
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Functionality
Displays help for items with the specified functionality.
Enter the functionality.
Wildcard characters are permitted.

This parameter has no effect on displays of conceptual ("About_") help.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Gets help about the specified command or concept.
Enter the name of a cmdlet, function, provider, script, or workflow, such as \`Get-Member\`, a conceptual topic name, such as \`about_Objects\`, or an alias, such as \`ls\`.
Wildcard characters are permitted in cmdlet and provider names, but you cannot use wildcard characters to find the names of function help and script help topics.

To get help for a script that is not located in a path that is listed in the Path environment variable, type the path and file name of the script.

If you enter the exact name of a help topic, Get-Help displays the topic contents.
If you enter a word or word pattern that appears in several help topic titles, Get-Help displays a list of the matching titles.
If you enter a word that does not match any help topic titles, Get-Help displays a list of topics that include that word in their contents.

The names of conceptual topics, such as \`about_Objects\`, must be entered in English, even in non-English versions of Windows PowerShell.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Online
Displays the online version of a help topic in the default Internet browser.
This parameter is valid only for cmdlet, function, workflow and script help topics.
You cannot use the Online parameter in Get-Help commands in a remote session.

For information about supporting this feature in help topics that you write, see about_Comment_Based_Help (http://go.microsoft.com/fwlink/?LinkID=144309), and Supporting Online Help (http://go.microsoft.com/fwlink/?LinkID=242132), and [How to Write Cmdlet Help](https://go.microsoft.com/fwlink/?LinkID=123415) in the MSDN library.

```yaml
Type: SwitchParameter
Parameter Sets: Online
Aliases: 

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Parameter
Displays only the detailed descriptions of the specified parameters.
Wildcards are permitted.

This parameter has no effect on displays of conceptual ("About_") help.

```yaml
Type: String
Parameter Sets: Parameters
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Gets help that explains how the cmdlet works in the specified provider path.
Enter a Windows PowerShell provider path.

This parameter gets a customized version of a cmdlet help topic that explains how the cmdlet works in the specified Windows PowerShell provider path.
This parameter is effective only for help about a provider cmdlet and only when the provider includes a custom version of the provider cmdlet help topic in its help file.
To use this parameter, install the help file for the module that includes the provider.

To see the custom cmdlet help for a provider path, go to the provider path location and enter a Get-Help command or, from any path location, use the Path parameter of Get-Help to specify the provider path.
You can also find custom cmdlet help online in the provider help section of the help topics.
For example, you can find help for the New-Item cmdlet in the Wsman:\*\ClientCertificate path (http://go.microsoft.com/fwlink/?LinkID=158676).

For more information about Windows PowerShell providers, see about_Providers (http://go.microsoft.com/fwlink/?LinkID=113250) in the TechNet library.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Role
Displays help customized for the specified user role.
Enter a role.
Wildcard characters are permitted.

Enter the role that the user plays in an organization.
Some cmdlets display different text in their help files based on the value of this parameter.
This parameter has no effect on help for the core cmdlets.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowWindow
Displays the help topic in a window for easier reading.
The window includes a Find search feature and a Settings box that lets you set options for the display.
These include options to display only selected sections of a help topic.

The ShowWindow parameter supports help topics for commands, which include cmdlets, functions, CIM commands, workflows, and scripts, and conceptual About topics.
It does not support provider help.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: ShowWindow
Aliases: 

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None
You cannot pipe objects to this cmdlet.

## OUTPUTS

### ExtendedCmdletHelpInfo
If you run Get-Help on a command that does not have a help file, Get-Help returns an ExtendedCmdletHelpInfo object that represents autogenerated help.

### System.String
If you get a conceptual help topic, Get-Help returns it as a string.

### MamlCommandHelpInfo
If you get a command that has a help file, Get-Help returns a MamlCommandHelpInfo object.

## NOTES
If you do not specify parameters, Get-Help * displays information about the Windows PowerShell help system.
Windows PowerShell 3.0 does not include help files.
To download and install the help files that Get-Help reads, use the Update-Help cmdlet.
You can use the Update-Help * cmdlet to download and install help files for the core commands that come with Windows PowerShell and for any modules that you install.
You can also use it to update the help files so that the help on your computer is never outdated.

You can also read the help topics about the commands that come with Windows PowerShell online starting at Scripting with Windows PowerShellhttp://go.microsoft.com/fwlink/?LinkID=107116 (http://go.microsoft.com/fwlink/?LinkID=107116). 
Get-Help displays help in the locale set for the Windows operating system or in the fallback language for that locale.
If you do not have help files for the primary or fallback locale, Get-Help * behaves as if there are no help files on the computer.
To get help for a different locale, use Region and Language in Control Panel to change the settings.

* The full view of help includes a table of information about the parameters. The table includes the following fields:
- Required. Indicates whether the parameter is required (true) or optional (false).
- Position. Indicates whether the parameter is named or positional (numbered). Positional parameters must appear in a specified place in the command.
---- "Named" indicates that the parameter name is required, but that the parameter can appear anywhere in the command.
---- \<Number\> indicates that the parameter name is optional, but when the name is omitted, the parameter must be in the place specified by the number. For example, "2" indicates that when the parameter name is omitted, the parameter must be the second (2) or only unnamed parameter in the command. When the parameter name is used, the parameter can appear anywhere in the command.
- Default value. The parameter value that Windows PowerShell uses if you do not include the parameter in the command.
- Accepts pipeline input. Indicates whether you can (true) or cannot (false) send objects to the parameter through a pipeline. "By Property Name" means that the pipelined object must have a property that has the same name as the parameter name.
- Accepts wildcard characters. Indicates whether the value of a parameter can include wildcard characters, such as * and ?.

## RELATED LINKS

[Updatable Help Status Table (http://go.microsoft.com/fwlink/?LinkID=270007)](http://go.microsoft.com/fwlink/?LinkID=270007)

[about_Command_Syntax](http://technet.microsoft.com/library/hh847867.aspx)

[Get-Command](get-command.md)

[about_Comment_Based_Help](About/about_Comment_Based_Help.md)

[about_Parameters](About/about_Parameters.md)


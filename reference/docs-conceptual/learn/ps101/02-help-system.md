# Chapter 2 - The Help System

Two groups of IT Pros were given a written test without access to a computer to determine their
skill level with PowerShell. PowerShell beginners were placed in one group and experts in another.
Based on the results of the test, there didn't seem to be much difference in the skill level between
the two groups. Both groups were given a second test which was similar to the first one except this
time they were given access to an isolated computer with PowerShell on it that didn't have access to
the Internet. The results of the second test showed there was a huge difference in the skill level
of the two groups. Why were these differences observed in the results of the first and second test
between these two groups?

Experts don't always know the answers, but they know how to figure out the answers.

The differences in the two tests mentioned in the previous scenario were observed because experts
don't memorize how to use thousands of commands in PowerShell. They learn how to use the help system
within PowerShell extremely well. This allows them to not only find the necessary commands when
needed, but to also figure out how to use those commands once they've found them.

I've heard Jeffrey Snover, the inventor of PowerShell, tell a similar story a number of times.

Mastering the help system is the key to being successful with PowerShell.

## Discoverability

Compiled commands in PowerShell are called cmdlets. Cmdlet is pronounced command-let (not CMD-let).
Cmdlets are in the form of singular Verb-Noun commands which makes them easily discoverable. For
example, the cmdlet for determining what processes are running is Get-Process and the cmdlet for
retrieving a list of services and their statuses is Get-Service. There are other types of commands
in PowerShell such as aliases and functions which will be covered later in this book. The term
PowerShell command is a generic term that's often used to refer to any type of command in
PowerShell, regardless of whether or not it's a cmdlet, function, or alias.

## The Three Core Cmdlets in PowerShell

- Get-Command
- Get-Help
- Get-Member (Covered in chapter 3)

One question I'm often asked is how do you figure out what the commands are in PowerShell? Both
Get-Command and Get-Help can be used to determine the commands.

## Get-Help

Get-Help is a multipurpose command. Get-Help helps you learn how to use commands once you find them.
Get-Help can also be used to help locate commands, but in a different and more indirect way when
compared to Get-Command.

When Get-Help is used to locate commands, it first searches for wildcard matches of command names
based on the provided input. If it doesn't find a match, it searches through the help topics
themselves, and if no match is found an error is returned. Contrary to popular belief, Get-Help can
be used to find commands that don't have help topics.

The first thing you need to know about the help system in PowerShell is how to use the Get-Help
cmdlet. The following command is used to display the help topic for Get-Help.

```powershell
Get-Help -Name Get-Help
```

```powershell
Do you want to run Update-Help?
The Update-Help cmdlet downloads the most current Help files for Windows PowerShell
modules, and installs them on your computer. For more information about the Update-Help
cmdlet, see http://go.microsoft.com/fwlink/?LinkId=210614.
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"):
```

Beginning with PowerShell version 3, PowerShell help doesn't ship with the operating system, so the
first time Get-Help is run for a command, the previous message will be displayed. If the help
function or man alias is used instead of the Get-Help cmdlet, you won't receive this prompt.

Answering yes by pressing "Y" (Y can be specified in either upper or lower case), runs the
Update-Help cmdlet which requires Internet access by default.

Once the help is downloaded and the update is complete, the help topic is returned for the specified
command:

```powershell
Get-Help -Name Get-Help
```

```Output
Do you want to run Update-Help?
The Update-Help cmdlet downloads the most current Help files for Windows PowerShell
modules, and installs them on your computer. For more information about the Update-Help
cmdlet, see http://go.microsoft.com/fwlink/?LinkId=210614.
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"): y

NAME
    Get-Help

SYNOPSIS
    Displays information about Windows PowerShell commands and concepts.


SYNTAX
    Get-Help [[-Name] <String>] [-Category {Alias | Cmdlet | Provider | General | FAQ |
    Glossary | HelpFile | ScriptCommand | Function | Filter | ExternalScript | All |
    DefaultHelp | Workflow | DscResource | Class | Configuration}] [-Component
    <String[]>] [-Full] [-Functionality <String[]>] [-Path <String>] [-Role <String[]>]
    [<CommonParameters>]

    Get-Help [[-Name] <String>] [-Category {Alias | Cmdlet | Provider | General | FAQ |
    Glossary | HelpFile | ScriptCommand | Function | Filter | ExternalScript | All |
    DefaultHelp | Workflow | DscResource | Class | Configuration}] [-Component
    <String[]>] [-Functionality <String[]>] [-Path <String>] [-Role <String[]>]
    -Detailed [<CommonParameters>]

    Get-Help [[-Name] <String>] [-Category {Alias | Cmdlet | Provider | General | FAQ |
    Glossary | HelpFile | ScriptCommand | Function | Filter | ExternalScript | All |
    DefaultHelp | Workflow | DscResource | Class | Configuration}] [-Component
    <String[]>] [-Functionality <String[]>] [-Path <String>] [-Role <String[]>]
    -Examples [<CommonParameters>]

    Get-Help [[-Name] <String>] [-Category {Alias | Cmdlet | Provider | General | FAQ |
    Glossary | HelpFile | ScriptCommand | Function | Filter | ExternalScript | All |
    DefaultHelp | Workflow | DscResource | Class | Configuration}] [-Component
    <String[]>] [-Functionality <String[]>] [-Path <String>] [-Role <String[]>] -Online
    [<CommonParameters>]

    Get-Help [[-Name] <String>] [-Category {Alias | Cmdlet | Provider | General | FAQ |
    Glossary | HelpFile | ScriptCommand | Function | Filter | ExternalScript | All |
    DefaultHelp | Workflow | DscResource | Class | Configuration}] [-Component
    <String[]>] [-Functionality <String[]>] [-Path <String>] [-Role <String[]>]
    -Parameter <String> [<CommonParameters>]

    Get-Help [[-Name] <String>] [-Category {Alias | Cmdlet | Provider | General | FAQ |
    Glossary | HelpFile | ScriptCommand | Function | Filter | ExternalScript | All |
    DefaultHelp | Workflow | DscResource | Class | Configuration}] [-Component
    <String[]>] [-Functionality <String[]>] [-Path <String>] [-Role <String[]>]
    -ShowWindow [<CommonParameters>]


DESCRIPTION
    The Get-Help cmdlet displays information about Windows PowerShell concepts and
    commands, including cmdlets, functions, CIM commands, workflows, providers, aliases
    and scripts.

    To get help for a Windows PowerShell command, type Get-Help followed by the command
    name, such as: Get-Help Get-Process. To get a list of all help topics on your
    system, type Get-Help *. You can display the whole help topic or use the parameters
    of the Get-Help cmdlet to get selected parts of the topic, such as the syntax,
    parameters, or examples.

    Conceptual help topics in Windows PowerShell begin with "about_", such as
    "about_Comparison_Operators". To see all "about_" topics, type Get-Help about_*. To
    see a particular topic, type Get-Help about_<topic-name>, such as Get-Help
    about_Comparison_Operators.

    To get help for a Windows PowerShell provider, type Get-Help followed by the
    provider name. For example, to get help for the Certificate provider, type Get-Help
    Certificate.

    In addition to Get-Help, you can also type help or man, which displays one screen of
    text at a time, or <cmdlet-name> -?, which is identical to Get-Help but works only
    for commands.

    Get-Help gets the help content that it displays from help files on your computer.
    Without the help files, Get-Help displays only basic information about commands.
    Some Windows PowerShell modules come with help files. However, starting in Windows
    PowerShell 3.0, the modules that come with the Windows operating system do not
    include help files. To download or update the help files for a module in Windows
    PowerShell 3.0, use the Update-Help cmdlet.

    You can also view the help topics for Windows PowerShell online in the TechNet
    Library. To get the online version of a help topic, use the Online parameter, such
    as: Get-Help Get-Process -Online. To read all of the help topics, see Scripting with
    Windows PowerShell (http://go.microsoft.com/fwlink/?LinkID=107116) in the TechNet
    library.

    If you type Get-Help followed by the exact name of a help topic, or by a word unique
    to a help topic, Get-Help displays the topic contents. If you enter a word or word
    pattern that appears in several help topic titles, Get-Help displays a list of the
    matching titles. If you enter a word that does not appear in any help topic titles,
    Get-Help displays a list of topics that include that word in their contents.

    Get-Help can get help topics for all supported languages and locales. Get-Help first
    looks for help files in the locale set for Windows, then in the parent locale, such
    as "pt" for "pt-BR", and then in a fallback locale. Beginning in Windows PowerShell
    3.0, if Get-Help does not find help in the fallback locale, it looks for help topics
    in English, "en-US", before it returns an error message or displaying auto-generated
    help.

    For information about the symbols that Get-Help displays in the command syntax
    diagram, see about_Command_Syntax. For information about parameter attributes, such
    as Required and Position, see about_Parameters.

    TROUBLESHOOTING NOTE: In Windows PowerShell 3.0 and Windows PowerShell 4.0, Get-Help
    cannot find About topics in modules unless the module is imported into the current
    session. This is a known issue. To get About topics in a module, import the module,
    either by using the Import-Module cmdlet or by running a cmdlet in the module.


RELATED LINKS
    Online Version: http://go.microsoft.com/fwlink/?LinkId=821483
    Updatable Help Status Table (http://go.microsoft.com/fwlink/?LinkID=270007)
    about_Command_Syntax
    Get-Command
    about_Comment_Based_Help
    about_Parameters

REMARKS
    To see the examples, type: "get-help Get-Help -examples".
    For more information, type: "get-help Get-Help -detailed".
    For technical information, type: "get-help Get-Help -full".
    For online help, type: "get-help Get-Help -online"
```

As you can see, help topics can contain an enormous amount of information and this isn't even the
entire help topic.

While not specific to PowerShell, a parameter is a way to provide input to a command. Get-Help has
numerous parameters that can be specified in order to return the entire help topic or a subset of
it.

The syntax section of the help topic shown in the previous set of results lists all of the
parameters for Get-Help. At first glance, it appears the same parameters are listed six different
times. Each of those different blocks in the syntax section is a parameter set. This means the
Get-Help cmdlet has six different parameter sets. If you take a closer look, you'll notice that at
least one parameter is different in each of the parameter sets.

Parameter sets are mutually exclusive. Once a unique parameter that only exists in one of the
parameter sets is used, only parameters contained within that parameter set can be used. For
example, both the Full and Detailed parameters couldn't be specified at the same time because they
reside in different parameter sets.

The following parameters each reside in different parameter sets:

- Full
- Detailed
- Examples
- Online
- Parameter
- ShowWindow

All of the cryptic syntax such as square and angle brackets in the syntax section means something
but will be covered in Appendix A of this book. While important, learning what the cryptic syntax
means is often short lived since it's difficult to retain for someone who is new to PowerShell and
may not use it everyday. For beginners, there's an easier way to figure out the same information
except in plain English.

When the Full parameter of Get-Help is specified, the entire help topic is returned.

```powershell
Get-Help -Name Get-Help -Full
```

```Output
NAME
    Get-Help

SYNOPSIS
    Displays information about Windows PowerShell commands and concepts.


SYNTAX
    Get-Help [[-Name] <String>] [-Category {Alias | Cmdlet | Provider | General | FAQ |
    Glossary | HelpFile | ScriptCommand | Function | Filter | ExternalScript | All |
    DefaultHelp | Workflow | DscResource | Class | Configuration}] [-Component
    <String[]>] -Detailed [-Functionality <String[]>] [-Path <String>] [-Role
    <String[]>] [<CommonParameters>]

    Get-Help [[-Name] <String>] [-Category {Alias | Cmdlet | Provider | General | FAQ |
    Glossary | HelpFile | ScriptCommand | Function | Filter | ExternalScript | All |
    DefaultHelp | Workflow | DscResource | Class | Configuration}] [-Component
    <String[]>] -Examples [-Functionality <String[]>] [-Path <String>] [-Role
    <String[]>] [<CommonParameters>]

    Get-Help [[-Name] <String>] [-Category {Alias | Cmdlet | Provider | General | FAQ |
    Glossary | HelpFile | ScriptCommand | Function | Filter | ExternalScript | All |
    DefaultHelp | Workflow | DscResource | Class | Configuration}] [-Component
    <String[]>] [-Full] [-Functionality <String[]>] [-Path <String>] [-Role <String[]>]
    [<CommonParameters>]

    Get-Help [[-Name] <String>] [-Category {Alias | Cmdlet | Provider | General | FAQ |
    Glossary | HelpFile | ScriptCommand | Function | Filter | ExternalScript | All |
    DefaultHelp | Workflow | DscResource | Class | Configuration}] [-Component
    <String[]>] [-Functionality <String[]>] -Online [-Path <String>] [-Role <String[]>]
    [<CommonParameters>]

    Get-Help [[-Name] <String>] [-Category {Alias | Cmdlet | Provider | General | FAQ |
    Glossary | HelpFile | ScriptCommand | Function | Filter | ExternalScript | All |
    DefaultHelp | Workflow | DscResource | Class | Configuration}] [-Component
    <String[]>] [-Functionality <String[]>] -Parameter <String> [-Path <String>] [-Role
    <String[]>] [<CommonParameters>]

    Get-Help [[-Name] <String>] [-Category {Alias | Cmdlet | Provider | General | FAQ |
    Glossary | HelpFile | ScriptCommand | Function | Filter | ExternalScript | All |
    DefaultHelp | Workflow | DscResource | Class | Configuration}] [-Component
    <String[]>] [-Functionality <String[]>] [-Path <String>] [-Role <String[]>]
    -ShowWindow [<CommonParameters>]


DESCRIPTION
    The Get-Help cmdlet displays information about Windows PowerShell concepts and
    commands, including cmdlets, functions, CIM commands, workflows, providers, aliases
    and scripts.

    To get help for a Windows PowerShell command, type `Get-Help` followed by the
    command name, such as: `Get-Help Get-Process`. To get a list of all help topics on
    your system, type `Get-Help *`. You can display the whole help topic or use the
    parameters of the Get-Help cmdlet to get selected parts of the topic, such as the
    syntax, parameters, or examples.

    Conceptual help topics in Windows PowerShell begin with "about_", such as
    "about_Comparison_Operators". To see all "about_" topics, type `Get-Help about_*`.
    To see a particular topic, type `Get-Help about_<topic-name>`, such as `Get-Help
    about_Comparison_Operators`.

    To get help for a Windows PowerShell provider, type `Get-Help` followed by the
    provider name. For example, to get help for the Certificate provider, type `Get-Help
    Certificate`.

    In addition to `Get-Help`, you can also type `help` or `man`, which displays one
    screen of text at a time, or `<cmdlet-name> -?`, which is identical to Get-Help but
    works only for commands. Get-Help gets the help content that it displays from help
    files on your computer. Without the help files, Get-Help displays only basic
    information about commands. Some Windows PowerShell modules come with help files.
    However, starting in Windows PowerShell 3.0, the modules that come with the Windows
    operating system do not include help files. To download or update the help files for
    a module in Windows PowerShell 3.0, use the Update-Help cmdlet.

    You can also view the help topics for Windows PowerShell online in the TechNet
    Library. To get the online version of a help topic, use the Online parameter, such
    as: `Get-Help Get-Process -Online`. To read all of the help topics, see Scripting
    with Windows PowerShellhttp://go.microsoft.com/fwlink/?LinkID=107116
    (http://go.microsoft.com/fwlink/?LinkID=107116) in the TechNet library.

    If you type `Get-Help` followed by the exact name of a help topic, or by a word
    unique to a help topic, Get-Help displays the topic contents. If you enter a word or
    word pattern that appears in several help topic titles, Get-Help displays a list of
    the matching titles. If you enter a word that does not appear in any help topic
    titles, Get-Help displays a list of topics that include that word in their contents.
    Get-Help can get help topics for all supported languages and locales. Get-Help first
    looks for help files in the locale set for Windows, then in the parent locale, such
    as "pt" for "pt-BR", and then in a fallback locale. Beginning in Windows PowerShell
    3.0, if Get-Help does not find help in the fallback locale, it looks for help topics
    in English, "en-US", before it returns an error message or displaying auto-generated
    help.

    For information about the symbols that Get-Help displays in the command syntax
    diagram, see about_Command_Syntax. For information about parameter attributes, such
    as Required and Position , see about_Parameters. TROUBLESHOOTING NOTE : In Windows
    PowerShell 3.0 and Windows PowerShell 4.0, Get-Help cannot find About topics in
    modules unless the module is imported into the current session. This is a known
    issue. To get About topics in a module, import the module, either by using the
    Import-Module cmdlet or by running a cmdlet in the module.


PARAMETERS
    -Category <String[]>
        Displays help only for items in the specified category and their aliases. The
        acceptable values for this parameter are:

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


        Required?                    false
        Position?                    named
        Default value                None
        Accept pipeline input?       False
        Accept wildcard characters?  false

    -Component <String[]>
        Displays commands with the specified component value, such as "Exchange." Enter
        a component name. Wildcard characters are permitted.

        This parameter has no effect on displays of conceptual ("About_") help.

        Required?                    false
        Position?                    named
        Default value                None
        Accept pipeline input?       False
        Accept wildcard characters?  false

    -Detailed [<SwitchParameter>]
        Adds parameter descriptions and examples to the basic help display.

        This parameter is effective only when help files are for the command are
        installed on the computer. It has no effect on displays of conceptual ("About_")
        help.

        Required?                    true
        Position?                    named
        Default value                False
        Accept pipeline input?       False
        Accept wildcard characters?  false

    -Examples [<SwitchParameter>]
        Displays only the name, synopsis, and examples. To display only the examples,
        type `(Get-Help <cmdlet-name>).Examples`.

        This parameter is effective only when help files are for the command are
        installed on the computer. It has no effect on displays of conceptual ("About_")
        help.

        Required?                    true
        Position?                    named
        Default value                False
        Accept pipeline input?       False
        Accept wildcard characters?  false

    -Full [<SwitchParameter>]
        Displays the whole help topic for a cmdlet. This includes parameter descriptions
        and attributes, examples, input and output object types, and additional notes.

        This parameter is effective only when help files are for the command are
        installed on the computer. It has no effect on displays of conceptual ("About_")
        help.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       False
        Accept wildcard characters?  false

    -Functionality <String[]>
        Displays help for items with the specified functionality. Enter the
        functionality. Wildcard characters are permitted.

        This parameter has no effect on displays of conceptual ("About_") help.

        Required?                    false
        Position?                    named
        Default value                None
        Accept pipeline input?       False
        Accept wildcard characters?  false

    -Name <String>
        Gets help about the specified command or concept. Enter the name of a cmdlet,
        function, provider, script, or workflow, such as `Get-Member`, a conceptual
        topic name, such as `about_Objects`, or an alias, such as `ls`. Wildcard
        characters are permitted in cmdlet and provider names, but you cannot use
        wildcard characters to find the names of function help and script help topics.

        To get help for a script that is not located in a path that is listed in the
        Path environment variable, type the path and file name of the script.

        If you enter the exact name of a help topic, Get-Help displays the topic
        contents. If you enter a word or word pattern that appears in several help topic
        titles, Get-Help displays a list of the matching titles. If you enter a word
        that does not match any help topic titles, Get-Help displays a list of topics
        that include that word in their contents.

        The names of conceptual topics, such as `about_Objects`, must be entered in
        English, even in non-English versions of Windows PowerShell.

        Required?                    false
        Position?                    0
        Default value                None
        Accept pipeline input?       True (ByPropertyName)
        Accept wildcard characters?  false

    -Online [<SwitchParameter>]
        Displays the online version of a help topic in the default Internet browser.
        This parameter is valid only for cmdlet, function, workflow and script help
        topics. You cannot use the Online parameter in Get-Help commands in a remote
        session.

        For information about supporting this feature in help topics that you write, see
        about_Comment_Based_Help (http://go.microsoft.com/fwlink/?LinkID=144309), and
        Supporting Online Help (http://go.microsoft.com/fwlink/?LinkID=242132), and How
        to Write Cmdlet Helphttp://go.microsoft.com/fwlink/?LinkID=123415
        (http://go.microsoft.com/fwlink/?LinkID=123415) in the Microsoft Developer
        Network MSDN library.

        Required?                    true
        Position?                    named
        Default value                False
        Accept pipeline input?       False
        Accept wildcard characters?  false

    -Parameter <String>
        Displays only the detailed descriptions of the specified parameters. Wildcards
        are permitted.

        This parameter has no effect on displays of conceptual ("About_") help.

        Required?                    true
        Position?                    named
        Default value                None
        Accept pipeline input?       False
        Accept wildcard characters?  false

    -Path <String>
        Gets help that explains how the cmdlet works in the specified provider path.
        Enter a Windows PowerShell provider path.

        This parameter gets a customized version of a cmdlet help topic that explains
        how the cmdlet works in the specified Windows PowerShell provider path. This
        parameter is effective only for help about a provider cmdlet and only when the
        provider includes a custom version of the provider cmdlet help topic in its help
        file. To use this parameter, install the help file for the module that includes
        the provider.

        To see the custom cmdlet help for a provider path, go to the provider path
        location and enter a Get-Help command or, from any path location, use the Path
        parameter of Get-Help to specify the provider path. You can also find custom
        cmdlet help online in the provider help section of the help topics. For example,
        you can find help for the New-Item cmdlet in the Wsman:\*\ClientCertificate path
        (http://go.microsoft.com/fwlink/?LinkID=158676).

        For more information about Windows PowerShell providers, see about_Providers
        (http://go.microsoft.com/fwlink/?LinkID=113250) in the TechNet library.

        Required?                    false
        Position?                    named
        Default value                None
        Accept pipeline input?       False
        Accept wildcard characters?  false

    -Role <String[]>
        Displays help customized for the specified user role. Enter a role. Wildcard
        characters are permitted.

        Enter the role that the user plays in an organization. Some cmdlets display
        different text in their help files based on the value of this parameter. This
        parameter has no effect on help for the core cmdlets.

        Required?                    false
        Position?                    named
        Default value                None
        Accept pipeline input?       False
        Accept wildcard characters?  false

    -ShowWindow [<SwitchParameter>]
        Displays the help topic in a window for easier reading. The window includes a
        Find search feature and a Settings box that lets you set options for the
        display. These include options to display only selected sections of a help topic.

        The ShowWindow parameter supports help topics for commands, which include
        cmdlets, functions, CIM commands, workflows, and scripts, and conceptual About
        topics. It does not support provider help.

        This parameter was introduced in Windows PowerShell 3.0.

        Required?                    true
        Position?                    named
        Default value                False
        Accept pipeline input?       False
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

INPUTS
    None
        You cannot pipe objects to this cmdlet.


OUTPUTS
    ExtendedCmdletHelpInfo
        If you run Get-Help on a command that does not have a help file, Get-Help
        returns an ExtendedCmdletHelpInfo object that represents autogenerated help.

    System.String
        If you get a conceptual help topic, Get-Help returns it as a string.

    MamlCommandHelpInfo
        If you get a command that has a help file, Get-Help returns a
        MamlCommandHelpInfo object.


NOTES


        If you do not specify parameters, Get-Help * displays information about the
        Windows PowerShell help system. Windows PowerShell 3.0 does not include help
        files. To download and install the help files that Get-Help reads, use the
        Update-Help cmdlet. You can use the Update-Help * cmdlet to download and install
        help files for the core commands that come with Windows PowerShell and for any
        modules that you install. You can also use it to update the help files so that
        the help on your computer is never outdated.

        You can also read the help topics about the commands that come with Windows
        PowerShell online starting at Scripting with Windows
        PowerShellhttp://go.microsoft.com/fwlink/?LinkID=107116
        (http://go.microsoft.com/fwlink/?LinkID=107116).  Get-Help displays help in the
        locale set for the Windows operating system or in the fallback language for that
        locale. If you do not have help files for the primary or fallback locale,
        Get-Help * behaves as if there are no help files on the computer. To get help
        for a different locale, use Region and Language in Control Panel to change the
        settings.

        * The full view of help includes a table of information about the parameters.
        The table includes the following fields:


        - Required. Indicates whether the parameter is required (true) or optional
        (false).

        - Position. Indicates whether the parameter is named or positional (numbered).
        Positional parameters must appear in a specified place in the command.

        ---- "Named" indicates that the parameter name is required, but that the
        parameter can appear anywhere in the command.

        ---- <Number> indicates that the parameter name is optional, but when the name
        is omitted, the parameter must be in the place specified by the number. For
        example, "2" indicates that when the parameter name is omitted, the parameter
        must be the second (2) or only unnamed parameter in the command. When the
        parameter name is used, the parameter can appear anywhere in the command.

        - Default value. The parameter value that Windows PowerShell uses if you do not
        include the parameter in the command.

        - Accepts pipeline input. Indicates whether you can (true) or cannot (false)
        send objects to the parameter through a pipeline. "By Property Name" means that
        the pipelined object must have a property that has the same name as the
        parameter name.
        - Accepts wildcard characters. Indicates whether the value of a parameter can
        include wildcard characters, such as * and ?.


    Example 1: Display help about the help system

    PS C:\>Get-Help

    This command displays help about the Windows PowerShell help system.
    Example 2: Display available help topics

    PS C:\>Get-Help *

    This command displays a list of the available help topics.
    Example 3: Display basic information about a cmdlet

    PS C:\>Get-Help Get-Alias
    Help Get-Alias
    Get-Alias -?

    These commands display basic information about the Get-Alias cmdlet. The Get-Help
    and ? commands display the information on a single page. The Help command displays
    the information one page at a time.
    Example 4: Display a list of conceptual topics

    PS C:\>Get-Help about_*

    This command displays a list of the conceptual topics included in Windows PowerShell
    help. All of these topics begin with the characters about_. To display a particular
    help file, type get-help <topic-name>, for example, `Get-Help about_Signing`.

    This command displays the conceptual topics only when the help files for those
    topics are installed on the computer. For information about downloading and
    installing help files in Windows PowerShell 3.0, see Update-Help.
    Example 5: Download and install help files

    The first command uses the **Get-Help** cmdlet to get help for the Get-Command
    cmdlet. Without help files, **Get-Help** display the cmdlet name, syntax and alias
    of **Get-Command**, and prompts you to use the **Update-Help** cmdlet to get the
    newest help files.
    PS C:\>Get-Help Get-Command
    NAME
        Get-Command


    SYNTAX

     Get-Command [[-Name] <string[]>] [-CommandType {Alias | Function | Filter | Cmdlet
    | ExternalScript | Application |

        Script | All}] [[-ArgumentList] <Object[]>] [-Module <string[]>] [-Syntax]
    [-TotalCount <int>] [<CommonParameters>]


        Get-Command [-Noun <string[]>] [-Verb <string[]>] [[-ArgumentList] <Object[]>]
    [-Module <string[]>] [-Syntax]

        [-TotalCount <int>] [<CommonParameters>]



    ALIASES
        gcm


    REMARKS
        Get-Help cannot find the help files for this cmdlet on this computer.
        It is displaying only partial help. To download and install help files
        for this cmdlet, use **Update-Help**.

    The second command runs the **Update-Help** cmdlet without parameters. This command
    downloads help files from the Internet for all of the modules in the current session
    and installs them on the local computer.This command works only when the local
    computer is connected to the Internet. If your computer is not connected to the
    Internet, you might be able to install help files from a network share. For more
    information, see Save-Help.
    PS C:\>Update-Help

    Now that the help files are downloaded, we can repeat the first command in the
    sequence. This command gets help for the **Get-Command** cmdlet. The cmdlet now gets
    more extensive help for **Get-Command** and you can use the *Detailed*, *Full*,
    *Example*, and *Parameter* parameters of **Get-Help** to customize the displays.You
    can use the **Get-Help** cmdlet as soon as the **Update-Help** command finishes. You
    do not have to restart Windows PowerShell.
    PS C:\>Get-Help Get-Command

    This example shows how to download and install new or updated help files for a
    module. It uses features that were introduced in Windows PowerShell 3.0.

    The example compares the help that Get-Help displays for commands when you do not
    have help files installed on your computer and when you do have help files. You can
    use the same command sequence to update the help files on your computer so that your
    local help content is never obsolete.

    To download and install the help files for the commands that come with Windows
    PowerShell, and for any modules in the $pshome\Modules directory, open Windows
    PowerShell by using the Run as administrator option. If you are not a member of the
    Administrators group on the computer, you cannot download help for these modules.
    However, you can use the Online parameter to open the online version of help for a
    command, and you can read the help for Windows PowerShell in the TechNet library
    starting at Scripting with Windows
    PowerShellhttp://go.microsoft.com/fwlink/?LinkID=107116
    (http://go.microsoft.com/fwlink/?LinkID=107116).
    Example 6: Display detailed help

    PS C:\>Get-Help ls -Detailed

    This command displays detailed help for the Get-ChildItem cmdlet by specifying one
    of its aliases, ls. The Detailed parameter of Get-Help gets the detailed view of the
    help topic, which includes parameter descriptions and examples. To see the complete
    help topic for a cmdlet, use the Full parameter.

    The Full and Detailed parameters are effective only when help files for the command
    are installed on the computer.
    Example 7: Display full information for a cmdlet

    PS C:\>Get-Help Format-Table -Full

    This command uses the Full parameter of Get-Help to display the full view help for
    the Format-Table cmdlet. The full view of help includes parameter descriptions,
    examples, and a table of technical details about the parameters.

    The Full parameter is effective only when help files for the command are installed
    on the computer.
    Example 8: Display examples for a cmdlet

    PS C:\>Get-Help Start-Service -Examples

    This command displays examples of using the Start-Service cmdlet. It uses the
    Examples parameter of Get-Help to display only the Examples section of the cmdlet
    help topics.

    The Examples parameter is effective only when help files for the command are
    installed on the computer.
    Example 9: Display parameter help

    PS C:\>Get-Help Format-List -Parameter GroupBy

    This command uses the Parameter parameter of Get-Help to display a detailed
    description of the GroupBy parameter of the Format-List cmdlet. For detailed
    descriptions of all parameters of the Format-List cmdlet, type `Get-Help Format-List
    -Parameter *`.
    Example 10: Search for a word in cmdlet help

    PS C:\>Get-Help Add-Member -Full | Out-String -Stream | Select-String -Pattern Clixml

    This example shows how to search for a word in particular cmdlet help topic. This
    command searches for the word Clixml in the full version of the help topic for the
    Add-Member cmdlet.

    Because the Get-Help cmdlet generates a MamlCommandHelpInfo object, not a string,
    you have to use a cmdlet that transforms the help topic content into a string, such
    as Out-String or Out-File.
    Example 11: Display online version of help

    PS C:\>Get-Help Get-Member -Online

    This command displays the online version of the help topic for the Get-Member cmdlet.
    Example 12: Display a list of topics that include a word

    PS C:\>Get-Help remoting

    This command displays a list of topics that include the word remoting.

    When you enter a word that does not appear in any topic title, Get-Help displays a
    list of topics that include that word.
    Example 13: Display provider specific help

    The first command uses the *Path* parameter of **Get-Help** to specify the provider
    path. This command can be entered at any path location.
    PS C:\>Get-Help Get-Item -Path SQLSERVER:\DataCollection

    NAME

        Get-Item


    SYNOPSIS

        Gets a collection of Server objects for the local computer and any computers

        to which you have made a SQL Server PowerShell connection.

        ...

    The second command uses the Set-Location cmdlet (alias = "cd") to navigate to the
    provider path. From that location, even without the *Path* parameter, the
    **Get-Help** command gets the provider-specific help for the **Get-Item** cmdlet.
    PS C:\>cd SQLSERVER:\DataCollection
    SQLSERVER:\DataCollection> Get-Help Get-Item

    NAME

        Get-Item


    SYNOPSIS

        Gets a collection of Server objects for the local computer and any computers

        to which you have made a SQL Server PowerShell connection.

        ...


    The third command shows that a **Get-Help** command in a file system path, and
    without the *Path* parameter, gets the standard help for the **Get-Item** cmdlet.
    PS C:\>Get-Item

    NAME

        Get-Item


    SYNOPSIS

        Gets the item at the specified location.
        ...

    This example shows how to get help that explains how to use the Get-Item cmdlet in
    the DataCollection node of the Windows PowerShellSQL Server provider. The example
    shows two ways of getting the provider-specific help for Get-Item .

    You can also get provider-specific help for cmdlets online in the section that
    describes the provider. For example, for provider-specific online help for the
    New-Item cmdlet in each WSMan provider path, see New-Item for
    ClientCertificatehttp://go.microsoft.com/fwlink/?LinkID=158676 in the TechNet
    library.
    Example 14: Display help for a script

    PS C:\>Get-Help C:\PS-Test\MyScript.ps1

    This command gets help for the MyScript.ps1 script. For information about how to
    write help for your functions and scripts, see about_Comment_Based_Help.

RELATED LINKS
    Online Version: http://go.microsoft.com/fwlink/?LinkId=821483
    Updatable Help Status Table (http://go.microsoft.com/fwlink/?LinkID=270007)
    http://go.microsoft.com/fwlink/?LinkID=270007
    about_Command_Syntax
    Get-Command
```

Notice that using the Full parameter returned several additional sections, one of which is the
Parameters section which provides the same information and more, as the cryptic syntax in the Syntax
section except in plain English.

The Full parameter is a switch parameter. A parameter that doesn't require a value is called a
switch parameter. When a switch parameter is specified, it's on and when it's not, it's off.

If you've been working through this chapter in the PowerShell console of your Windows 10 lab
environment computer, you noticed that the previous command to display the full help topic for
Get-Help flew by on the screen without giving you a chance to read it. There's a better way.

Help is a function that pipes Get-Help to a function named More which is a wrapper for the More.com
executable file in Windows. In the PowerShell console, Help provides a page of help at a time but it
works the same way as Get-Help in the ISE (Integrated Scripting Environment). My recommendation is
to use the Help function instead of the Get-Help cmdlet since it provides a better experience and
it's less to type.

Less typing isn't always a good thing, however. If you're going to save your commands as a script or
share them with someone else, be sure to use full cmdlet and parameter names since they're more
self-documenting which makes them easier to understand. Think about the next person that has to read
and understand your commands, it could be you. Your co-workers and future self will thank you.

Try running the following commands in the PowerShell console on your Windows 10 lab environment computer.

- Get-Help -Name Get-Help -Full
- help -Name Get-Help -Full
- help Get-Help -Full

Did you notice any differences in the output from the previously listed commands when you ran them
on your Windows 10 lab environment computer?

There aren't any differences other than the last two options return the results one page at a time.
The spacebar is used to display the next page of content when using the Help function and Ctrl+C
cancels commands that are running in the PowerShell console.

The first example uses the Get-Help cmdlet, the second uses the Help function, and the third omits
the Name parameter when using the Help function. Name is a positional parameter and it's being used
positionally in that example. This means the value can be specified without specifying the parameter
name, as long as the value itself is specified in the correct position. How did I know what position
to specify the value in? By reading the help as shown in the following example.

```powershell
help Get-Help -Parameter Name
```

```Output
-Name <String>
    Gets help about the specified command or concept. Enter the name of a cmdlet,
    function, provider, script, or workflow, such as `Get-Member`, a conceptual topic
    name, such as `about_Objects`, or an alias, such as `ls`. Wildcard characters are
    permitted in cmdlet and provider names, but you cannot use wildcard characters to
    find the names of function help and script help topics.

    To get help for a script that is not located in a path that is listed in the Path
    environment variable, type the path and file name of the script.

    If you enter the exact name of a help topic, Get-Help displays the topic contents.
    If you enter a word or word pattern that appears in several help topic titles,
    Get-Help displays a list of the matching titles. If you enter a word that does not
    match any help topic titles, Get-Help displays a list of topics that include that
    word in their contents.

    The names of conceptual topics, such as `about_Objects`, must be entered in English,
    even in non-English versions of Windows PowerShell.

    Required?                    false
    Position?                    0
    Default value                None
    Accept pipeline input?       True (ByPropertyName)
    Accept wildcard characters?  false
```

Notice that in the previous example, the Parameter parameter was used with the Help function to only
return information from the help topic for the Name parameter. This is much more concise than trying
to manually sift through what sometimes seems like a hundred page help topic.

Based on those results, you can see that the Name parameter is positional and must be specified in
position zero (the first position) when used positionally. The order that parameters are specified
in doesn't matter if the parameter name is specified.

One other important piece of information in the previous results is that the Name parameter expects
the datatype for its value to be a single string which is denoted by <String>. If it accepted
multiple strings, the datatype would be listed as <String[]>.

Sometimes you simply don't want to display the entire help topic for a command. There are a number
of other parameters besides Full that can be specified with Get-Help or Help. Try running the
following commands on your Windows 10 lab environment computer:

- Get-Help -Name Get-Command -Full
- Get-Help -Name Get-Command -Detailed
- Get-Help -Name Get-Command -Examples
- Get-Help -Name Get-Command -Online
- Get-Help -Name Get-Command -Parameter Noun
- Get-Help -Name Get-Command -ShowWindow

I typically use help <command name> with the Full or Online parameter. If I'm only interested in the
examples, I'll use the Examples parameter and if I'm only interested in a specific parameter, I'll
use the Parameter parameter. The ShowWindow parameter opens the help topic in a separate searchable
window that can be placed on a different monitor if you have multiple monitors. I've avoided the
ShowWindow parameter because there's a known
[bug](https://connect.microsoft.com/PowerShell/feedback/details/1549114/ps5-get-help-showwindow-doesnt-display-help-on-parameters)
where it doesn't display the entire help topic.

If you want help in a separate window, my recommendation is to either use the Online parameter or
use the Full parameter and pipe the results to Out-GridView, as shown in the following example.

```powershell
help Get-Command -Full | Out-GridView
```

Both the Out-GridView cmdlet and the ShowWindow parameter of the Get-Help cmdlet require an
operating system with a GUI (Graphical User Interface). They will generate an error message if you
attempt to use either of them on Windows Server that's been installed using the server core (no-GUI)
installation option.

To use Get-Help to find commands, use the asterisk (\*) wildcard character with the Name parameter.
Specify a term that you're searching for commands on as the value for the Name parameter as shown in
the following example.

```powershell
help *process*
```

```Output
Name                              Category  Module                    Synopsis
----                              --------  ------                    --------
Enter-PSHostProcess               Cmdlet    Microsoft.PowerShell.Core Connects to and ...
Exit-PSHostProcess                Cmdlet    Microsoft.PowerShell.Core Closes an intera...
Get-PSHostProcessInfo             Cmdlet    Microsoft.PowerShell.Core
Debug-Process                     Cmdlet    Microsoft.PowerShell.M... Debugs one or mo...
Get-Process                       Cmdlet    Microsoft.PowerShell.M... Gets the process...
Start-Process                     Cmdlet    Microsoft.PowerShell.M... Starts one or mo...
Stop-Process                      Cmdlet    Microsoft.PowerShell.M... Stops one or mor...
Wait-Process                      Cmdlet    Microsoft.PowerShell.M... Waits for the pr...
Get-AppvVirtualProcess            Function  AppvClient                ...
Start-AppvVirtualProcess          Function  AppvClient                ...
```

In the previous example, the * wildcard characters are not required and omitting them produces the
same result. Get-Help automatically adds the wildcard characters behind the scenes.

```powershell
help process
```

The previous command produces the same results as specifying the * wildcard character on each end of
process.

I prefer to add them since that's the option that always works consistently. Otherwise, they are
required in certain scenarios and not others. As soon as you add a wildcard character in the middle
of the value, they're no longer automatically added behind the scenes to the value you specified.

```powershell
help pr*cess
```

No results are returned by that command unless the * wildcard character is added to the beginning,
end, or both the beginning and end of pr*cess.

If the value you specified begins with a dash then an error will be generated because PowerShell
interprets it as a parameter name and no such parameter name exists for the Get-Help cmdlet.

```powershell
help -process
```

If what you're attempting to look for are commands that end with -process, you would simply need to
add the * wildcard character to the beginning of the value.

```powershell
help *-process
```

When searching for PowerShell commands with Get-Help, you want to be a little more vague instead of
being too specific with what you're searching for.

Searching for process earlier found only commands that contained process in the name of the command
and returned only those results. When Get-Help is used to search for processes, it doesn't find any
matches for command names, so it performs a search of every help topic in PowerShell on your system
and returns any matches it finds. This causes it to return an enormous amount of results.

```powershell
Get-Help processes
```

```Output
Name                              Category  Module                    Synopsis
----                              --------  ------                    --------
Disconnect-PSSession              Cmdlet    Microsoft.PowerShell.Core Disconnects from...
Enter-PSHostProcess               Cmdlet    Microsoft.PowerShell.Core Connects to and ...
ForEach-Object                    Cmdlet    Microsoft.PowerShell.Core Performs an oper...
Get-PSSessionConfiguration        Cmdlet    Microsoft.PowerShell.Core Gets the registe...
New-PSTransportOption             Cmdlet    Microsoft.PowerShell.Core Creates an objec...
Out-Host                          Cmdlet    Microsoft.PowerShell.Core Sends output to ...
Where-Object                      Cmdlet    Microsoft.PowerShell.Core Selects objects ...
Clear-Variable                    Cmdlet    Microsoft.PowerShell.U... Deletes the valu...
Compare-Object                    Cmdlet    Microsoft.PowerShell.U... Compares two set...
Convert-String                    Cmdlet    Microsoft.PowerShell.U... Formats a string...
ConvertFrom-Csv                   Cmdlet    Microsoft.PowerShell.U... Converts object ...
ConvertTo-Html                    Cmdlet    Microsoft.PowerShell.U... Converts Microso...
ConvertTo-Xml                     Cmdlet    Microsoft.PowerShell.U... Creates an XML-b...
Debug-Runspace                    Cmdlet    Microsoft.PowerShell.U... Starts an intera...
Export-Csv                        Cmdlet    Microsoft.PowerShell.U... Converts objects...
Export-FormatData                 Cmdlet    Microsoft.PowerShell.U... Saves formatting...
Format-List                       Cmdlet    Microsoft.PowerShell.U... Formats the outp...
Format-Table                      Cmdlet    Microsoft.PowerShell.U... Formats the outp...
Get-Random                        Cmdlet    Microsoft.PowerShell.U... Gets a random nu...
Get-Unique                        Cmdlet    Microsoft.PowerShell.U... Returns unique i...
Group-Object                      Cmdlet    Microsoft.PowerShell.U... Groups objects t...
Import-Clixml                     Cmdlet    Microsoft.PowerShell.U... Imports a CLIXML...
Import-Csv                        Cmdlet    Microsoft.PowerShell.U... Creates table-li...
Measure-Object                    Cmdlet    Microsoft.PowerShell.U... Calculates the n...
Out-File                          Cmdlet    Microsoft.PowerShell.U... Sends output to ...
Out-GridView                      Cmdlet    Microsoft.PowerShell.U... Sends output to ...
Select-Object                     Cmdlet    Microsoft.PowerShell.U... Selects objects ...
Set-Variable                      Cmdlet    Microsoft.PowerShell.U... Sets the value o...
Sort-Object                       Cmdlet    Microsoft.PowerShell.U... Sorts objects by...
Tee-Object                        Cmdlet    Microsoft.PowerShell.U... Saves command ou...
Trace-Command                     Cmdlet    Microsoft.PowerShell.U... Configures and s...
Write-Output                      Cmdlet    Microsoft.PowerShell.U... Sends the specif...
Debug-Process                     Cmdlet    Microsoft.PowerShell.M... Debugs one or mo...
Get-Process                       Cmdlet    Microsoft.PowerShell.M... Gets the process...
Get-WmiObject                     Cmdlet    Microsoft.PowerShell.M... Gets instances o...
Start-Process                     Cmdlet    Microsoft.PowerShell.M... Starts one or mo...
Stop-Process                      Cmdlet    Microsoft.PowerShell.M... Stops one or mor...
Wait-Process                      Cmdlet    Microsoft.PowerShell.M... Waits for the pr...
Get-Counter                       Cmdlet    Microsoft.PowerShell.D... Gets performance...
Invoke-WSManAction                Cmdlet    Microsoft.WSMan.Manage... Invokes an actio...
Remove-WSManInstance              Cmdlet    Microsoft.WSMan.Manage... Deletes a manage...
Get-WSManInstance                 Cmdlet    Microsoft.WSMan.Manage... Displays managem...
New-WSManInstance                 Cmdlet    Microsoft.WSMan.Manage... Creates a new in...
Set-WSManInstance                 Cmdlet    Microsoft.WSMan.Manage... Modifies the man...
about_Arithmetic_Operators        HelpFile                            Describes the op...
about_Arrays                      HelpFile                            Describes arrays...
about_Debuggers                   HelpFile                            Describes the Wi...
about_Execution_Policies          HelpFile                            Describes the Wi...
about_ForEach-Parallel            HelpFile                            Describes the Fo...
about_Foreach                     HelpFile                            Describes a lang...
about_Functions                   HelpFile                            Describes how to...
about_Language_Keywords           HelpFile                            Describes the ke...
about_Methods                     HelpFile                            Describes how to...
about_Objects                     HelpFile                            Provides essenti...
about_Parallel                    HelpFile                            Describes the Pa...
about_Pipelines                   HelpFile                            Combining comman...
about_Preference_Variables        HelpFile                            Variables that c...
about_Remote                      HelpFile                            Describes how to...
about_Remote_Output               HelpFile                            Describes how to...
about_Sequence                    HelpFile                            Describes the Se...
about_Session_Configuration_Files HelpFile                            Describes sessio...
about_Variables                   HelpFile                            Describes how va...
about_Windows_PowerShell_5.0      HelpFile                            Describes new fe...
about_WQL                         HelpFile                            Describes WMI Qu...
about_WS-Management_Cmdlets       HelpFile                            Provides an over...
about_ForEach-Parallel            HelpFile                            Describes the Fo...
about_Parallel                    HelpFile                            Describes the Pa...
about_Sequence                    HelpFile                            Describes the Se...
```

Using Help to search for "process" returned 10 results and using it to search for processes returned
68 results. If only one result is found, the help topic itself will be displayed instead of a list
of commands.

```powershell
get-help *hotfix*
```

```Output
NAME
    Get-HotFix

SYNOPSIS
    Gets the hotfixes that have been applied to the local and remote computers.


SYNTAX
    Get-HotFix [-ComputerName <String[]>] [-Credential <PSCredential>] [-Description
    <String[]>] [<CommonParameters>]

    Get-HotFix [[-Id] <String[]>] [-ComputerName <String[]>] [-Credential
    <PSCredential>] [<CommonParameters>]


DESCRIPTION
    The Get-Hotfix cmdlet gets hotfixes (also called updates) that have been installed
    on either the local computer (or on specified remote computers) by Windows Update,
    Microsoft Update, or Windows Server Update Services; the cmdlet also gets hotfixes
    or updates that have been installed manually by users.


RELATED LINKS
    Online Version: http://go.microsoft.com/fwlink/?LinkId=821586
    Win32_QuickFixEngineering http://go.microsoft.com/fwlink/?LinkID=145071
    Get-ComputerRestorePoint
    Add-Content

REMARKS
    To see the examples, type: "get-help Get-HotFix -examples".
    For more information, type: "get-help Get-HotFix -detailed".
    For technical information, type: "get-help Get-HotFix -full".
    For online help, type: "get-help Get-HotFix -online"
```

Now to debunk the myth that Help in PowerShell can only find commands that have help topics.

```powershell
help *more*
```

```Output
NAME
    more

SYNTAX
    more [[-paths] <string[]>]


ALIASES
    None


REMARKS
    None
```

Notice in the previous example that more doesn't have a help topic, yet the Help system in
PowerShell was able to find it. It only found one match and returned the basic syntax information
that you'll see when a command doesn't have a help topic.

PowerShell contains numerous conceptual (About) help topics. The following command can be used to
return a list of all About help topics on your system.

```powershell
help About_*
```

Limiting the results to one single About help topic displays the actual help topic instead of
returning a list.

```powershell
help about_Updatable_Help
```

The help system in PowerShell has to be updated in order for the About help topics to be present. If
for some reason the initial update of the help system failed on your Windows 10 lab environment
computer, they will not be available until the Update-Help cmdlet has been run successfully which is
covered later in this chapter.

## Get-Command

Get-Command is designed to help you locate commands. Running Get-Command without any parameters
returns a list of all the commands on your system. The following example demonstrates using the
Get-Command cmdlet to determine what commands exist for working with processes:

```powershell
Get-Command -Noun Process
```

```Output
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Debug-Process                                      3.1.0.0    Microsof...
Cmdlet          Get-Process                                        3.1.0.0    Microsof...
Cmdlet          Start-Process                                      3.1.0.0    Microsof...
Cmdlet          Stop-Process                                       3.1.0.0    Microsof...
Cmdlet          Wait-Process                                       3.1.0.0    Microsof...
```

Notice in the previous example where Get-Command was run, that the Noun parameter is used and
Process is specified as the value for the noun parameter. What if you didn't know how to use the
Get-Command cmdlet? You could simply use Get-Help to display the help topic for Get-Command.

The problem with the help topics in PowerShell is they're written by humans which means they're not
perfect. According to the help topic for Get-Command, the Name, Noun, and Verb parameters don't
allow wildcards. Those are parameters I use all the time and I can assure you they all do indeed
accept wildcards, as shown in the following example where wildcards are used with the Name
parameter.

```Output
Get-Command -Name *service*
```

```powershell
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        Get-NetFirewallServiceFilter                       2.0.0.0    NetSecurity
Function        Set-NetFirewallServiceFilter                       2.0.0.0    NetSecurity
Cmdlet          Get-Service                                        3.1.0.0    Microsof...
Cmdlet          New-Service                                        3.1.0.0    Microsof...
Cmdlet          New-WebServiceProxy                                3.1.0.0    Microsof...
Cmdlet          Restart-Service                                    3.1.0.0    Microsof...
Cmdlet          Resume-Service                                     3.1.0.0    Microsof...
Cmdlet          Set-Service                                        3.1.0.0    Microsof...
Cmdlet          Start-Service                                      3.1.0.0    Microsof...
Cmdlet          Stop-Service                                       3.1.0.0    Microsof...
Cmdlet          Suspend-Service                                    3.1.0.0    Microsof...
Application     AgentService.exe                                   10.0.14... C:\Windo...
Application     SensorDataService.exe                              10.0.14... C:\Windo...
Application     services.exe                                       10.0.14... C:\Windo...
Application     services.msc                                       0.0.0.0    C:\Windo...
Application     TieringEngineService.exe                           10.0.14... C:\Windo...
```

I'm not a big fan of using wildcards with the Name parameter of Get-Command since it also returns
Windows executables that are not native PowerShell commands.

If you are going to use wildcard characters with the Name parameter, I recommend limiting the
results with the CommandType parameter.

```powershell
Get-Command -Name *service* -CommandType Cmdlet, Function, Alias
```

A better option is to use either the verb or noun parameter or both of them since only PowerShell
commands have both verbs and nouns.

Found something wrong with a help topic such as the incorrect information described earlier in this
chapter? The good news is the help topics for PowerShell have been open-sourced and now reside on
[GitHub](https://github.com/powershell). Pay it forward by not only fixing the incorrect information
for yourself, but everyone else as well. Simply fork the PowerShell documentation repository on
GitHub, update the help topic, and submit a pull request. Once the pull request is accepted, the
corrected documentation will be available for everyone.

## Updating Help

The local copy of the PowerShell help topics was previously updated the first time help on a command
was requested. It's recommended to periodically update the help system because there can be updates
to the help content from time to time. The Update-Help cmdlet is used to update the help topics. It
requires Internet access by default and for you to be running PowerShell elevated as an
administrator.

```powershell
Update-Help
```

```Output
Update-Help : Failed to update Help for the module(s) 'BitsTransfer' with UI culture(s)
{en-US} : The value of the HelpInfoUri key in the module manifest must resolve to a
container or root URL on a website where the help files are stored. The HelpInfoUri
'https://technet.microsoft.com/en-us/library/dd819413.aspx' does not resolve to a
container.
At line:1 char:1
+ Update-Help
+
    + CategoryInfo          : InvalidOperation: (:) [Update-Help], Exception
    + FullyQualifiedErrorId : InvalidHelpInfoUri,Microsoft.PowerShell.Commands.UpdateHel
   pCommand

Update-Help : Failed to update Help for the module(s) 'NetworkControllerDiagnostics,
StorageReplica' with UI culture(s) {en-US} : Unable to retrieve the HelpInfo XML file
for UI culture en-US. Make sure the HelpInfoUri property in the module manifest is valid
or check your network connection and then try the command again.
At line:1 char:1
+ Update-Help
+
    + CategoryInfo          : ResourceUnavailable: (:) [Update-Help], Exception
    + FullyQualifiedErrorId : UnableToRetrieveHelpInfoXml,Microsoft.PowerShell.Commands.
   UpdateHelpCommand
```

A couple of the modules returned errors which is not uncommon. If the machine didn't have Internet
access, you could use the Save-Help cmdlet on another machine that does have Internet access to
first save the updated help information to a file share on your network and then use the SourcePath
parameter of Update-Help to specify this network location for the help topics.

Consider setting up a scheduled task or adding some logic to your profile script in PowerShell to
periodically update the help content on your computer. Profile scripts will be discussed in an
upcoming chapter.

## Summary

In this chapter you've learned how to find commands with both Get-Help and Get-Command. You've
learned how to use the help system to figure out how to use commands once you find them. You've also
learned how to update the content of the help topics when updates are available.

My challenge to you is to learn a PowerShell command a day.

```powershell
Get-Command | Get-Random | Get-Help -Full
```

## Review

1. Is the DisplayName parameter of Get-Service positional?
1. How many parameter sets does the Get-Process cmdlet have?
1. What PowerShell commands exists for working with event logs?
1. What is the PowerShell command for returning a list of PowerShell processes running on your computer?
1. How do you update the PowerShell help content that's stored on your computer?

## Recommended Reading

For those who want to know more information about the topics covered in this chapter, I recommend
reading the following PowerShell help topics.

- [Get-Help](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/get-help)
- [Get-Command](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/get-command)
- [Update-Help](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/update-help)
- [Save-Help](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/save-help)
- [about_Updatable_Help](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_updatable_help)
- [about_Command_Syntax](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_command_syntax)

In the next chapter, you'll learn about the Get-Member cmdlet as well as objects, properties, and
methods.

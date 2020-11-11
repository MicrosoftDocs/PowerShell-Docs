---
title: The Help System
description: Mastering the help system is the key to being successful with PowerShell.
ms.date: 06/02/2020
ms.topic: guide
ms.custom: Contributor-mikefrobbins
ms.reviewer: mirobb
---
# Chapter 2 - The Help System

Two groups of IT pros were given a written test without access to a computer to determine their
skill level with PowerShell. PowerShell beginners were placed in one group and experts in another.
Based on the results of the test, there didn't seem to be much difference in the skill level between
the two groups. Both groups were given a second test similar to the first one. This time they were
given access to a computer with PowerShell that didn't have access to the internet. The results of
the second test showed a huge difference in the skill level between the two groups. Experts don't
always know the answers, but they know how to figure out the answers.

What was the difference in the results of the first and second test between these two groups?

The differences observed in these two tests were because experts don't memorize how to use thousands
of commands in PowerShell. They learn how to use the help system within PowerShell extremely well.
This allows them to find the necessary commands when needed and how to use those commands once
they've found them.

I've heard Jeffrey Snover, the inventor of PowerShell, tell a similar story a number of times.

Mastering the help system is the key to being successful with PowerShell.

## Discoverability

Compiled commands in PowerShell are called cmdlets. Cmdlet is pronounced "command-let" (not
CMD-let). Cmdlets names have the form of singular "Verb-Noun" commands to make them easily
discoverable. For example, the cmdlet for determining what processes are running is `Get-Process`
and the cmdlet for retrieving a list of services and their statuses is `Get-Service`. There are
other types of commands in PowerShell such as aliases and functions that will be covered later in
this book. The term PowerShell command is a generic term that's often used to refer to any type of
command in PowerShell, regardless of whether or not it's a cmdlet, function, or alias.

## The Three Core Cmdlets in PowerShell

- `Get-Command`
- `Get-Help`
- `Get-Member` (covered in chapter 3)

One question I'm often asked is how do you figure out what the commands are in PowerShell? Both
`Get-Command` and `Get-Help` can be used to determine the commands.

## Get-Help

`Get-Help` is a multipurpose command. `Get-Help` helps you learn how to use commands once you find
them. `Get-Help` can also be used to help locate commands, but in a different and more indirect way
when compared to `Get-Command`.

When `Get-Help` is used to locate commands, it first searches for wildcard matches of command names
based on the provided input. If it doesn't find a match, it searches through the help topics
themselves, and if no match is found an error is returned. Contrary to popular belief, `Get-Help`
can be used to find commands that don't have help topics.

The first thing you need to know about the help system in PowerShell is how to use the `Get-Help`
cmdlet. The following command is used to display the help topic for `Get-Help`.

```powershell
Get-Help -Name Get-Help
```

```Output
Do you want to run Update-Help?
The Update-Help cmdlet downloads the most current Help files for Windows PowerShell
modules, and installs them on your computer. For more information about the Update-Help
cmdlet, see http://go.microsoft.com/fwlink/?LinkId=210614.
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"):
```

Beginning with PowerShell version 3, PowerShell help doesn't ship with the operating system. The
first time `Get-Help` is run for a command, the previous message is displayed. If the `help`
function or `man` alias is used instead of the `Get-Help` cmdlet, you don't receive this prompt.

Answering yes by pressing <kbd>Y</kbd> runs the `Update-Help` cmdlet, which requires internet access
by default. `Y` can be specified in either upper or lower case.

Once the help is downloaded and the update is complete, the help topic is returned for the specified
command:

```powershell
Get-Help -Name Get-Help
```

Take a moment to run that example on your computer, review the output, and take note of how the
information is grouped:

- NAME
- SYNOPSIS
- SYNTAX
- DESCRIPTION
- RELATED LINKS
- REMARKS

As you can see, help topics can contain an enormous amount of information and this isn't even the
entire help topic.

While not specific to PowerShell, a parameter is a way to provide input to a command. `Get-Help` has
many parameters that can be specified in order to return the entire help topic or a subset of
it.

The syntax section of the help topic shown in the previous set of results lists all of the
parameters for `Get-Help`. At first glance, it appears the same parameters are listed six different
times. Each of those different blocks in the syntax section is a parameter set. This means the
`Get-Help` cmdlet has six different parameter sets. If you take a closer look, you'll notice that at
least one parameter is different in each of the parameter sets.

Parameter sets are mutually exclusive. Once a unique parameter that only exists in one of the
parameter sets is used, only parameters contained within that parameter set can be used. For
example, both the **Full** and **Detailed** parameters couldn't be specified at the same time
because they are in different parameter sets.

Each of the following parameters are in different parameter sets:

- Full
- Detailed
- Examples
- Online
- Parameter
- ShowWindow

All of the cryptic syntax such as square and angle brackets in the syntax section means something
but will be covered in Appendix A of this book. While important, learning the cryptic syntax is
often difficult to retain for someone who is new to PowerShell and may not use it everyday.

For more information to better understand the cryptic syntax, see [Appendix A][].

For beginners, there's an easier way to figure out the same information except in plain language.

When the **Full** parameter of `Get-Help` is specified, the entire help topic is returned.

```powershell
Get-Help -Name Get-Help -Full
```

Take a moment to run that example on your computer, review the output, and take note of how the
information is grouped:

- NAME
- SYNOPSIS
- SYNTAX
- DESCRIPTION
- PARAMETERS
- INPUTS
- OUTPUTS
- NOTES
- EXAMPLES
- RELATED LINKS

Notice that using the **Full** parameter returned several additional sections, one of which is the
PARAMETERS section that provides more information than the cryptic SYNTAX section.

The **Full** parameter is a switch parameter. A parameter that doesn't require a value is called a
switch parameter. When a switch parameter is specified, its value is true and when it's not, its
value is false.

If you've been working through this chapter in the PowerShell console, you noticed that the previous
command to display the full help topic for `Get-Help` flew by on the screen without giving you a
chance to read it. There's a better way.

`Help` is a function that pipes `Get-Help` to a function named `more`, which is a wrapper for the
`more.com` executable file in Windows. In the PowerShell console, `help` provides one page of help
at a time. In the ISE, it works the same way as `Get-Help`. My recommendation is to use the `help`
function instead of the `Get-Help` cmdlet since it provides a better experience and it's less to
type.

Less typing isn't always a good thing, however. If you're going to save your commands as a script or
share them with someone else, be sure to use full cmdlet and parameter names. The full names are
self-documenting, which makes them easier to understand. Think about the next person that has to
read and understand your commands. It could be you. Your coworkers and future self will thank you.

Try running the following commands in the PowerShell console on your Windows 10 lab environment
computer.

```powershell
Get-Help -Name Get-Help -Full
help -Name Get-Help -Full
help Get-Help -Full
```

Did you notice any differences in the output from the previously listed commands when you ran them
on your Windows 10 lab environment computer?

There aren't any differences other than the last two options return the results one page at a time.
The <kbd>spacebar</kbd> is used to display the next page of content when using the `Help` function
and <kbd>Ctrl</kbd>+<kbd>C</kbd> cancels commands that are running in the PowerShell console.

The first example uses the `Get-Help` cmdlet, the second uses the `Help` function, and the third
omits the **Name** parameter when using the `Help` function. **Name** is a positional parameter and
it's being used positionally in that example. This means the value can be specified without
specifying the parameter name, as long as the value itself is specified in the correct position. How
did I know what position to specify the value in? By reading the help as shown in the following
example.

```powershell
help Get-Help -Parameter Name
```

```Output
-Name <String>
    Gets help about the specified command or concept. Enter the name of a cmdlet, function,
    provider, script, or workflow, such as Get-Member, a conceptual article name, such as
    about_Objects, or an alias, such as ls. Wildcard characters are permitted in cmdlet and
    provider names, but you can't use wildcard characters to find the names of function help and
    script help articles.

    To get help for a script that isn't located in a path that's listed in the $env:Path
    environment variable, type the script's path and file name.

    If you enter the exact name of a help article, Get-Help displays the article contents.

    If you enter a word or word pattern that appears in several help article titles, Get-Help
    displays a list of the matching titles.

    If you enter a word that doesn't match any help article titles, Get-Help displays a list of
    articles that include that word in their contents.

    The names of conceptual articles, such as about_Objects, must be entered in English, even in
    non-English versions of PowerShell.

    Required?                    false
    Position?                    0
    Default value                None
    Accept pipeline input?       True (ByPropertyName)
    Accept wildcard characters?  true
```

Notice that in the previous example, the **Parameter** parameter was used with the Help function to
only return information from the help topic for the **Name** parameter. This is much more concise
than trying to manually sift through what sometimes seems like a hundred page help topic.

Based on those results, you can see that the **Name** parameter is positional and must be specified
in position zero (the first position) when used positionally. The order that parameters are
specified in doesn't matter if the parameter name is specified.

One other important piece of information is that the **Name** parameter expects the datatype for its
value to be a single string, which is denoted by `<String>`. If it accepted multiple strings, the
datatype would be listed as `<String[]>`.

Sometimes you simply don't want to display the entire help topic for a command. There are a number
of other parameters besides **Full** that can be specified with `Get-Help` or `Help`. Try running
the following commands on your Windows 10 lab environment computer:

```powershell
Get-Help -Name Get-Command -Full
Get-Help -Name Get-Command -Detailed
Get-Help -Name Get-Command -Examples
Get-Help -Name Get-Command -Online
Get-Help -Name Get-Command -Parameter Noun
Get-Help -Name Get-Command -ShowWindow
```

I typically use `help <command name>` with the **Full** or **Online** parameter. If I'm only
interested in the examples, I'll use the **Examples** parameter and if I'm only interested in a
specific parameter, I'll use the **Parameter** parameter. The **ShowWindow** parameter opens the
help topic in a separate searchable window that can be placed on a different monitor if you have
multiple monitors. I've avoided the **ShowWindow** parameter because there's a known bug where it
doesn't display the entire help topic.

If you want help in a separate window, my recommendation is to either use the **Online** parameter
or use the **Full** parameter and pipe the results to `Out-GridView`, as shown in the following
example.

```powershell
help Get-Command -Full | Out-GridView
```

Both the `Out-GridView` cmdlet and the **ShowWindow** parameter of the `Get-Help` cmdlet require an
operating system with a GUI (Graphical User Interface). They will generate an error message if you
attempt to use either of them on Windows Server that's been installed using the server core (no-GUI)
installation option.

To use `Get-Help` to find commands, use the asterisk (`*`) wildcard character with the **Name**
parameter. Specify a term that you're searching for commands on as the value for the **Name**
parameter as shown in the following example.

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

In the previous example, the `*` wildcard characters are not required and omitting them produces the
same result. `Get-Help` automatically adds the wildcard characters behind the scenes.

```powershell
help process
```

The previous command produces the same results as specifying the `*` wildcard character on each end
of process.

I prefer to add them since that's the option that always works consistently. Otherwise, they are
required in certain scenarios and not others. As soon as you add a wildcard character in the middle
of the value, they're no longer automatically added behind the scenes to the value you specified.

```powershell
help pr*cess
```

No results are returned by that command unless the `*` wildcard character is added to the beginning,
end, or both the beginning and end of `pr*cess`.

If the value you specified begins with a dash, then an error is generated because PowerShell
interprets it as a parameter name and no such parameter name exists for the `Get-Help` cmdlet.

```powershell
help -process
```

If what you're attempting to look for are commands that end with `-process`, you only need to add
the `*` wildcard character to the beginning of the value.

```powershell
help *-process
```

When searching for PowerShell commands with `Get-Help`, you want to be a little more vague instead
of being too specific with what you're searching for.

Searching for `process` earlier found only commands that contained `process` in the name of the
command and returned only those results. When `Get-Help` is used to search for `processes`, it
doesn't find any matches for command names, so it performs a search of every help topic in
PowerShell on your system and returns any matches it finds. This causes it to return an enormous
number of results.

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

Using `Help` to search for `process` returned 10 results and using it to search for `processes`
returned 68 results. If only one result is found, the help topic itself will be displayed instead of
a list of commands.

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

Now to debunk the myth that `Help` in PowerShell can only find commands that have help topics.

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

Notice in the previous example that `more` doesn't have a help topic, yet the `Help` system in
PowerShell was able to find it. It only found one match and returned the basic syntax information
that you'll see when a command doesn't have a help topic.

PowerShell contains numerous conceptual (About) help topics. The following command can be used to
return a list of all **About** help topics on your system.

```powershell
help About_*
```

Limiting the results to one single About help topic displays the actual help topic instead of
returning a list.

```powershell
help about_Updatable_Help
```

The help system in PowerShell has to be updated in order for the **About** help topics to be
present. If for some reason the initial update of the help system failed on your computer, the files
will not be available until the `Update-Help` cmdlet has been run successfully.

## Get-Command

`Get-Command` is designed to help you locate commands. Running `Get-Command` without any parameters
returns a list of all the commands on your system. The following example demonstrates using the
`Get-Command` cmdlet to determine what commands exist for working with processes:

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

Notice in the previous example where `Get-Command` was run, the **Noun** parameter is used and
`Process` is specified as the value for the **Noun** parameter. What if you didn't know how to use
the `Get-Command` cmdlet? You could use `Get-Help` to display the help topic for `Get-Command`.

The **Name**, **Noun**, and **Verb** parameters accept wildcards. The following example shows
wildcards being used with the **Name** parameter:

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

I'm not a fan of using wildcards with the **Name** parameter of `Get-Command` since it also returns
executable files that are not native PowerShell commands.

If you are going to use wildcard characters with the **Name** parameter, I recommend limiting the
results with the **CommandType** parameter.

```powershell
Get-Command -Name *service* -CommandType Cmdlet, Function, Alias
```

A better option is to use either the **Verb** or **Noun** parameter or both of them since only
PowerShell commands have both verbs and nouns.

Found something wrong with a help topic? The good news is the help topics for PowerShell have been
open-sourced and available in the [PowerShell-Docs][] repository on GitHub. Pay it forward by not
only fixing the incorrect information for yourself, but everyone else as well. Simply fork the
PowerShell documentation repository on GitHub, update the help topic, and submit a pull request.
Once the pull request is accepted, the corrected documentation is available for everyone.

## Updating Help

The local copy of the PowerShell help topics was previously updated the first-time help on a command
was requested. It's recommended to periodically update the help system because there can be updates
to the help content from time to time. The `Update-Help` cmdlet is used to update the help topics.
It requires internet access by default and for you to be running PowerShell elevated as an
administrator.

```powershell
Update-Help
```

```Output
Update-Help : Failed to update Help for the module(s) 'BitsTransfer' with UI culture(s)
{en-US} : Unable to retrieve the HelpInfo XML file for UI culture en-US. Make sure the HelpInfoUri
property in the module manifest is valid or check your network connection and then try the command again.
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

A couple of the modules returned errors, which is not uncommon. If the machine didn't have internet
access, you could use the `Save-Help` cmdlet on another machine that does have internet access to
first save the updated help information to a file share on your network and then use the
**SourcePath** parameter of `Update-Help` to specify this network location for the help topics.

Consider setting up a scheduled task or adding some logic to your profile script in PowerShell to
periodically update the help content on your computer. Profile scripts will be discussed in an
upcoming chapter.

## Summary

In this chapter you've learned how to find commands with both `Get-Help` and `Get-Command`. You've
learned how to use the help system to figure out how to use commands once you find them. You've also
learned how to update the content of the help topics when updates are available.

My challenge to you is to learn a PowerShell command a day.

```powershell
Get-Command | Get-Random | Get-Help -Full
```

## Review

1. Is the **DisplayName** parameter of `Get-Service` positional?
1. How many parameter sets does the `Get-Process` cmdlet have?
1. What PowerShell commands exist for working with event logs?
1. What is the PowerShell command for returning a list of PowerShell processes running on your
   computer?
1. How do you update the PowerShell help content that's stored on your computer?

## Recommended Reading

If you want to know more information about the topics covered in this chapter, I recommend
reading the following PowerShell help topics.

- [Get-Help][]
- [Get-Command][]
- [Update-Help][]
- [Save-Help][]
- [about_Updatable_Help][]
- [about_Command_Syntax][]

In the next chapter, you'll learn about the `Get-Member` cmdlet as well as objects, properties, and
methods.

<!-- link references -->
[Get-Help]: /powershell/module/microsoft.powershell.core/get-help
[Get-Command]: /powershell/module/microsoft.powershell.core/get-command
[Update-Help]: /powershell/module/microsoft.powershell.core/update-help
[Save-Help]: /powershell/module/microsoft.powershell.core/save-help
[about_Updatable_Help]: /powershell/module/microsoft.powershell.core/about/about_updatable_help
[about_Command_Syntax]: /powershell/module/microsoft.powershell.core/about/about_command_syntax
[PowerShell-Docs]: https://github.com/powershell/powershell
[Appendix A]: appendix-a.md

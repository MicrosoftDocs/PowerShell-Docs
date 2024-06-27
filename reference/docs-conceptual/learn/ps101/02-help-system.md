---
description: Becoming proficient with the Help system is the key to success with PowerShell
ms.custom: Contributor-mikefrobbins
ms.date: 06/25/2024
ms.reviewer: mirobb
title: The Help system
---

# Chapter 2 - The Help system

In an experiment designed to assess proficiency in PowerShell, two distinct groups of IT
professionals — beginners and experts — were first given a written examination without access to a
computer. Surprisingly, the test scores indicated comparable skills across both groups. A subsequent
test was then administered, mirroring the first but with one key difference: participants had access
to an offline computer equipped with PowerShell. The results revealed a significant skills gap
between the two groups this time.

What factors contributed to the outcomes observed between the two assessments?

> Experts don't always know the answers, but they know how to figure out the answers.

The outcomes observed in the results of the two tests were because experts don't memorize thousands
of PowerShell commands. Instead, they excel at using the Help system within PowerShell, enabling
them to discover and learn how to use commands when necessary.

> Becoming proficient with the Help system is the key to success with PowerShell.

I heard Jeffrey Snover, the creator of PowerShell, share a similar story on multiple occasions.

## Discoverability

Compiled commands in PowerShell are known as cmdlets, pronounced as _"command-let"_, not
_"CMD-let"_. The naming convention for cmdlets follows a singular **Verb-Noun** format to make them
easily discoverable. For instance, `Get-Process` is the cmdlet to determine what processes are
running, and `Get-Service` is the cmdlet to retrieve a list of services. Functions, also known as
script cmdlets, and aliases are other types of PowerShell commands that are discussed later in this
book. The term _"PowerShell command"_ describes any command in PowerShell, regardless of whether
it's a cmdlet, function, or alias.

You can also run operating system native commands from PowerShell, such as traditional command-line
programs like `ping.exe` and `ipconfig.exe`.

## The three core cmdlets in PowerShell

- `Get-Help`
- `Get-Command`
- `Get-Member` (covered in chapter 3)

I'm often asked: _"How do you figure out what the commands are in PowerShell?"_. Both `Get-Help` and
`Get-Command` are invaluable resources for discovering and understanding commands in PowerShell.

## Get-Help

The first thing you need to know about the Help system in PowerShell is how to use the `Get-Help`
cmdlet.

`Get-Help` is a multipurpose command that helps you learn how to use commands once you find them.
You can also use `Get-Help` to locate commands, but in a different and more indirect way when
compared to `Get-Command`.

When using `Get-Help` to locate commands, it initially performs a wildcard search for command names
based on your input. If that doesn't find any matches, it conducts a comprehensive full-text search
across all PowerShell help articles on your system. If that also fails to find any results, it
returns an error.

Here's how to use `Get-Help` to view the help content for the `Get-Help` cmdlet.

```powershell
Get-Help -Name Get-Help
```

Beginning with PowerShell version 3.0, the help content doesn't ship preinstalled with the operating
system. When you run `Get-Help` for the first time, a message asks if you want to download the
PowerShell help files to your computer.

Answering **Yes** by pressing <kbd>Y</kbd> executes the `Update-Help` cmdlet, downloading the help
content.

```Output
Do you want to run Update-Help?
The Update-Help cmdlet downloads the most current Help files for Windows
PowerShell modules, and installs them on your computer. For more information
about the Update-Help cmdlet, see
https:/go.microsoft.com/fwlink/?LinkId=210614.
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"):
```

If you don't receive this message, run `Update-Help` from an elevated PowerShell session running as
an administrator.

Once the update is complete, the help article is displayed.

Take a moment to run the example on your computer, review the output, and observe how the help
system organizes the information.

- NAME
- SYNOPSIS
- SYNTAX
- DESCRIPTION
- RELATED LINKS
- REMARKS

As you review the output, keep in mind that help articles often contain a vast amount of
information, and what you see by default isn't the entire help article.

### Parameters

When you run a command in PowerShell, you might need to provide additional information or input to
the command. Parameters allow you to specify options and arguments that change the behavior of a
command. The **SYNTAX** section of each help article outlines the available parameters for the
command.

`Get-Help` has several parameters that you can specify to return the entire help article or a subset
for a command. To view all the available parameters for `Get-Help`, see the **SYNTAX** section of
its help article, as shown in the following example.

```Output
...
SYNTAX
    Get-Help [[-Name] <System.String>] [-Category {Alias | Cmdlet | Provider
    | General | FAQ | Glossary | HelpFile | ScriptCommand | Function |
    Filter | ExternalScript | All | DefaultHelp | Workflow | DscResource |
    Class | Configuration}] [-Component <System.String[]>] [-Full]
    [-Functionality <System.String[]>] [-Path <System.String>] [-Role
    <System.String[]>] [<CommonParameters>]

    Get-Help [[-Name] <System.String>] [-Category {Alias | Cmdlet | Provider
    | General | FAQ | Glossary | HelpFile | ScriptCommand | Function |
    Filter | ExternalScript | All | DefaultHelp | Workflow | DscResource |
    Class | Configuration}] [-Component <System.String[]>] -Detailed
    [-Functionality <System.String[]>] [-Path <System.String>] [-Role
    <System.String[]>] [<CommonParameters>]

    Get-Help [[-Name] <System.String>] [-Category {Alias | Cmdlet | Provider
    | General | FAQ | Glossary | HelpFile | ScriptCommand | Function |
    Filter | ExternalScript | All | DefaultHelp | Workflow | DscResource |
    Class | Configuration}] [-Component <System.String[]>] -Examples
    [-Functionality <System.String[]>] [-Path <System.String>] [-Role
    <System.String[]>] [<CommonParameters>]

    Get-Help [[-Name] <System.String>] [-Category {Alias | Cmdlet | Provider
    | General | FAQ | Glossary | HelpFile | ScriptCommand | Function |
    Filter | ExternalScript | All | DefaultHelp | Workflow | DscResource |
    Class | Configuration}] [-Component <System.String[]>] [-Functionality
    <System.String[]>] -Online [-Path <System.String>] [-Role
    <System.String[]>] [<CommonParameters>]

    Get-Help [[-Name] <System.String>] [-Category {Alias | Cmdlet | Provider
    | General | FAQ | Glossary | HelpFile | ScriptCommand | Function |
    Filter | ExternalScript | All | DefaultHelp | Workflow | DscResource |
    Class | Configuration}] [-Component <System.String[]>] [-Functionality
    <System.String[]>] -Parameter <System.String> [-Path <System.String>]
    [-Role <System.String[]>] [<CommonParameters>]

    Get-Help [[-Name] <System.String>] [-Category {Alias | Cmdlet | Provider
    | General | FAQ | Glossary | HelpFile | ScriptCommand | Function |
    Filter | ExternalScript | All | DefaultHelp | Workflow | DscResource |
    Class | Configuration}] [-Component <System.String[]>] [-Functionality
    <System.String[]>] [-Path <System.String>] [-Role <System.String[]>]
    -ShowWindow [<CommonParameters>]
...
```

### Parameter sets

When you review the **SYNTAX** section for `Get-Help`, notice that the information appears to be
repeated six times. Each of those blocks is an individual parameter set, indicating the `Get-Help`
cmdlet features six distinct sets of parameters. A closer look reveals each parameter set contains
at least one unique parameter, making it different from the others.

Parameter sets are mutually exclusive. Once you specify a unique parameter that only exists in one
parameter set, PowerShell limits you to using the parameters contained within that parameter set.
For instance, you can't use the **Full** and **Detailed** parameters of `Get-Help` together because
they belong to different parameter sets.

Each of the following parameters belongs to a different parameter set for the `Get-Help` cmdlet.

- Full
- Detailed
- Examples
- Online
- Parameter
- ShowWindow

### The command syntax

If you're new to PowerShell, comprehending the cryptic information — characterized by square and
angle brackets — in the **SYNTAX** section might seem overwhelming. However, learning these syntax
elements is essential to becoming proficient with PowerShell. The more frequently you use the
PowerShell Help system, the easier it becomes to remember all the nuances.

View the syntax of the `Get-EventLog` cmdlet.

```powershell
Get-Help Get-EventLog
```

The following output shows the relevant portion of the help article.

```Output
...
SYNTAX
    Get-EventLog [-LogName] <System.String> [[-InstanceId]
    <System.Int64[]>] [-After <System.DateTime>] [-AsBaseObject] [-Before
    <System.DateTime>] [-ComputerName <System.String[]>] [-EntryType {Error
    | Information | FailureAudit | SuccessAudit | Warning}] [-Index
    <System.Int32[]>] [-Message <System.String>] [-Newest <System.Int32>]
    [-Source <System.String[]>] [-UserName <System.String[]>]
    [<CommonParameters>]

    Get-EventLog [-AsString] [-ComputerName <System.String[]>] [-List]
    [<CommonParameters>]
...
```

The syntax information includes pairs of square brackets (`[]`). Depending on their usage, these
square brackets serve two different purposes.

- Elements enclosed in square brackets are optional.
- An empty set of square brackets following a datatype, such as `<string[]>`, indicates that the
  parameter can accept multiple values passed as an array or a collection object.

### Positional parameters

Some cmdlets are designed to accept positional parameters. Positional parameters allow you to
provide a value without specifying the name of the parameter. When using a parameter positionally,
you must specify its value in the correct position on the command line. You can find the positional
information for a parameter in the **PARAMETERS** section of a command's help article. When you
explicitly specify parameter names, you can use the parameters in any order.

For the `Get-EventLog` cmdlet, the first parameter in the first parameter set is **LogName**.
**LogName** is enclosed in square brackets, indicating it's a positional parameter.

```Syntax
Get-EventLog [-LogName] <System.String>
```

Since **LogName** is a positional parameter, you can specify it by either name or position.
According to the angle brackets following the parameter name, the value for **LogName** must be a
single string. The absence of square brackets enclosing both the parameter name and datatype
indicates that **LogName** is a required parameter within this particular parameter set.

The second parameter in that parameter set is **InstanceId**. Both the parameter name and datatype
are entirely enclosed in square brackets, signifying that **InstanceId** is an optional parameter.

```Syntax
[[-InstanceId] <System.Int64[]>]
```

Furthermore, **InstanceId** has its own pair of square brackets, indicating that it's a positional
parameter similar to the **LogName** parameter. Following the datatype, an empty set of square
brackets implies that **InstanceId** can accept multiple values.

### Switch parameters

A parameter that doesn't require a value is called a switch parameter. You can easily identify
switch parameters because there's no datatype following the parameter name. When you specify a
switch parameter, its value is `true`. When you don't specify a switch parameter, its value is
`false`.

The second parameter set includes a **List** parameter, which is a switch parameter. When you
specify the **List** parameter, it returns a list of event logs on the local computer.

```Syntax
[-List]
```

### A simplified approach to syntax

There's a more user-friendly method to obtain the same information as the cryptic command syntax for
some commands, except in plain English. PowerShell returns the complete help article when using
`Get-Help` with the **Full** parameter, making it easier to understand a command's usage.

```powershell
Get-Help -Name Get-Help -Full
```

Take a moment to run the example on your computer, review the output, and observe how the help
system organizes the information.

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

By specifying the **Full** parameter with the `Get-Help` cmdlet, the output includes several extra
sections. Among these sections, **PARAMETERS** often provides a detailed explanation for each
parameter. However, the extent of this information varies depending on the specific command you're
investigating.

```Output
...
    -Detailed <System.Management.Automation.SwitchParameter>
        Adds parameter descriptions and examples to the basic help display.
        This parameter is effective only when the help files are installed
        on the computer. It has no effect on displays of conceptual ( About_
        ) help.

        Required?                    true
        Position?                    named
        Default value                False
        Accept pipeline input?       False
        Accept wildcard characters?  false

    -Examples <System.Management.Automation.SwitchParameter>
        Displays only the name, synopsis, and examples. This parameter is
        effective only when the help files are installed on the computer. It
        has no effect on displays of conceptual ( About_ ) help.

        Required?                    true
        Position?                    named
        Default value                False
        Accept pipeline input?       False
        Accept wildcard characters?  false

    -Full <System.Management.Automation.SwitchParameter>
        Displays the entire help article for a cmdlet. Full includes
        parameter descriptions and attributes, examples, input and output
        object types, and additional notes.

        This parameter is effective only when the help files are installed
        on the computer. It has no effect on displays of conceptual ( About_
        ) help.

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       False
        Accept wildcard characters?  false
...
```

When you ran the previous command to display the help for the `Get-Help` command, you probably
noticed the output scrolled by too quickly to read it.

If you're using the PowerShell console, Windows Terminal, or VS Code and need to view a help
article, the `help` function can be useful. It pipes the output of `Get-Help` to `more.com`,
displaying one page of help content at a time. I recommend using the `help` function instead of the
`Get-Help` cmdlet because it provides a better user experience and it's less to type.

> [!NOTE]
> The ISE doesn't support using `more.com`, so running `help` works the same way as `Get-Help`.

Run each of the following commands in PowerShell on your computer.

```powershell
Get-Help -Name Get-Help -Full
help -Name Get-Help -Full
help Get-Help -Full
```

Did you observe any variations in the output when you ran the previous commands?

In the previous example, the first line uses the `Get-Help` cmdlet, the second uses the `help`
function, and the third line omits the **Name** parameter while using the `help` function. Since
**Name** is a positional parameter, the third example takes advantage of its position instead of
explicitly stating the parameter's name.

The difference is that the last two commands display their output one page at a time. When using the
`help` function, press the <kbd>Spacebar</kbd> to display the next page of content or <kbd>Q</kbd>
to quit. If you need to terminate any command running interactively in PowerShell, press
<kbd>Ctrl</kbd>+<kbd>C</kbd>.

To quickly find information about a specific parameter, use the **Parameter** parameter. This
approach returns content containing only the parameter-specific information, rather than the entire
help article. This is the easiest way to find information about a specific parameter.

The following example uses the `help` function with the **Parameter** parameter to return
information from the help article for the **Name** parameter of `Get-Help`.

```powershell
help Get-Help -Parameter Name
```

The help information shows that the **Name** parameter is positional and must be specified in the
first position (position zero) when used positionally.

```Output
-Name <System.String>
    Gets help about the specified command or concept. Enter the name of a
    cmdlet, function, provider, script, or workflow, such as `Get-Member`,
    a conceptual article name, such as `about_Objects`, or an alias, such
    as `ls`. Wildcard characters are permitted in cmdlet and provider
    names, but you can't use wildcard characters to find the names of
    function help and script help articles.

    To get help for a script that isn't located in a path that's listed in
    the `$env:Path` environment variable, type the script's path and file
    name.

    If you enter the exact name of a help article, `Get-Help` displays the
    article contents.

    If you enter a word or word pattern that appears in several help
    article titles, `Get-Help` displays a list of the matching titles.

    If you enter any text that doesn't match any help article titles,
    `Get-Help` displays a list of articles that include that text in their
    contents.

    The names of conceptual articles, such as `about_Objects`, must be
    entered in English, even in non-English versions of PowerShell.

    Required?                    false
    Position?                    0
    Default value                None
    Accept pipeline input?       True (ByPropertyName)
    Accept wildcard characters?  true
```

The **Name** parameter expects a string value as identified by the `<String>` datatype next to the
parameter name.

There are several other parameters you can specify with `Get-Help` to return a subset of a help
article. To see how they work, run the following commands on your computer.

```powershell
Get-Help -Name Get-Command -Full
Get-Help -Name Get-Command -Detailed
Get-Help -Name Get-Command -Examples
Get-Help -Name Get-Command -Online
Get-Help -Name Get-Command -Parameter Noun
Get-Help -Name Get-Command -ShowWindow
```

I typically use `help <command name>` with the **Full** or **Online** parameter. If you only have an
interest in the examples, use the **Examples** parameter. If you only have an interest in a specific
parameter, use the **Parameter** parameter.

When you use the **ShowWindow** parameter, it displays the help content in a separate searchable
window. You can move that window to a different monitor if you have multiple monitors. However, the
**ShowWindow** parameter has a known bug that might prevent it from displaying the entire help
article. The **ShowWindow** parameter also requires an operating system with a Graphical User
Interface (GUI). It returns an error when you attempt to use it on Windows Server Core.

If you have internet access, you can use the **Online** parameter instead. The **Online** parameter
opens the help article in your default web browser. The online content is the most up-to-date
content. The browser allows you to search the help content and view other related help articles.

> [!NOTE]
> The **Online** parameter isn't supported for **About** articles.

```powershell
help Get-Command -Online
```

### Finding commands with Get-Help

To find commands with `Get-Help`, specify a search term surrounded by asterisk (`*`) wildcard
characters for the value of the **Name** parameter. The following example uses the **Name**
parameter positionally.

```powershell
help *process*
```

```Output
Name                              Category  Module                    Synops
----                              --------  ------                    ------
Enter-PSHostProcess               Cmdlet    Microsoft.PowerShell.Core Con...
Exit-PSHostProcess                Cmdlet    Microsoft.PowerShell.Core Clo...
Get-PSHostProcessInfo             Cmdlet    Microsoft.PowerShell.Core Get...
Debug-Process                     Cmdlet    Microsoft.PowerShell.M... Deb...
Get-Process                       Cmdlet    Microsoft.PowerShell.M... Get...
Start-Process                     Cmdlet    Microsoft.PowerShell.M... Sta...
Stop-Process                      Cmdlet    Microsoft.PowerShell.M... Sto...
Wait-Process                      Cmdlet    Microsoft.PowerShell.M... Wai...
Invoke-LapsPolicyProcessing       Cmdlet    LAPS                      Inv...
ConvertTo-ProcessMitigationPolicy Cmdlet    ProcessMitigations        Con...
Get-ProcessMitigation             Cmdlet    ProcessMitigations        Get...
Set-ProcessMitigation             Cmdlet    ProcessMitigations        Set...
```

In this scenario, you aren't required to add the `*` wildcard characters. If `Get-Help` can't find a
command matching the value you provided, it does a full-text search for that value. The following
example produces the same results as specifying the `*` wildcard character on each end of `process`.

```powershell
help process
```

When you specify a wildcard character within the value, `Get-Help` only searches for commands that
match the pattern you provided. It doesn't perform a full-text search. The following command doesn't
return any results.

```powershell
help pr*cess
```

PowerShell generates an error if you specify a value that begins with a dash without enclosing it in
quotes because it interprets it as a parameter name. No such parameter name exists for the
`Get-Help` cmdlet.

```powershell
help -process
```

If you're attempting to search for commands that end with `-process`, you must add an `*` to the
beginning of the value.

```powershell
help *-process
```

When you search for PowerShell commands with `Get-Help`, it's better to be vague rather than too
specific.

When you searched for `process` earlier, the results only returned commands that included `process`
in their name. But if you search for `processes`, it doesn't find any matches for command names. As
previously stated, when help doesn't find any matches, it performs a comprehensive full-text search
of every help article on your system and returns those results. This type of search often produces
more results than expected, including information not relevant to you.

```powershell
help processes
```

```Output
Name                              Category  Module                    Synops
----                              --------  ------                    ------
Disconnect-PSSession              Cmdlet    Microsoft.PowerShell.Core Dis...
Enter-PSHostProcess               Cmdlet    Microsoft.PowerShell.Core Con...
ForEach-Object                    Cmdlet    Microsoft.PowerShell.Core Per...
Get-PSHostProcessInfo             Cmdlet    Microsoft.PowerShell.Core Get...
Get-PSSessionConfiguration        Cmdlet    Microsoft.PowerShell.Core Get...
New-PSSessionOption               Cmdlet    Microsoft.PowerShell.Core Cre...
New-PSTransportOption             Cmdlet    Microsoft.PowerShell.Core Cre...
Out-Host                          Cmdlet    Microsoft.PowerShell.Core Sen...
Start-Job                         Cmdlet    Microsoft.PowerShell.Core Sta...
Where-Object                      Cmdlet    Microsoft.PowerShell.Core Sel...
Debug-Process                     Cmdlet    Microsoft.PowerShell.M... Deb...
Get-Process                       Cmdlet    Microsoft.PowerShell.M... Get...
Get-WmiObject                     Cmdlet    Microsoft.PowerShell.M... Get...
Start-Process                     Cmdlet    Microsoft.PowerShell.M... Sta...
Stop-Process                      Cmdlet    Microsoft.PowerShell.M... Sto...
Wait-Process                      Cmdlet    Microsoft.PowerShell.M... Wai...
Clear-Variable                    Cmdlet    Microsoft.PowerShell.U... Del...
Convert-String                    Cmdlet    Microsoft.PowerShell.U... For...
ConvertFrom-Csv                   Cmdlet    Microsoft.PowerShell.U... Con...
ConvertFrom-Json                  Cmdlet    Microsoft.PowerShell.U... Con...
ConvertTo-Html                    Cmdlet    Microsoft.PowerShell.U... Con...
ConvertTo-Xml                     Cmdlet    Microsoft.PowerShell.U... Cre...
Debug-Runspace                    Cmdlet    Microsoft.PowerShell.U... Sta...
Export-Csv                        Cmdlet    Microsoft.PowerShell.U... Con...
Export-FormatData                 Cmdlet    Microsoft.PowerShell.U... Sav...
Format-List                       Cmdlet    Microsoft.PowerShell.U... For...
Format-Table                      Cmdlet    Microsoft.PowerShell.U... For...
Get-Unique                        Cmdlet    Microsoft.PowerShell.U... Ret...
Group-Object                      Cmdlet    Microsoft.PowerShell.U... Gro...
Import-Clixml                     Cmdlet    Microsoft.PowerShell.U... Imp...
Import-Csv                        Cmdlet    Microsoft.PowerShell.U... Cre...
Measure-Object                    Cmdlet    Microsoft.PowerShell.U... Cal...
Out-File                          Cmdlet    Microsoft.PowerShell.U... Sen...
Out-GridView                      Cmdlet    Microsoft.PowerShell.U... Sen...
Select-Object                     Cmdlet    Microsoft.PowerShell.U... Sel...
Set-Variable                      Cmdlet    Microsoft.PowerShell.U... Set...
Sort-Object                       Cmdlet    Microsoft.PowerShell.U... Sor...
Tee-Object                        Cmdlet    Microsoft.PowerShell.U... Sav...
Trace-Command                     Cmdlet    Microsoft.PowerShell.U... Con...
Write-Information                 Cmdlet    Microsoft.PowerShell.U... Spe...
Export-BinaryMiLog                Cmdlet    CimCmdlets                Cre...
Get-CimAssociatedInstance         Cmdlet    CimCmdlets                Ret...
Get-CimInstance                   Cmdlet    CimCmdlets                Get...
Import-BinaryMiLog                Cmdlet    CimCmdlets                Use...
Invoke-CimMethod                  Cmdlet    CimCmdlets                Inv...
New-CimInstance                   Cmdlet    CimCmdlets                Cre...
Remove-CimInstance                Cmdlet    CimCmdlets                Rem...
Set-CimInstance                   Cmdlet    CimCmdlets                Mod...
Compress-Archive                  Function  Microsoft.PowerShell.A... Cre...
Get-Counter                       Cmdlet    Microsoft.PowerShell.D... Get...
Invoke-WSManAction                Cmdlet    Microsoft.WSMan.Manage... Inv...
Remove-WSManInstance              Cmdlet    Microsoft.WSMan.Manage... Del...
Get-WSManInstance                 Cmdlet    Microsoft.WSMan.Manage... Dis...
New-WSManInstance                 Cmdlet    Microsoft.WSMan.Manage... Cre...
Set-WSManInstance                 Cmdlet    Microsoft.WSMan.Manage... Mod...
about_Arithmetic_Operators        HelpFile
about_Arrays                      HelpFile
about_Environment_Variables       HelpFile
about_Execution_Policies          HelpFile
about_Functions                   HelpFile
about_Jobs                        HelpFile
about_Logging                     HelpFile
about_Methods                     HelpFile
about_Objects                     HelpFile
about_Pipelines                   HelpFile
about_Preference_Variables        HelpFile
about_Remote                      HelpFile
about_Remote_Jobs                 HelpFile
about_Session_Configuration_Files HelpFile
about_Simplified_Syntax           HelpFile
about_Switch                      HelpFile
about_Variables                   HelpFile
about_Variable_Provider           HelpFile
about_Windows_Powershell_5.1      HelpFile
about_WQL                         HelpFile
about_WS-Management_Cmdlets       HelpFile
about_Foreach-Parallel            HelpFile
about_Parallel                    HelpFile
about_Sequence                    HelpFile
```

When you searched for `process`, it returned 12 results. However, when searching for `processes`, it
produced 78 results. If your search only finds one match, `Get-Help` displays the help content
instead of listing the search results.

```powershell
help *hotfix*
```

```Output
NAME
    Get-HotFix

SYNOPSIS
    Gets the hotfixes that are installed on local or remote computers.


SYNTAX
    Get-HotFix [-ComputerName <System.String[]>] [-Credential
    <System.Management.Automation.PSCredential>] [-Description
    <System.String[]>] [<CommonParameters>]

    Get-HotFix [[-Id] <System.String[]>] [-ComputerName <System.String[]>]
    [-Credential <System.Management.Automation.PSCredential>]
    [<CommonParameters>]


DESCRIPTION
    > This cmdlet is only available on the Windows platform. The
    `Get-Hotfix` cmdlet uses the Win32_QuickFixEngineering WMI class to
    list hotfixes that are installed on the local computer or specified
    remote computers.


RELATED LINKS
    Online Version: https://learn.microsoft.com/powershell/module/microsoft.
    powershell.management/get-hotfix?view=powershell-5.1&WT.mc_id=ps-gethelp
    about_Arrays
    Add-Content
    Get-ComputerRestorePoint
    Get-Credential
    Win32_QuickFixEngineering class

REMARKS
    To see the examples, type: "get-help Get-HotFix -examples".
    For more information, type: "get-help Get-HotFix -detailed".
    For technical information, type: "get-help Get-HotFix -full".
    For online help, type: "get-help Get-HotFix -online"
```

You can also find commands that lack help articles with `Get-Help`, although this capability isn't
commonly known. The `more` function is one of the commands that doesn't have a help article. To
confirm that you can find commands with `Get-Help` that don't include help articles, use the `help`
function to find `more`.

```powershell
help *more*
```

The search only found one match, so it returned the basic syntax information you see when a command
doesn't have a help article.

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

The PowerShell help system also contains conceptual **About** help articles. You must update the
help content on your system to get the **About** articles. For more information, see the
[Updating help](#updating-help) section of this chapter.

Use the following command to return a list of all **About** help articles on your system.

```powershell
help About_*
```

When you limit the results to one **About** help article, `Get-Help` displays the content of that
article.

```powershell
help about_Updatable_Help
```

## Updating help

Earlier in this chapter, you updated the PowerShell help articles on your computer the first time
you ran the `Get-Help` cmdlet. You should periodically run the `Update-Help` cmdlet on your computer
to obtain any updates to the help content.

> [!IMPORTANT]
> In Windows PowerShell 5.1, you must run `Update-Help` as an administrator in an elevated
> PowerShell session.

In the following example, `Update-Help` downloads the PowerShell help content for all modules
installed on your computer. You should use the **Force** parameter to ensure that you download the
latest version of the help content.

```powershell
Update-Help -Force
```

As shown in the following results, a module returned an error. Errors aren't uncommon and usually
occur when the module's author doesn't configure updatable help correctly.

```Output
Update-Help : Failed to update Help for the module(s) 'BitsTransfer' with UI
culture(s) {en-US} : Unable to retrieve the HelpInfo XML file for UI culture
en-US. Make sure the HelpInfoUri property in the module manifest is valid or
check your network connection and then try the command again.
At line:1 char:1
+ Update-Help
+ ~~~~~~~~~~~
    + CategoryInfo          : ResourceUnavailable: (:) [Update-Help], Except
   ion
    + FullyQualifiedErrorId : UnableToRetrieveHelpInfoXml,Microsoft.PowerShe
   ll.Commands.UpdateHelpCommand
```

`Update-Help` requires internet access to download the help content. If your computer doesn't have
internet access, use the `Save-Help` cmdlet on a computer with internet access to download and save
the updated help content. Then, use the **SourcePath** parameter of `Update-Help` to specify the
location of the saved updated help content.

## Get-Command

`Get-Command` is another multipurpose command that helps you find commands. When you run
`Get-Command` without any parameters, it returns a list of all PowerShell commands on your system.
You can also use `Get-Command` to get command syntax similar to `Get-Help`.

How do you determine the syntax for `Get-Command`? You could use `Get-Help` to display the help
article for `Get-Command`, as shown in the [Get-Help](#get-help) section of this chapter. You can
also use `Get-Command` with the **Syntax** parameter to view the syntax for any command. This
shortcut helps you quickly determine how to use a command without navigating through its help
content.

```powershell
Get-Command -Name Get-Command -Syntax
```

Using `Get-Command` with the **Syntax** parameter provides a more concise view of the syntax that
shows the parameters and their value types, without listing the specific allowable values like
`Get-Help` shows.

```Output
Get-Command [[-ArgumentList] <Object[]>] [-Verb <string[]>]
[-Noun <string[]>] [-Module <string[]>]
[-FullyQualifiedModule <ModuleSpecification[]>] [-TotalCount <int>]
[-Syntax] [-ShowCommandInfo] [-All] [-ListImported]
[-ParameterName <string[]>] [-ParameterType <PSTypeName[]>]
[<CommonParameters>]

Get-Command [[-Name] <string[]>] [[-ArgumentList] <Object[]>]
[-Module <string[]>] [-FullyQualifiedModule <ModuleSpecification[]>]
[-CommandType <CommandTypes>] [-TotalCount <int>] [-Syntax]
[-ShowCommandInfo] [-All] [-ListImported] [-ParameterName <string[]>]
[-ParameterType <PSTypeName[]>] [<CommonParameters>]
```

If you need more detailed information about how to use a command, use `Get-Help`.

```powershell
help Get-Command -Full
```

The **SYNTAX** section of `Get-Help` provides a more user-friendly display by expanding enumerated
values for parameters. It shows you the actual values you can use, making it easier to understand
the available options.

```Output
...
    Get-Command [[-Name] <System.String[]>] [[-ArgumentList]
    <System.Object[]>] [-All] [-CommandType {Alias | Function | Filter |
    Cmdlet | ExternalScript | Application | Script | Workflow |
    Configuration | All}] [-FullyQualifiedModule
    <Microsoft.PowerShell.Commands.ModuleSpecification[]>] [-ListImported]
    [-Module <System.String[]>] [-ParameterName <System.String[]>]
    [-ParameterType <System.Management.Automation.PSTypeName[]>]
    [-ShowCommandInfo] [-Syntax] [-TotalCount <System.Int32>]
    [<CommonParameters>]

    Get-Command [[-ArgumentList] <System.Object[]>] [-All]
    [-FullyQualifiedModule
    <Microsoft.PowerShell.Commands.ModuleSpecification[]>] [-ListImported]
    [-Module <System.String[]>] [-Noun <System.String[]>] [-ParameterName
    <System.String[]>] [-ParameterType
    <System.Management.Automation.PSTypeName[]>] [-ShowCommandInfo]
    [-Syntax] [-TotalCount <System.Int32>] [-Verb <System.String[]>]
    [<CommonParameters>]
...
```

The **PARAMETERS** section of the help for `Get-Command` reveals that the **Name**, **Noun**, and
**Verb** parameters accept wildcard characters.

```Output
...
    -Name <System.String[]>
        Specifies an array of names. This cmdlet gets only commands that
        have the specified name. Enter a name or name pattern. Wildcard
        characters are permitted.

        To get commands that have the same name, use the All parameter. When
        two commands have the same name, by default, `Get-Command` gets the
        command that runs when you type the command name.

        Required?                    false
        Position?                    0
        Default value                None
        Accept pipeline input?       True (ByPropertyName, ByValue)
        Accept wildcard characters?  true

    -Noun <System.String[]>
        Specifies an array of command nouns. This cmdlet gets commands,
        which include cmdlets, functions, and aliases, that have names that
        include the specified noun. Enter one or more nouns or noun
        patterns. Wildcard characters are permitted.

        Required?                    false
        Position?                    named
        Default value                None
        Accept pipeline input?       True (ByPropertyName)
        Accept wildcard characters?  true
    -Verb <System.String[]>
        Specifies an array of command verbs. This cmdlet gets commands,
        which include cmdlets, functions, and aliases, that have names that
        include the specified verb. Enter one or more verbs or verb
        patterns. Wildcard characters are permitted.

        Required?                    false
        Position?                    named
        Default value                None
        Accept pipeline input?       True (ByPropertyName)
        Accept wildcard characters?  true
...
```

The following example uses the `*` wildcard character with the value for the **Name** parameter of
`Get-Command`.

```powershell
Get-Command -Name *service*
```

When you use wildcard characters with the **Name** parameter of `Get-Command`, it returns PowerShell
commands and native commands, as shown in the following results.

```Output

CommandType     Name                                               Version
-----------     ----                                               -------
Function        Get-NetFirewallServiceFilter                       2.0.0.0
Function        Set-NetFirewallServiceFilter                       2.0.0.0
Cmdlet          Get-Service                                        3.1.0.0
Cmdlet          New-Service                                        3.1.0.0
Cmdlet          New-WebServiceProxy                                3.1.0.0
Cmdlet          Restart-Service                                    3.1.0.0
Cmdlet          Resume-Service                                     3.1.0.0
Cmdlet          Set-Service                                        3.1.0.0
Cmdlet          Start-Service                                      3.1.0.0
Cmdlet          Stop-Service                                       3.1.0.0
Cmdlet          Suspend-Service                                    3.1.0.0
Application     SecurityHealthService.exe                          10.0.2...
Application     SensorDataService.exe                              10.0.2...
Application     services.exe                                       10.0.2...
Application     services.msc                                       0.0.0.0
Application     TieringEngineService.exe                           10.0.2...
Application     Windows.WARP.JITService.exe                        10.0.2...
```

You can limit the results of `Get-Command` to PowerShell commands using the **CommandType**
parameter.

```powershell
Get-Command -Name *service* -CommandType Cmdlet, Function, Alias, Script
```

Another option might be to use either the **Verb** or **Noun** parameter or both since only
PowerShell commands have verbs and nouns.

The following example uses `Get-Command` to find commands on your computer that work with processes.
Use the **Noun** parameter and specify `Process` as its value.

```powershell
Get-Command -Noun Process
```

```Output
CommandType     Name                                               Version
-----------     ----                                               -------
Cmdlet          Debug-Process                                      3.1.0.0
Cmdlet          Get-Process                                        3.1.0.0
Cmdlet          Start-Process                                      3.1.0.0
Cmdlet          Stop-Process                                       3.1.0.0
Cmdlet          Wait-Process                                       3.1.0.0
```

## Summary

In this chapter, you learned how to find commands with `Get-Help` and `Get-Command`. You also
learned how to use the help system to understand how to use commands once you find them. In
addition, you learned how to update the help system on your computer when new help content is
available.

## Review

1. Is the **DisplayName** parameter of `Get-Service` positional?
1. How many parameter sets does the `Get-Process` cmdlet have?
1. What PowerShell commands exist for working with event logs?
1. What's the PowerShell command for returning a list of PowerShell processes running on your
   computer?
1. How do you update the PowerShell help content stored on your computer?

## References

To learn more about the concepts covered in this chapter, read the following PowerShell help
articles.

- [Get-Help][help]
- [Get-Command][gcm]
- [Update-Help][update-help]
- [Save-Help][save-help]
- [about_Updatable_Help][updatable-help]
- [about_Command_Syntax][command-syntax]

## Next steps

In the next chapter, you'll learn about objects, properties, methods, and the `Get-Member` cmdlet.

<!-- link references -->

[help]: /powershell/module/microsoft.powershell.core/get-help
[gcm]: /powershell/module/microsoft.powershell.core/get-command
[update-help]: /powershell/module/microsoft.powershell.core/update-help
[save-help]: /powershell/module/microsoft.powershell.core/save-help
[updatable-help]: /powershell/module/microsoft.powershell.core/about/about_updatable_help
[command-syntax]: /powershell/module/microsoft.powershell.core/about/about_command_syntax

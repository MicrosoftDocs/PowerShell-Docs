---
description: Examples of Comment-based Help
ms.date: 10/05/2023
title: Examples of Comment-based Help
---

# Examples of Comment-based Help

This topic includes examples that demonstrate how to use comment-based help for scripts and
functions.

## Example 1: Comment-based Help for a Function

 The following sample function includes comment-based Help.

```powershell
function Add-Extension
{
    param ([string]$Name,[string]$Extension = "txt")
    $Name = $Name + "." + $Extension
    $Name

    <#
        .SYNOPSIS
        Adds a file name extension to a supplied name.

        .DESCRIPTION
        Adds a file name extension to a supplied name.
        Takes any strings for the file name or extension.

        .PARAMETER Name
        Specifies the file name.

        .PARAMETER Extension
        Specifies the extension. "Txt" is the default.

        .INPUTS
        None. You can't pipe objects to Add-Extension.

        .OUTPUTS
        System.String. Add-Extension returns a string with the extension or file name.

        .EXAMPLE
        PS> Add-Extension -Name "File"
        File.txt

        .EXAMPLE
        PS> Add-Extension -Name "File" -Extension "doc"
        File.doc

        .EXAMPLE
        PS> Add-Extension "File" "doc"
        File.doc

        .LINK
        Online version: http://www.fabrikam.com/add-extension.html

        .LINK
        Set-Item
    #>
}
```

The following output shows the results of a `Get-Help` command that displays the help for the
`Add-Extension` function.

```powershell
PS> Get-Help Add-Extension -Full
```

```Output
NAME
    Add-Extension

SYNOPSIS
    Adds a file name extension to a supplied name.

SYNTAX
    Add-Extension [[-Name] <String>] [[-Extension] <String>] [<CommonParameters>]

DESCRIPTION
    Adds a file name extension to a supplied name. Takes any strings for the file name or extension.

PARAMETERS
    -Name
        Specifies the file name.

        Required?                    false
        Position?                    0
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?

    -Extension
        Specifies the extension. "Txt" is the default.

        Required?                    false
        Position?                    1
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?

    <CommonParameters>
        This cmdlet supports the common parameters: -Verbose, -Debug,
        -ErrorAction, -ErrorVariable, -WarningAction, -WarningVariable,
        -OutBuffer and -OutVariable. For more information, type
        "Get-Help about_CommonParameters".

INPUTS
    None. You can't pipe objects to Add-Extension.

OUTPUTS
    System.String. Add-Extension returns a string with the extension or file name.

    -------------------------- EXAMPLE 1 --------------------------

    PS> Add-Extension -Name "File"
    File.txt

    -------------------------- EXAMPLE 2 --------------------------

    PS> Add-Extension -Name "File" -Extension "doc"
    File.doc

    -------------------------- EXAMPLE 3 --------------------------

    PS> Add-Extension "File" "doc"
    File.doc

RELATED LINKS
    Online version: http://www.fabrikam.com/add-extension.html
    Set-Item
```

## Example 2: Comment-based Help for a Script

The following sample function includes comment-based Help.

Notice the blank lines between the closing `#>` and the `param` statement. In a script that doesn't
have a `param` statement, there must be at least two blank lines between the final comment in the
Help topic and the first function declaration. Without these blank lines, `Get-Help` associates the
Help topic with the function, instead of the script.

```powershell
<#
  .SYNOPSIS
  Performs monthly data updates.

  .DESCRIPTION
  The Update-Month.ps1 script updates the registry with new data generated
  during the past month and generates a report.

  .PARAMETER InputPath
  Specifies the path to the CSV-based input file.

  .PARAMETER OutputPath
  Specifies the name and path for the CSV-based output file. By default,
  MonthlyUpdates.ps1 generates a name from the date and time it runs, and
  saves the output in the local directory.

  .INPUTS
  None. You can't pipe objects to Update-Month.ps1.

  .OUTPUTS
  None. Update-Month.ps1 doesn't generate any output.

  .EXAMPLE
  PS> .\Update-Month.ps1

  .EXAMPLE
  PS> .\Update-Month.ps1 -InputPath C:\Data\January.csv

  .EXAMPLE
  PS> .\Update-Month.ps1 -InputPath C:\Data\January.csv -OutputPath C:\Reports\2009\January.csv
#>

param ([string]$InputPath, [string]$OutputPath)

function Get-Data { }
```

The following command gets the script Help. Because the script isn't in a directory that's listed in
the PATH environment variable, the `Get-Help` command that gets the script Help must specify the
script path.

```powershell
PS> Get-Help C:\ps-test\update-month.ps1 -Full
```

```Output
NAME
    C:\ps-test\Update-Month.ps1

SYNOPSIS
    Performs monthly data updates.

SYNTAX
    C:\ps-test\Update-Month.ps1 [-InputPath] <String> [[-OutputPath]
    <String>] [<CommonParameters>]

DESCRIPTION
    The Update-Month.ps1 script updates the registry with new data
    generated during the past month and generates a report.

PARAMETERS
    -InputPath
        Specifies the path to the CSV-based input file.

        Required?                    true
        Position?                    0
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?

    -OutputPath
        Specifies the name and path for the CSV-based output file. By
        default, MonthlyUpdates.ps1 generates a name from the date
        and time it runs, and saves the output in the local directory.

        Required?                    false
        Position?                    1
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?

    <CommonParameters>
        This cmdlet supports the common parameters: -Verbose, -Debug,
        -ErrorAction, -ErrorVariable, -WarningAction, -WarningVariable,
        -OutBuffer and -OutVariable. For more information, type,
        "Get-Help about_CommonParameters".

INPUTS
        None. You can't pipe objects to Update-Month.ps1.

OUTPUTS
        None. Update-Month.ps1 doesn't generate any output.

-------------------------- EXAMPLE 1 --------------------------

PS> .\Update-Month.ps1

-------------------------- EXAMPLE 2 --------------------------

PS> .\Update-Month.ps1 -InputPath C:\Data\January.csv

-------------------------- EXAMPLE 3 --------------------------

PS> .\Update-Month.ps1 -InputPath C:\Data\January.csv -OutputPath
C:\Reports\2009\January.csv

RELATED LINKS
```

## Example 3: Parameter Descriptions in a `param` Statement

This example shows how to insert parameter descriptions in the `param` statement of a function or
script. This format is most useful when the parameter descriptions are brief.

```powershell
function Add-Extension
{
    param
    (
        [string]
        # Specifies the file name.
        $Name,

        [string]
        # Specifies the file name extension. "Txt" is the default.
        $Extension = "txt"
    )
    $Name = $Name + "." + $Extension
    $Name

    <#
        .SYNOPSIS
        Adds a file name extension to a supplied name.
...
    #>
}
```

The results are the same as the results for Example 1. `Get-Help` interprets the parameter
descriptions as though they were accompanied by the `.PARAMETER` keyword.

## Example 4:  Redirecting to an XML File

You can write XML-based Help topics for functions and scripts. Although comment-based Help is easier
to implement, XML-based Help is required if you want more precise control over Help content or if
you are translating Help topics into multiple languages.The following example shows the first few
lines of the `Update-Month.ps1` script. The script uses the `.EXTERNALHELP` keyword to specify the
path to an XML-based Help topic for the script.

```powershell
# .EXTERNALHELP C:\MyScripts\Update-Month-Help.xml

    param ([string]$InputPath, [string]$OutputPath)

    function Get-Data { }
```

The following example shows the use of the `.EXTERNALHELP` keyword in a function.

```powershell
function Add-Extension
{
    param ([string]$Name, [string]$Extension = "txt")
    $Name = $Name + "." + $Extension
    $Name

    # .EXTERNALHELP C:\ps-test\Add-Extension.xml
}
```

## Example 5:  Redirecting to a Different Help Topic

The following code is an excerpt from the beginning of the built-in `help` function in PowerShell,
which displays one screen of Help text at a time. Because the Help topic for the Get-Help cmdlet
describes the Help function, the Help function uses the `.FORWARDHELPTARGETNAME` and
`.FORWARDHELPCATEGORY` keywords to redirect the user to the Get-Help cmdlet Help topic.

```powershell
function help
{
    <#
      .FORWARDHELPTARGETNAME Get-Help
      .FORWARDHELPCATEGORY Cmdlet
    #>
    [CmdletBinding(DefaultParameterSetName='AllUsersView')]
    param(
            [Parameter(Position=0, ValueFromPipelineByPropertyName=$true)]
            [System.String]
            ${Name},
    ...
}
```

The following command uses this feature. When a user types a `Get-Help` command for the `help`
function, `Get-Help` displays the Help topic for the `Get-Help` cmdlet.

```powershell
PS> Get-Help help
```

```Output
NAME
    Get-Help

SYNOPSIS
    Displays information about Windows PowerShell cmdlets and concepts.
...
```

---
ms.date:  12/12/2018
keywords:  dsc,powershell,configuration,setup
title:  Writing help for DSC configurations
description: You can use comment-based help in DSC configurations. Users can access the help by calling the Configuration with `-?` parameter or by using the Get-Help cmdlet.
---

# Writing help for DSC configurations

> Applies To: Windows PowerShell 5.0

You can use comment-based help in DSC configurations. Users can access the help by calling the
**Configuration** with `-?`, or by using the
[Get-Help](/powershell/module/Microsoft.PowerShell.Core/Get-Help) cmdlet. Place your Comment-based
help directly above the `Configuration` keyword. You can place parameter help in-line with your
comment block, directly above the parameter declaration, or both as in the example below.

For more information about PowerShell comment-based help, see
[about_Comment_Based_Help](/powershell/module/microsoft.powershell.core/about/about_comment_based_help).

> [!NOTE]
> PowerShell development environments, like VS Code and the ISE, also have snippets to allow you to
> automatically insert comment block templates.

The following example shows a script that contains a configuration and comment-based help for it.
This example shows a Configuration with parameters. To learn more about using parameters in your
Configurations, see [Add Parameters to your Configurations](add-parameters-to-a-configuration.md).

```powershell
<#
.SYNOPSIS
A brief description of the function or script. This keyword can be used only once for each configuration.


.DESCRIPTION
A detailed description of the function or script. This keyword can be used only once for each
configuration.

.PARAMETER ComputerName
The description of a parameter. Add a .PARAMETER keyword for each parameter in the function or
script syntax.

Type the parameter name on the same line as the .PARAMETER keyword. Type the parameter description
on the lines following the .PARAMETER keyword. Windows PowerShell interprets all text between the
.PARAMETER line and the next keyword or the end of the comment block as part of the parameter
description. The description can include paragraph breaks.

The Parameter keywords can appear in any order in the comment block, but the function or script
syntax determines the order in which the parameters (and their descriptions) appear in help topic.
To change the order, change the syntax.

.EXAMPLE
HelpSample -ComputerName localhost

A sample command that uses the function or script, optionally followed by sample output and a
description. Repeat this keyword for each example. PowerShell automatically prefaces the first line
with a PowerShell prompt. Additional lines are treated as output and description. The example can
contain spaces, newlines and PowerShell code.

If you have multiple examples, there is no need to number them. PowerShell will number the examples in help text.

.EXAMPLE
HelpSample -FilePath "C:\output.txt"

This example will be labeled "EXAMPLE 2" when help is displayed to the user.
#>
configuration HelpSample1
{
    param
    (
        [string]$ComputerName = 'localhost',
        # Provide a PARAMETER section for each parameter that your script or function accepts.
        [string]$FilePath = 'C:\Destination.txt'
    )

    Node $ComputerName
    {
        File HelloWorld
        {
            Contents="Hello World"
            DestinationPath = $FilePath
        }
    }
}
```

## Viewing configuration help

To view the help for a configuration, use the `Get-Help` cmdlet with the name of the function, or
type the name of the function followed by `-?`. The following is the output of the previous
Configuration passed to `Get-Help`.

```powershell
Get-Help HelpSample1 -Detailed
```

```Output
NAME
    HelpSample1

SYNOPSIS
    A brief description of the function or script. This keyword can be used only once for each configuration.


SYNTAX
    HelpSample1 [[-InstanceName] <String>] [[-DependsOn] <String[]>] [[-PsDscRunAsCredential] <PSCredential>]
      [[-OutputPath] <String>] [[-ConfigurationData] <Hashtable>] [[-ComputerName] <String>] [[-FilePath] <String>]
      [<CommonParameters>]


DESCRIPTION
    A detailed description of the function or script. This keyword can be used only once for each configuration.


PARAMETERS
    -InstanceName <String>

    -DependsOn <String[]>

    -PsDscRunAsCredential <PSCredential>

    -OutputPath <String>

    -ConfigurationData <Hashtable>

    -ComputerName <String>
        The description of a parameter. Add a .PARAMETER keyword for each parameter in the function
        or script syntax.

        Type the parameter name on the same line as the .PARAMETER keyword. Type the parameter
        description on the lines following the .PARAMETER keyword. Windows PowerShell interprets all
        text between the .PARAMETER line and the next keyword or the end of the comment block as
        part of the parameter description. The description can include paragraph breaks.

        The Parameter keywords can appear in any order in the comment block, but the function or
        script syntax determines the order in which the parameters (and their descriptions) appear
        in help topic. To change the order, change the syntax.

    -FilePath <String>
        Provide a PARAMETER section for each parameter that your script or function accepts.

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>HelpSample -ComputerName localhost

    A sample command that uses the function or script, optionally followed by sample output and a
    description. Repeat this keyword for each example. PowerShell automatically prefaces the first
    line with a PowerShell prompt. Additional lines are treated as output and description. The
    example can contain spaces, newlines and PowerShell code.

    If you have multiple examples, there is no need to number them. PowerShell will number the
    examples in help text.


    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>HelpSample -FilePath "C:\output.txt"

    This example will be labeled "EXAMPLE 2" when help is displayed to the user.


REMARKS
    To see the examples, type: "get-help HelpSample1 -examples".
    For more information, type: "get-help HelpSample1 -detailed".
    For technical information, type: "get-help HelpSample1 -full".
```

> [!NOTE]
> Syntax fields and parameter attributes are automatically generated for you by PowerShell.

## See Also

- [DSC Configurations](configurations.md)
- [Write, Compile, and Apply a Configuration](write-compile-apply-configuration.md)
- [Add Parameters to a Configuration](add-parameters-to-a-configuration.md)

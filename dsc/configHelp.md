---
ms.date:  2017-06-12
ms.topic:  conceptual
keywords:  dsc,powershell,configuration,setup
title:  Writing help for DSC configurations
---

# Writing help for DSC configurations

>Applies To: Windows Windows PowerShell 5.0

You can use comment-based help in DSC configurations. Users can access the help by calling the configuration function with `-?`, or by using the 
[Get-Help](https://technet.microsoft.com/library/hh849696.aspx) cmdlet. For more information about PowerShell comment-based help, see 
[about_Comment_Based_Help](https://technet.microsoft.com/library/hh847834.aspx).

The following example shows a script that contains a configuration and comment-based help for it:

```powershell
<#
.SYNOPSIS
A brief description of the function or script. This keyword can be used only once for each configuration.


.DESCRIPTION
A detailed description of the function or script. This keyword can be used only once for each configuration.


.PARAMETER ComputerName
The description of a parameter. Add a .PARAMETER keyword for each parameter in the function or script syntax.

Type the parameter name on the same line as the .PARAMETER keyword. Type the parameter description on the lines following the .PARAMETER keyword. 
Windows PowerShell interprets all text between the .PARAMETER line and the next keyword or the end of the comment block as part of the parameter description. 
The description can include paragraph breaks.

The Parameter keywords can appear in any order in the comment block, but the function or script syntax determines the order in which the parameters 
(and their descriptions) appear in help topic. To change the order, change the syntax.

.PARAMETER FilePath
Provide a PARAMETER section for each parameter that your script or function accepts.

.EXAMPLE
A sample command that uses the function or script, optionally followed by sample output and a description. Repeat this keyword for each example. If you have multiple examples,
there is no need to number them. PowerShell will number the examples in help text.

.EXAMPLE
This example will be labeled "EXAMPLE 2" when help is displayed to the user.
#>

configuration HelpSample1
{
    param([string]$ComputerName,[string]$FilePath)
    File f
    {
		Contents="Hello World"
        DestinationPath = "c:\Destination.txt"
    }
}
```

## Viewing configuration help

To view the help for a configuration, use the **Get-Help** cmdlet with the name of the function, or type the name of the function followed by `-?`. The following is the output
of the previous function when passed to **Get-Help**:

```powershell
PS C:\> Get-Help HelpSample1

NAME
    HelpSample1
    
SYNOPSIS
    A brief description of the function or script. This keyword can be used only once for each configuration.
    
    
SYNTAX
    HelpSample1 [[-InstanceName] <String>] [[-DependsOn] <String[]>] [[-OutputPath] <String>] [[-ConfigurationData] <Hashtable>] [[-ComputerName] 
    <String>] [[-FilePath] <String>] [<CommonParameters>]
    
    
DESCRIPTION
    A detailed description of the function or script. This keyword can be used only once for each configuration.
    

RELATED LINKS

REMARKS
    To see the examples, type: "get-help HelpSample1 -examples".
    For more information, type: "get-help HelpSample1 -detailed".
    For technical information, type: "get-help HelpSample1 -full".
```

## See Also
* [DSC Configurations](configurations.md)


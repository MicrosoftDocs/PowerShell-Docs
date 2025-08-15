---
description: This article demonstrates how to use the Trace-Command cmdlet to visualize the parameter binding process in PowerShell.
ms.date: 05/17/2024
ms.topic: how-to
title: Visualize parameter binding
---
# Visualize parameter binding

Parameter binding is the process that PowerShell uses to determine which parameter set is being used
and to associate (bind) values to the parameters of a command. These values can come from the
command line and the pipeline.

The parameter binding process starts by binding named and positional command-line arguments. After
binding command-line arguments, PowerShell tries to bind any pipeline input. There are two ways that
values are bound from the pipeline. Parameters that accept pipeline input have one or both of the
following attributes:

- [ValueFromPipeline][01] - The value from the pipeline is bound to the parameter based on its type.
  The type of the argument must match the type of the parameter.
- [ValueFromPipelineByPropertyName][02] - The value from the pipeline is bound to the parameter
  based on its name. The object in the pipeline must have a property that matches the name of the
  parameter or one of its aliases. The type of the property must match or be convertible to the type
  of the parameter.

For more information about parameter binding, see [about_Parameter_Binding][03].

## Use `Trace-Command` to visualize parameter binding

Troubleshooting parameter binding issues can be challenging. You can use the [Trace-Command][04]
cmdlet to visualize the parameter binding process.

Consider the following scenario. You have a directory with two text files, `file1.txt` and
`[file2].txt`.

```powershell
PS> Get-ChildItem

    Directory: D:\temp\test\binding

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---           5/17/2024 12:59 PM              0 [file2].txt
-a---           5/17/2024 12:59 PM              0 file1.txt
```

You want to delete the files by passing the filenames, through the pipeline, to the `Remove-Item`
cmdlet.

```powershell
PS> 'file1.txt', '[file2].txt' | Remove-Item
PS> Get-ChildItem

    Directory: D:\temp\test\binding

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---           5/17/2024 12:59 PM              0 [file2].txt
```

Notice that `Remove-Item` only deleted `file1.txt` and not `[file2].txt`. The filename includes
square brackets, which is treated as a wildcard expression. Using `Trace-Command`, you can see that
the filename is being bound to the **Path** parameter of `Remove-Item`.

```powershell
Trace-Command -PSHost -Name ParameterBinding -Expression {
    '[file2].txt' | Remove-Item
}
```

The output from `Trace-Command` can be verbose. Each line of output is prefixed with a timestamp
and trace provider information. For the output of this example, the prefix information has been
removed to make it easier to read.

```Output
BIND NAMED cmd line args [Remove-Item]
BIND POSITIONAL cmd line args [Remove-Item]
BIND cmd line args to DYNAMIC parameters.
    DYNAMIC parameter object: [Microsoft.PowerShell.Commands.FileSystemProviderRemoveItemDynamicParameters]
MANDATORY PARAMETER CHECK on cmdlet [Remove-Item]
CALLING BeginProcessing
BIND PIPELINE object to parameters: [Remove-Item]
    PIPELINE object TYPE = [System.String]
    RESTORING pipeline parameter's original values
    Parameter [Path] PIPELINE INPUT ValueFromPipeline NO COERCION
    BIND arg [[file2].txt] to parameter [Path]
        Binding collection parameter Path: argument type [String], parameter type [System.String[]],
            collection type Array, element type [System.String], no coerceElementType
        Creating array with element type [System.String] and 1 elements
        Argument type String is not IList, treating this as scalar
        Adding scalar element of type String to array position 0
        BIND arg [System.String[]] to param [Path] SUCCESSFUL
    Parameter [Credential] PIPELINE INPUT ValueFromPipelineByPropertyName NO COERCION
    Parameter [Credential] PIPELINE INPUT ValueFromPipelineByPropertyName NO COERCION
    Parameter [Credential] PIPELINE INPUT ValueFromPipelineByPropertyName WITH COERCION
    Parameter [Credential] PIPELINE INPUT ValueFromPipelineByPropertyName WITH COERCION
MANDATORY PARAMETER CHECK on cmdlet [Remove-Item]
CALLING ProcessRecord
CALLING EndProcessing
```

Using `Get-Help`, you can see that the **Path** parameter of `Remove-Item` accepts string objects
from the pipeline `ByValue` or `ByPropertyName`. **LiteralPath** accepts string objects from the
pipeline `ByPropertyName`.

```powershell
PS> Get-Help Remove-Item -Parameter Path, LiteralPath

-Path <System.String[]>
    Specifies a path of the items being removed. Wildcard characters are permitted.

    Required?                    true
    Position?                    0
    Default value                None
    Accept pipeline input?       True (ByPropertyName, ByValue)
    Accept wildcard characters?  true


-LiteralPath <System.String[]>
    Specifies a path to one or more locations. The value of LiteralPath is used exactly as it's
    typed. No characters are interpreted as wildcards. If the path includes escape characters,
    enclose it in single quotation marks. Single quotation marks tell PowerShell not to interpret
    any characters as escape sequences.

    Required?                    true
    Position?                    named
    Default value                None
    Accept pipeline input?       True (ByPropertyName)
    Accept wildcard characters?  false
```

The output of `Trace-Command` shows that parameter binding starts by binding command-line parameters
followed by the pipeline input. You can see that `Remove-Item` receives a string object from the
pipeline. That string object is bound to the **Path** parameter.

```
BIND PIPELINE object to parameters: [Remove-Item]
    PIPELINE object TYPE = [System.String]
    RESTORING pipeline parameter's original values
    Parameter [Path] PIPELINE INPUT ValueFromPipeline NO COERCION
    BIND arg [[file2].txt] to parameter [Path]
    ...
        BIND arg [System.String[]] to param [Path] SUCCESSFUL
```

Since the **Path** parameter accepts wildcard characters, the square brackets represent a wildcard
expression. However, that expression doesn't match any files in the directory. You need to use the
**LiteralPath** parameter to specify the exact path to the file.

`Get-Command` shows that the **LiteralPath** parameter accepts input from the pipeline
`ByPropertyName` or `ByValue`. And, that it has two aliases, `PSPath` and `LP`.

```powershell
PS> (Get-Command Remove-Item).Parameters.LiteralPath.Attributes |
>> Select-Object ValueFrom*, Alias* | Format-List

ValueFromPipeline               : False
ValueFromPipelineByPropertyName : True
ValueFromRemainingArguments     : False

AliasNames : {PSPath, LP}
```

In this next example, `Get-Item` is used to retrieve a **FileInfo** object. That object has a
property named **PSPath**.

```powershell
PS> Get-Item *.txt | Select-Object PSPath

PSPath
------
Microsoft.PowerShell.Core\FileSystem::D:\temp\test\binding\[file2].txt
```

The **FileInfo** object is then passed to `Remove-Item`.

```powershell
Trace-Command -PSHost -Name ParameterBinding -Expression {
    Get-Item *.txt | Remove-Item
}
```

For the output of this example, the prefix information has been removed and separated to show
parameter binding for both commands.

In this output, you can see that `Get-Item` binds the positional parameter value `*.txt` to the
**Path** parameter.

```Output
BIND NAMED cmd line args [Get-Item]
BIND POSITIONAL cmd line args [Get-Item]
    BIND arg [*.txt] to parameter [Path]
        Binding collection parameter Path: argument type [String], parameter type [System.String[]],
            collection type Array, element type [System.String], no coerceElementType
        Creating array with element type [System.String] and 1 elements
        Argument type String is not IList, treating this as scalar
        Adding scalar element of type String to array position 0
        BIND arg [System.String[]] to param [Path] SUCCESSFUL
BIND cmd line args to DYNAMIC parameters.
    DYNAMIC parameter object: [Microsoft.PowerShell.Commands.FileSystemProviderGetItemDynamicParameters]
MANDATORY PARAMETER CHECK on cmdlet [Get-Item]
```

In the trace output for parameter binding, you can see that `Remove-Item` receives a **FileInfo**
object from the pipeline. Since a **FileInfo** object isn't a **String** object, it can't be bound
to the **Path** parameter.

The **PSPath** property of the **FileInfo** object matches an alias for the **LiteralPath**
parameter. **PSPath** is also a **String** object, so it can be bound to the **LiteralPath**
parameter without type coercion.

```Output
BIND NAMED cmd line args [Remove-Item]
BIND POSITIONAL cmd line args [Remove-Item]
BIND cmd line args to DYNAMIC parameters.
    DYNAMIC parameter object: [Microsoft.PowerShell.Commands.FileSystemProviderRemoveItemDynamicParameters]
MANDATORY PARAMETER CHECK on cmdlet [Remove-Item]
CALLING BeginProcessing
CALLING BeginProcessing
CALLING ProcessRecord
    BIND PIPELINE object to parameters: [Remove-Item]
        PIPELINE object TYPE = [System.IO.FileInfo]
        RESTORING pipeline parameter's original values
        Parameter [Path] PIPELINE INPUT ValueFromPipeline NO COERCION
        BIND arg [D:\temp\test\binding\[file2].txt] to parameter [Path]
            Binding collection parameter Path: argument type [FileInfo], parameter type [System.String[]],
                collection type Array, element type [System.String], no coerceElementType
            Creating array with element type [System.String] and 1 elements
            Argument type FileInfo is not IList, treating this as scalar
            BIND arg [D:\temp\test\binding\[file2].txt] to param [Path] SKIPPED
        Parameter [Credential] PIPELINE INPUT ValueFromPipelineByPropertyName NO COERCION
        Parameter [Path] PIPELINE INPUT ValueFromPipelineByPropertyName NO COERCION
        Parameter [Credential] PIPELINE INPUT ValueFromPipelineByPropertyName NO COERCION
        Parameter [LiteralPath] PIPELINE INPUT ValueFromPipelineByPropertyName NO COERCION
        BIND arg [Microsoft.PowerShell.Core\FileSystem::D:\temp\test\binding\[file2].txt] to parameter [LiteralPath]
            Binding collection parameter LiteralPath: argument type [String], parameter type [System.String[]],
                collection type Array, element type [System.String], no coerceElementType
            Creating array with element type [System.String] and 1 elements
            Argument type String is not IList, treating this as scalar
            Adding scalar element of type String to array position 0
            BIND arg [System.String[]] to param [LiteralPath] SUCCESSFUL
        Parameter [Credential] PIPELINE INPUT ValueFromPipelineByPropertyName WITH COERCION
    MANDATORY PARAMETER CHECK on cmdlet [Remove-Item]
    CALLING ProcessRecord
CALLING EndProcessing
CALLING EndProcessing
```

<!-- link references -->
[01]: /powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters#valuefrompipeline-argument
[02]: /powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters#valuefrompipelinebypropertyname-argument
[03]: /powershell/module/microsoft.powershell.core/about/about_parameter_binding
[04]: xref:Microsoft.PowerShell.Utility.Trace-Command

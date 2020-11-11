---
ms.date: 09/13/2016
ms.topic: reference
title: How to Create a Console Shell
description: How to Create a Console Shell
---
# How to Create a Console Shell

Windows PowerShell provides a Make-Shell tool, also referred to as the "make-kit", that is used to create a console shell that is not extensible. Shells created with this new tool cannot be extended later through a Windows PowerShell snap-in.

## Syntax

Here is the syntax used to run Make-Shell from within a make-file.

```
make-shell
  -out n.exe
  -namespace ns
  [ -lib libdirectory1[,libdirectory2,..] ]
  [ -reference ca1.dll[,ca2.dll,...] ]
  [ -formatdata fd1.format.ps1xml[,fd2.format.ps1xml,...] ]
  [ -typedata td1.type.ps1xml[,td2.type.ps1xml,...] ]
  [ -source c1.cs [,c2.cs,...] ]
  [ -authorizationmanager authorizationManagerType ]
  [ -win32icon i.ico ]
  [ -initscript p.ps1 ]
  [ -builtinscript s1.ps1[,s2.ps1,...] ]
  [ -resource resourcefile.txt ]
  [ -cscflags cscFlags ]
  [ -? | -help ]
```

## Parameters

Here is a brief description of the parameters of Make-Shell.

> [!CAUTION]
> UNC paths to assemblies are not supported by Make-Shell.

|Parameter|Description|
|---------------|-----------------|
|-out n.exe|Required. The name of the shell to produce. The path is specified as part of this parameter.<br /><br /> Make-shell will append ".exe" to this value if it is not specified. **Caution:**  Do not create an output file with the same name as the referenced .dll file. If you attempt this, the Make-Shell tool creates a .cs file with the same name, which will overwrite the .cs file that has your cmdlet source code.|
|-namespace ns|Required. The namespace to use for the derived [System.Management.Automation.Runspaces.Runspaceconfiguration](/dotnet/api/System.Management.Automation.Runspaces.RunspaceConfiguration) class that the make-kit generates and compiles.|
|-lib libdirectory1[,libdirectory2,..]|The directories that are searched for .NET assemblies, including the Windows PowerShell assemblies, assemblies specified by the `reference` parameter, assemblies indirectly referenced by another assembly, and the .NET system assemblies.|
|-reference ca1.dll[,ca2.dll,...]|A comma-separated list of the assemblies to include in the shell. These assemblies  includes all cmdlet and provider assemblies, as well as resource assemblies that should be loaded. If this parameter is not specified, then a shell is produced that contains only the core cmdlets and providers provided by Windows PowerShell.<br /><br /> The assemblies can be specified using their full path, otherwise they will be searched for using the path specified by the `lib` parameter.|
|-formatdata fd1.format.ps1xml[,fd2.format.ps1xml,...]|A comma-separated list of format data to include in the shell. If this parameter is not specified, then a shell is produced that contains only the format data provided by Windows PowerShell.|
|-typedata td1.type.ps1xml[,td2.type.ps1xml,...]|A comma-separated list of type data to include in the shell. If this parameter is not specified, then a shell is produced that contains only the type data provided by Windows PowerShell.|
|-source c1.cs [,c2.cs,...]|The name of a file, provided by the shell developer, that contains any source code needed to build the shell.<br /><br /> The source code file can contain any of the following source code:<br /><br /> -   The Authorization manager implementation that overrides the default authorization manager. (This could also be supplied compiled into an assembly.)<br />-   Assembly informational attribute declarations: such as the AssemblyCompanyAttribute, AssemblyCopyrightAttribute, AssemblyFileVersionAttribute, AssemblyInformationalVersionAttribute, AssemblyProductAttribute, and AssemblyTrademarkAttribute.|
|-authorizationmanager authorizationManagerType|The type that contains the authorization manager implementation. This can be defined in source code, or compiled into an assembly (specified by the `reference` parameter). If this parameter is not specified, the default security manager is used. The value should be the full type name, including namespaces.|
|-win32icon i.ico|The icon for the .exe file for the shell. If not specified, then the shell will have the icon that the c# compiler includes (if any).|
|-initscript p.ps1|The startup profile for the shell. The file is included "as-is"; no validity checking is done by Make-Shell.|
|-builtinscript s1.ps1[,s2.ps1,...]|A list of built-in scripts for the shell. These scripts are discovered before scripts in the path, and their contents cannot be changed once the shell is built.<br /><br /> The files are included "as-is"; no validity checking is done by Make-Shell.|
|-resource resourcefile.txt|The .txt file containing help and banner resources for the shell. The first resource is named ShellHelp, and contains the text displayed if the shell is invoked with the `help` parameter. The second resource is named ShellBanner, and it contains the text and copyright information displayed when the shell is launched in interactive mode.<br /><br /> If this parameter is not provided, or these resources are not present, then a generic help and banner are used.|
|-cscflags cscFlags|Flags that should be passed to the C# compiler (csc.exe). These are passed through unchanged. If this parameter includes spaces, it should be surrounded in double-quotes.|
|-?<br /><br /> -help|Displays the copyright message and Make-Shell command line options.|
|-verbose|Displays detailed information while the shell is being created.|

## See Also

[Windows PowerShell Programmer's Guide](./windows-powershell-programmer-s-guide.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)

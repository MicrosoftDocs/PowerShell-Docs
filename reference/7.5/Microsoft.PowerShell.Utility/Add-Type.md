---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 11/25/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/add-type?view=powershell-7.5&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Add-Type
---

# Add-Type

## SYNOPSIS
Adds a Microsoft .NET class to a PowerShell session.

## SYNTAX

### FromSource (Default)

```
Add-Type [-TypeDefinition] <String> [-Language <Language>] [-ReferencedAssemblies <String[]>]
 [-OutputAssembly <String>] [-OutputType <OutputAssemblyType>] [-PassThru] [-IgnoreWarnings]
 [-CompilerOptions <String[]>] [<CommonParameters>]
```

### FromMember

```
Add-Type [-Name] <String> [-MemberDefinition] <String[]> [-Namespace <String>]
 [-UsingNamespace <String[]>] [-Language <Language>] [-ReferencedAssemblies <String[]>]
 [-OutputAssembly <String>] [-OutputType <OutputAssemblyType>] [-PassThru] [-IgnoreWarnings]
 [-CompilerOptions <String[]>] [<CommonParameters>]
```

### FromPath

```
Add-Type [-Path] <String[]> [-ReferencedAssemblies <String[]>] [-OutputAssembly <String>]
 [-OutputType <OutputAssemblyType>] [-PassThru] [-IgnoreWarnings] [-CompilerOptions <String[]>]
 [<CommonParameters>]
```

### FromLiteralPath

```
Add-Type -LiteralPath <String[]> [-ReferencedAssemblies <String[]>] [-OutputAssembly <String>]
 [-OutputType <OutputAssemblyType>] [-PassThru] [-IgnoreWarnings] [-CompilerOptions <String[]>]
 [<CommonParameters>]
```

### FromAssemblyName

```
Add-Type -AssemblyName <String[]> [-PassThru] [<CommonParameters>]
```

## DESCRIPTION

The `Add-Type` cmdlet lets you define a Microsoft .NET Core class in your PowerShell session. You
can then instantiate objects, by using the `New-Object` cmdlet, and use the objects just as you
would use any .NET Core object. If you add an `Add-Type` command to your PowerShell profile, the
class is available in all PowerShell sessions.

You can specify the type by specifying an existing assembly or source code files, or you can specify
the source code inline or saved in a variable. You can even specify only a method and `Add-Type`
defines and generates the class. On Windows, you can use this feature to make Platform Invoke
(P/Invoke) calls to unmanaged functions in PowerShell. If you specify source code, `Add-Type`
compiles the specified source code and generates an in-memory assembly that contains the new .NET
Core types.

You can use the parameters of `Add-Type` to specify an alternate language and compiler, C# is the
default, compiler options, assembly dependencies, the class namespace, the names of the type, and
the resulting assembly.

Beginning in PowerShell 7, `Add-Type` doesn't compile a type if a type with the same name already
exists. Also, `Add-Type` looks for assemblies in a `ref` folder under the folder that contains
`pwsh.dll`.

## EXAMPLES

### Example 1: Add a .NET type to a session

This example adds the **BasicTest** class to the session by specifying source code that's stored in
a variable. The **BasicTest** class is used to add integers, create an object, and multiply
integers.

```powershell
$Source = @"
public class BasicTest
{
  public static int Add(int a, int b)
    {
        return (a + b);
    }
  public int Multiply(int a, int b)
    {
    return (a * b);
    }
}
"@

Add-Type -TypeDefinition $Source
[BasicTest]::Add(4, 3)
$BasicTestObject = New-Object BasicTest
$BasicTestObject.Multiply(5, 2)
```

The `$Source` variable stores the source code for the class. The type has a static method called
`Add` and a non-static method called `Multiply`.

The `Add-Type` cmdlet adds the class to the session. Because it's using inline source code, the
command uses the **TypeDefinition** parameter to specify the code in the `$Source` variable.

The `Add` static method of the **BasicTest** class uses the double-colon characters (`::`) to
specify a static member of the class. The integers are added and the sum is displayed.

The `New-Object` cmdlet instantiates an instance of the **BasicTest** class. It saves the new object
in the `$BasicTestObject` variable.

`$BasicTestObject` uses the `Multiply` method. The integers are multiplied and the product is
displayed.

### Example 2: Examine an added type

This example uses the `Get-Member` cmdlet to examine the objects that the `Add-Type` and
`New-Object` cmdlets created in **Example 1**.

```powershell
[BasicTest] | Get-Member
```

```Output
   TypeName: System.RuntimeType

Name                 MemberType Definition
----                 ---------- ----------
AsType               Method     type AsType()
Clone                Method     System.Object Clone(), System.Object ICloneable.Clone()
Equals               Method     bool Equals(System.Object obj), bool Equals(type o)
FindInterfaces       Method     type[] FindInterfaces(System.Reflection.TypeFilter filter...
...
```

```powershell
[BasicTest] | Get-Member -Static
```

```Output
  TypeName: BasicTest

Name            MemberType Definition
----            ---------- ----------
Add             Method     static int Add(int a, int b)
Equals          Method     static bool Equals(System.Object objA, System.Object objB)
new             Method     BasicTest new()
ReferenceEquals Method     static bool ReferenceEquals(System.Object objA, System.Object objB)
```

```powershell
$BasicTestObject | Get-Member
```

```Output
   TypeName: BasicTest

Name        MemberType Definition
----        ---------- ----------
Equals      Method     bool Equals(System.Object obj)
GetHashCode Method     int GetHashCode()
GetType     Method     type GetType()
Multiply    Method     int Multiply(int a, int b)
ToString    Method     string ToString()
```

The `Get-Member` cmdlet gets the type and members of the **BasicTest** class that `Add-Type` added
to the session. The `Get-Member` command reveals that it's a **System.RuntimeType** object, which is
derived from the **System.Object** class.

The `Get-Member` **Static** parameter gets the static properties and methods of the **BasicTest**
class. The output shows that the `Add` method is included.

The `Get-Member` cmdlet gets the members of the object stored in the `$BasicTestObject` variable.
`$BasicTestObject` was created by using the `New-Object` cmdlet with the **BasicTest** class. The
output reveals that the value of the `$BasicTestObject` variable is an instance of the **BasicTest**
class and that it includes a member called `Multiply`.

### Example 3: Add types from an assembly

This example adds the classes from the `JsonSchema.NET.dll` assembly to the current session.

```powershell
Set-Location -Path $PSHOME
$AccType = Add-Type -AssemblyName *jsonschema* -PassThru
```

`Set-Location` uses the **Path** parameter to specify the `$PSHOME` variable. The variable
references the PowerShell installation directory where the DLL file is located.

The `$AccType` variable stores an object created with the `Add-Type` cmdlet. `Add-Type` uses the
**AssemblyName** parameter to specify the name of the assembly. The asterisk (`*`) wildcard
character allows you to get the correct assembly even when you aren't sure of the name or its
spelling. The **PassThru** parameter generates objects that represent the classes that are added to
the session.

### Example 4: Call native Windows APIs

This example demonstrates how to call native Windows APIs in PowerShell. `Add-Type` uses the
Platform Invoke (P/Invoke) mechanism to call a function in `User32.dll` from PowerShell. This
example only works on computers running the Windows operating system.

```powershell
$Signature = @"
[DllImport("user32.dll")]public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
"@

$addTypeSplat = @{
    MemberDefinition = $Signature
    Name = "Win32ShowWindowAsync"
    Namespace = 'Win32Functions'
    PassThru = $true
}
$ShowWindowAsync = Add-Type @addTypeSplat

# Minimize the PowerShell console

$ShowWindowAsync::ShowWindowAsync((Get-Process -Id $pid).MainWindowHandle, 2)

# Restore the PowerShell console

$ShowWindowAsync::ShowWindowAsync((Get-Process -Id $Pid).MainWindowHandle, 4)
```

The `$Signature` variable stores the C# signature of the `ShowWindowAsync` function. To ensure that
the resulting method is visible in a PowerShell session, the `public` keyword was added to the
standard signature. For more information, see
[ShowWindowAsync](/windows/win32/api/winuser/nf-winuser-showwindowasync) function.

The `$ShowWindowAsync` variable stores the object created by the `Add-Type` **PassThru** parameter.
The `Add-Type` cmdlet adds the `ShowWindowAsync` function to the PowerShell session as a static
method. The command uses the **MemberDefinition** parameter to specify the method definition saved
in the `$Signature` variable. The command uses the **Name** and **Namespace** parameters to specify
a name and namespace for the class. The **PassThru** parameter generates an object that represents
the types.

The new `ShowWindowAsync` static method is used in the commands to minimize and restore the
PowerShell console. The method takes two parameters: the window handle, and an integer that
specifies how the window is displayed.

To minimize the PowerShell console, `ShowWindowAsync` uses the `Get-Process` cmdlet with the `$PID`
automatic variable to get the process that's hosting the current PowerShell session. Then it uses
the **MainWindowHandle** property of the current process and a value of `2`, which represents the
`SW_MINIMIZE` value.

To restore the window, `ShowWindowAsync` uses a value of `4` for the window position, which
represents the `SW_RESTORE` value.

To maximize the window, use the value of `3` that represents `SW_MAXIMIZE`.

## PARAMETERS

### -AssemblyName

Specifies the name of an assembly that includes the types. `Add-Type` takes the types from the
specified assembly. This parameter is required when you're creating types based on an assembly name.

Enter the full or simple name, also known as the partial name, of an assembly. Wildcard characters
are permitted in the assembly name. If you enter a simple or partial name, `Add-Type` resolves it to
the full name, and then uses the full name to load the assembly.

Using the **Path** or **LiteralPath** parameters guarantees that you are loading the assembly that
you intended to load. When you use the **AssemblyName** parameter, PowerShell asks .NET to resolve
the assembly name using the standard .NET assembly resolution process. Since .NET searches the
application folder first, `Add-Type` might load an assembly from `$PSHOME` instead of the version in
the current folder. For more information, see
[Assembly location](/dotnet/standard/assembly/location).

If .NET fails to resolve the name, PowerShell then looks in the current location to find the
assembly. When you use wildcards in the **AssemblyName** parameter, the .NET assembly resolution
process fails causing PowerShell to look in the current location.

```yaml
Type: System.String[]
Parameter Sets: FromAssemblyName
Aliases: AN

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -CompilerOptions

Specifies the options for the source code compiler. These options are sent to the compiler without
revision.

This parameter allows you to direct the compiler to generate an executable file, embed resources, or
set command-line options, such as the `/unsafe` option.

```yaml
Type: System.String[]
Parameter Sets: FromSource, FromMember, FromPath, FromLiteralPath
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IgnoreWarnings

Ignores compiler warnings. Use this parameter to prevent `Add-Type` from handling compiler warnings
as errors.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: FromSource, FromMember, FromPath, FromLiteralPath
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Language

Specifies the language that's used in the source code. The acceptable value for this parameter is
`CSharp`.

```yaml
Type: Microsoft.PowerShell.Commands.Language
Parameter Sets: FromSource, FromMember
Aliases:
Accepted values: CSharp

Required: False
Position: Named
Default value: CSharp
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralPath

Specifies the path to source code files or assembly DLL files that contain the types. Unlike
**Path**, the value of the **LiteralPath** parameter is used exactly as it's typed. No characters
are interpreted as wildcards. If the path includes escape characters, enclose it in single quotation
marks. Single quotation marks tell PowerShell not to interpret any characters as escape sequences.

Using the **Path** or **LiteralPath** parameters guarantees that you are loading the assembly that
you intended to load.

```yaml
Type: System.String[]
Parameter Sets: FromLiteralPath
Aliases: PSPath, LP

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MemberDefinition

Specifies new properties or methods for the class. `Add-Type` generates the template code that's
required to support the properties or methods.

On Windows, you can use this feature to make Platform Invoke (P/Invoke) calls to unmanaged functions
in PowerShell.

```yaml
Type: System.String[]
Parameter Sets: FromMember
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Specifies the name of the class to create. This parameter is required when generating a type from a
member definition.

The type name and namespace must be unique within a session. You can't unload a type or change it.
To change the code for a type, you must change the name or start a new PowerShell session.
Otherwise, the command fails.

```yaml
Type: System.String
Parameter Sets: FromMember
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Namespace

By default, this command creates the type in the
**Microsoft.PowerShell.Commands.AddType.AutoGeneratedTypes** namespace. When you use this parameter,
the type is created in the specified namespace. If the value an empty string, the type is created in
the global namespace.

```yaml
Type: System.String
Parameter Sets: FromMember
Aliases: NS

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutputAssembly

Generates a DLL file for the assembly with the specified name in the location. Enter an optional
path and filename. Wildcard characters are permitted. By default, `Add-Type` generates the assembly
only in memory. If you output the assembly to a file you should include the **PassThru** parameter
to return the type from the newly created assembly.

```yaml
Type: System.String
Parameter Sets: FromSource, FromMember, FromPath, FromLiteralPath
Aliases: OA

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -OutputType

Specifies the output type of the output assembly. By default, no output type is specified. This
parameter is valid only when an output assembly is specified in the command. For more information
about the values, see
[OutputAssemblyType Enumeration](/dotnet/api/microsoft.powershell.commands.outputassemblytype).

The acceptable values for this parameter are as follows:

- `ConsoleApplication`
- `Library`
- `WindowsApplication`

> [!IMPORTANT]
> As of PowerShell 7.1, `ConsoleApplication` and `WindowsApplication` aren't supported and
> PowerShell throws a terminating error if either are specified as values for the **OutputType**
> parameter.

```yaml
Type: Microsoft.PowerShell.Commands.OutputAssemblyType
Parameter Sets: FromSource, FromMember, FromPath, FromLiteralPath
Aliases: OT
Accepted values: ConsoleApplication, Library, WindowsApplication

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru

Returns a **System.Runtime** object that represents the types that were added. By default, this
cmdlet doesn't generate any output. Use this parameter if you used **OutputAssembly** to create a
DLL file and you want to return the type from the newly created assembly.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specifies the path to source code files or assembly DLL files that contain the types.

If you submit source code files, `Add-Type` compiles the code in the files and creates an in-memory
assembly of the types. The file extension specified in the value of **Path** determines the compiler
that `Add-Type` uses.

Using the **Path** or **LiteralPath** parameters guarantees that you are loading the assembly that
you intended to load.

```yaml
Type: System.String[]
Parameter Sets: FromPath
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReferencedAssemblies

Specifies the assemblies upon which the type depends. By default, `Add-Type` references `System.dll`
and `System.Management.Automation.dll`. Beginning in PowerShell 6, **ReferencedAssemblies** doesn't
include the default .NET assemblies. You must include a specific reference to them in the value
passed to this parameter.

```yaml
Type: System.String[]
Parameter Sets: FromSource, FromMember, FromPath, FromLiteralPath
Aliases: RA

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TypeDefinition

Specifies the source code that contains the type definitions. Enter the source code in a string or
here-string, or enter a variable that contains the source code. For more information about
here-strings, see [about_Quoting_Rules](../Microsoft.PowerShell.Core/about/about_Quoting_Rules.md).

Include a namespace declaration in your type definition. If you omit the namespace declaration, your
type might have the same name as another type or the shortcut for another type, causing an
unintentional overwrite. For example, if you define a type called **Exception**, scripts that use
**Exception** as the shortcut for **System.Exception** will fail.

```yaml
Type: System.String
Parameter Sets: FromSource
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UsingNamespace

Specifies other namespaces that are required for the class. This is much like the C# keyword,
`Using`.

By default, `Add-Type` references the **System** namespace. When the **MemberDefinition** parameter
is used, `Add-Type` also references the **System.Runtime.InteropServices** namespace by default. The
namespaces that you add by using the **UsingNamespace** parameter are referenced in addition to the
default namespaces.

```yaml
Type: System.String[]
Parameter Sets: FromMember
Aliases: Using

Required: False
Position: Named
Default value: System namespace
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You can't pipe objects to this cmdlet.

## OUTPUTS

### None

By default, this cmdlet returns no output.

### System.Type

When you use the **PassThru** parameter, this cmdlet returns a **System.Type** object representing
the new type.

## NOTES

The types that you add exist only in the current session. To use the types in all sessions, add them
to your PowerShell profile. For more information about the profile, see
[about_Profiles](../Microsoft.PowerShell.Core/About/about_Profiles.md).

Type names and namespaces must be unique within a session. You can't unload a type or change it. If
you need to change the code for a type, you must change the name or start a new PowerShell session.
Otherwise, the command fails.

In Windows PowerShell (version 5.1 and below), you need to use `Add-Type` for anything that isn't
already loaded. Most commonly, this applies to assemblies found in the Global Assembly Cache (GAC).
In PowerShell 6 and higher, there is no GAC, so PowerShell installs its own assemblies in `$PSHOME`.
These assemblies are automatically loaded on request, so there's no need to use `Add-Type` to load
them. However, using `Add-Type` is still permitted to allow scripts to be implicitly compatible with
any version of PowerShell.

Assemblies in the GAC can be loaded by type name, rather than by path. Loading assemblies from an
arbitrary path requires `Add-Type`, since those assemblies can't not be loaded automatically.

## RELATED LINKS

[about_Profiles](../Microsoft.PowerShell.Core/About/about_profiles.md)

[about_Quoting_Rules](../Microsoft.PowerShell.Core/About/about_Quoting_Rules.md)

[Add-Member](Add-Member.md)

[New-Object](New-Object.md)

[OutputAssemblyType](/dotnet/api/microsoft.powershell.commands.outputassemblytype)

[Platform Invoke (P/Invoke)](/dotnet/standard/native-interop/pinvoke)

[Where-Object](../Microsoft.PowerShell.Core/Where-Object.md)

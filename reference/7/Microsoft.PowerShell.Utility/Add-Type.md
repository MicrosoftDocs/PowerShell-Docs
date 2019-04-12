---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821749
schema: 2.0.0
title: Add-Type
---
# Add-Type

## SYNOPSIS
Adds a Microsoft .NET Core type (a class) to a PowerShell session.

## SYNTAX

### FromSource (Default)

```
Add-Type [-TypeDefinition] <String> [-Language <Language>] [-ReferencedAssemblies <String[]>]
 [-OutputAssembly <String>] [-OutputType <OutputAssemblyType>] [-PassThru] [-IgnoreWarnings]
 [-CompilerOptions <String[]>] [<CommonParameters>]
```

### FromMember

```
Add-Type [-Name] <String> [-MemberDefinition] <String[]> [-Namespace <String>] [-UsingNamespace <String[]>]
 [-Language <Language>] [-ReferencedAssemblies <String[]>] [-OutputAssembly <String>]
 [-OutputType <OutputAssemblyType>] [-PassThru] [-IgnoreWarnings] [<CommonParameters>]
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

The `Add-Type` cmdlet lets you define a Microsoft .NET Core class in your PowerShell session.
You can then instantiate objects (by using the `New-Object` cmdlet) and use the objects, just as you would use any .NET Core object.
If you add an `Add-Type` command to your PowerShell profile, the class is available in all PowerShell sessions.

You can specify the type by specifying an existing assembly or source code files, or you can specify the source code inline or saved in a variable.
You can even specify only a method and `Add-Type` will define and generate the class.
On Windows, you can use this feature to make Platform Invoke (P/Invoke) calls to unmanaged functions in PowerShell.
If you specify source code, `Add-Type` compiles the specified source code and generates an in-memory assembly that contains the new .NET Core types.

You can use the parameters of `Add-Type` to specify an alternate language and compiler (C# is the default), compiler options, assembly dependencies, the class namespace, the names of the type, and the resulting assembly.

## EXAMPLES

### Example 1: Add a .NET type to a session

```powershell
PS> $Source = @"
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

PS> Add-Type -TypeDefinition $Source
PS> [BasicTest]::Add(4, 3)
PS> $BasicTestObject = New-Object BasicTest
PS> $BasicTestObject.Multiply(5, 2)
```

These commands add the BasicTest class to the session by specifying source code that is stored in a variable.
The type has a static method called Add and a non-static method called Multiply.

The first command stores the source code for the class in the `$Source` variable.

The second command uses the `Add-Type` cmdlet to add the class to the session.
Because it is using inline source code, the command uses the **TypeDefinition** parameter to specify the code in the `$Source` variable.

The remaining commands use the new class.

The third command calls the Add static method of the BasicTest class.
It uses the double-colon characters (::) to specify a static member of the class.

The fourth command uses the `New-Object` cmdlet to instantiate an instance of the BasicTest class.
It saves the new object in the `$BasicTestObject` variable.

The fifth command uses the Multiply method of `$BasicTestObject`.

### Example 2: Examine an added type

```powershell
PS> [BasicTest] | Get-Member
```

```output
   TypeName: System.RuntimeType

Name                           MemberType Definition
----                           ---------- ----------
AsType                         Method     type AsType()
Clone                          Method     System.Object I
Equals                         Method     bool Equals(Sys
FindInterfaces                 Method     type[] FindInter...
...
```

```powershell
PS> [BasicTest] | Get-Member -Static
```

```output
   TypeName: BasicTest

Name            MemberType Definition
----            ---------- ----------
Add             Method     static int Add(int a, int b)
Equals          Method     static bool Equals(System.Obj
new             Method     BasicTest new()
ReferenceEquals Method     static bool ReferenceEquals(S
```

```powershell
PS> $BasicTestObject | Get-Member
```

```output
   TypeName: BasicTest

Name        MemberType Definition
----        ---------- ----------
Equals      Method     bool Equals(System.Object obj)
GetHashCode Method     int GetHashCode()
GetType     Method     type GetType()
Multiply    Method     int Multiply(int a, int b)
ToString    Method     string ToString()
```

These commands use the `Get-Member` cmdlet to examine the objects that the `Add-Type` and `New-Object` cmdlets created in the previous example.

The first command uses the `Get-Member` cmdlet to get the type and members of the BasicTest class that `Add-Type` added to the session.
The `Get-Member` command reveals that it is a **System.RuntimeType** object, which is derived from the System.Object class.

The second command uses the **Static** parameter of the `Get-Member` cmdlet to get the static properties and methods of the BasicTest class.
The output shows that the Add method is included.

The third command uses the `Get-Member` cmdlet to get the members of the object stored in the `$BasicTestObject` variable.
This was the object instance that was created by using the `New-Object` cmdlet with the BasicTest class.

The output reveals that the value of the `$BasicTestObject` variable is an instance of the BasicTest class and that it includes a member called Multiply.

### Example 3: Add types from an assembly

```powershell
PS> Set-Location -Path $PSHOME
PS> $AccType = Add-Type -AssemblyName *jsonschema* -PassThru
```

This command adds the classes from the NJsonSchema.dll assembly to the current session.
The command uses the **AssemblyName** parameter to specify the name of the assembly.
The wildcard character allows you to get the correct assembly even when you are not sure of the name or its spelling.

The command uses the **PassThru** parameter to generate objects that represent the classes that are added to the session, and it saves the objects in the `$AccType` variable.

### Example 4: Call native Windows APIs

This example works only on Windows.

```powershell
$Signature = @"
[DllImport("user32.dll")]public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
"@

$ShowWindowAsync = Add-Type -MemberDefinition $Signature -Name "Win32ShowWindowAsync" -Namespace Win32Functions -PassThru

# Minimize the PowerShell console

$ShowWindowAsync::ShowWindowAsync((Get-Process -Id $pid).MainWindowHandle, 2)

# Restore it

$ShowWindowAsync::ShowWindowAsync((Get-Process -Id $Pid).MainWindowHandle, 4)
```

The commands in this example demonstrate how to call native Windows APIs in PowerShell.
`Add-Type` uses the Platform Invoke (P/Invoke) mechanism to call a function in User32.dll from PowerShell.

The first command stores the C# signature of the `ShowWindowAsync` function in the `$Signature` variable.
(For more information, see [ShowWindowAsync function](https://go.microsoft.com/fwlink/?LinkId=143643) in the MSDN library.)
To ensure that the resulting method will be visible in a PowerShell session, the "public" keyword has been added to the standard signature.

The second command uses the `Add-Type` cmdlet to add the `ShowWindowAsync` function to the PowerShell session as a static method of a class that `Add-Type` creates.
The command uses the **MemberDefinition** parameter to specify the method definition saved in the `$Signature` variable.

The command uses the **Name** and **Namespace** parameters to specify a name and namespace for the class.
It uses the **PassThru** parameter to generate an object that represents the types, and it saves the object in the `$ShowWindowAsync` variable.

The third and fourth commands use the new ShowWindowAsync static method.
The method takes two parameters, the window handle, and an integer specifies how the window is to be shown.

The third command calls `ShowWindowAsync`.
It uses the `Get-Process` cmdlet with the $PID automatic variable to get the process that is hosting the current PowerShell session.
Then it uses the **MainWindowHandle** property of the current process and a value of 2, which represents the SW_MINIMIZE value.

To restore the window, the fourth command use a value of 4 for the window position, which represents the SW_RESTORE value.
(SW_MAXIMIZE is 3.)

## PARAMETERS

### -AssemblyName

Specifies the name of an assembly that includes the types.
`Add-Type` takes the types from the specified assembly.
This parameter is required when you are creating types based on an assembly name.

Enter the full or simple name (also known as the "partial name") of an assembly.
Wildcard characters are permitted in the assembly name.
If you enter a simple or partial name, `Add-Type` resolves it to the full name, and then uses the full name to load the assembly.

This parameter does not accept a path or a file name.
To enter the path to the assembly dynamic-link library (DLL) file, use the **Path** parameter.

```yaml
Type: String[]
Parameter Sets: FromAssemblyName
Aliases: AN

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompilerOptions

Specifies the options for the source code compiler.
These options are sent to the compiler without revision.

This parameter allows you to direct the compiler to generate an executable file, embed resources, or set command-line options, such as the "/unsafe" option.

You cannot use the **CompilerOptions** and **ReferencedAssemblies** parameters in the same command.

```yaml
Type: String[]
Parameter Sets: FromSource, FromMember, FromPath, FromLiteralPath
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IgnoreWarnings

Ignores compiler warnings.
Use this parameter to prevent `Add-Type` from handling compiler warnings as errors.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Language

Specifies the language that is used in the source code.
The acceptable value for this parameter is CSharp.

```yaml
Type: Language
Parameter Sets: FromSource, FromMember
Aliases:
Accepted values: CSharp

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralPath

Specifies the path to source code files or assembly DLL files that contain the types.
Unlike **Path**, the value of the **LiteralPath** parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: FromLiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MemberDefinition

Specifies new properties or methods for the class.
`Add-Type` generates the template code that is required to support the properties or methods.

On Windows, you can use this feature to make Platform Invoke (P/Invoke) calls to unmanaged functions in PowerShell.
For more information, see the examples.

```yaml
Type: String[]
Parameter Sets: FromMember
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Specifies the name of the class to create.
This parameter is required when generating a type from a member definition.

The type name and namespace must be unique within a session.
You cannot unload a type or change it.
If you need to change the code for a type, you must change the name or start a new PowerShell session.
Otherwise, the command fails.

```yaml
Type: String
Parameter Sets: FromMember
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Namespace

Specifies a namespace for the type.

If this parameter is not included in the command, the type is created in the **Microsoft.PowerShell.Commands.AddType.AutoGeneratedTypes** namespace.
If the parameter is included in the command with an empty string value or a value of `$Null`, the type is generated in the global namespace.

```yaml
Type: String
Parameter Sets: FromMember
Aliases: NS

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutputAssembly

Generates a DLL file for the assembly with the specified name in the location.
Enter a path (optional) and file name.
Wildcard characters are permitted.
By default, `Add-Type` generates the assembly only in memory.

```yaml
Type: String
Parameter Sets: FromSource, FromMember, FromPath, FromLiteralPath
Aliases: OA

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutputType

Specifies the output type of the output assembly.
The acceptable values for this parameter are:

- Library
- ConsoleApplication
- WindowsApplication

For more information about the values, see [OutputAssemblyType Enumeration](https://msdn.microsoft.com/library/microsoft.powershell.commands.outputassemblytype) in the MSDN library.

By default, no output type is specified.

This parameter is valid only when an output assembly is specified in the command.

```yaml
Type: OutputAssemblyType
Parameter Sets: FromSource, FromMember, FromPath, FromLiteralPath
Aliases: OT
Accepted values: Library, ConsoleApplication, WindowsApplication

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru

Returns a **System.Runtime** object that represents the types that were added.
By default, this cmdlet does not generate any output.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specifies the path to source code files or assembly DLL files that contain the types.

If you submit source code files, `Add-Type` compiles the code in the files and creates an in-memory assembly of the types.
The file name extension specified in the value of **Path** determines the compiler that `Add-Type` uses.

If you submit an assembly file, `Add-Type` takes the types from the assembly.
To specify an in-memory assembly or the global assembly cache, use the **AssemblyName** parameter.

```yaml
Type: String[]
Parameter Sets: FromPath
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReferencedAssemblies

Specifies the assemblies upon which the type depends.
By default, `Add-Type` references System.dll and System.Management.Automation.dll.
The assemblies that you specify by using this parameter are referenced in addition to the default assemblies.

You cannot use the **CompilerOptions** and **ReferencedAssemblies** parameters in the same command.

```yaml
Type: String[]
Parameter Sets: FromSource, FromMember, FromPath, FromLiteralPath
Aliases: RA

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TypeDefinition

Specifies the source code that contains the type definitions.
Enter the source code in a string or here-string, or enter a variable that contains the source code.
For more information about here-strings, see [about_Quoting_Rules](../Microsoft.PowerShell.Core/about/about_Quoting_Rules.md).

Include a namespace declaration in your type definition.
If you omit the namespace declaration, your type might have the same name as another type or the shortcut for another type, causing an unintentional overwrite.
For example, if you define a type called Exception, scripts that use Exception as the shortcut for **System.Exception** will fail.

```yaml
Type: String
Parameter Sets: FromSource
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UsingNamespace

Specifies other namespaces that are required for the class.
This is much like the Using keyword in C#.

By default, `Add-Type` references the **System** namespace.
When the **MemberDefinition** parameter is used, `Add-Type` also references the **System.Runtime.InteropServices** namespace by default.
The namespaces that you add by using the **UsingNamespace** parameter are referenced in addition to the default namespaces.

```yaml
Type: String[]
Parameter Sets: FromMember
Aliases: Using

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe objects to `Add-Type`.

## OUTPUTS

### None or System.Type

When you use the **PassThru** parameter, `Add-Type` returns a **System.Type** object that represents the new type.
Otherwise, this cmdlet does not generate any output.

## NOTES

- The types that you add exist only in the current session. To use the types in all sessions, add them to your PowerShell profile. For more information about the profile, see [about_Profiles](../Microsoft.PowerShell.Core/About/about_Profiles.md).
- Type names (and namespaces) must be unique within a session. You cannot unload a type or change it. If you need to change the code for a type, you must change the name or start a new PowerShell session. Otherwise, the command fails.

## RELATED LINKS

[Add-Member](Add-Member.md)

[New-Object](New-Object.md)
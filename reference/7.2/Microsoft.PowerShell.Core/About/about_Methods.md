---
description: Describes how to use methods to perform actions on objects in PowerShell.
Locale: en-US
ms.date: 04/08/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_methods?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Methods
---
# About methods

## Short description
Describes how to use methods to perform actions on objects in PowerShell.

## Long description

PowerShell uses objects to represent the items in data stores or the state of
the computer. For example, FileInfo objects represent the files in file system
drives and ProcessInfo objects represent the processes on the computer.

Objects have properties, which store data about the object, and methods that
let you change the object.

A "method" is a set of instructions that specify an action you can perform on
the object. For example, the `FileInfo` object includes the `CopyTo` method
that copies the file that the `FileInfo` object represents.

To get the methods of any object, use the `Get-Member` cmdlet. Use its
**MemberType** property with a value of "Method". The following command gets
the methods of process objects.

```powershell
Get-Process | Get-Member -MemberType Method
```

```Output
TypeName: System.Diagnostics.Process

Name                      MemberType Definition
----                      ---------- ----------
BeginErrorReadLine        Method     System.Void BeginErrorReadLine()
BeginOutputReadLine       Method     System.Void BeginOutputReadLine()
...
Kill                      Method     System.Void Kill()
Refresh                   Method     System.Void Refresh()
Start                     Method     bool Start()
ToString                  Method     string ToString()
WaitForExit               Method     bool WaitForExit(int milliseconds), ...
WaitForInputIdle          Method     bool WaitForInputIdle(int millisecon...
```

To perform or "invoke" a method of an object, type a dot (.), the method name,
and a set of parentheses "()". If the method has arguments, place the argument
values inside the parentheses. The parentheses are required for every method
call, even when there are no arguments. If the method takes multiple arguments,
they should be separated by commas.

For example, the following command invokes the Kill method of processes to end
the Notepad process on the computer.

```powershell
$notepad = Get-Process notepad
$notepad.Kill()
```

This example can be shortened by combining the above statements.

```powershell
(Get-Process Notepad).Kill()
```

The `Get-Process` command is enclosed in parentheses to ensure that it
runs before the Kill method is invoked. The `Kill` method is then invoked
on the returned `Process` object.

Another very useful method is the `Replace` method of strings. The `Replace`
method, replaces text within a string. In the example below, the dot (.) can
be placed immediately after the end quote of the string.

```powershell
'this is rocket science'.Replace('rocket', 'rock')
```

```Output
this is rock science
```

As shown in the previous examples, you can invoke a method on an object that
you get by using a command, an object in a variable, or anything that
results in an object (like a string in quotes).

Starting in PowerShell 4.0, method invocation by using dynamic method names is
supported.

### Learning about methods

To find definitions of the methods of an object, go to help topic for the
object type and look for its methods page. For example, the following page
describes the methods of process objects
[System.Diagnostics.Process](/dotnet/api/system.diagnostics.process#methods).

To determine the arguments of a method, review the method definition, which is
like the syntax diagram of a PowerShell cmdlet.

A method definition might have one or more method signatures, which are like
the parameter sets of PowerShell cmdlets. The signatures show all of the valid
formats of commands to invoke the method.

For example, the `CopyTo` method of the `FileInfo` class contains the following
two method signatures:

```
    CopyTo(String destFileName)
    CopyTo(String destFileName, Boolean overwrite)
```

The first method signature takes the destination file name (and a path). The
following example uses the first `CopyTo` method to copy the `Final.txt` file to
the `C:\Bin` directory.

```powershell
(Get-ChildItem c:\final.txt).CopyTo("c:\bin\final.txt")
```

> [!NOTE]
> Unlike PowerShell's _argument_ mode, object methods execute in _expression_
> mode, which is a pass-through to the .NET framework that PowerShell is built
> on. In _expression_ mode **bareword** arguments (unquoted strings) are not
> allowed. You can see this difference when using a the path as a parameter,
> versus the path as an argument. You can read more about parsing modes in
> [about_Parsing](about_Parsing.md)

The second method signature takes a destination file name and a Boolean value
that determines whether the destination file should be overwritten, if it
already exists.

The following example uses the second `CopyTo` method to copy the `Final.txt`
file to the `C:\Bin` directory, and to overwrite existing files.

```powershell
(Get-ChildItem c:\final.txt).CopyTo("c:\bin\final.txt", $true)
```

### Methods of Scalar objects and Collections

The methods of one ("scalar") object of a particular type are often different
from the methods of a collection of objects of the same type.

For example, every process has a `Kill` method, but a collection of processes
does not have a Kill method.

Beginning in PowerShell 3.0, PowerShell tries to prevent scripting errors that
result from the differing methods of scalar objects and collections.

If you submit a collection, but request a method that exists only on single
("scalar") objects, PowerShell invokes the method on every object in the
collection.

If the method exists on the individual objects and on the collection, only
the collection's method is invoked.

This feature also works on properties of scalar objects and collections. For
more information, see [about_Properties](about_Properties.md).

### Examples

The following example runs the **Kill** method of individual process objects in
a collection of objects.

The first command starts three instances of the Notepad process. `Get-Process`
gets all three instance of the Notepad process and saves them in the `$p`
variable.

```powershell
Notepad; Notepad; Notepad
$p = Get-Process Notepad
$p.Count
```

```Output
3
```

The next command runs the **Kill** method on all three processes in the `$p`
variable. This command works even though a collection of processes does not
have a `Kill` method.

```powershell
$p.Kill()
Get-Process Notepad
```

The `Get-Process` command confirms that the `Kill` method worked.

```Output
Get-Process : Cannot find a process with the name "notepad". Verify the proc
ess name and call the cmdlet again.
At line:1 char:12
+ Get-Process <<<<  notepad
    + CategoryInfo          : ObjectNotFound: (notepad:String) [Get-Process]
, ProcessCommandException
    + FullyQualifiedErrorId : NoProcessFoundForGivenName,Microsoft.PowerShel
l.Commands.GetProcessCommand
```

This example is functionally equivalent to using the `Foreach-Object` cmdlet to
run the method on each object in the collection.

```powershell
$p | ForEach-Object {$_.Kill()}
```

### ForEach and Where methods

Beginning in PowerShell 4.0, collection filtering by using a method syntax is
supported. This allows use of two new methods when dealing with collections
`ForEach` and `Where`.

You can read more about these methods in [about_arrays](about_arrays.md)

### Calling a specific method when multiple overloads exist

Consider the following scenario when calling .NET methods. If a method takes an
object but has an overload via an interface taking a more specific type,
PowerShell chooses the method that accepts the object unless you explicitly
cast it to that interface.

```powershell
Add-Type -TypeDefinition @'

   // Interface
   public interface IFoo {
     string Bar(int p);
   }

   // Type that implements the interface
   public class Foo : IFoo {

   // Direct member method named 'Bar'
   public string Bar(object p) { return $"object: {p}"; }

   // *Explicit* implementation of IFoo's 'Bar' method().
   string IFoo.Bar(int p) {
       return $"int: {p}";
   }

}
'@
```

In this example the less specific `object` overload of the **Bar** method was chosen.

```powershell
[Foo]::new().Bar(1)
```

```Output
object: 1
```

In this example we cast the method to the interface **IFoo** to select the more
specific overload of the **Bar** method.

```powershell
([IFoo] [Foo]::new()).Bar(1)
```

```Output
int: 1
```

## See Also

[about_Objects](about_Objects.md)

[about_Properties](about_Properties.md)

[Get-Member](xref:Microsoft.PowerShell.Utility.Get-Member)


---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Methods
---

# About methods

## SHORT DESCRIPTION

Describes how to use methods to perform actions on objects in PowerShell.

## LONG DESCRIPTION

PowerShell uses objects to represent the items in data stores or the state of
the computer. For example, FileInfo objects represent the files in file system
drives and ProcessInfo objects represent the processes on the computer.

Objects have properties, which store data about the object, and methods that
let you change the object.

A "method" is a set of instructions that specify an action you can perform on
the object. For example, the `FileInfo` object includes the `CopyTo` method that
copies the file that the `FileInfo` object represents.

To get the methods of any object, use the `Get-Member` cmdlet. Use its
**MemberType** property with a value of "Method". The following command gets
the methods of process objects.

```powershell
PS C:\> Get-Process | Get-Member -MemberType Method
```

```output
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
call, even when there are no arguments.

For example, the following command invokes the Kill method of processes to end
the Notepad process on the computer. As a result, the instance of Notepad
closes. (The `Get-Process` command is enclosed in parentheses to insure that
it runs before the Kill method is invoked.

```powershell
(Get-Process Notepad).Kill()
```

Another very useful process is the Split method of strings. The split method
takes a delimiter character argument that tells the method where to split the
string.

```powershell
PS C:\> $a = "Try-Catch-Finally"
PS C:\> $a.Split("-")
Try
Catch
Finally
```

As shown in the previous examples, you can invoke a method on an object that
you get by using a command or an object in a variable.

Starting in PowerShell 4.0, method invocation by using dynamic method names is
supported.

### LEARNING ABOUT METHODS

To find definitions of the methods of an object, go to help topic for the
object type in MSDN and look for its methods page. For example, the following
page describes the methods of process objects
[System.Diagnostics.Process](http://msdn.microsoft.com/library/system.diagnostics.process_methods).

To determine the arguments of a method, review the method definition, which is
like the syntax diagram of a PowerShell cmdlet.

A method definition might have one or more method signatures, which are like
the parameter sets of PowerShell cmdlets. The signatures show all of the valid
formats of commands to invoke the method.

For example, the `CopyTo` method of the `FileInfo` class contains the following
two method signatures:

    CopyTo(String destFileName)
    CopyTo(String destFileName, Boolean overwrite)

The first method signature takes the destination file name (and a path). The
following example use The first `CopyTo` method to copy the Final.txt file to
the C:\\Bin directory.

```powershell
(Get-ChildItem c:\final.txt).CopyTo("c:\bin\final.txt")
```

The second method signature take a destination file name and a Boolean value
that determines whether the destination file should be overwritten, if it
already exists.

The following example use The second `CopyTo` method to copy the Final.txt file
to the C:\\Bin directory, and to overwrite existing files.

```
(Get-ChildItem c:\final.txt).CopyTo("c:\bin\final.txt", $true)
```

### METHODS OF SCALAR OBJECTS AND COLLECTIONS

The methods of one ("scalar") object of a particular type are often different
from the methods of a collection of objects of the same type.

For example, every process has a `Kill` method, but a collection of processes
does not have a Kill method.

Beginning in PowerShell 3.0, PowerShell tries to prevent scripting errors that
result from the differing methods of scalar objects and collections.

Beginning in PowerShell 4.0, collection filtering by using a method syntax is
supported.

If you submit a collection, but request a method that exists only on single
("scalar") objects, PowerShell invokes the method on every object in the
collection.

If the method exists on the individual objects and on the collection,
PowerShell does not alter the result.

This feature also works on properties of scalar objects and collections. For
more information, see [about_Properties](about_Properties.md).

### EXAMPLES

The following example runs the Kill method of individual process objects on a
collection of process objects. This example works only on PowerShell 3.0 and
later versions of PowerShell.

The first command starts three instances of the Notepad process. The second
command uses the `Get-Process` command to get all three instance of the Notepad
process and save them in the \$p variable.

```powershell
PS C:\> Notepad; Notepad; Notepad
PS C:\> $p = Get-Process Notepad
```

The third command uses the Count property of all collections to verify that
there are three processes in the \$p variable.

```powershell
PS C:\> $p.Count
3
```

The fourth command runs the Kill method on all three processes in the \$p
variable.

This command works even though a collection of processes does not have a `Kill`
method.

```
PS C:\> $p.Kill()
```

The fifth command uses the Get-Process command to confirm that the `Kill`
command worked.

```powershell
PS C:\> Get-Process Notepad
Get-Process : Cannot find a process with the name "notepad". Verify the proc
ess name and call the cmdlet again.
At line:1 char:12
+ get-process <<<<  notepad
    + CategoryInfo          : ObjectNotFound: (notepad:String) [Get-Process]
, ProcessCommandException
    + FullyQualifiedErrorId : NoProcessFoundForGivenName,Microsoft.PowerShel
l.Commands.GetProcessCommand
```

To perform the same task on PowerShell 2.0, use the `Foreach-Object` cmdlet to
run the method on each object in the collection.

```powershell
PS C:\> $p | Foreach-Object {$_.Kill()}
```

## SEE ALSO

[about_Objects](about_Objects.md)

[about_Properties](about_Properties.md)

[Get-Member](../../Microsoft.PowerShell.Utility/Get-Member.md)
---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_pipelines
---

# About Pipelines
## about_Pipelines



### Short Description

Combining commands into pipelines in the Windows PowerShell

### Long Description

A pipeline is a series of commands connected by pipeline operators
(`|`)(ASCII 124). Each pipeline operator sends the results of the preceding
command to the next command.

You can use pipelines to send the objects that are output by one command
to be used as input to another command for processing. And you can send the
output of that command to yet another command. The result is a very powerful
command chain or "pipeline" that is comprised of a series of simple commands.

For example,
```powershell
Command-1 | Command-2 | Command-3
```

In this example, the objects that `Command-1` emits are sent to `Command-2`.
`Command-2` processes the objects and sends them to `Command-3`. `Command-3` processes
the objects and send them down the pipeline. Because there are no more commands in
the pipeline, the results are displayed at the console.

In a pipeline, the commands are processed from left to right in the order
that they appear. The processing is handled as a single operation and
output is displayed as it is generated.

Here is a simple example. The following command gets the Notepad process
and then stops it.

For example,
```powershell
Get-Process notepad | Stop-Process
```

The first command uses the `Get-Process` cmdlet to get an object representing
the Notepad process. It uses a pipeline operator (`|`) to send the process object
to the `Stop-Process` cmdlet, which stops the Notepad process. Notice that the
`Stop-Process` command does not have a Name or ID parameter to specify the process,
because the specified process is submitted through the pipeline.

Here is a practical example. This command pipeline gets the text files in the
current directory, selects only the files that are more than 10,000 bytes long,
sorts them by length, and displays the name and length of each file in a table.

```powershell
Get-ChildItem -Path *.txt | Where-Object {$_.length -gt 10000} |
Sort-Object -Property length | Format-Table -Property name, length
```

This pipeline is comprised of four commands in the specified order. The command
is written horizontally, but we will show the process vertically in the following
graphic.

`Get-ChildItem` `-Path` *.txt

 **|**

|   (FileInfo objects )
|   (    .txt         )

 **|**

 **V**

`Where-Object` {$_.length `-gt` 10000}

 **|**

|   (FileInfo objects )
|   (    .txt         )
|   ( Length > 10000  )

 **|**

 **V**


`Sort-Object` `-Property` Length

 **|**

|   (FileInfo objects  )
|   (    .txt          )
|   ( Length > 10000   )
|   ( Sorted by length )

 **|**

 **V**


`Format-Table` `-Property` name, length

 **|**

|   (FileInfo objects     )
|   (    .txt             )
|   ( Length > 10000      )
|   ( Sorted by length    )
|   (Formatted in a table )

 **|**

 **V**

```
Name                       Length
----                       ------
tmp1.txt                    82920
tmp2.txt                   114000
tmp3.txt                   114000
```

### Using Pipelines


The Windows PowerShell cmdlets were designed to be used in pipelines. For example,
you can usually pipe the results of a Get cmdlet to an action cmdlet (such as a Set,
Start, Stop, or Rename cmdlet) for the same noun.

For example, you can pipe any service from the `Get-Service` cmdlet to the `Start-Service`
or `Stop-Service` cmdlets (although disabled services cannot be restarted in this way).

This command pipeline starts the WMI service on the computer:

For example,
```powershell
Get-Service wmi | Start-Service
```

The cmdlets that get and set objects of the Windows PowerShell providers, such as the
Item and ItemProperty cmdlets, are also designed to be used in pipelines.

For example, you can pipe the results of a `Get-Item` or `Get-ChildItem` command in the
Windows PowerShell registry provider to the `New-ItemProperty` cmdlet. This command adds
a new registry entry, NoOfEmployees, with a value of 8124, to the MyCompany registry key.

For example,
```powershell
Get-Item -Path HKLM:\Software\MyCompany | New-ItemProperty -Name NoOfEmployees -Value 8124
```

Many of the utility cmdlets, such as `Get-Member`, `Where-Object`, `Sort-Object`, `Group-Object`,
and `Measure-Object` are used almost exclusively in pipelines. You can pipe any objects to
these cmdlets.

For example, you can pipe all of the processes on the computer to the `Sort-Object` command
and have them sorted by the number of handles in the process.

For example,
```powershell
Get-Process | Sort-Object -Property handles
```

Also, you can pipe any objects to the formatting cmdlets, such as `Format-List` and
`Format-Table`, the Export cmdlets, such as `Export-Clixml` and `Export-CSV`, and the Out
cmdlets, such as `Out-Printer`.

For example, you can pipe the Winlogon process to the `Format-List` cmdlet to display all
of the properties of the process in a list.

For example,
```powershell
Get-Process winlogon | Format-List -Property *
```

With a bit of practice, you'll find that combining simple commands into pipelines
saves time and typing, and makes your scripting more efficient.

### How Pipelines Work


When you "pipe" objects, that is send the objects in the output of one command to another
command, Windows PowerShell tries to associate the piped objects with one of the parameters
of the receiving cmdlet.

To do so, the Windows PowerShell "parameter binding" component, which associates input objects
with cmdlet parameters, tries to find a parameter that meets the following criteria:

- The parameter must accept input from a pipeline (not all do)
- The parameter must accept the type of object being sent or a type that the object
can be converted to.
- The parameter must not already be used in the command.

For example, the `Start-Service` cmdlet has many parameters, but only two of them, `-Name` and `-InputObject`
accept pipeline input. The `-Name` parameter takes strings and the `-InputObject` parameter takes
service objects. Therefore, you can pipe strings and service objects (and objects with properties
that can be converted to string and service objects) to `Start-Service`.

If the parameter binding component of Windows PowerShell cannot associate the piped objects
with a parameter of the receiving cmdlet, the command fails and Windows PowerShell prompts you
for the missing parameter values.

You cannot force the parameter binding component to associate the piped objects with a particular
parameter -- you cannot even suggest a parameter. Instead, the logic of the component manages
the piping as efficiently as possible.

### One-At-A-Time Processing


Piping objects to a command is much like using a parameter of the command to submit the
objects.

For example, piping objects representing the services on the computer to a `Format-Table` command,
such as:

```powershell
Get-Service | Format-Table -Property name, dependentservices
```

is much like saving the service objects in a variable and using the InputObject parameter
of `Format-Table` to submit the service object.

For example,
```powershell
$services = Get-Service
Format-Table -InputObject $services -Property name, dependentservices
```

or imbedding the command in the parameter value

For example,
```powershell
Format-Table -InputObject (Get-Service wmi) -Property name, dependentservices
```

However, there is an important difference. When you pipe multiple objects to a command,
Windows PowerShell sends the objects to the command one at a time. When you use a
command parameter, the objects are sent as a single array object.

This seemingly technical difference can have interesting, and sometimes useful, consequences.

For example, if you pipe multiple process objects from the `Get-Process` cmdlet to the
`Get-Member` cmdlet, Windows PowerShell sends each process object, one at a time, to `Get-Member`.
`Get-Member` displays the .NET class (type) of the process objects, and their properties and methods.
(`Get-Member` eliminates duplicates, so if the objects are all of the same type, it displays only
one object type.)

In this case, `Get-Member` displays the properties and methods of each process object, that is, a
System.Diagnostics.Process object.

For example,
```powershell
Get-Process | Get-Member
```

```
TypeName: System.Diagnostics.Process

Name                           MemberType     Definition
----                           ----------     ----------
Handles                        AliasProperty  Handles = Handlecount
Name                           AliasProperty  Name = ProcessName
NPM                            AliasProperty  NPM = NonpagedSystemMemorySize
...
```

However, if you use the InputObject parameter of `Get-Member`, then `Get-Member` receives an
array of System.Diagnostics.Process objects as a single unit, and it displays the properties
of an array of objects. (Note the array symbol ([]) after the System.Object type name.)

For example,
```powershell
Get-Member -InputObject (Get-Process)
```

```
TypeName: System.Object[]

Name               MemberType    Definition
----               ----------    ----------
Count              AliasProperty Count = Length
Address            Method        System.Object& Address(Int32 )
Clone              Method        System.Object Clone()
...
```

This result might not be what you intended, but after you understand it, you can use it. For
example, an array of process objects has a Count property that you can use to count the number
of processes on the computer.

For example,
```powershell
(Get-Process).count
```

This distinction can be important, so remember that when you pipe objects to a cmdlet, they
are delivered one at a time.

### Accepts Pipeline Input

In order to receive objects in a pipeline, the receiving cmdlet must have a parameter
that accepts pipeline input. You can use a `Get-Help` command with the **Full** or **Parameter**
parameters to determine which, if any, of a cmdlet's parameters accepts pipeline input.

In the `Get-Help` default display, the "Accept pipeline input?" item appears in a table
of parameter attributes. This table is displayed only when you use the **Full** or **Parameter**
parameters of the `Get-Help` cmdlet.

For example, to determine which of the parameters of the `Start-Service` cmdlet accepts
pipeline input, type:

```powershell
Get-Help Start-Service -Full
```

or

```powershell
Get-Help Start-Service -Parameter *
```

For example, the help for the `Start-Service` cmdlet shows that the **InputObject** and **Name**
parameters accept pipeline input ("true"). All other parameters have a value of "false"
in the "Accept pipeline input?" row.

```
-InputObject <ServiceController[]>
    Specifies ServiceController objects representing the services to be started.
    Enter a variable that contains the objects, or type a command or expression 
    that gets the objects.

    Required?                    true
    Position?                    0
    Default value                None
    Accept pipeline input?       True (ByValue)
    Accept wildcard characters?  false

-Name <String[]>
    Specifies the service names for the service to be started.

    The parameter name is optional. You can use Name or its alias, ServiceName,
    or you can omit the parameter name.

    Required?                    true
    Position?                    0
    Default value                None
    Accept pipeline input?       True (ByPropertyName, ByValue)
    Accept wildcard characters?  false
```

This means that you can send objects (PsObjects) through the pipeline to the
`Where-Object` cmdlet and Windows PowerShell will associate the object with the
**InputObject** and **Name** parameters.

### Methods Of Accepting Pipeline Input


Cmdlets parameters can accept pipeline input in one of two different ways:

- ByValue: Parameters that accept input "by value" can accept piped objects
that have the same .NET type as their parameter value or objects that can be
converted to that type.

For example, the Name parameter of `Start-Service` accepts pipeline input
by value. It can accept string objects or objects that can be converted to
strings.

- ByPropertyName: Parameters that accept input "by property name" can accept piped
objects only when a property of the object has the same name as the parameter.

For example, the Name parameter of `Start-Service` can accept objects that have
a Name property.

(To list the properties of an object, pipe it to `Get-Member`.)

Some parameters can accept objects by value or by property name. These parameters are
designed to take input from the pipeline easily.

### Investigating Pipeline Errors


If a command fails because of a pipeline error, you can investigate the failure and
rewrite the command.

For example, the following command tries to move a registry entry from one
registry key to another by using the `Get-Item` cmdlet to get the destination path and
then piping the path to the `Move-ItemProperty` cmdlet.

Specifically, the command uses the `Get-Item` cmdlet to get the destination path. It uses
a pipeline operator to send the result to the `Move-ItemProperty` cmdlet. The `Move-ItemProperty`
command specifies the current path and name of the registry entry to be moved.

For example,
```powershell
Get-Item -Path HKLM:\software\mycompany\sales |
Move-ItemProperty -Path HKLM:\software\mycompany\design -Name product
```

```
The command fails and Windows PowerShell displays the following error
message:

Move-ItemProperty : The input object cannot be bound to any parameters for the
command either because the command does not take pipeline input or the input
and its properties do not match any of the parameters that take pipeline input.
At line:1 char:23
+ $a | Move-ItemProperty <<<<  -Path HKLM:\software\mycompany\design -Name product
```

To investigate, use the `Trace-Command` cmdlet to trace the Parameter Binding component of
Windows PowerShell. The following command traces the Parameter Binding component while the
command is processing. It uses the `-PSHost` parameter to display the results at the console
and the `-filepath` command to send them to the debug.txt file for later reference.

For example,
```powershell
Trace-Command -Name parameterbinding -Expression {Get-Item -Path HKLM:\software\mycompany\sales |
Move-ItemProperty -Path HKLM:\software\mycompany\design -Name product} -PSHost -FilePath debug.txt
```

The results of the trace are lengthy, but they show the values being bound to the `Get-Item` cmdlet
and then the named values being bound to the `Move-ItemProperty` cmdlet.

...

BIND NAMED cmd line args [`Move-ItemProperty`]
BIND arg [HKLM:\software\mycompany\design] to parameter [Path]

...

BIND arg [product] to parameter [Name]

...

BIND POSITIONAL cmd line args [`Move-ItemProperty`]

...

Finally, it shows that the attempt to bind the path to the Destination parameter
of `Move-ItemProperty` failed.

...

BIND PIPELINE object to parameters: [`Move-ItemProperty`]
PIPELINE object TYPE = [Microsoft.Win32.RegistryKey]
RESTORING pipeline parameter's original values
Parameter [Destination] PIPELINE INPUT ValueFromPipelineByPropertyName NO COERCION
Parameter [Credential] PIPELINE INPUT ValueFromPipelineByPropertyName NO COERCION

...


To investigate the failure, use the `Get-Help` cmdlet to view the attributes of the
**Destination** parameter. The following command gets detailed information about the
**Destination** parameter.

```powershell
Get-Help Move-ItemProperty -Parameter Destination
```

The results show that **Destination** takes pipeline input only "by property name".
That is, the piped object must have a property named Destination.

```
-Destination <String>
    Specifies the path to the destination location.

    Required?                    true
    Position?                    1
    Default value                None
    Accept pipeline input?       True (ByPropertyName)
    Accept wildcard characters?  false
```

To see the properties of the object being piped to the `Move-ItemProperty` cmdlet,
pipe it to the `Get-Member` cmdlet. The following command pipes the results of the
first part of the command to the `Get-Member` cmdlet.

For example,
```powershell
Get-Item -Path HKLM:\software\mycompany\sales | Get-Member
```

The output shows that the item is a Microsoft.Win32.RegistryKey that does not
have a Destination property. That explains why the command failed.

To fix the command, we must specify the destination in the `Move-ItemProperty` cmdlet. We can
use a `Get-ItemProperty` command to get the path, but the name and destination must be specified
in the `Move-ItemProperty` part of the command.

For example,
```powershell
Get-Item -Path HKLM:\software\mycompany\design |
Move-ItemProperty -Dest HKLM:\software\mycompany\design -Name product
```

To verify that the command worked, use a `Get-ItemProperty` command:

For example,
```powershell
Get-Itemproperty HKLM:\software\mycompany\sales
```

The results show that the Product registry entry was moved to the Sales key.

```
PSPath       : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\software\mycompany\sales
PSParentPath : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\software\mycompany
PSChildName  : sales
PSDrive      : HKLM
PSProvider   : Microsoft.PowerShell.Core\Registry
Product      : 18
```

# See Also

[about_objects](about_objects.md)

[about_parameters](about_parameters.md)

[about_command_syntax](about_command_syntax.md)

[about_foreach](about_foreach.md)

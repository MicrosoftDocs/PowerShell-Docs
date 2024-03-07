---
description: Learn what PowerShell is and some essential commands used to discover more about PowerShell.
ms.date: 01/31/2023
ms.topic: overview
title: Discover PowerShell
---

# Discover PowerShell

PowerShell is a command-line shell and a scripting language in one. PowerShell started out on
Windows to help automate administrative tasks. Now, it runs cross platform and can be used for
various tasks.

The thing that makes PowerShell unique is that it accepts and returns .NET objects, rather than
text. This feature makes it easier to connect different commands in a _pipeline_.

## What can PowerShell be used for?

Usage of PowerShell has grown since the days when it was Windows-only. It's still used for Windows
task automation, but today, you can use it for tasks like:

- **Cloud management**. PowerShell can be used to manage cloud resources. For example, you can
  retrieve information about cloud resources, as well as update or deploy new resources.
- **CI/CD**. It can also be used as part of a Continuous Integration/Continuous Deployment pipeline.
- **Automate tasks for Active Directory and Exchange**. You can use it to automate almost any task
  on Windows like creating users in Active Directory and mailboxes in Exchange.

There are many more areas of usage but the preceding list gives you a hint that PowerShell has come
a long way.

## Who uses PowerShell?

PowerShell is a powerful tool that can help people working in a multitude of roles. Traditionally,
PowerShell has been used by the System Administrator role but is now being used by people calling
themselves DevOps, Cloud Ops, and even Developers.

## PowerShell cmdlets

PowerShell comes with hundreds of preinstalled commands. PowerShell commands are called cmdlets
(pronounced _command-lets_).

The name of each cmdlet consists of a _Verb-Noun_ pair. For example, `Get-Process`. This naming
convention makes it easier to understand what the cmdlet does. It also makes it easier to find the
command you're looking for. When looking for a cmdlet to use, you can filter on the verb or noun.

### Using cmdlets to explore PowerShell

When you first pick up PowerShell, it might feel intimidating as there seems to be so much to learn.
PowerShell is designed to help you learn a little at a time, as you need it.

PowerShell includes cmdlets that help you discover PowerShell. Using these three cmdlets, you can
discover what commands are available, what they do, and what types they operate on.

- `Get-Verb`. Running this command returns a list of verbs that most commands adhere to. The
  response includes a description of what these verbs do. Since most commands follow this naming
  convention, it sets expectations on what a command does. This helps you select the appropriate
  command and what to name a command, should you be creating one.
- `Get-Command`. This command retrieves a list of all commands installed on your machine.
- `Get-Member`. It operates on object based output and is able to discover what object, properties
  and methods are available for a command.
- `Get-Help`. Invoking this command with the name of a command as an argument displays a help page
  describing various parts of a command.

Using these commands, you can discover almost anything you need to know about PowerShell.

### Verb

_Verb_ is an important concept in PowerShell. It's a naming standard that most cmdlets follow. It's
also a naming standard you're expected to follow when you write your own commands. The idea is that
the _Verb_ says what you're trying to do, like read or maybe change data. PowerShell has a
standardized list of verbs. To get a full list of all possible verbs, use the `Get-Verb` cmdlet:

```powershell
Get-Verb
```

The cmdlet returns a long list of verbs. The **Description** provides context for what the verb is
meant to do. Here's the first few rows of output:

```Output
Verb    AliasPrefix   Group     Description
----    -----------   -----     -----------
Add     a             Common    Adds a resource to a container, or attaches an item to another item
Clear   cl            Common    Removes all the resources from a container but does not delete the container
Close   cs            Common    Changes the state of a resource to make it inaccessible, unavailable, or unusab…
Copy    cp            Common    Copies a resource to another name or to another container
Enter   et            Common    Specifies an action that allows the user to move into a resource
Exit    ex            Common    Sets the current environment or context to the most recently used context
...
```

## Find commands with Get-Command

The `Get-Command` cmdlet returns a list of all available commands installed on your system. The list
you get back is quite large. You can limit the amount of information that comes back by filtering
the response using parameters or helper cmdlets.

### Filter on name

You can filter the output of `Get-Command` using different parameters. Filtering allows you to find
commands that have certain properties. The **Name** parameter allows you to find a specific command
by name.

```powershell
Get-Command -Name Get-Process
```

```Output
CommandType     Name              Version    Source
-----------     ----              -------    ------
Cmdlet          Get-Process       7.0.0.0    Microsoft.PowerShell.Management
```

What if you want to find all the commands that work with processes? You can use a wildcard `*`
to match other forms of the string. For example:

```powershell
Get-Command -Name *-Process
```

```Output
CommandType     Name              Version    Source
-----------     ----              -------    ------
Cmdlet          Debug-Process     7.0.0.0    Microsoft.PowerShell.Management
Cmdlet          Get-Process       7.0.0.0    Microsoft.PowerShell.Management
Cmdlet          Start-Process     7.0.0.0    Microsoft.PowerShell.Management
Cmdlet          Stop-Process      7.0.0.0    Microsoft.PowerShell.Management
Cmdlet          Wait-Process      7.0.0.0    Microsoft.PowerShell.Management
```

### Filtering on Noun and Verb

There are other parameters that filter on verb and noun values. The verb part of a command's name is
the leftmost part. The verb should be one of the values returned by the `Get-Verb` cmdlet. The
rightmost part of a command is the noun part. A noun can be anything.

- **Filter on verb**. In the command
  `Get-Process`, the verb part is `Get`. To filter on the verb part, use the **Verb** parameter.

   ```powershell
   Get-Command -Verb 'Get'
   ```

   This example lists all commands that use the verb `Get`.

- **Filter on noun**. In the command `Get-Process`, the noun part is `Process`. To filter on the
  noun, use the **Noun** parameter. The following example returns all cmdlets that have nouns
  starting with the letter `U`.

   ```powershell
   Get-Command -Noun U*
   ```

Also, you can combine parameters to narrow down your search, for example:

```powershell
Get-Command -Verb Get -Noun U*
```

```Output
CommandType     Name                         Version    Source
-----------     ----                         -------    ------
Cmdlet          Get-UICulture                7.0.0.0    Microsoft.PowerShell.Utility
Cmdlet          Get-Unique                   7.0.0.0    Microsoft.PowerShell.Utility
Cmdlet          Get-Uptime                   7.0.0.0    Microsoft.PowerShell.Utility
```

### Use helper cmdlets to filter results

You can also use other cmdlets to filter results.

- `Select-Object`. This versatile command helps you pick out specific properties from one or more
  objects. You can also limit the number of items you get back. The following example returns the
  **Name** and **Source** property values for the first 5 commands available in the current session.

   ```powershell
   Get-Command | Select-Object -First 5 -Property Name, Source
   ```

   ```Output
   Name                      Source
   ----                      ------
   Add-AppPackage            Appx
   Add-AppPackageVolume      Appx
   Add-AppProvisionedPackage Dism
   Add-AssertionOperator     Pester
   Add-ProvisionedAppPackage Dism
   ```

   For more information, see [Select-Object][03].

- `Where-Object`. This cmdlet lets you filter the objects returned based on the values of
  properties. The command takes an expression that can test the value of a property. The following
  example returns all processes where the `ProcessName` starts with `p`.

  ```powershell
  Get-Process | Where-Object {$_.ProcessName -like "p*"}
  ```

  The `Get-Process` cmdlet returns a collection of process objects. To filter the response, _pipe_
  the output to `Where-Object`. Piping means that two or more commands are connected via a pipe `|`
  character. The output from one command is sent as the input for the next command. The filter
  expression for `Where-Object` uses the `-like` operator to match processes that start with the
  letter `p`.

## Explore objects with Get-Member

Once you've been able to locate the cmdlet you want, you want to know more about what output it
produces. The `Get-Member` cmdlet displays the type, properties, and methods of an object. Pipe the
output you want to inspect to `Get-Member`.

```powershell
Get-Process | Get-Member
```

The result displays the returned type as `TypeName` and all the properties and methods of the
object. Here's an excerpt of such a result:

```Output
TypeName: System.Diagnostics.Process

Name        MemberType     Definition
----        ----------     ----------
Handles     AliasProperty  Handles = Handlecount
Name        AliasProperty  Name = ProcessName
...
```

Using the **MemberType** parameter you can limit the information returned.

```powershell
Get-Process | Get-Member -MemberType Method
```

By default PowerShell only displays a few properties. The previous example displayed the `Name`,
`MemberType` and `Definition` members. You can use `Select-Object` to specify properties you want to
see. For example, you want to display only the `Name` and `Definition` properties:

```powershell
Get-Process | Get-Member | Select-Object Name, Definition
```

### Search by parameter type

`Get-Member` showed us that `Get-Process` returns **Process** type objects. The **ParameterType**
parameter of `Get-Command` can be used to find other commands that take **Process** objects as
input.

```powershell
Get-Command -ParameterType Process
```

```Output
CommandType     Name                         Version    Source
-----------     ----                         -------    ------
Cmdlet          Debug-Process                7.0.0.0    Microsoft.PowerShell.Managem…
Cmdlet          Enter-PSHostProcess          7.1.0.0    Microsoft.PowerShell.Core
Cmdlet          Get-Process                  7.0.0.0    Microsoft.PowerShell.Managem…
Cmdlet          Get-PSHostProcessInfo        7.1.0.0    Microsoft.PowerShell.Core
Cmdlet          Stop-Process                 7.0.0.0    Microsoft.PowerShell.Managem…
Cmdlet          Wait-Process                 7.0.0.0    Microsoft.PowerShell.Managem…
```

Knowing the output type of a command can help narrow down your search for related commands.

### Additional resources

- [Get-Command][01]
- [Get-Member][02]
- [Select-Object][03]

<!-- link references -->
[01]: xref:Microsoft.PowerShell.Core.Get-Command
[02]: xref:Microsoft.PowerShell.Utility.Get-Member
[03]: xref:Microsoft.PowerShell.Utility.Select-Object

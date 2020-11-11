---
ms.date: 09/13/2016
ms.topic: reference
title: Windows PowerShell Reference
description: Windows PowerShell Reference
---
# Windows PowerShell Reference

Windows PowerShell is a Microsoft .NET Framework-connected environment designed for administrative
automation. Windows PowerShell provides a new approach to building commands, composing solutions,
and creating graphical user interface-based management tools.

Windows PowerShell enables a system administrator to automate the administration of system resources
by the execution of commands either directly or through scripts.

## Developer Audience

The Windows PowerShell Software Development Kit (SDK) is written for command developers who require
reference information about the APIs provided by Windows PowerShell. Command developers use Windows
PowerShell to create both commands and providers that extend the tasks that can be performed by
Windows PowerShell.

## Windows PowerShell Resources

In addition to the Windows PowerShell SDK, the following resources provide more information.

[Getting Started with Windows PowerShell](/powershell/scripting/getting-started/getting-started-with-windows-powershell)
Provides an introduction to Windows PowerShell: the language, the cmdlets, the providers, and the
use of objects.

[Writing a Windows PowerShell Module](./module/writing-a-windows-powershell-module.md) Provides
information and examples for administrators, script developers, and cmdlet developers who need to
package and distribute their Windows PowerShell solutions using Windows PowerShell modules.

[Writing a Windows PowerShell Cmdlet](./cmdlet/writing-a-windows-powershell-cmdlet.md) Provides
information and code examples for program managers who are designing cmdlets and for developers who
are implementing cmdlet code.

[Windows PowerShell Team Blog](https://devblogs.microsoft.com/powershell/) The best resource for
learning from and collaborating with other Windows PowerShell users. Read the Windows PowerShell
Team blog, and then join the Windows PowerShell User Forum (microsoft.public.windows.powershell).
Use Windows Live Search to find other Windows PowerShell blogs and resources. Then, as you develop
your expertise, freely contribute your ideas.

[PowerShell module browser](/powershell/module/) Provides the latest versions of the command-line
Help topics.

## Class Libraries

[System.Management.Automation](/dotnet/api/System.Management.Automation) This namespace is the root
namespace for Windows PowerShell. It contains the classes, enumerations, and interfaces required to
implement custom cmdlets. In particular, the
[System.Management.Automation.Cmdlet](/dotnet/api/System.Management.Automation.Cmdlet) class is the
base class from which all cmdlet classes must be derived. For more information about cmdlets, see.

[System.Management.Automation.Provider](/dotnet/api/System.Management.Automation.Provider) This
namespace contains the classes, enumerations, and interfaces required to implement a Windows
PowerShell provider. In particular, the
[System.Management.Automation.Provider.Cmdletprovider](/dotnet/api/System.Management.Automation.Provider.CmdletProvider)
class is the base class from which all Windows PowerShell provider classes must be derived.

[Microsoft.PowerShell.Commands](/dotnet/api/Microsoft.PowerShell.Commands) This namespace contains
the classes for the cmdlets and providers implemented by Windows PowerShell. Similarly, it is
recommended that you create a *YourName*.Commands namespace for those cmdlets that you implement.

[System.Management.Automation.Host](/dotnet/api/System.Management.Automation.Host) This namespace
contains the classes, enumerations, and interfaces that the cmdlet uses to define the interaction
between the user and Windows PowerShell.

[System.Management.Automation.Internal](/dotnet/api/System.Management.Automation.Internal) This
namespace contains the base classes used by other namespace classes. For example, the
[System.Management.Automation.Internal.Cmdletmetadataattribute](/dotnet/api/System.Management.Automation.Internal.CmdletMetadataAttribute)
class is the base class for the
[System.Management.Automation.CmdletAttribute](/dotnet/api/System.Management.Automation.CmdletAttribute)
class.

[System.Management.Automation.Runspaces](/dotnet/api/System.Management.Automation.Runspaces) This
namespace contains the classes, enumerations, and interfaces used to create a Windows PowerShell
runspace. In this context, the Windows PowerShell runspace is the context in which one or more
Windows PowerShell pipelines invoke cmdlets. That is, cmdlets work within the context of a Windows
PowerShell runspace. For more information aboutWindows PowerShell runspaces, see
[Windows PowerShell Runspaces](hosting/creating-runspaces.md).

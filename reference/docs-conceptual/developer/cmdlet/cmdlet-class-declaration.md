---
ms.date: 09/13/2016
ms.topic: reference
title: Cmdlet Class Declaration
description: Cmdlet Class Declaration
---
# Cmdlet Class Declaration

A Microsoft .NET Framework class is declared as a cmdlet by specifying the **Cmdlet** attribute as
metadata for the class. (The **Cmdlet** attribute is the only required attribute for all cmdlets).
When you specify the **Cmdlet** attribute, you must specify the verb-and-noun pair that identifies
the cmdlet to the user. And, you must describe the Windows PowerShell functionality that the cmdlet
supports. For more information about the declaration syntax that is used to specify the **Cmdlet**
attribute, see [Cmdlet Attribute Declaration](./cmdlet-attribute-declaration.md).

> [!NOTE]
> The **Cmdlet** attribute is defined by the
> [System.Management.Automation.CmdletAttribute](/dotnet/api/System.Management.Automation.CmdletAttribute)
> class. The properties of this class correspond to the declaration parameters that are used when
> you declare the attribute.

## Nouns

The noun of the cmdlet specifies the resources upon which the cmdlet acts. The noun differentiates
your cmdlets from other cmdlets.

Nouns in cmdlet names must be specific, and in the case of generic nouns, such as *server*, it is
best to add a short prefix that differentiates your resource from other similar resources. For
example, a cmdlet name that includes a noun with a prefix is `Get-SQLServer`. The combination of a
specific noun with a more general verb enables the user to quickly locate the cmdlet by its action
and then identify the cmdlet by its resource while avoiding unnecessary cmdlet name duplication.

For a list of special characters that cannot be used in cmdlet names, see
[Required Development Guidelines](./required-development-guidelines.md).

## Verbs

When you specify a verb, the development guidelines require you to use one of the predefined verbs
provided by Windows PowerShell. By using one of these predefined verbs, you will ensure consistency
between the cmdlets that you write and the cmdlets that are written by Microsoft and by others. For
example, the "Get" verb is used for cmdlets that retrieve data.

For more information about guidelines for verbs, see
[Cmdlet Verb Names](./approved-verbs-for-windows-powershell-commands.md). For a list of special
characters that cannot be used in cmdlet names, see
[Required Development Guidelines](./required-development-guidelines.md).

## Supporting Windows PowerShell Functionality

The **Cmdlet** attribute also allows you to specify that your cmdlet supports some of the common
functionality that is provided by Windows PowerShell. This includes support for common functionality
such as user feedback confirmation (referred to as support for the ShouldProcess feature) and
support for transactions. (Support for transactions was introduced in Windows PowerShell 2.0).

For more information about the declaration syntax that is used to specify the **Cmdlet** attribute,
see [Cmdlet Attribute Declaration](./cmdlet-attribute-declaration.md).

## Cmdlet Class Definition

The following code is the definition for a GetProc cmdlet class. Notice that Pascal casing is used
and that the name of the class includes the verb and noun of the cmdlet.

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/GetProcessSample01/GetProcessSample01.cs" range="33-34":::

## Pascal Casing

When you name cmdlets, use Pascal casing. For example, the `Get-Item` and `Get-ItemProperty` cmdlets
show the correct way to use capitalization when you are naming cmdlets.

## See Also

[System.Management.Automation.CmdletAttribute](/dotnet/api/System.Management.Automation.CmdletAttribute)

[CmdletAttribute Declaration](./cmdlet-attribute-declaration.md)

[Cmdlet Verb Names](./approved-verbs-for-windows-powershell-commands.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)

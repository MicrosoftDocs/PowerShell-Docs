---
ms.date: 09/13/2016
ms.topic: reference
title: How to Add a Cmdlet Description
description: How to Add a Cmdlet Description
---
# How to Add a Cmdlet Description

This section describes how to add content that is displayed in the **DESCRIPTION** section of the cmdlet
Help. In the Help file, this content is added to the **Command** node for each cmdlet.

> [!NOTE]
> For a complete view of a Help file, open one of the `dll-Help.xml` files located in the PowerShell
> installation directory. For example, the `Microsoft.PowerShell.Commands.Management.dll-Help.xml`
> file contains content for several of the PowerShell cmdlets.

### To Add a Description

- Begin by explaining the basic features of the cmdlet in more detail. In many cases, you can
  explain the terms used in the cmdlet name and illustrate unfamiliar concepts with an example. For
  example, if the cmdlet appends data to a file, explain that it adds data to the end of an existing
  file.

- To find all of the features of the cmdlet, review the parameter list. Describe the primary
  function of the cmdlet, and then include other functions and features. For example, if the main
  function of the cmdlet is to change one property, but the cmdlet can change all of the properties,
  say so in the detailed description. If the cmdlet parameters let the users solicit information in
  different ways, explain it.

- Include information on ways that users can use the cmdlet, in addition to the obvious uses. For
  example, you can use the object that the `Get-Host` cmdlet retrieves to change the color of text
  in the Windows PowerShell command window.

  Example: "The `Get-Acl` cmdlet gets objects that represent the security descriptor of a file or
  resource. The security descriptor contains the access control lists (ACLs) of the resource. The
  ACL specifies the permissions that users and user groups have to access the resource."

- The detailed description should describe the cmdlet, but it should not describe concepts that the
  cmdlet uses. Place concept definitions in Additional Notes.

## See Also

[Windows PowerShell SDK](../windows-powershell-reference.md)

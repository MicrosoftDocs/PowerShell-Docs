---
ms.date: 09/13/2016
ms.topic: reference
title: Confirmation Messages
description: Confirmation Messages
---
# Confirmation Messages

Here are different confirmation messages that can be displayed depending on the variants of the
[System.Management.Automation.Cmdlet.ShouldProcess](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess)
and
[System.Management.Automation.Cmdlet.ShouldContinue](/dotnet/api/System.Management.Automation.Cmdlet.ShouldContinue)
methods that are called.

> [!IMPORTANT]
> For sample code that shows how to request confirmations, see
> [How to Request Confirmations](./how-to-request-confirmations.md).

## Specifying the Resource

You can specify the resource that is about to be changed by calling the
[System.Management.Automation.Cmdlet.Shouldprocess%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess)
method. In this case, you supply the resource by using the `target` parameter of the method, and the
operation is added by Windows PowerShell. In the following message, the text "MyResource" is the
resource acted on and the operation is the name of the command that makes the call.

```Output
Confirm
Are you sure you want to perform this action?
Performing operation "Test-RequestConfirmationTemplate1" on Target "MyResource".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"):
```

If the user selects **Yes** or **Yes to All** to the confirmation request (as shown in the following
example), a call to the
[System.Management.Automation.Cmdlet.ShouldContinue](/dotnet/api/System.Management.Automation.Cmdlet.ShouldContinue)
method is made, which causes a second confirmation message to be displayed.

```Output
Confirm
Are you sure you want to perform this action?
Performing operation "Test-RequestConfirmationTemplate1" on Target "MyResource".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): y

Confirm
Continue with this operation?
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"):
```

## Specifying the Operation and Resource

You can specify the resource that is about to be changed and the operation that the command is about
to perform by calling the
[System.Management.Automation.Cmdlet.Shouldprocess%2A?Displayproperty=Fullname](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess)
method. In this case, you supply the resource by using the `target` parameter and the operation by
using the `target` parameter. In the following message, the text "MyResource" is the resource acted
on and "MyAction" is the operation to be performed.

```Output
Confirm
Are you sure you want to perform this action?
Performing operation "MyAction" on Target "MyResource".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"):
```

If the user selects **Yes** or **Yes to All** to the previous message, a call to the
[System.Management.Automation.Cmdlet.ShouldContinue](/dotnet/api/System.Management.Automation.Cmdlet.ShouldContinue)
method is made, which causes a second confirmation message to be displayed.

```Output
Confirm
Are you sure you want to perform this action?
Performing operation "MyAction" on Target "MyResource".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): y

Confirm
Continue with this operation?
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"):
```

## See Also

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)

---
ms.date: 09/13/2016
ms.topic: reference
title: Users Requesting Confirmation
description: Users Requesting Confirmation
---
# Users Requesting Confirmation

When you specify a value of `true` for the `SupportsShouldProcess` parameter of the Cmdlet attribute declaration, users can specify the `Confirm` parameter at the command prompt.

In the default environment, users can specify the `Confirm` parameter or `"-Confirm:$true` so that confirmation is requested when the [System.Management.Automation.Cmdlet.ShouldProcess](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess) method is called. This bypasses [System.Management.Automation.Cmdlet.ShouldProcess](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess) confirmation requests, even for high-impact operations.

If `Confirm` is not specified, the [System.Management.Automation.Cmdlet.ShouldProcess](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess) call requests confirmation if the `$ConfirmPreference` preference variable is equal to or greater than the `ConfirmImpact` setting of the cmdlet or provider. The default setting of `$ConfirmPreference` is High. Therefore, in the default environment, only cmdlets and providers that specify a high-impact action request confirmation.

If `Confirm` is false or if `"-Confirm:$false` is specified, the [System.Management.Automation.Cmdlet.ShouldProcess](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess) call requests confirmation from the user, and the `$ConfirmPreference` shell variable is ignored.

## Remarks

- For cmdlets and providers that specify `SupportsShouldProcess`, but not `ConfirmImpact`, those actions are handled as "medium impact" actions, and they will not prompt by default. Their impact level is less than the default setting of the `$ConfirmPreference` preference variable.

- If the user specifies the `Verbose` parameter, they will be notified of the operation even if they are not prompted for confirmation.

## See Also

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)

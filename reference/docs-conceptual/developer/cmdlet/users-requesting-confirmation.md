---
description: Users Requesting Confirmation
ms.date: 09/24/2024
ms.topic: reference
title: Users Requesting Confirmation
---
# Users Requesting Confirmation

When you specify a value of `true` for the `SupportsShouldProcess` parameter of the Cmdlet attribute
declaration, the **Confirm** parameter is added to the parameters of the cmdlet.

In the default environment, users can specify the **Confirm** parameter so that confirmation is
requested when the `ShouldProcess()` method is called. This forces confirmation regardless of the
impact level setting.

If **Confirm** parameter is not used, the `ShouldProcess()` call requests confirmation if the
`ConfirmImpact` setting is equal to or greater than the `$ConfirmPreference` preference variable.
The default setting of `$ConfirmPreference` is **High**. Therefore, in the default environment, only
cmdlets and providers that specify a high-impact action request confirmation.

If **Confirm** is explicitly set to false (`-Confirm:$false`), the cmdlet runs without prompting for
confirmation and the `$ConfirmPreference` shell variable is ignored.

## Remarks

- For cmdlets and providers that specify `SupportsShouldProcess`, but not `ConfirmImpact`, those
  actions are handled as `Medium` impact actions, and they will not prompt by default. Their impact
  level is less than the default setting of the `$ConfirmPreference` preference variable.

- If the user specifies the `Verbose` parameter, they will be notified of the operation even if they
  are not prompted for confirmation.

## See Also

- [Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
- [System.Management.Automation.Cmdlet.ShouldProcess](/dotnet/api/System.Management.Automation.Cmdlet.ShouldProcess)

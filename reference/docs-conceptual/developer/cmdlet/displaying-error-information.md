---
ms.date: 09/13/2016
ms.topic: reference
title: Displaying Error Information
description: Displaying Error Information
---
# Displaying Error Information

This topic discusses the ways in which users can display error information.

When your cmdlet encounters an error, the presentation of the error information will, by default, resemble the following error output.

```powershell
$ stop-service lanmanworkstation
You do not have sufficient permissions to stop the service Workstation.
```

However, users can view errors by category by setting the `$ErrorView` variable to `"CategoryView"`. Category view displays specific information from the error record rather than a free-text description of the error. This view can be useful if you have a long list of errors to scan. In category view, the previous error message is displayed as follows.

```powershell
$ $ErrorView = "CategoryView"
$ stop-service lanmanworkstation
CloseError: (System.ServiceProcess.ServiceController:ServiceController) [stop-service], ServiceCommandException
```

For more information about error categories, see [Windows PowerShell Error Records](./windows-powershell-error-records.md).

## See Also

[Windows PowerShell Error Records](./windows-powershell-error-records.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)

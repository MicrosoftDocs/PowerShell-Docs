---
ms.date: 09/13/2016
ms.topic: reference
title: Date and Time Parameters
description: Date and Time Parameters
---
# Date and Time Parameters

The following table lists recommended names and functionality for parameters that handle date and time information. Date and time parameters are typically used to record when something is created or accessed.

|Parameter|Functionality|
|---|---|
|**Accessed**<br>Data type: SwitchParameter|Implement this parameter so that when it is specified the cmdlet will operate on the resources that have been accessed based on the date and time specified by the **Before** and **After** parameters. If this parameter is specified, the **Created** and **Modified** parameters must be not be specified.|
|**After**<br>Data type: DateTime|Implement this parameter to specify the date and time after which the cmdlet was used. For the **After** parameter to work, the cmdlet must also have an **Accessed**, **Created**, or **Modified** parameter. And, that parameter must be set to **true** when the cmdlet is called.|
|**Before**<br>Data type: DateTime|Implement this parameter to specify the date and time before which the cmdlet was used. For the **Before** parameter to work, the cmdlet must also have an **Accessed**, **Created**, or **Modified** parameter. And, that parameter must be set to **true** when the cmdlet is called.|
|**Created**<br>Data type: SwitchParameter|Implement this parameter so that when it is specified the cmdlet will operate on the resources that have been created based on the date and time specified by the **Before** and **After** parameters. If this parameter is specified, the **Accessed** and **Modified** parameters must not be specified.|
|**Exact**<br>Data type: SwitchParameter|Implement this parameter so that when it is specified the resource term must match the resource name exactly. When the parameter is not specified the resource term and name do not need to match exactly.|
|**Modified**<br>Data type: DateTime|Implement this parameter so that when it is specified the cmdlet will operate on resources that have been changed based on the date and time specified by the **Before** and **After** parameters. If this parameter is specified, the **Accessed** and **Created** parameters must not be specified.|
## See Also

[Cmdlet Parameters](./cmdlet-parameters.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)

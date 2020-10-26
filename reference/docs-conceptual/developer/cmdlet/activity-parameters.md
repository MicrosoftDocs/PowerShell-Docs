---
ms.date: 09/13/2016
ms.topic: reference
title: Activity Parameters
description: Activity Parameters
---
# Activity Parameters

The following table lists the recommended names and functionality for activity parameters.

|Parameter|Functionality|
|---|---|
|**Append**<br>Data type: SwitchParameter|Implement this parameter so that the user can add content to the end of a resource when the parameter is specified.|
|**CaseSensitive**<br>Data type: SwitchParameter|Implement this parameter so the user can require case sensitivity when the parameter is specified.|
|**Command**<br>Data type: String|Implement this parameter so the user can specify a command string to run.|
|**CompatibleVersion**<br>Data type: System.Version object|Implement this parameter so the user can specify the semantics that the cmdlet must be compatible with for compatibility with previous versions.|
|**Compress**<br>Data type: SwitchParameter|Implement this parameter so that data compression is used when the parameter is specified.|
|**Compress**<br>Data type: Keyword|Implement this parameter so that the user can specify the algorithm to use for data compression.|
|**Continuous**<br>Data type: SwitchParameter|Implement this parameter so that data is processed until the user terminates the cmdlet when the parameter is specified. If the parameter is not specified, the cmdlet processes a predefined amount of data and then terminates the operation.|
|**Create**<br>Data type: SwitchParameter|Implement this parameter to indicate that a resource is created if one does not already exist when the parameter is specified.|
|**Delete**<br>Data type: SwitchParameter|Implement this parameter so that resources are deleted when the cmdlet has completed its operation when the parameter is specified.|
|**Drain**<br>Data type: SwitchParameter|Implement this parameter to indicate that outstanding work items are processed before the cmdlet processes new data when the parameter is specified. If the parameter is not specified, the work items are processed immediately.|
|**Erase**<br>Data type: Int32|Implement this parameter so that the user can specify the number of times a resource is erased before it is deleted.|
|**ErrorLevel**<br>Data type: Int32|Implement this parameter so that the user can specify the level of errors to report.|
|**Exclude**<br>Data type: String[]|Implement this parameter so that the user can exclude something from an activity. For more information about how to use input filters, see [Input Filter Parameters](input-filter-parameters.md).|
|**Filter**<br>Data type: Keyword|Implement this parameter so that the user can specify a filter that selects the resources upon which to perform the cmdlet action. For more information about how to use input filters, see [Input Filter Parameters](./input-filter-parameters.md).|
|**Follow**<br>Data type: SwitchParameter|Implement this parameter so that progress is tracked when the parameter is specified.|
|**Force**<br>Data type: SwitchParameter|Implement this parameter to indicate that the user can perform an action even if restrictions are encountered when the parameter is specified. The parameter does not allow security to be compromised. For example, this parameter lets a user overwrite a read-only file.|
|**Include**<br>Data type: String[]|Implement this parameter so that the user can include something in an activity. For more information about how to use input filters, see [Input Filter Parameters](input-filter-parameters.md).|
|**Incremental**<br>Data type: SwitchParameter|Implement this parameter to indicate that processing is performed incrementally when the parameter is specified. For example, this parameter lets a user perform incremental backups that back up files only since the last backup.|
|**InputObject**<br>Data type: Object|Implement this parameter when the cmdlet takes input from other cmdlets. When you define an **InputObject** parameter, always specify the **ValueFromPipeline** keyword when you declare the **Parameter** attribute. For more information about using input filters, see [Input Filter Parameters](./input-filter-parameters.md).|
|**Insert**<br>Data type: SwitchParameter|Implement this parameter so that the cmdlet inserts an item when the parameter is specified.|
|**Interactive**<br>Data type: SwitchParameter|Implement this parameter so that the cmdlet works interactively with the user when the parameter is specified.|
|**Interval**<br>Data type: HashTable|Implement this parameter so that the user can specify a hash table of keywords that contains the values. The following example shows sample values for the **Interval** parameter: `-interval @{ResumeScan=15; Retry=3}`.|
|**Log**<br>Data type: SwitchParameter|Implement this parameter audit the actions of the cmdlet when the parameter is specified.|
|**NoClobber**<br>Data type: SwitchParameter|Implement this parameter so that the resource will not be overwritten when the parameter is specified. This parameter generally applies to cmdlets that create new objects so that they can be prevented from overwriting existing objects with the same name.|
|**Notify**<br>Data type: SwitchParameter|Implement this parameter so that the user will be notified that the activity is complete when the parameter is specified.|
|**NotifyAddress**<br>Data type: Email address|Implement this parameter so that the user can specify the e-mail address to use to send a notification when the **Notify** parameter is specified.|
|**Overwrite**<br>Data type: SwitchParameter|Implement this parameter so that the cmdlet overwrites any existing data when the parameter is specified.|
|**Prompt**<br>Data type: String|Implement this parameter so that the user can specify a prompt for the cmdlet.|
|**Quiet**<br>Data type: SwitchParameter|Implement this parameter so that the cmdlet suppresses user feedback during its actions when the parameter is specified.|
|**Recurse**<br>Data type: SwitchParameter|Implement this parameter so that the cmdlet recursively performs its actions on resources when the parameter is specified.|
|**Repair**<br>Data type: SwitchParameter|Implement this parameter so that the cmdlet will attempt to correct something from a broken state when the parameter is specified.|
|**RepairString**<br>Data type: String|Implement this parameter so that the user can specify a string to use when the **Repair** parameter is specified.|
|**Retry**<br>Data type: Int32|Implement this parameter so the user can specify the number of times the cmdlet will attempt an action.|
|**Select**<br>Data type: Keyword array|Implement this parameter so that the user can specify an array of the types of items.|
|**Stream**<br>Data type: SwitchParameter|Implement this parameter so the user can stream multiple output objects through the pipeline when the parameter is specified.|
|**Strict**<br>Data type: SwitchParameter|Implement this parameter so that all errors are handled as terminating errors when the parameter is specified.|
|**TempLocation**<br>Data type: String|Implement this parameter so the user can specify the location of temporary data that is used during the operation of the cmdlet.|
|**Timeout**<br>Data type: Int32|Implement this parameter so that the user can specify the timeout interval (in milliseconds).|
|**Truncate**<br>Data type: SwitchParameter|Implement this parameter so that the cmdlet will truncate its actions when the parameter is specified. If the parameter is not specified, the cmdlet performs another action.|
|**Verify**<br>Data type: SwitchParameter|Implement this parameter so that the cmdlet will test to determine whether an action has occurred when the parameter is specified.|
|**Wait**<br>Data type: SwitchParameter|Implement this parameter so that the cmdlet will wait for user input before continuing when the parameter is specified.
|**WaitTime**<br>Data type: Int32|Implement this parameter so that the user can specify the duration (in seconds) that the cmdlet will wait for user input when the **Wait** parameter is specified.|

## See Also

[Cmdlet Parameters](./cmdlet-parameters.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)

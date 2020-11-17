---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 11/12/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/get-error?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-Error
---

# Get-Error

## SYNOPSIS

Gets and displays the most recent error messages from the current session.

## SYNTAX

### Newest (Default)

```
Get-Error [[-Newest] <Int32>] [<CommonParameters>]
```

### Error

```
Get-Error [-InputObject <PSObject>] [<CommonParameters>]
```

## DESCRIPTION

The `Get-Error` cmdlet gets a **PSExtendedError** object that represents the current error details
from the last error that occurred in the session.

You can use `Get-Error` to display a specified number of errors that have occurred in the current
session using the **Newest** parameter.

The `Get-Error` cmdlet also receives error objects from a collection, such as `$Error`, to display
multiple errors from the current session.

## EXAMPLES

### Example 1: Get the most recent error details

In this example, `Get-Error` displays the details of the most recent error that occurred in the
current session.

```powershell
Get-Childitem -path /NoRealDirectory
Get-Error
```

```
Get-ChildItem: Cannot find path 'C:\NoRealDirectory' because it does not exist.

Exception             :
    ErrorRecord          :
        Exception             :
            Message : Cannot find path 'C:\NoRealDirectory' because it does not exist.
            HResult : -2146233087
        TargetObject          : C:\NoRealDirectory
        CategoryInfo          : ObjectNotFound: (C:\NoRealDirectory:String) [], ParentContainsErrorRecordException
        FullyQualifiedErrorId : PathNotFound
    ItemName             : C:\NoRealDirectory
    SessionStateCategory : Drive
    TargetSite           :
        Name          : GetChildItems
        DeclaringType : System.Management.Automation.SessionStateInternal
        MemberType    : Method
        Module        : System.Management.Automation.dll
    StackTrace           :
   at System.Management.Automation.SessionStateInternal.GetChildItems(String path, Boolean recurse, UInt32 depth,
CmdletProviderContext context)
   at System.Management.Automation.ChildItemCmdletProviderIntrinsics.Get(String path, Boolean recurse, UInt32
depth, CmdletProviderContext context)
   at Microsoft.PowerShell.Commands.GetChildItemCommand.ProcessRecord()
    Message              : Cannot find path 'C:\NoRealDirectory' because it does not exist.
    Source               : System.Management.Automation
    HResult              : -2146233087
TargetObject          : C:\NoRealDirectory
CategoryInfo          : ObjectNotFound: (C:\NoRealDirectory:String) [Get-ChildItem], ItemNotFoundException
FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.GetChildItemCommand
InvocationInfo        :
    MyCommand        : Get-ChildItem
    ScriptLineNumber : 1
    OffsetInLine     : 1
    HistoryId        : 57
    Line             : Get-Childitem -path c:\NoRealDirectory
    PositionMessage  : At line:1 char:1
                       + Get-Childitem -path c:\NoRealDirectory
                       + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    InvocationName   : Get-Childitem
    CommandOrigin    : Internal
ScriptStackTrace      : at <ScriptBlock>, <No file>: line 1
PipelineIterationInfo :
```

### Example 2: Get the specified number of error messages that occurred in the current session

This example shows how to use `Get-Error` with the **Newest** parameter. In this example, **Newest**
returns the details of the 3 newest errors that occurred in this session.

```powershell
Get-Error -Newest 3
```

### Example 3: Send a collection of errors to receive detailed messages

The `$Error` automatic variable contains an array of error objects in the current session. The
array of objects can be piped to `Get-Error` to receive detailed error messages.

In this example, `$Error` is piped to the `Get-Error` cmdlet. the result is list of detailed error
messages, similar to the result of Example 1.

```powershell
$Error | Get-Error
```

## PARAMETERS

### -Newest

Specifies the number of errors to display that have occurred in the current session.

```yaml
Type: System.Int32
Parameter Sets: Newest
Aliases: Last

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

This parameter is used for pipeline input.

```yaml
Type: System.Management.Automation.PSObject
Parameter Sets: Error
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### PSObject

Supports input from any **PSObject**, but results vary unless either an **ErrorRecord** or
**Exception** object are supplied.

## OUTPUTS

### System.Management.Automation.ErrorRecord#PSExtendedError

Output in a **PSExtendedError** object.

## NOTES

`Get-Error` accepts pipeline input. For example, `$Error | Get-Error`.

## RELATED LINKS

[about_Try_Catch_Finally](../Microsoft.PowerShell.Core/About/about_Try_Catch_Finally.md)

---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 10/14/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/write-error?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Write-Error
---

# Write-Error

## SYNOPSIS
Writes an object to the error stream.

## SYNTAX

### NoException (Default)

```
Write-Error [-Message] <String> [-Category <ErrorCategory>] [-ErrorId <String>] [-TargetObject <Object>]
 [-RecommendedAction <String>] [-CategoryActivity <String>] [-CategoryReason <String>]
 [-CategoryTargetName <String>] [-CategoryTargetType <String>] [<CommonParameters>]
```

### WithException

```
Write-Error -Exception <Exception> [[-Message] <String>] [-Category <ErrorCategory>] [-ErrorId <String>]
 [-TargetObject <Object>] [-RecommendedAction <String>] [-CategoryActivity <String>] [-CategoryReason <String>]
 [-CategoryTargetName <String>] [-CategoryTargetType <String>] [<CommonParameters>]
```

### ErrorRecord

```
Write-Error -ErrorRecord <ErrorRecord> [-RecommendedAction <String>] [-CategoryActivity <String>]
 [-CategoryReason <String>] [-CategoryTargetName <String>] [-CategoryTargetType <String>] [<CommonParameters>]
```

## DESCRIPTION

The `Write-Error` cmdlet declares a non-terminating error. By default, errors are sent in the error
stream to the host program to be displayed, along with output.

To write a non-terminating error, enter an error message string, an **ErrorRecord** object, or an
**Exception** object. Use the other parameters of `Write-Error` to populate the error record.

Non-terminating errors write an error to the error stream, but they do not stop command processing.
If a non-terminating error is declared on one item in a collection of input items, the command
continues to process the other items in the collection.

To declare a terminating error, use the `Throw` keyword.
For more information, see [about_Throw](../Microsoft.PowerShell.Core/About/about_Throw.md).

## EXAMPLES

### Example 1: Write an error for RegistryKey object

```powershell
Get-ChildItem | ForEach-Object {
    if ($_.GetType().ToString() -eq "Microsoft.Win32.RegistryKey")
    {
        Write-Error "Invalid object" -ErrorId B1 -TargetObject $_
    }
    else
    {
        $_
    }
}
```

This command declares a non-terminating error when the `Get-ChildItem` cmdlet returns a
`Microsoft.Win32.RegistryKey` object, such as the objects in the `HKLM:` or `HKCU:` drives of the
PowerShell Registry provider.

### Example 2: Write an error message to the console

```powershell
Write-Error "Access denied."
```

This command declares a non-terminating error and writes an "Access denied" error. The command uses
the **Message** parameter to specify the message, but omits the optional **Message** parameter name.

### Example 3: Write an error to the console and specify the category

```powershell
Write-Error -Message "Error: Too many input values." -Category InvalidArgument
```

This command declares a non-terminating error and specifies an error category.

### Example 4: Write an error using an Exception object

```powershell
$E = [System.Exception]@{Source="Get-ParameterNames.ps1";HelpLink="https://go.microsoft.com/fwlink/?LinkID=113425"}
Write-Error -Exception $E -Message "Files not found. The $Files location does not contain any XML files."
```

This command uses an **Exception** object to declare a non-terminating error.

The first command uses a hash table to create the **System.Exception** object. It saves the
exception object in the `$E` variable. You can use a hash table to create any object of a type that
has a null constructor.

The second command uses the `Write-Error` cmdlet to declare a non-terminating error. The value of
the **Exception** parameter is the **Exception** object in the `$E` variable.

## PARAMETERS

### -Category

Specifies the category of the error. The default value is **NotSpecified**. The acceptable values
for this parameter are:

- NotSpecified
- OpenError
- CloseError
- DeviceError
- DeadlockDetected
- InvalidArgument
- InvalidData
- InvalidOperation
- InvalidResult
- InvalidType
- MetadataError
- NotImplemented
- NotInstalled
- ObjectNotFound
- OperationStopped
- OperationTimeout
- SyntaxError
- ParserError
- PermissionDenied
- ResourceBusy
- ResourceExists
- ResourceUnavailable
- ReadError
- WriteError
- FromStdErr
- SecurityError
- ProtocolError
- ConnectionError
- AuthenticationError
- LimitsExceeded
- QuotaExceeded
- NotEnabled

For information about the error categories, see [ErrorCategory Enumeration](https://go.microsoft.com/fwlink/?LinkId=143600).

```yaml
Type: System.Management.Automation.ErrorCategory
Parameter Sets: NoException, WithException
Aliases:
Accepted values: NotSpecified, OpenError, CloseError, DeviceError, DeadlockDetected, InvalidArgument, InvalidData, InvalidOperation, InvalidResult, InvalidType, MetadataError, NotImplemented, NotInstalled, ObjectNotFound, OperationStopped, OperationTimeout, SyntaxError, ParserError, PermissionDenied, ResourceBusy, ResourceExists, ResourceUnavailable, ReadError, WriteError, FromStdErr, SecurityError, ProtocolError, ConnectionError, AuthenticationError, LimitsExceeded, QuotaExceeded, NotEnabled

Required: False
Position: Named
Default value: NotSpecified
Accept pipeline input: False
Accept wildcard characters: False
```

### -CategoryActivity

Specifies the action that caused the error.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Activity

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CategoryReason

Specifies how or why the activity caused the error.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Reason

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CategoryTargetName

Specifies the name of the object that was being processed when the error occurred.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: TargetName

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CategoryTargetType

Specifies the type of the object that was being processed when the error occurred.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: TargetType

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ErrorId

Specifies an ID string to identify the error. The string should be unique to the error.

```yaml
Type: System.String
Parameter Sets: NoException, WithException
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ErrorRecord

Specifies an error record object that represents the error. Use the properties of the object to
describe the error.

To create an error record object, use the `New-Object` cmdlet or get an error record object from the
array in the `$Error` automatic variable.

```yaml
Type: System.Management.Automation.ErrorRecord
Parameter Sets: ErrorRecord
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Exception

Specifies an exception object that represents the error. Use the properties of the object to
describe the error.

To create an exception object, use a hash table or use the `New-Object` cmdlet.

```yaml
Type: System.Exception
Parameter Sets: WithException
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Message

Specifies the message text of the error. If the text includes spaces or special characters, enclose
it in quotation marks. You can also pipe a message string to `Write-Error`.

```yaml
Type: System.String
Parameter Sets: NoException, WithException
Aliases: Msg

Required: True (NoException), False (WithException)
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -RecommendedAction

Specifies the action that the user should take to resolve or prevent the error.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetObject

Specifies the object that was being processed when the error occurred. Enter the object, a variable
that contains the object, or a command that gets the object.

```yaml
Type: System.Object
Parameter Sets: NoException, WithException
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a string that contains an error message to `Write-Error`.

## OUTPUTS

### Error object

`Write-Error` writes only to the error stream. It does not return any objects.

## NOTES

`Write-Error` does not change the value of the `$?` automatic variable, therefore it does not signal
a terminating error condition. To signal a terminating error, use the
[$PSCmdlet.WriteError()](/dotnet/api/system.management.automation.cmdlet.writeerror) method.

## RELATED LINKS

[about_Automatic_Variables](../microsoft.powershell.core/about/about_automatic_variables.md)

[about_Output_Streams](../Microsoft.PowerShell.Core/About/about_Output_Streams.md)

[about_Redirection](../Microsoft.PowerShell.Core/About/about_Redirection.md)

[Write-Debug](Write-Debug.md)

[Write-Host](Write-Host.md)

[Write-Output](Write-Output.md)

[Write-Progress](Write-Progress.md)

[Write-Verbose](Write-Verbose.md)

[Write-Warning](Write-Warning.md)

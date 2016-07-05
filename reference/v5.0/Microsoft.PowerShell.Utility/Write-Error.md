---
external help file: PSITPro5_Utility.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=294028
schema: 2.0.0
---

# Write-Error
## SYNOPSIS
Writes an object to the error stream.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Write-Error [-Message] <String> [-Category] [-CategoryActivity <String>] [-CategoryReason <String>]
 [-CategoryTargetName <String>] [-CategoryTargetType <String>] [-ErrorId <String>]
 [-RecommendedAction <String>] [-TargetObject <Object>]
```

### UNNAMED_PARAMETER_SET_2
```
Write-Error [-Category] [-CategoryActivity <String>] [-CategoryReason <String>] [-CategoryTargetName <String>]
 [-CategoryTargetType <String>] [-ErrorId <String>] [[-Message] <String>] [-RecommendedAction <String>]
 [-TargetObject <Object>] -Exception <Exception>
```

### UNNAMED_PARAMETER_SET_3
```
Write-Error [-CategoryActivity <String>] [-CategoryReason <String>] [-CategoryTargetName <String>]
 [-CategoryTargetType <String>] [-RecommendedAction <String>] -ErrorRecord <ErrorRecord>
```

## DESCRIPTION
The Write-Error cmdlet declares a non-terminating error.
By default, errors are sent in the error stream to the host program to be displayed, along with output.

To write a non-terminating error, enter an error message string, an ErrorRecord object, or an Exception object. 
Use the other parameters of Write-Error to populate the error record.

Non-terminating errors write an error to the error stream, but they do not stop command processing.
If a non-terminating error is declared on one item in a collection of input items, the command continues to process the other items in the collection.

To declare a terminating error, use the Throw keyword.
For more information, see about_Throw (http://go.microsoft.com/fwlink/?LinkID=145153).

## EXAMPLES

### Example 1: Write an error for RegistryKey object
```
PS C:\>Get-ChildItem | ForEach-Object { if ($_.GetType().ToString() -eq "Microsoft.Win32.RegistryKey") {Write-Error "Invalid object" -ErrorID B1 -Targetobject $_ } else {$_ } }
```

This command declares a non-terminating error when the Get-ChildItem cmdlet returns a Microsoft.Win32.RegistryKey object, such as the objects in the HKLM: or HKCU: drives of the Windows PowerShell Registry provider.

### Example 2: Write an error message to the console
```
PS C:\>Write-Error "Access denied."
```

This command declares a non-terminating error and writes an "Access denied" error.
The command uses the Message parameter to specify the message, but omits the optional Message parameter name.

### Example 3: Write an error to the console and specify the category
```
PS C:\>Write-Error -Message "Error: Too many input values." -Category InvalidArgument
```

This command declares a non-terminating error and specifies an error category.

### Example 4: Write an error using an Exception object
```
PS C:\>$E = [System.Exception]@{$e = [System.Exception]@{Source="Get-ParameterNames.ps1";HelpLink="http://go.microsoft.com/fwlink/?LinkID=113425"}HelpLink="http://go.microsoft.com/fwlink/?LinkID=113425"}
PS C:\> Write-Error $E -Message "Files not found. The $Files location does not contain any XML files."
```

This command uses an Exception object to declare a non-terminating error.

The first command uses a hash table to create the System.Exception object.
It saves the exception object in the $E variable.
You can use a hash table to create any object of a type that has a null constructor.

The second command uses the Write-Error cmdlet to declare a non-terminating error.
The value of the Exception parameter is the Exception object in the $E variable.

## PARAMETERS

### -Category
Specifies the category of the error.
The default value is NotSpecified.
The acceptable values for this parameter are:

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

For information about the error categories, see ErrorCategory Enumerationhttp://go.microsoft.com/fwlink/?LinkId=143600 (http://go.microsoft.com/fwlink/?LinkId=143600) in MSDN.

```yaml
Type: SwitchParameter
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 
Accepted values: , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CategoryActivity
Describes the action that caused the error.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Activity

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CategoryReason
Explains how or why the activity caused the error.

```yaml
Type: String
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
Type: String
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
Type: String
Parameter Sets: (All)
Aliases: TargetType

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ErrorId
Specifies an ID string to identify the error.
The string should be unique to the error.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ErrorRecord
Specifies an error record object that represents the error.
Use the properties of the object to describe the error.

To create an error record object, use the New-Object cmdlet or get an error record object from the array in the $Error automatic variable.

```yaml
Type: ErrorRecord
Parameter Sets: UNNAMED_PARAMETER_SET_3
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Exception
Specifies an exception object that represents the error.
Use the properties of the object to describe the error.

To create an exception object, use a hash table or use the New-Object cmdlet.

```yaml
Type: Exception
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Message
Specifies the message text of the error.
If the text includes spaces or special characters, enclose it in quotation marks.
You can also pipe a message string to Write-Error.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1
Aliases: Msg

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_2
Aliases: Msg

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -RecommendedAction
Describes the action that the user should take to resolve or prevent the error.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetObject
Specifies the object that was being processed when the error occurred.
Enter the object (such as a string), a variable that contains the object, or a command that gets the object.

```yaml
Type: Object
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.String
You can pipe a string that contains an error message to Write-Error.

## OUTPUTS

### Error object
Write-Error writes only to the error stream.
It does not return any objects.

## NOTES

## RELATED LINKS

[Write-Debug](fb95cfe7-8a21-4b6a-9e00-0205a6b74c41)

[Write-Host](023e670a-cfda-4e8c-af8f-c2b2d9ee5612)

[Write-Output](72e7f802-c08c-435e-88ad-b2b77faea1a7)

[Write-Progress](3e78a07f-87ae-4bc2-ac28-b0163831fd80)

[Write-Verbose](d17c2519-dae0-4142-a506-9acfb79b72e7)

[Write-Warning](8e53946e-1762-40e6-ab70-5307f6fc2a98)


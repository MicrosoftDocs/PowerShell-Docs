---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293976
schema: 2.0.0
---

# Get-TypeData
## SYNOPSIS
Gets the extended type data in the current session.

## SYNTAX

```
Get-TypeData [[-TypeName] <String[]>] [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

## DESCRIPTION
The Get-TypeData cmdlet gets the extended type data in the current session.
This includes type data that was added to the session by Types.ps1xml file and dynamic type data that was added by using the parameter of the Update-TypeData cmdlet.

You can use the extended type data that Get-TypeData returns to examine the type data in the session and send it to the Update-TypeData and Remove-TypeData cmdlets.

Extended type data adds properties and methods to objects in Windows PowerShell.
You can use the added properties and methods in the same ways that you would use the properties and methods that are defined in the object type.
However, when writing scripts, be aware that the added properties and methods might not be present in every Windows PowerShell session.

For more information about Types.ps1xml files, see about_Types.ps1xml (http://go.microsoft.com/fwlink/?LinkID=113274).
For more information about dynamic type data that the Update-TypeData cmdlet adds, see Update-TypeData.

This cmdlet is introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1
```
PS C:\>Get-TypeData
```

This command gets all extended type data in the current session.

### Example 2
```
PS C:\>"*Eventing*" | Get-TypeData
TypeName                                                              Members--------                                                              -------System.Diagnostics.Eventing.Reader.EventLogConfiguration              {}System.Diagnostics.Eventing.Reader.EventLogRecord                    {}System.Diagnostics.Eventing.Reader.ProviderMetadata                   {[ProviderName, System.Management.Automation.Runspaces.AliasProper...
```

This command gets all types in the current session that have names that contain "Eventing".

### 1:
```
PS C:\>(Get-TypeData *EventLogEntry*).Members.EventID
GetScriptBlock                     SetScriptBlock                                               IsHidden Name

--------------                     --------------                                               -------- ----
$this.get_EventID() -band 0xFFFF                                                                   False EventID
```

This command gets the script block that creates the value of the EventID property of EventLogEntry objects.

### Example 3
```
PS C:\>(Get-TypeData -TypeName System.DateTime).Members["DateTime"].GetScriptBlock
if ((& { Set-StrictMode -Version 1; $this.DisplayHint }) -ieq  "Date")                    
{                        
    "{0}" -f $this.ToLongDateString()                    
}
elseif ((& { Set-StrictMode -Version 1; $this.DisplayHint }) -ieq "Time")                    
{                        
    "{0}" -f  $this.ToLongTimeString()                    
}                    
else                    
{                        
    "{0} {1}" -f $this.ToLongDateString(), $this.ToLongTimeString()                    
}
```

This command gets the script block that defines the DateTime property of System.DateTime objects in Windows PowerShell.

The command uses the Get-TypeData cmdlet to get the extended type data for the System.DataTime type.
The command gets the Members property of the TypeData object.

The Members property contains  a hash table of properties and methods that are defined by extended type data.
Each key in the Members hash table is a property or method name and each value is the definition of the property or method value.

The command gets the DateTime key in Members and its GetScriptBlock property value.

The output shows the script block that creates the value of the DateTime property of every System.DateTime object in Windows PowerShell.

### Example 4
```
PS C:\>dir $pshome\*types.ps1xml -Recurse | Select-String "EventLogEntry"
C:\WINDOWS\System32\WindowsPowerShell\v1.0\DotNetTypes.format.ps1xml:180: 
<Name>System.Diagnostics.EventLogEntry</Name>
C:\WINDOWS\System32\WindowsPowerShell\v1.0\DotNetTypes.format.ps1xml:182: 
<TypeName>System.Diagnostics.EventLogEntry</TypeName>
C:\WINDOWS\System32\WindowsPowerShell\v1.0\DotNetTypes.format.ps1xml:801: 
<Name>System.Diagnostics.EventLogEntry</Name>
C:\WINDOWS\System32\WindowsPowerShell\v1.0\DotNetTypes.format.ps1xml:803: 
<TypeName>System.Diagnostics.EventLogEntry</TypeName>
C:\WINDOWS\System32\WindowsPowerShell\v1.0\types.ps1xml:433: 
<Name>System.Diagnostics.EventLogEntry</Name>
```

This command finds the Types.ps1xml file that added extended type data for the EventLogEntry type to the session.
This command uses the Get-ChildItem cmdlet (alias = "dir") to perform a recursive search for Types.ps1xml files in the Windows PowerShell installation directory ($pshome) and its subdirectories.
The command sends the Types.ps1xml files to the Select-String cmdlet, which does a full-text search for the "EventLogEntry" type name in the files and returns the matches.

## PARAMETERS

### -InformationAction
Enter type names or a name patterns.
Full names (or name patterns with wildcard characters) are required, even for types in the System namespace.
Wildcards are supported and the parameter name (-TypeName) is optional.
You can also pipe type names to Get-TypeData.

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa
Accepted values: SilentlyContinue, Stop, Continue, Inquire, Ignore, Suspend

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
Enter type names or a name patterns.
Full names (or name patterns with wildcard characters) are required, even for types in the System namespace.
Wildcards are supported and the parameter name (-TypeName) is optional.
You can also pipe type names to Get-TypeData.

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TypeName
Gets type data only for the types with the specified names.
By default, Get-TypeData gets all types in the session.

Enter type names or a name patterns.
Full names (or name patterns with wildcard characters) are required, even for types in the System namespace.
Wildcards are supported and the parameter name (-TypeName) is optional.
You can also pipe type names to Get-TypeData.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

## INPUTS

### System.String
You can pipe type names to Get-TypeData.

## OUTPUTS

### System.Management.Automation.Runspaces.TypeData

## NOTES
Get-TypeData gets only the extended type data in the current session.
It does not get extended type data that is on the computer, but has not been added to the current session, such as extended types that are defined in modules that have not been imported into the current session.

## RELATED LINKS

[about_Types.ps1xml]()

[Remove-TypeData]()

[Update-TypeData]()


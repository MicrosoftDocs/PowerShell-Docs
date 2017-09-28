---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=113447
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  Update-List
---

# Update-List
## SYNOPSIS
Adds items to and removes items from a property value that contains a collection of objects.
## SYNTAX

### AddRemoveSet (Default)
```
Update-List [-Add <Object[]>] [-Remove <Object[]>] [-InputObject <PSObject>] [[-Property] <String>]
 [<CommonParameters>]
```

### ReplaceSet
```
Update-List -Replace <Object[]> [-InputObject <PSObject>] [[-Property] <String>] [<CommonParameters>]
```

## DESCRIPTION
The Update-List cmdlet adds items to and removes items from a property value of an object, and then it returns the updated object.
This cmdlet is designed for properties that contain collections of objects.

The Add and Remove parameters add individual items to and remove them from the collection.
The Replace parameter replaces the entire collection.

If you do not specify a property in the command, Update-List returns an object that describes the update instead of updating the object.
You can submit the update object to cmdlets that change objects, such as Set-* cmdlets.

This cmdlet works only when the property that is being updated supports the IList interface that Update-List uses.
Also, any Set-* cmdlets that accept an update must support the IList interface.
The core cmdlets that are installed with Windows PowerShell do not support this interface.
To determine whether a cmdlet supports Update-List, see the cmdlet Help topic.
## EXAMPLES

### Example 1
```
PS C:\> get-mailbox | update-list -Property aliases -Add "A","B" -Remove "X","Y" | set-mailbox
```

This command adds A and B and removes X and Y from the Aliases property of a mailbox.

The command uses the [Get-Mailbox](https://go.microsoft.com/fwlink/?LinkId=111536) cmdlet from Microsoft Exchange Server to get the mailbox.
A pipeline operator sends the mailbox object to the Update-List cmdlet.

The Update-List command uses the Property parameter to indicate that the Aliases property of the mailbox is being updated, and it uses the Add and Remove parameters to specify the items that are being added and removed from the collection.
The Aliases property fulfills the conditions of Update-List, because it stores a collection of Microsoft .NET Framework objects that have Add and Remove methods.

The Update-List cmdlet returns the updated mailbox, which is piped to the Set-MailBox cmdlet, which changes the mailbox.

### Example 2
```
PS C:\> $m = get-mailbox
PS C:\> update-list -InputObject $m -Property aliases -Add "A","B" -Remove "X", "Y" | set-mailbox
```

This command adds A and B to the value of the Aliases property of a mailbox and removes X and Y.
This command has the same effect as the previous command, although it has a slightly different format.

The command uses the Get-MailBox cmdlet to get the mailbox, and it saves the mailbox in the $m variable.
This command uses the InputObject parameter of Update-List to specify the mailbox.
The value of InputObject is the mailbox in the $m variable.
It uses the Property parameter to specify the Aliases property and the Add and Remove parameters to specify the items being added to and removed from the value of Aliases.

The command uses a pipeline operator (|) to send the updated mailbox object to the Set-Mailbox cmdlet, which changes the mailbox.
### Example 3
```
PS C:\> get-mailbox | set-mailbox -alias (update-list -Add "A", "B" -Remove "X","Y")
```

This command adds A and B to the value of the Aliases property of a mailbox and removes X and Y.
This command has the same effect as the two previous commands, but it uses a different procedure to perform the task.

Instead of updating the Aliases property of the mailbox before sending it to Set-Mailbox, this command uses Update-List to create an object that represents the change.
Then it submits the change to the Alias parameter of Set-Mailbox.

The command uses the Get-MailBox cmdlet to get the mailbox.
A pipeline operator sends the mailbox object to the Set-Mailbox cmdlet, which changes mailboxes.

The command uses the Alias parameter of Set-Mailbox to change the Aliases property of the mailbox object.
The value of the Alias parameter is an Update-List command that creates an object that represents the update.
The Update-List command is enclosed in parentheses to ensure that it runs before the value of the Alias parameter is evaluated.
When the Set-Mailbox command completes, the mailbox is changed.
### Example 4
```
PS C:\> update-list -InputObject $a -Property aliases -replace "A", "B" | set-mailbox
```

This command uses the Replace operator of Update-List to replace the collection in the Aliases property of the object in $a with a new collection.

This command uses the InputObject parameter which, in this case, is equivalent to using a pipeline operator to pass $a to Update-List.
## PARAMETERS

### -Add
Specifies the property values to be added to the collection.
Enter the values in the order that they should appear in the collection.

```yaml
Type: Object[]
Parameter Sets: AddRemoveSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies the objects to be updated.
You can also pipe the object to be updated to Update-List.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Property
Identifies the property that contains the collection that is being updated.
If you omit this parameter, Update-List returns an object that represents the change instead of changing the object.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Remove
Specifies the property values to be removed from the collection.

```yaml
Type: Object[]
Parameter Sets: AddRemoveSet
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Replace
Specifies a new collection.
This parameter replaces all items in the original collection with the items specified by this parameter.

```yaml
Type: Object[]
Parameter Sets: ReplaceSet
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

### System.Management.Automation.PSObject
You can pipe the objects to be updated to Update-List.
## OUTPUTS

### Objects or System.Management.Automation.PSListModifier
Update-List returns the updated object, or it returns an object that represents the update action.
## NOTES

## RELATED LINKS

[Select-Object](Select-Object.md)


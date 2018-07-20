---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821710
external help file:  Microsoft.PowerShell.Security.dll-Help.xml
title:  Get-Acl
---
# Get-Acl

## SYNOPSIS

Gets the security descriptor for a resource, such as a file or registry key.

## SYNTAX

### ByPath (Default)

```
Get-Acl [[-Path] <String[]>] [-Audit] [-AllCentralAccessPolicies] [-Filter <String>] [-Include <String[]>]
 [-Exclude <String[]>] [-UseTransaction] [<CommonParameters>]
```

### ByInputObject

```
Get-Acl -InputObject <PSObject> [-Audit] [-AllCentralAccessPolicies] [-Filter <String>] [-Include <String[]>]
 [-Exclude <String[]>] [-UseTransaction] [<CommonParameters>]
```

### ByLiteralPath

```
Get-Acl [-LiteralPath <String[]>] [-Audit] [-AllCentralAccessPolicies] [-Filter <String>] [-Include <String[]>]
 [-Exclude <String[]>] [-UseTransaction] [<CommonParameters>]
```

## DESCRIPTION

The **Get-Acl** cmdlet gets objects that represent the security descriptor of a file or resource.
The security descriptor contains the access control lists (ACLs) of the resource. The ACL specifies
the permissions that users and user groups have to access the resource.

Beginning in Windows PowerShell 3.0, you can use the **InputObject** parameter of **Get-Acl** to
get the security descriptor of objects that do not have a path.

## EXAMPLES

### Example 1

```powershell
Get-Acl C:\Windows
```

This command gets the security descriptor of the C:Windows directory.

### Example 2

```powershell
Get-Acl C:\Windows\k*.log | Format-List -Property PSPath, Sddl
```

This command gets the Windows PowerShell path and SDDL for all of the .log files in the C:\Windows
directory whose names begin with "k."

The command uses the **Get-Acl** cmdlet to get objects representing the security descriptors of each log file.
It uses a pipeline operator (|) to send the results to the Format-List cmdlet.
The command uses the **Property** parameter of **Format-List** to display only the **PsPath** and **SDDL** properties of each security descriptor object.

Lists are often used in Windows PowerShell, because long values appear truncated in tables.

The **SDDL** values are valuable to system administrators, because they are simple text strings
that contain all of the information in the security descriptor. As such, they are easy to pass and
store, and they can be parsed when needed.

### Example 3

```powershell
Get-Acl C:/Windows/k*.log -Audit | ForEach-Object { $_.Audit.Count }
```

This command gets the security descriptors of the .log files in the C:\Windows directory whose
names begin with "k." It uses the **Audit** parameter to get the audit records from the SACL in the
security descriptor. Then it uses theForEach-Object cmdlet to count the number of audit records
associated with each file. The result is a list of numbers representing the number of audit records
for each log file.

### Example 4

```powershell
Get-Acl -Path HKLM:\System\CurrentControlSet\Control | Format-List
```

This command uses the **Get-Acl** cmdlet to get the security descriptor of the Control subkey
(HKLM\SYSTEM\CurrentControlSet\Control) of the registry.

The **Path** parameter specifies the Control subkey. The pipeline operator (|) passes the security
descriptor that **Get-Ac**l gets to the Format-List command, which formats the properties of the
security descriptor as a list so that they are easy to read.

### Example 5

```powershell
Get-Acl -InputObject (Get-StorageSubSystem -Name S087)
```

This command uses the **InputObject** parameter of **Get-Acl** to get the security descriptor of a
storage subsystem object.

## PARAMETERS

### -Audit

Gets the audit data for the security descriptor from the system access control list (SACL).

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Exclude

Omits the specified items. The value of this parameter qualifies the Path parameter. Enter a path
element or pattern, such as "*.txt". Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Filter

Specifies a filter in the provider's format or language. The value of this parameter qualifies the
**Path** parameter. The syntax of the filter, including the use of wildcards, depends on the
provider. Filters are more efficient than other parameters, because the provider applies them when
gettting the objects, rather than having Windows PowerShell filter the objects after they are
retrieved.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Include

Gets only the specified items. The value of this parameter qualifies the **Path** parameter. Enter
a path element or pattern, such as "*.txt". Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Path

Specifies the path to a resource. **Get-Acl** gets the security descriptor of the resource
indicated by the path. Wildcards are permitted. If you omit the **Path** parameter, Get-Acl gets
the security descriptor of the current directory.

The parameter name ("Path") is optional.

```yaml
Type: String[]
Parameter Sets: ByPath
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -AllCentralAccessPolicies

Gets information about all central access policies that are enabled on the computer.

Beginning in Windows Server 2012, administrators can use Active Directory and Group Policy to set
central access policies for users and groups. For more information, see
[Dynamic Access Control: Scenario Overview](/windows-server/identity/solution-guides/dynamic-access-control--scenario-overview).

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Gets the security descriptor for the specified object.
Enter a variable that contains the object or a command that gets the object.

You cannot pipe an object, other than a path, to **Get-Acl**.
Instead, use the **InputObject** parameter explicitly in the command.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: PSObject
Parameter Sets: ByInputObject
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralPath

Specifies the path to a resource.
Unlike **Path**, the value of the **LiteralPath** parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

This parameter is introduced in Windows PowerShell 3.0.

```yaml
Type: String[]
Parameter Sets: ByLiteralPath
Aliases: PSPath

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -UseTransaction

Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see about_Transactions.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: usetx

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see about_CommonParameters
(http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a string that contains a path to Get-Acl.

## OUTPUTS

### System.Security.AccessControl

**Get-Acl** returns an object that represents the ACLs that it gets. The object type depends upon
the ACL type.

## NOTES

By default, **Get-Acl** displays the Windows PowerShell path to the resource
(\<provider\>::\<resource-path\>), the owner of the resource, and "Access", a list (array) of the
access control entries in the discretionary access control list (DACL) for the resource. The DACL
list is controlled by the resource owner.

When you format the result as a list, ("`Get-Acl | Format-List`"), in addition to the path, owner,
and access list, Windows PowerShell displays the following properties and property values:

- **Group**: The security group of the owner.
- **Audit**:  A list (array) of entries in the system access control list (SACL). The SACL
  specifies the types of access attempts for which Windows generates audit records.
- **Sddl**: The security descriptor of the resource displayed in a single text string in Security
  Descriptor Definition Language format. Windows PowerShell uses the GetSddlForm method of security
  descriptors to get this data.

Because **Get-Acl** is supported by the file system and registry providers, you can use **Get-Acl**
to view the ACL of file system objects, such as files and directories, and registry objects, such
as registry keys and entries.

## RELATED LINKS

[Set-Acl](Set-Acl.md)
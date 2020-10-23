---
ms.date: 07/08/2020
keywords:  dsc,powershell,configuration,setup
title:  Using the Resource Designer tool
description: The Resource Designer tool is a set of cmdlets exposed by the xDscResourceDesigner module that make creating PowerShell DSC resources easier.
---

# Using the Resource Designer tool

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

The Resource Designer tool is a set of cmdlets exposed by the **xDscResourceDesigner** module that
make creating Windows PowerShell Desired State Configuration (DSC) resources easier. The cmdlets in
this resource help create the MOF schema, the script module, and the directory structure for your
new resource. For more information about DSC resources, see
[Build Custom Windows PowerShell Desired State Configuration Resources](authoringResource.md). In
this article, we will create a DSC resource that manages Active Directory users. Use the
[Install-Module](/powershell/module/PowershellGet/Install-Module) cmdlet to install the
**xDscResourceDesigner** module.

## Creating resource properties

The first thing we need to do is decide on properties that the resource will expose. For this
example, we will define an Active Directory user with the following properties.

Parameter name  Description

- **UserName**: Key property that uniquely identifies a user.
- **Ensure**: Specifies whether the user account should be Present or Absent. This parameter will
  have only two possible values.
- **DomainCredential**: The domain password for the user.
- **Password**: The desired password for the user to allow a configuration to change the user
  password if necessary.

To create the properties, we use the `New-xDscResourceProperty` cmdlet. The following PowerShell
commands create the properties described above.

```powershell
$UserName = New-xDscResourceProperty –Name UserName -Type String -Attribute Key
$Ensure = New-xDscResourceProperty –Name Ensure -Type String -Attribute Write –ValidateSet "Present", "Absent"
$DomainCredential = New-xDscResourceProperty –Name DomainCredential -Type PSCredential -Attribute Write
$Password = New-xDscResourceProperty –Name Password -Type PSCredential -Attribute Write
```

## Create the resource

Now that the resource properties have been created, we can call the `New-xDscResource` cmdlet to
create the resource. The `New-xDscResource` cmdlet takes the list of properties as parameters. It
also takes the path where the module should be created, the name of the new resource, and the name
of the module in which it is contained. The following PowerShell command creates the resource.

```powershell
New-xDscResource –Name Demo_ADUser –Property $UserName, $Ensure, $DomainCredential, $Password –Path 'C:\Program Files\WindowsPowerShell\Modules' –ModuleName Demo_DSCModule
```

The `New-xDscResource` cmdlet creates the MOF schema, a skeleton resource script, the required
directory structure for your new resource, and a manifest for the module that exposes the new
resource.

The MOF schema file is at
`C:\Program Files\WindowsPowerShell\Modules\Demo_DSCModule\DSCResources\Demo_ADUser\Demo_ADUser.schema.mof`,
and its contents are as follows.

```
[ClassVersion("1.0.0.0"), FriendlyName("Demo_ADUser")]
class Demo_ADUser : OMI_BaseResource
{
  [Key] string UserName;
  [Write, ValueMap{"Present","Absent"}, Values{"Present","Absent"}] string Ensure;
  [Write, EmbeddedInstance("MSFT_Credential")] String DomainCredential;
  [Write, EmbeddedInstance("MSFT_Credential")] String Password;
};
```

The resource script is at
`C:\Program Files\WindowsPowerShell\Modules\Demo_DSCModule\DSCResources\Demo_ADUser\Demo_ADUser.psm1`.
It does not include the actual logic to implement the resource, which you must add yourself. The
contents of the skeleton script are as follows.

```powershell
function Get-TargetResource
{
  [CmdletBinding()]
  [OutputType([System.Collections.Hashtable])]
  param
  (
    [parameter(Mandatory = $true)]
    [System.String]
    $UserName
  )

  #Write-Verbose "Use this cmdlet to deliver information about command processing."

  #Write-Debug "Use this cmdlet to write debug information while troubleshooting."

  <#
  $returnValue = @{
  UserName = [System.String]
  Ensure = [System.String]
  DomainAdminCredential = [System.Management.Automation.PSCredential]
  Password = [System.Management.Automation.PSCredential]
  }

  $returnValue
  #>
}

function Set-TargetResource
{
  [CmdletBinding()]
  param
  (
    [parameter(Mandatory = $true)]
    [System.String]
    $UserName,

    [ValidateSet("Present","Absent")]
    [System.String]
    $Ensure,

    [System.Management.Automation.PSCredential]
    $DomainAdminCredential,

    [System.Management.Automation.PSCredential]
    $Password
  )

  #Write-Verbose "Use this cmdlet to deliver information about command processing."

  #Write-Debug "Use this cmdlet to write debug information while troubleshooting."

  #Include this line if the resource requires a system reboot.
  #$global:DSCMachineStatus = 1
}

function Test-TargetResource
{
  [CmdletBinding()]
  [OutputType([System.Boolean])]
  param
  (
    [parameter(Mandatory = $true)]
    [System.String]
    $UserName,

    [ValidateSet("Present","Absent")]
    [System.String]
    $Ensure,

    [System.Management.Automation.PSCredential]
    $DomainAdminCredential,

    [System.Management.Automation.PSCredential]
    $Password
  )

  #Write-Verbose "Use this cmdlet to deliver information about command processing."

  #Write-Debug "Use this cmdlet to write debug information while troubleshooting."

  <#
  $result = [System.Boolean]

  $result
  #>
}

Export-ModuleMember -Function *-TargetResource
```

## Updating the resource

If you need to add or modify the parameter list of the resource, you can call the
`Update-xDscResource` cmdlet. The cmdlet updates the resource with a new parameter list. If you have
already added logic in your resource script, it is left intact.

For example, suppose you want to include the last log in time for the user in our resource. Rather
than writing the resource again completely, you can call the `New-xDscResourceProperty` to create
the new property, and then call `Update-xDscResource` and add your new property to the properties
list.

```powershell
$lastLogon = New-xDscResourceProperty –Name LastLogon –Type Hashtable –Attribute Write –Description "For mapping users to their last log on time"
Update-xDscResource –Name 'Demo_ADUser' –Property $UserName, $Ensure, $DomainCredential, $Password, $lastLogon -Force
```

## Testing a resource schema

The Resource Designer tool exposes one more cmdlet that can be used to test the validity of a MOF
schema that you have written manually. Call the `Test-xDscSchema` cmdlet, passing the path of a MOF
resource schema as a parameter. The cmdlet will output any errors in the schema.

### See Also

#### Concepts

[Build Custom Windows PowerShell Desired State Configuration Resources](authoringResource.md)

#### Other Resources

[xDscResourceDesigner Module](https://www.powershellgallery.com/packages/xDscResourceDesigner/1.12.0.0)

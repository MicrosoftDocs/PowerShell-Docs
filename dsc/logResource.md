# DSC Log Resource 

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

The __Log__ resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to write messages to the Microsoft-Windows-Desired State Configuration/Analytic event log.

```
Syntax

Log [string] #ResourceName
{
    Message = [string]
    [ DependsOn = [string[]] ]
}
```

## Properties
|  Property  |  Description   | 
|---|---| 
| Message| Indicates the message you want to write to the Microsoft-Windows-Desired State Configuration/Analytic event log.| 
| DependsOn | Indicates that the configuration of another resource must run before this log message gets written. For example, if the ID of the resource configuration script block that you want to run first is __ResourceName__ and its type is __ResourceType__, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.| 

## Example

The following example shows how to include a message in the Microsoft-Windows-Desired State Configuration/Analytic event log.

> **Note**: if you run [Test-DscConfiguration](https://technet.microsoft.com/en-us/library/dn407382.aspx) with this resource configured, it will always return **$false**.

```powershell 
Log LogExample
{
    Message = "This message will appear in the Microsoft-Windows-Desired State Configuration/Analytic event log."
} 
```


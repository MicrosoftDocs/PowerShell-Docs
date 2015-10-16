#DSC Script Resource#

 
>Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

The __Script__ resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to run Windows PowerShell script blocks on target nodes.

##Syntax##

```
Script [string] #ResourceName
{
    GetScript = [string]
    SetScript = [string]
    TestScript = [string]
    [ Credential = [PSCredential] ]
    [ DependsOn = [string[]] ]
}
```

##Properties##


Property 

|  Property  |  Description   | 
|---|---| 
| GetScript| Provides a block of Windows PowerShell script that runs when you invoke the [Get-DscConfiguration](https://technet.microsoft.com/en-us/library/dn407379.aspx) cmdlet. This block must return a hash table.| 
| SetScript| Provides a block of Windows PowerShell script. When you invoke the [Start-DscConfiguration](https://technet.microsoft.com/en-us/library/dn521623.aspx) cmdlet, the __TestScript__ block runs first. If the __TestScript__ block returns __$false__, the __SetScript__ block will run. If the __TestScript__ block returns __$true__, the __SetScript__ block will not run.| 
| TestScript| Provides a block of Windows PowerShell script. When you invoke the [Start-DscConfiguration](https://technet.microsoft.com/en-us/library/dn521623.aspx) cmdlet, this block runs. If it returns __$false__, the SetScript block will run. If it returns __$true__, the SetScript block will not run. The __TestScript__ block also runs when you invoke the [Test-DscConfiguration](https://technet.microsoft.com/en-us/library/dn407382.aspx) cmdlet. However, in this case, the __SetScript__ block will not run, no matter what value the TestScript block returns.
The __TestScript__ block must return True if the actual configuration matches the current desired state configuration, and False if it does not match. (The current desired state configuration is the last configuration enacted on the node that is using DSC.)| 
| Credential| Indicates the credentials to use for running this script, if credentials are required.| 
| DependsOn| Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is __ResourceName__ and its type is __ResourceType__, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.| 

##Example##
```powershell
Script ScriptExample
{
    SetScript = { 
        $sw = New-Object System.IO.StreamWriter("C:\TempFolder\TestFile.txt")
        $sw.WriteLine("Some sample string")
        $sw.Close()
    }
    TestScript = { Test-Path "C:\TempFolder\TestFile.txt" }
    GetScript = { <# This must return a hash table #> }          
}
```


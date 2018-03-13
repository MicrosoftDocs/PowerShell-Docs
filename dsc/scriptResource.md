---
ms.date:  2017-06-12
ms.topic:  conceptual
keywords:  dsc,powershell,configuration,setup
title:  DSC Script Resource
---

# DSC Script Resource

 
> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

The **Script** resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to run Windows PowerShell script blocks on target nodes. The `Script` resource has `GetScript`, `SetScript`, and `TestScript` properties. These properties should be set to script blocks that will run on each target node. 

The `GetScript` script block should return a hashtable representing the state of the current node. The hashtable must only contain one key `Result` and the value must be of type `String`. It is not required to return anything. DSC doesn't do anything with the output of this script block.

The `TestScript` script block should determine if the current node needs to be modified. It should return `$true` if the node is up-to-date. It should return `$false` if the node's configuration is out-of-date and should be updated by the `SetScript` script block. The `TestScript` script block is called by DSC.

The `SetScript` script block should modify the node. It is called by DSC if the `TestScript` block return `$false`.

If you need to use variables from your configuration script in the `GetScript`, `TestScript`, or `SetScript` script blocks, use the `$using:` scope (see below for an example).


## Syntax

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

## Properties

|  Property  |  Description   | 
|---|---| 
| GetScript| Provides a block of Windows PowerShell script that runs when you invoke the [Get-DscConfiguration](https://technet.microsoft.com/library/dn407379.aspx) cmdlet. This block must return a hashtable. The hashtable must only contain one key **Result** and the value must be of type **String**.| 
| SetScript| Provides a block of Windows PowerShell script. When you invoke the [Start-DscConfiguration](https://technet.microsoft.com/library/dn521623.aspx) cmdlet, the **TestScript** block runs first. If the **TestScript** block returns **$false**, the **SetScript** block will run. If the **TestScript** block returns **$true**, the **SetScript** block will not run.| 
| TestScript| Provides a block of Windows PowerShell script. When you invoke the [Start-DscConfiguration](https://technet.microsoft.com/library/dn521623.aspx) cmdlet, this block runs. If it returns **$false**, the SetScript block will run. If it returns **$true**, the SetScript block will not run. The **TestScript** block also runs when you invoke the [Test-DscConfiguration](https://technet.microsoft.com/en-us/library/dn407382.aspx) cmdlet. However, in this case, the **SetScript** block will not run, no matter what value the TestScript block returns. The **TestScript** block must return True if the actual configuration matches the current desired state configuration, and False if it does not match. (The current desired state configuration is the last configuration enacted on the node that is using DSC.)| 
| Credential| Indicates the credentials to use for running this script, if credentials are required.| 
| DependsOn| Indicates that the configuration of another resource must run before this resource is configured. For example, if the ID of the resource configuration script block that you want to run first is **ResourceName** and its type is **ResourceType**, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.

## Example 1
```powershell
Configuration ScriptTest
{
    Import-DscResource –ModuleName 'PSDesiredStateConfiguration'

    Script ScriptExample
    {
        SetScript = 
        { 
            $sw = New-Object System.IO.StreamWriter("C:\TempFolder\TestFile.txt")
            $sw.WriteLine("Some sample string")
            $sw.Close()
        }
        TestScript = { Test-Path "C:\TempFolder\TestFile.txt" }
        GetScript = { @{ Result = (Get-Content C:\TempFolder\TestFile.txt) } }          
    }
}
```

## Example 2
```powershell
$version = Get-Content 'version.txt'

Configuration ScriptTest
{
    Import-DscResource –ModuleName 'PSDesiredStateConfiguration'

    Script UpdateConfigurationVersion
    {
        GetScript = { 
            $currentVersion = Get-Content (Join-Path -Path $env:SYSTEMDRIVE -ChildPath 'version.txt')
            return @{ 'Result' = "$currentVersion" }
        }          
        TestScript = { 
            $state = $GetScript
            if( $state['Result'] -eq $using:version )
            {
                Write-Verbose -Message ('{0} -eq {1}' -f $state['Result'],$using:version)
                return $true
            }
            Write-Verbose -Message ('Version up-to-date: {0}' -f $using:version)
            return $false
        }
        SetScript = { 
            $using:version | Set-Content -Path (Join-Path -Path $env:SYSTEMDRIVE -ChildPath 'version.txt')
        }
    }
}
```

This resource is writing the configuration's version to a text file. This version is available on the client computer, but isn't on any of the nodes, so it has to be passed to each of the `Script` resource's script blocks with PowerShell's `using` scope. When generating the node's MOF file, the value of the `$version` variable is read from a text file on the client computer. DSC replaces the `$using:version` variables in each script block with the value of the `$version` variable.


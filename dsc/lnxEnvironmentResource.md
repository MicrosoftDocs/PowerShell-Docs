# PowerShell Desired State Configuration nxEnvironment Resource

 
The __nxEnvironment__ resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to to manage system environment variables on a Linux node.

## Syntax

```
nxEnvironment <string> #ResourceName
{
    Name = <string>
    [ Value = <string>
    [ Ensure = <string> { Absent | Present }  ]
    [ Path = <bool> }
    [ DependsOn = <string[]> ]

}
```

## Properties

|  Property |  Description | 
|---|---|
| Name| Indicates the name of the environment variable for which you want to ensure a specific state.| 
| Value| The value to assign to the environment variable.| 
| Ensure| Determines whether to check if the variable exists. Set this property to "Present" to ensure the variable exists. Set it to "Absent" to ensure the variable does not exist. The default value is "Present".| 
| Path| Defines the environment variable that is being configured. Set this property to __$true__ if the variable is the __Path__ variable; otherwise, set it to __$false__. The default is __$false__. If the variable being configured is the __Path__ variable, the value provided through the __Value__ property will be appended to the existing value.| 
| DependsOn | Indicates that the configuration of another resource must run before this resource is configured. For example, if the __ID__ of the resource configuration script block that you want to run first is __ResourceName__ and its type is __ResourceType__, the syntax for using this property is `DependsOn = "[ResourceType]ResourceName"`.| 


## Additional Information

- If __Path__ is absent or set to __$false__, environment variables are managed in `/etc/environment`. Your programs or scripts may require configuration to source the `/etc/environment` file to access the managed environment variables.


- If __Path__ is set to __$true__, the environment variable is managed in the file `/etc/profile.d/DSCenvironment.sh`. This file will be created if it does not exist. If __Ensure__ is set to "Absent" and __Path__ is set to __$true__, an existing environment variable will only be removed from `/etc/profile.d/DSCenvironment.sh` and not from other files.


## Example


The following example shows how to use the __nxEnvironment__ resource to ensure that __TestEnvironmentVariable__ is present and has the value "Test-Value". If __TestEnvironmentVariable__ is not present, it will be created.

```
Import-DSCResource -Module nx 


nxEnvironment EnvironmentExample
{
    Ensure = “Present”
    Name = “TestEnvironmentVariable”
    Value = “TestValue”
}
```



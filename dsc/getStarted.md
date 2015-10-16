# Get Started with Windows PowerShell Desired State Configuration

This topic explains how to use Windows PowerShell Desired State Configuration (DSC), which was introduced in Windows PowerShell 4.0, to configure your environment.

## Defining a configuration
DSC introduces a new keyword called Configuration. To use DSC to configure your environment, first define a Windows PowerShell script block using the Configuration keyword, then follow it with an identifier, then with braces ({}) to delimit the block.

Inside the configuration block you can define node blocks that specify the desired configuration for each node (computer) in your environment. A node block starts with the Node keyword. Follow this keyword with the name of the target computer, which can be a variable. After the computer name, use braces {} to delimit the node block.

Inside the node block, you can define resource blocks to configure specific resources. A resource block starts with the name of the resource, followed by the identifier you want to specify for that block, then braces {} to delimit the block.

## Script example
The following example uses DSC to ensure that the Web Server (IIS) role is installed on a target computer called “Server001”, and that the “wwwroot” folder on “Server001” contains a specified set of files. This is accomplished using two built-in DSC resources: the Role resource (with the friendly type name WindowsFeature) and the File resource (with the friendly type name File).

To define the example configuration:

1. Start Windows PowerShell ISE as an administrator.
1. In the View menu, select Show Script Pane.
1. In the script pane, define a variable called $WebsiteFilePath. Assign to it the path of a folder that contains website files. The content or type of files does not matter for the purpose of this example.
1. Copy the script below and paste it into the script pane below the definition of the variable.
  ```powershell
  Configuration MyWebConfig
  {
     # A Configuration block can have zero or more Node blocks
     Node "Server001"
     {
        # Next, specify one or more resource blocks

        # WindowsFeature is one of the built-in resources you can use in a Node block
        # This example ensures the Web Server (IIS) role is installed
        WindowsFeature MyRoleExample
        {
            Ensure = "Present" # To uninstall the role, set Ensure to "Absent"
            Name = "Web-Server"  
        }

        # File is a built-in resource you can use to manage files and directories
        # This example ensures files from the source directory are present in the destination directory
        File MyFileExample
        {
           Ensure = "Present"  # You can also set Ensure to "Absent"
           Type = "Directory“ # Default is “File”
           Recurse = $true
           SourcePath = $WebsiteFilePath # This is a path that has web files
           DestinationPath = "C:\inetpub\wwwroot" # The path where we want to ensure the web files are present
           DependsOn = "[WindowsFeature]MyRoleExample"  # This ensures that MyRoleExample completes successfully before this block runs
        }
     }
  } 
  ```
1. Change the name of the Node block from "Server001" to the name of a server on which you want to ensure the Windows features are installed and the "C:\inetpub\wwwroot" folder contains the appropriate content from the source directory. Alternatively, you can set the name of the node to "localhost". This will allow the configuration to be applied locally.
1. Run the example script. You will see the script appear in the console pane.

You have now defined the example configuration. Next, you will need to enact this configuration. Do so by invoking the configuration. For example:
```powershell 
PS C:\Scripts> MyWebConfig
```

Invoking the configuration creates MOF files and places them in a new directory with the same name as the configuration block. The new directory is a child of the current directory. (To specify a different directory for the MOF files, use the OutputPath parameter when invoking the configuration.) The new MOF files contain the configuration information for the target nodes. To enact the configuration, run the following command.

```powershell 
Start-DscConfiguration -Wait -Verbose -Path .\MyWebConfig
```

This cmdlet is part of the DSC system. The -Wait parameter is optional and makes the cmdlet run interactively. Without this parameter, the cmdlet will create and return a job. If you use the OutputPath parameter when invoking the configuration, you must specify the same path using the Path parameter of the Start-DscConfiguration cmdlet.

## Rules for nesting node and configuration blocks
The following nesting rules apply:

* There can be zero or more node blocks inside a configuration block.
* A target node can have more than one node block inside a given configuration block. In other words, the same node block identifier can appear more than once inside a given configuration block. This is functionally equivalent to grouping the contents of all the blocks for a given node inside one node block.
* A given type of resource can have zero or more blocks inside the same node block. However, it is not possible to have duplicate resource identifiers. Inside a given node block, each resource block must have a unique identifier.

## Declaring configuration parameters
It is possible to define a configuration block that takes parameters. Below is an example:
```powershell
Configuration MyParametrizedConfiguration
{
    # Parameters are optional
    param ($MyTargetNodeName, $MyGroupName)

    Node $MyTargetNodeName
    {
        # Group is a built-in resource that you can use to manage local Windows groups
        # This example ensures the existence of a group with the name specified by $MyGroupName
        Group MyGroupExample
        {
            Ensure = "Present" # Checks whether a group by this GroupName already exists and creates it if it does not
            Name = $MyGroupName
        }
    }
}  
```

You can invoke the above configuration as follows:
```powershell
MyParametrizedConfiguration -MyTargetNodeName "Server001" -MyGroupName "TestGroup"```

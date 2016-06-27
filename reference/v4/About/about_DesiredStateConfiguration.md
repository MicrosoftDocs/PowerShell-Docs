---
title: about_DesiredStateConfiguration
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f1b54875-bf62-4a04-bf50-470791b1dfca
---
# about_DesiredStateConfiguration
## TOPIC  
 about\_Desired\_State\_Configuration  
  
## SHORT DESCRIPTION  
 Provides a brief introduction to the [!INCLUDE[wps_1]()] Desired State Configuration \(DSC\) feature.  
  
## LONG DESCRIPTION  
 DSC is a management platform in [!INCLUDE[wps_2]()]. It enables the deployment and management of configuration data for software services and the environment on which these services run. DSC provides a set of [!INCLUDE[wps_2]()] language extensions, new cmdlets, and resources that you can use to declaratively specify how you want the state of your software environment to be configured.  
  
 DSC is introduced in [!INCLUDE[wps_2]()] 4.0.  
  
 For detailed information about DSC, see "[!INCLUDE[wps_2]()] Desired State Configuration" in the TechNet Library at http:\/\/go.microsoft.com\/fwlink\/?LinkId\=311940.  
  
## USING DSC  
 To use DSC to configure your environment, first define a [!INCLUDE[wps_2]()] script block using the Configuration keyword, followed by an identifier, which is in turn followed by the pair of curly braces delimiting the block. Inside the configuration block you can define node blocks that specify the desired configuration state for each node \(computer\) in the environment. A node block starts with the Node keyword, followed by the name of the target computer, which can be a variable. After the computer name, come the curly braces that delimit the node block. Inside the node block, you can define resource blocks to configure specific resources. A resource block starts with the type name of the resource, followed by the identifier you want to specify for that block, followed by the curly braces that delimit the block, as shown in the following example.  
  
```  
Configuration MyWebConfig  
    {  
       # Parameters are optional  
       param ($MachineName, $WebsiteFilePath)  
  
       # A Configuration block can have one or more Node blocks  
       Node $MachineName  
       {  
          # Next, specify one or more resource blocks  
          # WindowsFeature is one of the resources you can use in a Node block  
          # This example ensures the Web Server (IIS) role is installed  
          WindowsFeature IIS  
          {  
             # To ensure that the role is not installed, set Ensure to "Absent"  
              Ensure = "Present"   
              Name = "Web-Server" # Use the Name property from Get-WindowsFeature    
          }  
  
          # You can use the File resource to create files and folders  
          # "WebDirectory" is the name you want to use to refer to this instance  
          File WebDirectory  
          {  
             Ensure = "Present"  # You can also set Ensure to "Absent“  
             Type = "Directory“ # Default is “File”  
             Recurse = $true  
             SourcePath = $WebsiteFilePath  
             DestinationPath = "C:\inetpub\wwwroot"  
  
             # Ensure that the IIS block is successfully run first before  
             # configuring this resource  
             Requires = "[WindowsFeature]IIS"  # Use Requires for dependencies       
          }  
       }  
    }  
  
```  
  
 To create a configuration, invoke the Configuration block the same way you would invoke a [!INCLUDE[wps_2]()] function, passing in any expected parameters you may have defined \(two in the example above\). For example, in this case:  
  
```  
MyWebConfig -MachineName "TestMachine" –WebsiteFilePath "\\filesrv\WebFiles" `  
     -OutputPath "C:\Windows\system32\temp" # OutputPath is optional  
  
```  
  
 This generates a MOF file per node at the path you specify. These MOF files specify the desired configuration for each node. Next, use the following cmdlet to parse the configuration MOF files, send each node its corresponding configuration, and enact those configurations.  
  
```  
Start-DscConfiguration –Verbose -Wait -Path "C:\Windows\system32\temp"  
  
```  
  
## USING DSC TO MAINTAIN CONFIGURATION STATE  
 With DSC, configuration is idempotent. This means that if you use DSC to enact the same configuration more than once, the resulting configuration state will always be the same. Because of this, if you suspect that any nodes in your environment may have drifted from the desired state of configuration, you can enact the same DSC configuration again to bring them back to the desired state. You do not need to modify the configuration script to address only those resources whose state has drifted from the desired state.  
  
 The following example shows how you can verify whether the actual state of configuration on a given node has drifted from the last DSC configuration enacted on the node. In this example we are checking the configuration of the local computer.  
  
```  
$session = New-CimSession -ComputerName "localhost"  
Test-DscConfiguration -CimSession $session  
  
```  
  
## BUILT\-IN DSC RESOURCES  
 DSC provides the following set of built\-in resources that you can use in a configuration script: Registry, Script, Archive, File, WindowsFeature, Package, Environment, Group, User, Log, Service, and WindowsProcess. The example above demonstrates how to use the File and WindowsFeature resources. To see all the properties that you can use with a given resource, place the cursor on the resource keyword \(for example, File\) within your configuration script in the [!INCLUDE[wps_2]()] ISE, hold down CTRL, and press the SPACEBAR.  
  
## SEE ALSO  
 "[!INCLUDE[wps_2]()] Desired State Configuration"  
  
 \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=311940\)
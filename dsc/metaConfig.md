  

   


#Configuring the Local Configuration Manager#

The Local Configuration Manager (LCM) is the engine of Windows PowerShell Desired State Configuration (DSC). The LCM runs on every target node, and is responsible for parsing and enacting configurations that are sent to the node. It is also responsible for a number of other aspects of DSC, including the following.
* Determining refresh mode (push or pull).
* Specifying how often a node pulls and enacts configurations.
* Associating the node with pull servers.
* Specifying partial configurations.

You use a special type of configuration to configure the LCM to specify each of these behaviors. The following sections describe how to configure the LCM.

__Note__ 

> This topic applies to the LCM introduced in Windows PowerShell 5.0. For information about configuring the LCM in Windows PowerShell 4.0, see Windows PowerShell 4.0 Desired State Configuration Local Configuration Manager.

 



Writing and enacting an LCM configuration


To configure the LCM, you create and run a special type of configuration. To specify an LCM configuration, you use the DscLocalConfigurationManager attribute. The following shows a simple configuration that sets the LCM to push mode.



Windows PowerShell




Copy


[DSCLocalConfigurationManager()]
configuration LCMConfig
{
    Node localhost
    {
        Settings
        {
            RefreshMode = 'Push'

        }
           
    }
    
} 



You call and run the configuration to create the configuration MOF, just as you would a normal configuration (for information on creating the configuration MOF, see Get Started with Windows PowerShell Desired State Configuration). Unlike normal configurations, you do not enact an LCM configuration by calling the Start-DscConfiguration cmdlet. Instead, you call the Set-DscLocalConfigurationManager cmdlet, supplying the path to the configuration MOF as a parameter. After you enact the configuration, you can see the properties of the LCM by calling the Get-DscLocalConfigurationManager cmdlet.

An LCM configuration can contain blocks only for a limited set of resources. In the previous example, the only resource called is Settings. The other available resources are:
-ConfigurationRepositoryWeb—specifies an HTTP pull server for configurations.


-ConfigurationRepositoryShare—specifies an SMB pull server for configurations.


-ResourceRepositoryWeb—specifies an HTTP pull server for modules.


-ResourceRepositoryShare—specifies an SMB pull server for modules.


-ReportServerWeb—specifies an HTTP pull server to which reports are sent.


-PartialConfiguration—specifies partial configurations.



Basic settings


Other than specifying pull servers and partial configurations, all of the properties of the LCM are configured in a __Settings__ block. The following properties are available in a __Settings__ block.

 


 |  Property  |  Type  |  Description   | 
|--- |--- |---  | 
| ConfigurationModeFrequencyMins| UInt32| How often, in minutes, the current configuration is checked and applied. This property is ignored if the ConfigurationMode property is set to ApplyOnly. The default value is 15.
>Note: 
>Either the value of this property must be a multiple of the value of the RefreshFrequencyMins property, or the value of the >RefreshFrequencyMins property must be a multiple of the value of this property.| 
| RebootNodeIfNeeded| bool| Set this to $true to automatically reboot the node after a configuration that requires reboot is applied. Otherwise, you will have to manually reboot the node for any configuration that requires it. The default value is $false.| 
| ConfigurationMode| string | Specifies how the Local Configuration Manager actually applies the configuration to the target nodes. It can take the following values:
<ul><li>ApplyOnly: DSC applies the configuration and does nothing further unless a new configuration is pushed to the target node or when a new configuration is pulled from a server. After initial application of a new configuration, DSC does not check for drift from a previously configured state.</li>


<li>ApplyAndMonitor: This is the default value. The LCM applies any new configurations. After initial application of a new configuration, if the target node drifts from the desired state, DSC reports the discrepancy in logs.</li> 


<li>ApplyAndAutoCorrect: DSC applies any new configurations. After initial application of a new configuration, if the target node drifts from the desired state, DSC reports the discrepancy in logs, and then re-applies the current configuration.| 
| ActionAfterReboot| string| Specifies what happens after a reboot during the application of a configuration. The possible values are as follows.
ContuinueConfiguration: Continue applying the current configuration.</li>


<li>StopConfiguraiton: Stop the current configuration.</li></ul>| 
| RefreshMode| string| Specifies how the LCM gets configurations. The possible values are as follows.
<ul><li>Disabled: DSC configurations are disabled for this node.</li>


<li>Push: Configurations are initiated by calling the Start-DscConfiguration cmdlet. The configuration is applied immediately to the node. This is the default value.</li>


<li>Pull: The node is configured to regularly check for configurations from a pull server. If this property is set to Pull, you must specify a pull server in a ConfigurationRepositoryWeb or ConfigurationRepositoryShare block. For more information about pull servers, see Windows PowerShell Desired State Configuration Pull Servers.</li>| 
| CertificateID| string| A GUID that specifies a certificate used to secure credentials for access to the configuration. For more information see Want to secure credentials in Windows PowerShell Desired State Configuration?.| 
| ConfigurationID| string| A GUID that identifies the configuration file to get from a pull server in pull mode. The node will pull configurations on the pull sever if the name of the configuration MOF is named ConfigurationID.mof.
Note 
If you set this property, registering the node with a pull server by using RegistryKeys and AgentID does not work. For more information, see How to register a node with a DSC pull server.| 
| RefreshFrequencyMins| Uint32| The time interval, in minutes, at which the LCM checks a pull server to get updated configurations. This value is ignored if the LCM is not configured in pull mode. The default value is 30.
Note 
Either the value of this property must be a multiple of the value of the ConfigurationModeFrequencyMins property, or the value of the ConfigurationModeFrequencyMins property must be a multiple of the value of this property.| 
| AllowModlueOverwrite| bool| $TRUE if new configurations downloaded from the configuration server are allowed to overwrite the old ones on the target node. Otherwise, $FALSE.| 
| DebugMode| bool| If set to $TRUE, this causes the LCM to reload any DSC resources, even if they have been previously cached. Set to $FALSE to use cached resources. Typically you would set this property to $TRUE while debugging a resource, and to $FALSE for production. The default value is $FALSE.| 
| ConfigurationDownloadManagers| CimInstance[]| Obsolete. Use ConfigurationRepositoryWeb and ConfigurationRepositoryShare blocks to define configuration pull servers.| 
| ResourceModuleManagers| CimInstance[]| Obsolete. Use ResourceRepositoryWeb and ResourceRepositoryShare blocks to define resource pull servers.| 
| ReportManagers| CimInstance[]| Obsolete. Use ReportServerWeb blocks to define report pull servers.| 
| PartialConfigurations| CimInstance| Not implemented. Do not use.| 
| StatusRetentionTimeInDays | UInt32| The number of days the LCM keeps the status of the current configuration.| 

 

Pull servers


A pull server is either an OData web service or an SMB share that is used as a central location for DSC files. LCM configuration supports defining the following types of pull servers:
• Configuration server—A repository for DSC configurations. Define configuration severs by using ConfigurationRepositoryWeb (for web-based servers) and ConfigurationRepositoryShare (for SMB-based servers) blocks.


• Resource server—A repository for DSC resources, packaged as PowerShell modules. Define resource severs by using ResourceRepositoryWeb (for web-based servers) and ResourceRepositoryShare (for SMB-based servers) blocks.


• Report server—A service that DSC sends report data to. Define report servers by using ReportServerWeb blocks. A report server must be a web service.



For information about setting up and using pull servers, see Windows PowerShell Desired State Configuration Pull Servers

Configuration server blocks


To define a web-based configuration sever, you create a ConfigurationRepositoryWeb block. A ConfigurationRepositoryWeb defines the following properties.

 


Property 

Type 

Description 


AllowUnsecureConnection
 
bool
 
Set to $TRUE to allow connections from the node to the server without authentication. Set to $FALSE to require authentication.
 

CertificateID
 
string
 
A GUID that represents the certificate used to authenticate to the server.
 

ConfigurationNames
 
String[]
 
An array of names of configurations to be pulled by the target node. These are used only if the node is registered with the pull server by using an AgentID. For more information, see How to register a node with a DSC pull server.
 

RegistrationKey
 
string
 
A GUID that identifies the node to the pull server. For more information, see How to register a node with a DSC pull server.
 

ServerURL
 
string
 
The URL of the configuration server.
 

To define an SMB-based configuration server, you create a ConfigurationRepositoryShare block. A ConfigurationRepositoryShare defines the following properties.

 


Property 

Type 

Description 


Credential
 
MSFT_Credential 
 
The credential used to authenticate to the SMB share.
 

SourcePath
 
string
 
The path of the SMB share.
 

Resource server blocks


To define a web-based resource sever, you create a ResourceRepositoryWeb block. A ResourceRepositoryWeb defines the following properties.

 


Property 

Type 

Description 


AllowUnsecureConnection
 
bool
 
Set to $TRUE to allow connections from the node to the server without authentication. Set to $FALSE to require authentication.
 

CertificateID
 
string
 
A GUID that represents the certificate used to authenticate to the server.
 

RegistrationKey
 
string
 
A GUID that identifies the node to the pull server. For more information, see How to register a node with a DSC pull server.
 

ServerURL
 
string
 
The URL of the configuration server.
 

To define an SMB-based resource server, you create a ResourceRepositoryShare block. ResourceRepositoryShare defines the following properties.

 


Property 

Type 

Description 


Credential
 
MSFT_Credential 
 
The credential used to authenticate to the SMB share.
 

SourcePath
 
string
 
The path of the SMB share.
 

Report server blocks


A report server must be an OData web service. To define a report server, you create a ReportServerWeb block. ReportServerWeb defines the following properties.

 


Property 

Type 

Description 


AllowUnsecureConnection
 
bool
 
Set to $TRUE to allow connections from the node to the server without authentication. Set to $FALSE to require authentication.
 

CertificateID
 
string
 
A GUID that represents the certificate used to authenticate to the server.
 

RegistrationKey
 
string
 
A GUID that identifies the node to the pull server. For more information, see How to register a node with a DSC pull server.
 

ServerURL
 
string
 
The URL of the configuration server.
 

Partial configurations


To define a partial configuration, you create a PartialConfiguration block. For more information about partial configurations, see PowerShell Desired State Configuration Partial configurations. PartialConfiguration defines the following properties.

 


Property 

Type 

Description 


ConfigurationSource
 
string[]
 
An array of names of configuration servers, previously defined in ConfiguratoinRepositoryWeb and ConfigurationRepositoryShare blocks, where the partial configuration is pulled from.
 

DependsOn
 
string[]
 
A list of names of other configurations that must be completed before this partial configuration is applied.
 

Description
 
string
 
Text used to describe the partial configuration.
 

ExclusiveResources
 
string[]
 
An array of resources exclusive to this partial configuration.
 

RefreshMode
 
string
 
Specifies how DCS gets this partial configuration.. The possible values are as follows.
•Disabled: This partial configuration is disabled.


•Push: The partial configuration is pushed to the node by calling the Publish-DscConfiguration cmdlet. After all partial configurations for the node are either pushed or pulled from a server, the configuration can be started by calling Start-DscConfiguration –UseExisting. This is the default value.


•Pull: The node is configured to regularly check for the partial configuration from a pull server. If this property is set to Pull, you must specify a pull server by setting the ConfigurationSource property. For more information about pull servers, see Windows PowerShell Desired State Configuration Pull Servers.


 

ResourceModlueSource
 
string[]
 
An array of the names of resource servers from which to download required resources for this partial configuration. These names must refer to resource servers previously defined in ResourceRepositoryWeb and ResourceRepositoryShare blocks
 

See Also 


Concepts
Get Started with Windows PowerShell Desired State Configuration 
Windows PowerShell Desired State Configuration Pull Servers 
Windows PowerShell 4.0 Desired State Configuration Local Configuration Manager 

Other Resources
Set-DscLocalConfigurationManager 
How to register a node with a DSC pull server 






Was this page helpful?


 Yes 

 No 
 

















             



Community Additions

ADD  



 
Both ActionAfterReboot Options Misspelled 


•ContuinueConfiguration: Continue applying the current configuration.

•StopConfiguraiton: Stop the current configuration.



Should be:


•
ContinueConfiguration: Continue applying the current configuration.

•
StopConfiguration: Stop the current configuration.



So don't copy and paste them into your LCM config.




 


 Daniel Scott-Raynsford  

9/13/2015 



 
    





























Dev centers
Windows  
Office  
Visual Studio  
Microsoft Azure  
More...  







 United States (English)  
 

Newsletter 
Privacy & cookies 
Terms of use 
Trademarks 
 © 2015 Microsoft  


    
 
 

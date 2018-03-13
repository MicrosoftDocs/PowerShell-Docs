---
ms.date:  2017-06-12
ms.topic:  conceptual
keywords:  dsc,powershell,configuration,setup
title:  Using resources with multiple versions
---

# Using resources with multiple versions

> Applies To: Windows PowerShell 5.0

In PowerShell 5.0, DSC resources can have multiple versions, and versions can be installed on a computer side-by-side. This is implemented by having multiple versions of a resource module
that are contained in the same module folder.

## Installing multiple resource versions side-by-side

You can use the **MinimumVersion**, **MaximumVersion**, and **RequiredVersion** parameters of the [Install-Module](https://technet.microsoft.com/library/dn807162.aspx) cmdlet to specify
which version of a module to install. Calling **Install-Module** without specifying a version installs the most recent version.

For example, there are multiple versions of the **xFailOverCluster** module, each of which contains an **xCluster** resouce. The result of calling **Install-Module** without specifying the
version number is as follows:

```powershell
C:\Program Files\WindowsPowerShell\Modules\xFailOverCluster> Install-Module xFailOverCluster
C:\Program Files\WindowsPowerShell\Modules\xFailOverCluster> Get-DscResource xCluster

ImplementedAs   Name                      ModuleName                     Version    Properties
-------------   ----                      ----------                     -------    ----------
PowerShell      xCluster                  xFailOverCluster               1.2.0.0    {DomainAdministratorCredential, ...
```

Now, if you call **Install-Module** again, but specify a **RequiredVersion** of 1.1.0.0, it results in the following:

```powershell
C:\Program Files\WindowsPowerShell\Modules\xFailOverCluster> Install-Module xFailOverCluster -RequiredVersion 1.1
C:\Program Files\WindowsPowerShell\Modules\xFailOverCluster> Get-DscResource xCluster

ImplementedAs   Name                      ModuleName                     Version    Properties
-------------   ----                      ----------                     -------    ----------
PowerShell      xCluster                  xFailOverCluster               1.1        {DomainAdministratorCredential, Name, ...
PowerShell      xCluster                  xFailOverCluster               1.2.0.0    {DomainAdministratorCredential, Name, ...
```

## Specifying a resource version in a configuration

If you have multiple resources installed on a computer, you must specify the version of that resource when you use it in a configuration. You do this by specifying the **ModuleVersion** 
parameter of the **Import-DscResource** keyword. If you fail to specify the version of a resource module of a resource of which you have more than one version installed, the configuration
generates an error.

The following configuration shows how to specify the version of the resource to call:

```powershell
configuration VersionTest
{
    Import-DscResource -ModuleName xFailOverCluster -ModuleVersion 1.1

    Node 'localhost'
    {
       xCluster ClusterTest
       {
            Name                          = 'TestCluster'
            StaticIPAddress               = '10.0.0.3'
            DomainAdministratorCredential = Get-Credential
        }
     }
}     
```

>Note: The ModuleVersion parameter of Import-DscResource is not available in PowerShell 4.0. In PowerShell 4.0, you can specify a module version by passing a module specification 
>object to the ModuleName parameter of Import-DscResource. A module specification object is a hash table that contains ModuleName and RequiredVersion  keys. For example:

```powershell
configuration VersionTest
{
    Import-DscResource -ModuleName (@{ModuleName='xFailOverCluster'; RequiredVersion='1.1'} )

    Node 'localhost'
    {
       xCluster ClusterTest
       {
            Name                          = 'TestCluster'
            StaticIPAddress               = '10.0.0.3'
            DomainAdministratorCredential = Get-Credential
        }
     }
}     
```

This will also work in PowerShell 5.0, but it is recommended that you use the **ModuleVersion** parameter.

## See also
* [DSC Configurations](configurations.md)
* [DSC Resources](resources.md)


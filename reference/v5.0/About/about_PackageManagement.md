---
title: about_PackageManagement
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 97c415d6-30c3-495d-b955-60b787c442ef
---
# about_PackageManagement
```  
TOPIC  
    about_PackageManagement  
  
SHORT DESCRIPTION  
    PackageManagement is an aggregator for software package managers.  
  
LONG DESCRIPTION  
    PackageManagement functionality was introduced in Windows PowerShell 5.0.  
  
    PackageManagement is a unified interface for software package management systems; you  
    can run PackageManagement cmdlets to perform software discovery, installation, and  
    inventory (SDII) tasks. Regardless of the underlying installation technology,  
    you can run the common cmdlets in the PackageManagement module to search for,  
    install, or uninstall packages; add, remove, and query package repositories; and  
    run queries on a computer to determine which software packages are installed.  
  
    PackageManagement supports a flexible plug-in model that enables support for other   
    software package management systems.  
  
    The PackageManagement module is included with Windows PowerShell 5.0 and later releases  
    of Windows PowerShell, and works on three levels of package management  
    structure:  package providers, package sources, and the packages themselves.  
  
         Term                  Description  
         ----------            ------------------------------  
         Package manager       Software package management system. In  
                               PackageManagement terms, this is a package provider.  
         Package provider      PackageManagement term for a package manager. Examples  
                               can include Windows Installer, Chocolatey,   
                               and others.  
         Package source        A URL, local folder, or network shared folder that  
                               you configure package providers to use as a  
                               repository.  
         Package               A piece of software that a package provider manages,  
                               and that is stored in a specific package source.  
  
    The PackageManagement module includes the following cmdlets. You can find the  
    Help for these cmdlets on TechNet starting on the following page:  
    http://technet.microsoft.com/library/dn890951(v=wps.640).aspx.  
  
         Cmdlet                   Description  
         ----------               ------------------------------  
         Get-PackageProvider      Returns a list of package providers that are  
                                  connected to PackageManagement.  
         Get-PackageSource        Gets a list of package sources that are  
                                  registered for a package provider.  
         Register-PackageSource   Adds a package source for a specified  
                                  package provider.  
         Set-PackageSource        Sets properties on an existing package  
                                  source.  
         Unregister-PackageSource Removes a registered package source.  
         Get-Package              Returns a list of installed software  
                                  packages.  
         Find-Package             Finds software packages in available  
                                  package sources.  
         Install-Package          Installs one or more software packages.  
         Save-Package             Saves packages to the local computer  
                                  without installing them.  
         Uninstall-Package        Uninstalls one or more software packages.  
  
  PackageManagement Package Provider Bootstrapping and Dynamic Cmdlet Parameters  
  
    By default, PackageManagement ships with a core bootstrap provider. You can install  
    additional package providers as you need them by bootstrapping the providers;  
    that is, responding to a prompt to install the provider automatically, from a  
    web service. You can specify a package provider with any PackageManagement cmdlet;  
    if the specified provider is not available, PackageManagement prompts you to bootstrap  
    --or automatically install--the provider. In the following examples, if the  
    Chocolatey provider is not already installed, PackageManagement bootstrapping installs  
    the provider.   
  
        Find-Package –Provider Chocolatey <PackageName>  
  
    If the Chocolatey provider is not already installed, when you run the  
    preceding command, you are prompted to install it.  
  
        Install-Package <Chocolatey package Name> -ForceBootstrap  
  
    If the Chocolatey provider is not already installed, when you run the  
    preceding command, the provider is installed; but because the ForceBootstrap  
    parameter has been added to the command, you are not prompted to install it;  
    both the provider and the package are installed automatically.  
  
    When you try to install a package, if you do not already have the supporting  
    provider installed, and you do not add the ForceBootstrap parameter to your  
    command, PackageManagement prompts you to install the provider.  
  
    Specifying a package provider in your PackageManagement command can make  
    dynamic parameters available that are specific to that package provider.   
    When you run Get-Help for a specific PackageManagement cmdlet, a list of  
    parameter sets are returned, grouping dynamic parameters for available  
    package providers in separate parameter sets.  
  
  More Information About the PackageManagement Project  
  
    For more information about the PackageManagement open development project,  
    including how to create a PackageManagement package provider, see the  
    PackageManagement project on GitHub at https://oneget.org.  
  
SEE ALSO  
    Get-PackageProvider  
    Get-PackageSource  
    Register-PackageSource  
    Set-PackageSource  
    Unregister-PackageSource  
    Get-Package  
    Find-Package  
    Install-Package  
    Save-Package  
    Uninstall-Package  
```
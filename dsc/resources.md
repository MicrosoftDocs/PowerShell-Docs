# DSC Resources
A Desired State Configuration (DSC) resource can model something as generic as a file or a Windows process or as specific as an IIS server or a VM running in Azure. Resources provide the building blocks for a DSC configuration. A resource exposes properties that can be configured (schema) and contains the PowerShell code that the Local Configuration Manager (LCM) calls to "make it so." 

The following topics describe DSC resources:
- [Built-In DSC resources](builtInResource.md)
- [Build custom DSC resources](authoringResource.md)
- [Built-In DSC resources for Linux](lnxBuiltInResources.md)
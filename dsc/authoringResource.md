# Build Custom Windows PowerShell Desired State Configuration Resources

Windows PowerShell Desired State Configuration (DSC) has built-in resources that you can use to configure your environment. (For more information, see [Built-In Windows PowerShell Desired State Configuration Resources](TODO).) This topic provides an overview of developing resources and links to topics with specific information and examples.

## DSC resource components

A DSC resource is a Windows PowerShell module. The module contains both the schema (the definition of the configurable properties) and the implementation (the code that does the actual work specified by a configuration) for the resource. A DSC resource schema can be defined in a MOF file, and the implementation is performed by a script module. Beginning with the support of PowerShell classes in version 5, the schema and implementation can both be defined in a class. The following topics describe in more detail how to create DSC resources.

* [Writing a custom DSC resource with MOF](TODO) 
* [Implementing a DSC resource in C#](TODO) 
* [Writing a custom DSC resource with PowerShell classes](TODO) 
* [Composite resources: Using a DSC configuration as a resource](TODO) 
* [Using the Resource Designer tool](TODO) 
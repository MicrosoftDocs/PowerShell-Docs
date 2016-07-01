# Class-based DSC Resources

## Defining DSC resources with classes

Based on feedback, we’ve made authoring class-based DSC resources simpler and easier to understand. 
The major differences between a class-based DSC resource and a cmdlet DSC resource provider are:

* A MOF file for the schema is not required.
* A **DSCResource** subfolder in the module folder is not required.
* A PowerShell module file can contain multiple DSC resource classes.

For more information, see [Writing a custom DSC resource with PowerShell classes](../dsc/authoringResourceClass.md).

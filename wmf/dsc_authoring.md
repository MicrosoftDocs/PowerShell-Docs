# Authoring Improvements using PowerShell ISE

Authoring DSC configurations in Windows PowerShell ISE is much easier, thanks to the following improvements:

- List all DSC resources within a **configuration** block or **node** block by entering **Ctrl+Space** on a blank line within it.
- Automatic completion on resource properties that are of the **enumeration** type.
- Automatic completion on the **DependsOn** property of DSC resources, based on other resource instances in the configuration.
- Better tab completion of resource property values.

**Note:** You must have an empty string for resource property values before you can use Ctrl+Space to list the options. Pressing **Tab** cycles through options.

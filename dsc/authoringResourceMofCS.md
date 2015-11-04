# Authoring a DSC resource in C#

> Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0

Typically, a Windows PowerShell Desired State Configuration (DSC) custom resource is implemented in a PowerShell script. However, you can also implement the functionality of a DSC custom resource by writing cmdlets in C#. For an introduction on writing cmdlets in C#, see [Writing a Windows PowerShell Cmdlet](https://technet.microsoft.com/en-us/library/dd878294.aspx).

Aside from implementing the resource in C# as cmdlets, the process of creating the MOF schema, creating the folder structure, importing and using your custom DSC resource are the same as described in [Writing a custom DSC resource with MOF](authoringResourceMOF.md).

## Writing a cmdlet-based resource
For this example, we will implement a simple resource that manages a text file and its contents.

### Writing the MOF schema

The following is the MOF resource definition.

```
[ClassVersion("1.0.0"), FriendlyName("xDemoFile")]
class MSFT_XDemoFile : OMI_BaseResource
{
                [Key, Description("path")] String Path;
                [Write, Description("Should the file be present"), ValueMap{"Present","Absent"}, Values{"Present","Absent"}] String Ensure;
                [Write, Description("Contentof file.")] String Content;                   
};
```

### Setting up the Visual Studio project
#### Setting up a cmdlet project

1. Open Visual Studio.
1. Create a C# project and provide the name.
1. Select **Class Library** from the available project templates.
1. Click **Ok**.
1. Add an assembly reference to System.Automation.Management.dll to your project.
1. Change the assembly name to match the resource name. In this case, the assembly should be named **MSFT_XDemoFile**.

### Writing the cmdlet code

The following C# code implements the **Get-TargetResource**, **Set-TargetResource**, and **Test-TargetResource** cmdlets.

```C#
Get-TargetResource
       [OutputType(typeof(System.Collections.Hashtable))]
       [Cmdlet(VerbsCommon.Get, "TargetResource")]
       public class GetTargetResource : PSCmdlet
       {
              [Parameter(Mandatory = true)]
              public string Path { get; set; }
 
///<summary>
/// Implement the logic to write the current state of the resource as a 
/// Hash table with keys being the resource properties 
/// and the Values are the corresponding current values on the target machine.
 
///</summary>
              protected override void ProcessRecord()
              {
// Download the zip file at the end of this blog to see sample implementation.
 }
 
Set-TargetResouce
         [OutputType(typeof(void))]
    [Cmdlet(VerbsCommon.Set, "TargetResource")]
    public class SetTargetResource : PSCmdlet
    {
        privatestring _ensure;
        privatestring _content;
        
[Parameter(Mandatory = true)]
        public string Path { get; set; }
        
[Parameter(Mandatory = false)]      
       [ValidateSet("Present", "Absent", IgnoreCase = true)]
       public string Ensure {
            get
            {
                // set the default to present.
               return (this._ensure ?? "Present");
            }
            set
            {
                this._ensure = value;
            }
           } 
            public string Content {
            get { return (string.IsNullOrEmpty(this._content) ? "" : this._content); }
            set { this._content = value; }
        }
 
///<summary>
        /// Implement the logic to set the state of the machine to the desired state.
        ///</summary>
        protected override void ProcessRecord()
        {
//Implement the set method of the resource 
/* Uncomment this section if your resource needs a machine reboot.
PSVariable DscMachineStatus = new PSVariable("DSCMachineStatus", 1, ScopedItemOptions.AllScope);
                this.SessionState.PSVariable.Set(DscMachineStatus);
*/     
  }
    }
Test-TargetResource    
       [Cmdlet("Test", "TargetResource")]
    [OutputType(typeof(Boolean))]
    public class TestTargetResource : PSCmdlet
    {   
        
        private string _ensure;
        private string _content;
 
        [Parameter(Mandatory = true)]
        public string Path { get; set; }
 
        [Parameter(Mandatory = false)]
        [ValidateSet("Present", "Absent", IgnoreCase = true)]
        public string Ensure
        {
            get
            {
                // set the default to present.
                return (this._ensure ?? "Present");
            }
            set
            {
                this._ensure = value;
            }
        }
 
        [Parameter(Mandatory = false)]
        public string Content
        {
            get { return (string.IsNullOrEmpty(this._content) ? "“:this._content);}
            set { this._content = value; }
        }
 
///<summary>
/// Write a Boolean value which indicates whether the current machine is in    
/// desired state or not.
        ///</summary>
        protected override void ProcessRecord()
        {
                // Implement the test method of the resource.
        }
}
```

### Deploying the resource

The compiled dll file should be saved in a file structure similar to a script-based resource. The following is the folder structure for this resource.

```
$env: psmodulepath (folder)
    |- MyDscResources (folder)
        |- DSCResources (folder)
            |- MSFT_XDemoFile (folder)
                |- MSFT_XDemoFile.psd1 (file, optional)
                |- MSFT_XDemoFile.dll (file, required)
                |- MSFT_XDemoFile.schema.mof (file, required)
```

### See Also
#### Concepts
[Writing a custom DSC resource with MOF](authoringResourceMOF.md)
#### Other Resources
[Writing a Windows PowerShell Cmdlet](https://msdn.microsoft.com/en-us/library/dd878294.aspx)
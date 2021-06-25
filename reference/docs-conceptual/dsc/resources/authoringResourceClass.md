---
ms.date: 06/22/2021
title:  Writing a custom DSC resource with PowerShell classes
description: This article shows how to create a simple resource that manages a file in a specified path.
---

# Writing a custom DSC resource with PowerShell classes

> Applies To: Windows PowerShell 5.0

With the introduction of PowerShell classes in Windows PowerShell 5.0, you can now define a DSC
resource by creating a class. The class defines both the schema and the implementation of the
resource, so there is no need to create a separate MOF file. The folder structure for a class-based
resource is also simpler, because a **DSCResources** folder is not necessary.

In a class-based DSC resource, the schema is defined as properties of the class which can be
modified with attributes to specify the property type.. The resource is implemented by `Get()`,
`Set()`, and `Test()` methods (equivalent to the `Get-TargetResource`, `Set-TargetResource`,
and `Test-TargetResource` functions in a script resource.

In this article, we will create a simple resource named **FileResource** that manages a file in a
specified path.

For more information about DSC resources, see [Build Custom Windows PowerShell Desired State Configuration Resources](authoringResource.md)

> [!Note]
> Generic collections are not supported in class-based resources.

## Folder structure for a class resource

To implement a DSC custom resource with a PowerShell class, create the following folder structure.
The class is defined in `MyDscResource.psm1` and the module manifest is defined in
`MyDscResource.psd1`.

```
$env:ProgramFiles\WindowsPowerShell\Modules (folder)
    |- MyDscResource (folder)
        MyDscResource.psm1
        MyDscResource.psd1
```

## Create the class

You use the class keyword to create a PowerShell class. To specify that a class is a DSC resource,
use the `DscResource()` attribute. The name of the class is the name of the DSC resource.

```powershell
[DscResource()]
class File {
}
```

### Declare properties

The DSC resource schema is defined as properties of the class. We declare three properties as
follows.

```powershell
[DscProperty(Key)]
[string] $path

[DscProperty(Mandatory)]
[ensure] $ensure

[DscProperty()]
[string] $content

[DscProperty(NotConfigurable)]
[Reason[]] $Reasons
```

Notice that the properties are modified by attributes. The meaning of the attributes is as follows:

- **DscProperty(Key)**: The property is required. The property is a key. The values of all
  properties marked as keys must combine to uniquely identify a resource instance within a
  configuration.
- **DscProperty(Mandatory)**: The property is required.
- **DscProperty(NotConfigurable)**: The property is read-only. Properties marked with this attribute
  cannot be set by a configuration, but are populated by the `Get()` method when present.
- **DscProperty()**: The property is configurable, but it is not required.

The `$Path` and `$SourcePath` properties are both strings. The `$CreationTime` is a [DateTime](/dotnet/api/system.datetime)
property. The `$Ensure` property is an enumeration type, defined as follows.

```powershell
enum Ensure
{
    Absent
    Present
}
```

### Embedding classes

If you would like to include a new type with defined properties that you can
use within your resource, just create a class with property types as described
above.

```powershell
class Reason {
    [DscProperty()]
    [string] $Code

    [DscProperty()]
    [string] $Phrase
}
```

### Public and Private functions

You can create PowerShell functions within the same module file and use them
inside the methods of your DSC class resource. The functions must be delcared
as public, however the script blocks within those public functions can call
functions that are private. The only difference is whether they are listed in
the `FunctionsToExport` property of the module manifest.

```powershell
<#
   Public Functions
#>

function Get-File {
    param(
        [ensure]$ensure,
        
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$path,

        [String]$content
    )
    $fileContent        = [reason]::new()
    $fileContent.code   = 'file:file:content'

    $filePresent        = [reason]::new()
    $filePresent.code   = 'file:file:path'

    $ensureReturn = 'Absent'

    $fileExists = Test-path $path -ErrorAction SilentlyContinue

    if ($true -eq $fileExists) {
        $filePresent.phrase     = "The file was expected to be: $ensure`nThe file exists at path: $path"
        
        $existingFileContent    = Get-Content $path -Raw
        if ([string]::IsNullOrEmpty($existingFileContent)) {
            $existingFileContent = ''
        }

        if ($false -eq ([string]::IsNullOrEmpty($content))) {
            $content = $content | ConvertTo-SpecialChars
        }

        $fileContent.phrase     = "The file was expected to contain: $content`nThe file contained: $existingFileContent"

        if ($content -eq $existingFileContent) {
            $ensureReturn = 'Present'
        }
    }
    else {
        $filePresent.phrase     = "The file was expected to be: $ensure`nThe file does not exist at path: $path"
        $path = 'file not found'
    }

    return @{
        ensure  = $ensureReturn
        path    = $path
        content = $existingFileContent
        Reasons = @($filePresent,$fileContent)
    }
}

function Set-File {
    param(
        [ensure]$ensure = "Present",
        
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$path,

        [String]$content
    )
    Remove-Item $path -Force -ErrorAction SilentlyContinue
    if ($ensure -eq "Present") {
        New-Item $path -ItemType File -Force
        if ([ValidateNotNullOrEmpty()]$content) {
            $content | ConvertTo-SpecialChars | Set-Content $path -NoNewline -Force
        }
    }
}

function Test-File {
    param(
        [ensure]$ensure = "Present",
        
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$path,

        [String]$content
    )
    $test = $false
    $get = Get-File @PSBoundParameters
    
    if ($get.ensure -eq $ensure) {
        $test = $true
    }
    return $test
}

<#
   Private Functions
#>

function ConvertTo-SpecialChars {
    param(
        [parameter(Mandatory = $true,ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]$string
    )
    $specialChars = @{
        '`n' = "`n"
        '\\n' = "`n"
        '`r' = "`r"
        '\\r' = "`r"
        '`t' = "`t"
        '\\t' = "`t"
    }
    foreach ($char in $specialChars.Keys) {
        $string = $string -replace ($char,$specialChars[$char])
    }
    return $string
}
```

### Implementing the methods

The `Get()`, `Set()`, and `Test()` methods are analogous to the `Get-TargetResource`,
`Set-TargetResource`, and `Test-TargetResource` functions in a script resource.

As a best practice, minimize the amount of code within the class implementation. Instead,
move the majority of your code our to public functions in the module, which can then
be independently tested.

```powershell
<#
    This method is equivalent of the Get-TargetResource script function.
    The implementation should use the keys to find appropriate
    resources. This method returns an instance of this class with the
    updated key properties.
#>
[File] Get() {
    $get = Get-File -ensure $this.ensure -path $this.path -content $this.content
    return $get
}

<#
    This method is equivalent of the Set-TargetResource script function.
    It sets the resource to the desired state.
#>
[void] Set() {
    $set = Set-File -ensure $this.ensure -path $this.path -content $this.content
}

<#
    This method is equivalent of the Test-TargetResource script
    function. It should return True or False, showing whether the
    resource is in a desired state.
#>
[bool] Test() {
    $test = Test-File -ensure $this.ensure -path $this.path -content $this.content
    return $test
}
```

### The complete file

The complete class file follows.

```powershell
enum ensure {
    Absent
    Present
}

<#
    This class is used within the DSC Resource to standardize how data
    is returned about the compliance details of the machine.
#>
class Reason {
    [DscProperty()]
    [string] $Code

    [DscProperty()]
    [string] $Phrase
}

<#
   Public Functions
#>

function Get-File {
    param(
        [ensure]$ensure,
        
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$path,

        [String]$content
    )
    $fileContent        = [reason]::new()
    $fileContent.code   = 'file:file:content'

    $filePresent        = [reason]::new()
    $filePresent.code   = 'file:file:path'

    $ensureReturn = 'Absent'

    $fileExists = Test-path $path -ErrorAction SilentlyContinue

    if ($true -eq $fileExists) {
        $filePresent.phrase     = "The file was expected to be: $ensure`nThe file exists at path: $path"
        
        $existingFileContent    = Get-Content $path -Raw
        if ([string]::IsNullOrEmpty($existingFileContent)) {
            $existingFileContent = ''
        }

        if ($false -eq ([string]::IsNullOrEmpty($content))) {
            $content = $content | ConvertTo-SpecialChars
        }

        $fileContent.phrase     = "The file was expected to contain: $content`nThe file contained: $existingFileContent"

        if ($content -eq $existingFileContent) {
            $ensureReturn = 'Present'
        }
    }
    else {
        $filePresent.phrase     = "The file was expected to be: $ensure`nThe file does not exist at path: $path"
        $path = 'file not found'
    }

    return @{
        ensure  = $ensureReturn
        path    = $path
        content = $existingFileContent
        Reasons = @($filePresent,$fileContent)
    }
}

function Set-File {
    param(
        [ensure]$ensure = "Present",
        
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$path,

        [String]$content
    )
    Remove-Item $path -Force -ErrorAction SilentlyContinue
    if ($ensure -eq "Present") {
        New-Item $path -ItemType File -Force
        if ([ValidateNotNullOrEmpty()]$content) {
            $content | ConvertTo-SpecialChars | Set-Content $path -NoNewline -Force
        }
    }
}

function Test-File {
    param(
        [ensure]$ensure = "Present",
        
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$path,

        [String]$content
    )
    $test = $false
    $get = Get-File @PSBoundParameters
    
    if ($get.ensure -eq $ensure) {
        $test = $true
    }
    return $test
}

<#
   Private Functions
#>

function ConvertTo-SpecialChars {
    param(
        [parameter(Mandatory = $true,ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]$string
    )
    $specialChars = @{
        '`n' = "`n"
        '\\n' = "`n"
        '`r' = "`r"
        '\\r' = "`r"
        '`t' = "`t"
        '\\t' = "`t"
    }
    foreach ($char in $specialChars.Keys) {
        $string = $string -replace ($char,$specialChars[$char])
    }
    return $string
}

<#
    This resource manages the file in a specific path.
    [DscResource()] indicates the class is a DSC resource
#>

[DscResource()]
class File {
    
    <#
        This property is the fully qualified path to the file that is
        expected to be present or absent.

        The [DscProperty(Key)] attribute indicates the property is a
        key and its value uniquely identifies a resource instance.
        Defining this attribute also means the property is required
        and DSC will ensure a value is set before calling the resource.

        A DSC resource must define at least one key property.
    #>
    [DscProperty(Key)]
    [string] $path

    <#
        This property indicates if the settings should be present or absent
        on the system. For present, the resource ensures the file pointed
        to by $Path exists. For absent, it ensures the file point to by
        $Path does not exist.

        The [DscProperty(Mandatory)] attribute indicates the property is
        required and DSC will guarantee it is set.

        If Mandatory is not specified or if it is defined as
        Mandatory=$false, the value is not guaranteed to be set when DSC
        calls the resource.  This is appropriate for optional properties.
    #>
    [DscProperty(Mandatory)]
    [ensure] $ensure

    <#
        This property is optional. When provided, the content of the file
        will be overwridden by this value.
    #>
    [DscProperty()]
    [string] $content

    <#
        This property reports the reasons the machine is or is not compliant.

        [DscProperty(NotConfigurable)] attribute indicates the property is
        not configurable in DSC configuration.  Properties marked this way
        are populated by the Get() method to report additional details
        about the resource when it is present.
    #>
    [DscProperty(NotConfigurable)]
    [Reason[]] $Reasons

    <#
        This method is equivalent of the Get-TargetResource script function.
        The implementation should use the keys to find appropriate
        resources. This method returns an instance of this class with the
        updated key properties.
    #>
    [File] Get() {
        $get = Get-File -ensure $this.ensure -path $this.path -content $this.content
        return $get
    }
    
    <#
        This method is equivalent of the Set-TargetResource script function.
        It sets the resource to the desired state.
    #>
    [void] Set() {
        $set = Set-File -ensure $this.ensure -path $this.path -content $this.content
    }
    
    <#
        This method is equivalent of the Test-TargetResource script
        function. It should return True or False, showing whether the
        resource is in a desired state.
    #>
    [bool] Test() {
        $test = Test-File -ensure $this.ensure -path $this.path -content $this.content
        return $test
    }
}
```

## Create a manifest

To make a class-based resource available to the DSC engine, you must include a
`DscResourcesToExport` statement in the manifest file that instructs the module to export the
resource. Our manifest looks like this:

```powershell
@{

    # Script module or binary module file associated with this manifest.
    RootModule = 'File.psm1'
    
    # Version number of this module.
    ModuleVersion = '1.0.0.0'
    
    # ID used to uniquely identify this module
    GUID = 'fad0d04e-65d9-4e87-aa17-39de1d008ee4'
    
    # Author of this module
    Author = 'Microsoft Corporation'
    
    # Company or vendor of this module
    CompanyName = 'Microsoft Corporation'
    
    # Copyright statement for this module
    Copyright = ''
    
    # Description of the functionality provided by this module
    Description = 'Create and set content of a file'
    
    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion = '5.0'
    
    # Functions to export from this module
    FunctionsToExport = @('Get-File','Set-File','Test-File')
    
    # DSC resources to export from this module
    DscResourcesToExport = @('File')
    
    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData = @{
    
        PSData = @{
    
            # Tags applied to this module. These help with module discovery in online galleries.
            # Tags = @(Power Plan, Energy, Battery)
    
            # A URL to the license for this module.
            # LicenseUri = ''
    
            # A URL to the main website for this project.
            # ProjectUri = ''
    
            # A URL to an icon representing this module.
            # IconUri = ''
    
            # ReleaseNotes of this module
            # ReleaseNotes = ''
    
        } # End of PSData hashtable
    
    } 
}
```

## Test the resource

After saving the class and manifest files in the folder structure as described earlier, you can
create a configuration that uses the new resource. For information about how to run a DSC
configuration, see [Enacting configurations](../pull-server/enactingConfigurations.md). The
following configuration will check to see whether the file at `/tmp/test.txt` exists and if the contents
match the string provided by the property 'Content'. If not, the entire file is written.

```powershell
Configuration Test
{
    Import-DSCResource -module File
    File testFile
    {
        Path = "/tmp/test.txt"
        Content = "DSC Rocks!"
        Ensure = "Present"
    }
}
Test
```

## Supporting PsDscRunAsCredential

> [Note]
> **PsDscRunAsCredential** is supported in PowerShell 5.0 and later.

The **PsDscRunAsCredential** property can be used in [DSC configurations](../configurations/configurations.md)
resource block to specify that the resource should be run under a specified set of credentials. For
more information, see [Running DSC with user credentials](../configurations/runAsUser.md).

### Require or disallow PsDscRunAsCredential for your resource

The `DscResource()` attribute takes an optional parameter **RunAsCredential**. This parameter
takes one of three values:

- `Optional` **PsDscRunAsCredential** is optional for configurations that call this resource. This
  is the default value.
- `Mandatory` **PsDscRunAsCredential** must be used for any configuration that calls this resource.
- `NotSupported` Configurations that call this resource cannot use **PsDscRunAsCredential**.
- `Default` Same as `Optional`.

For example, use the following attribute to specify that your custom resource does not support using
**PsDscRunAsCredential**:

```powershell
[DscResource(RunAsCredential=NotSupported)]
class FileResource {
}
```

### Declaring multiple class resources in a module

A module can define multiple class based DSC resources. You can create the folder structure in the
following ways:

1. Define the first resource in the `<ModuleName>.psm1` file and subsequent resources under the
   **DSCResources** folder.

   ```
   $env:ProgramFiles\WindowsPowerShell\Modules (folder)
        |- MyDscResource (folder)
           |- MyDscResource.psm1
              MyDscResource.psd1
        |- DSCResources
           |- SecondResource.psm1
   ```

1. Define all resources under the **DSCResources** folder.

   ```
   $env:ProgramFiles\WindowsPowerShell\Modules (folder)
        |- MyDscResource (folder)
           |- MyDscResource.psm1
              MyDscResource.psd1
        |- DSCResources
           |- FirstResource.psm1
              SecondResource.psm1
   ```

> [!NOTE]
> In the examples above, add any PSM1 files under the **DSCResources** to the **NestedModules** key
> in your PSD1 file.

### Access the user context

To access the user context from within a custom resource, you can use the automatic variable
`$global:PsDscContext`.

For example the following code would write the user context under which the resource is running to
the verbose output stream:

```powershell
if (PsDscContext.RunAsUser) {
    Write-Verbose "User: $global:PsDscContext.RunAsUser";
}
```

## See Also

[Build Custom Windows PowerShell Desired State Configuration Resources](authoringResource.md)

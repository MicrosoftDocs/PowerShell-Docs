# Class-based DSC Resources
Develop DSC resources with classes in Windows PowerShell
--------------------------------------------------------

## Define DSC resources with classes

Based on feedback, we’ve made authoring class-defined DSC resources simpler and easier to understand. The major differences between a class-defined DSC resource and a cmdlet DSC resource provider are:

-   A MOF file for the schema is not required.

-   A **DSCResource** subfolder in the module folder is not required.

-   A Windows PowerShell module file can contain multiple DSC resource classes.

The following is an example of a class-defined DSC resource provider that extends the other class DSC resource in the same file. This is saved as a module, **MyDSCResource.psm1**. Note that you must always include at least one key property and Get, Set, Test method in a class-defined DSC resource or its base classes.
```powershell
enum Ensure

{

Absent

Present

}

&lt;\#

This resource manages the file in a specific path.

\[DscResource()\] indicates the class is a DSC resource

\#&gt;

\[DscResource()\]

class BaseFileResource

{

&lt;\#

This property is the fully qualified path to the file that is expected to be present or absent.

The \[DscProperty(Key)\] attribute indicates the property is a key and its value uniquely identifies a resource instance. Defining this attribute also means the property is required and DSC will ensure a value is set before calling the resource.

A DSC resource must define at least one key property.

\#&gt;

\[DscProperty(Key)\]

\[string\]$Path

&lt;\#

This property indicates if the settings should be present or absent on the system.

For present, the resource ensures the file pointed to by $Path exists. For absent, it ensures the file that $Path points to does not exist.

The \[DscProperty(Mandatory)\] attribute indicates the property is required and DSC will guarantee it is set.

If Mandatory is not specified or if it is defined as Mandatory=$false, the value is not guaranteed to be set when DSC calls the resource. This is appropriate for optional properties.

\#&gt;

\[DscProperty(Mandatory)\]

\[Ensure\] $Ensure

&lt;\#

This property defines the fully qualified path to a file that will be placed on the system if $Ensure = Present and $Path does not exist.

NOTE: This property is required because \[DscProperty(Mandatory)\] is set.

\#&gt;

\[DscProperty(Mandatory)\]

\[string\] $SourcePath

&lt;\#

This property reports the file's creation timestamp.

\[DscProperty(NotConfigurable))\] attribute indicates the property is not configurable in a DSC configuration. Properties marked this way are populated by the Get() method to report additional details about the resource when it is present.

\#&gt;

\[DscProperty(NotConfigurable)\]

\[Nullable\[datetime\]\] $CreationTime

&lt;\#

This method is equivalent of the Set-TargetResource script function.

It sets the resource to the desired state.

\#&gt;

\[void\] Set()

{

$fileExists = $this.TestFilePath($this.Path)

if($this.ensure -eq \[Ensure\]::Present)

{

if(-not $fileExists)

{

$this.CopyFile()

}

}

else

{

if($fileExists)

{

Write-Verbose -Message "Deleting the file $($this.Path)"

Remove-Item -LiteralPath $this.Path -Force

}

}

}

&lt;\#

This method is equivalent of the Test-TargetResource script function.

It should return True or False, showing whether the resource

is in a desired state.

\#&gt;

\[bool\] Test()

{

$present = $this.TestFilePath($this.Path)

if($this.Ensure -eq \[Ensure\]::Present)

{

return $present

}

else

{

return -not $present

}

}

&lt;\#

This method is equal to the Get-TargetResource script function.

The implementation should use the keys to find appropriate resources.

This method returns an instance of this class with the updated key properties.

\#&gt;

\[BaseFileResource\] Get()

{

$present = $this.TestFilePath($this.Path)

if ($present)

{

$file = Get-ChildItem -LiteralPath $this.Path

$this.CreationTime = $file.CreationTime

$this.Ensure = \[Ensure\]::Present

}

else

{

$this.CreationTime = $null

$this.Ensure = \[Ensure\]::Absent

}

return $this

}

&lt;\#

Helper method to check if the file exists and it is the right file

\#&gt;

\[bool\] TestFilePath(\[string\] $location)

{

$present = $true

$item = Get-ChildItem -LiteralPath $location -ea Ignore

if ($item -eq $null)

{

$present = $false

}

elseif( $item.PSProvider.Name -ne "FileSystem")

{

throw "Path $($location) is not a file path."

}

elseif($item.PSIsContainer)

{

throw "Path $($location) is a directory path."

}

return $present

}

&lt;\#

Helper method to copy the file from source to path

\#&gt;

\[void\] CopyFile()

{

if(-not $this.TestFilePath($this.SourcePath))

{

throw "SourcePath $($this.SourcePath) is not found."

}

\[System.IO.FileInfo\] $destFileInfo = new-object System.IO.FileInfo($this.Path)

if (-not $destFileInfo.Directory.Exists)

{

Write-Verbose -Message "Creating directory $($destFileInfo.Directory.FullName)"

\#use CreateDirectory instead of New-Item to avoid code

\# to handle the non-terminating error

\[System.IO.Directory\]::CreateDirectory($destFileInfo.Directory.FullName)

}

if(Test-Path -LiteralPath $this.Path -PathType Container)

{

throw "Path $($this.Path) is a directory path"

}

Write-Verbose -Message "Copying $($this.SourcePath) to $($this.Path)"

\#DSC engine catches and reports any error that occurs

Copy-Item -LiteralPath $this.SourcePath -Destination $this.Path -Force

}

}

&lt;\#

This resource inherits from the \[BaseFileResource\]

It reports additional information in Get method

\#&gt;

\[DscResource()\]

class FileResource : BaseFileResource

{

&lt;\#

This property reports if it is a readonly file

\#&gt;

\[DscProperty(NotConfigurable)\]

\[bool\] $IsReadOnly

&lt;\#

This property reports the file's LastAccessTime timestamp.

\#&gt;

\[DscProperty(NotConfigurable)\]

\[Nullable\[datetime\]\] $LastAccessTime

&lt;\#

This property reports the file's LastWriteTime timestamp.

\#&gt;

\[DscProperty(NotConfigurable)\]

\[Nullable\[datetime\]\] $LastWriteTime

&lt;\#

This method overrides the Get method in the base class.

\#&gt;

\[FileResource\] Get()

{

$present = $this.TestFilePath($this.Path)

if ($present)

{

$file = Get-ChildItem -LiteralPath $this.Path

$this.CreationTime = $file.CreationTime

$this.IsReadOnly = $file.IsReadOnly

$this.LastAccessTime = $file.LastAccessTime

$this.LastWriteTime = $file.LastWriteTime

$this.Ensure = \[Ensure\]::Present

}

else

{

$this.CreationTime = $null

$this.LastAccessTime = $null

$this.LastWriteTime = $null

$this.Ensure = \[Ensure\]::Absent

}

return $this

}

}
```
After creating the class-defined DSC resource provider, and saving it as a module, create a module manifest for the module. In this example, the following module manifest is saved as **MyDscResource.psd1**.
```powershell
@{

\# Script module or binary module file associated with this manifest.

RootModule = 'MyDscResource.psm1'

\# Version number of this module.

ModuleVersion = '1.0'

\# ID used to identify this module uniquely

GUID = '81624038-5e71-40f8-8905-b1a87afe22d7'

\# Author of this module

Author = 'User01'

\# Company or vendor of this module

CompanyName = 'Unknown'

\# Copyright statement for this module

Copyright = '(c) 2015 User01. All rights reserved.'

\# Description of the functionality provided by this module

Description = 'DSC resource provider for FileResource.'

\# Minimum version of the Windows PowerShell engine required by this module

PowerShellVersion = '5.0'

\# Name of the Windows PowerShell host required by this module

\# PowerShellHostName = ''

\# Required for DSC to detect PS class-based resources.

DscResourcesToExport = @('BaseFileResource','FileResource')

}
```
Deploy the new DSC resource provider by creating a **MyDscResource** folder for it under $env:SystemDrive\\Program Files\\WindowsPowerShell\\Modules. You do not need to create a DSCResource subfolder. Copy the module and module manifest files (**MyDscResource.psm1** and **MyDscResource.psd1**) to the **MyDscResource** folder.

From this point, you create and run a configuration script as you would with any DSC resource. The following is a configuration that references the MyDSCResource module. Save this as a script, **MyResource.ps1**.
```powershell
Configuration MyConfig

{

Import-Dscresource -ModuleName MyDscResource

BaseFileResource file

{

Path = "C:\\test\\baseFile.txt"

SourcePath = "c:\\\\test.txt"

Ensure = "Present"

}

FileResource file

{

Path = "C:\\test\\File.txt"

SourcePath = "c:\\\\test.txt"

Ensure = "Present"

}

}

MyConfig
```
Run this as you would any DSC configuration script. To start the configuration, in an elevated Windows PowerShell console, run the following cmdlet. You will see the output of Get-DscConfiguration from FileResource contains more information than BaseFileResource.
```powershell
PS C:\\test&gt; .\\MyResource.ps1

PS C:\\test&gt; Start-DscConfiguration c:\\test\\MyConfig –wait –verbose

PS C:\\test&gt; Get-DscConfiguration
```

## Known issues

In this release, the following are known issues with class-defined DSC resource providers.

-   Get-DscConfiguration may return empty values for the properties within the complex type property.

-   Composite resources cannot be written as a class based resource.

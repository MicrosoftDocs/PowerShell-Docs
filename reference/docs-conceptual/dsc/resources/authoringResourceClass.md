---
ms.date: 07/08/2020
keywords:  dsc,powershell,configuration,setup
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
class FileResource {
}
```

### Declare properties

The DSC resource schema is defined as properties of the class. We declare three properties as
follows.

```powershell
[DscProperty(Key)]
[string]$Path

[DscProperty(Mandatory)]
[Ensure] $Ensure

[DscProperty(Mandatory)]
[string] $SourcePath

[DscProperty(NotConfigurable)]
[Nullable[datetime]] $CreationTime
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

### Implementing the methods

The `Get()`, `Set()`, and `Test()` methods are analogous to the `Get-TargetResource`,
`Set-TargetResource`, and `Test-TargetResource` functions in a script resource.

This code also includes the `CopyFile()` function, a helper function that copies the file from
`$SourcePath` to `$Path`.

```powershell
    <#
        This method is equivalent of the Set-TargetResource script function.
        It sets the resource to the desired state.
    #>
    [void] Set()
    {
        $fileExists = $this.TestFilePath($this.Path)

        if ($this.ensure -eq [Ensure]::Present)
        {
            if(-not $fileExists)
            {
                $this.CopyFile()
            }
        }
        else
        {
            if ($fileExists)
            {
                Write-Verbose -Message "Deleting the file $($this.Path)"
                Remove-Item -LiteralPath $this.Path -Force
            }
        }
    }

    <#
        This method is equivalent of the Test-TargetResource script function.
        It should return True or False, showing whether the resource
        is in a desired state.
    #>
    [bool] Test()
    {
        $present = $this.TestFilePath($this.Path)

        if ($this.Ensure -eq [Ensure]::Present)
        {
            return $present
        }
        else
        {
            return -not $present
        }
    }

    <#
        This method is equivalent of the Get-TargetResource script function.
        The implementation should use the keys to find appropriate resources.
        This method returns an instance of this class with the updated key
         properties.
    #>
    [FileResource] Get()
    {
        $present = $this.TestFilePath($this.Path)

        if ($present)
        {
            $file = Get-ChildItem -LiteralPath $this.Path
            $this.CreationTime = $file.CreationTime
            $this.Ensure = [Ensure]::Present
        }
        else
        {
            $this.CreationTime = $null
            $this.Ensure = [Ensure]::Absent
        }

        return $this
    }

    <#
        Helper method to check if the file exists and it is file
    #>
    [bool] TestFilePath([string] $location)
    {
        $present = $true

        $item = Get-ChildItem -LiteralPath $location -ErrorAction Ignore

        if ($item -eq $null)
        {
            $present = $false
        }
        elseif ($item.PSProvider.Name -ne "FileSystem")
        {
            throw "Path $($location) is not a file path."
        }
        elseif ($item.PSIsContainer)
        {
            throw "Path $($location) is a directory path."
        }

        return $present
    }

    <#
        Helper method to copy file from source to path
    #>
    [void] CopyFile()
    {
        if (-not $this.TestFilePath($this.SourcePath))
        {
            throw "SourcePath $($this.SourcePath) is not found."
        }

        [System.IO.FileInfo] $destFileInfo = New-Object -TypeName System.IO.FileInfo($this.Path)

        if (-not $destFileInfo.Directory.Exists)
        {
            Write-Verbose -Message "Creating directory $($destFileInfo.Directory.FullName)"

            <#
                Use CreateDirectory instead of New-Item to avoid code
                to handle the non-terminating error
            #>
            [System.IO.Directory]::CreateDirectory($destFileInfo.Directory.FullName)
        }

        if (Test-Path -LiteralPath $this.Path -PathType Container)
        {
            throw "Path $($this.Path) is a directory path"
        }

        Write-Verbose -Message "Copying $($this.SourcePath) to $($this.Path)"

        # DSC engine catches and reports any error that occurs
        Copy-Item -LiteralPath $this.SourcePath -Destination $this.Path -Force
    }
```

### The complete file

The complete class file follows.

```powershell
enum Ensure
{
    Absent
    Present
}

<#
   This resource manages the file in a specific path.
   [DscResource()] indicates the class is a DSC resource
#>

[DscResource()]
class FileResource
{
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
    [string]$Path

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
    [Ensure] $Ensure

    <#
       This property defines the fully qualified path to a file that will
       be placed on the system if $Ensure = Present and $Path does not
        exist.

       NOTE: This property is required because [DscProperty(Mandatory)] is
        set.
    #>
    [DscProperty(Mandatory)]
    [string] $SourcePath

    <#
       This property reports the file's create timestamp.

       [DscProperty(NotConfigurable)] attribute indicates the property is
       not configurable in DSC configuration.  Properties marked this way
       are populated by the Get() method to report additional details
       about the resource when it is present.

    #>
    [DscProperty(NotConfigurable)]
    [Nullable[datetime]] $CreationTime

    <#
        This method is equivalent of the Set-TargetResource script function.
        It sets the resource to the desired state.
    #>
    [void] Set()
    {
        $fileExists = $this.TestFilePath($this.Path)
        if ($this.ensure -eq [Ensure]::Present)
        {
            if (-not $fileExists)
            {
                $this.CopyFile()
            }
        }
        else
        {
            if ($fileExists)
            {
                Write-Verbose -Message "Deleting the file $($this.Path)"
                Remove-Item -LiteralPath $this.Path -Force
            }
        }
    }

    <#
        This method is equivalent of the Test-TargetResource script function.
        It should return True or False, showing whether the resource
        is in a desired state.
    #>
    [bool] Test()
    {
        $present = $this.TestFilePath($this.Path)

        if ($this.Ensure -eq [Ensure]::Present)
        {
            return $present
        }
        else
        {
            return -not $present
        }
    }

    <#
        This method is equivalent of the Get-TargetResource script function.
        The implementation should use the keys to find appropriate resources.
        This method returns an instance of this class with the updated key
         properties.
    #>
    [FileResource] Get()
    {
        $present = $this.TestFilePath($this.Path)

        if ($present)
        {
            $file = Get-ChildItem -LiteralPath $this.Path
            $this.CreationTime = $file.CreationTime
            $this.Ensure = [Ensure]::Present
        }
        else
        {
            $this.CreationTime = $null
            $this.Ensure = [Ensure]::Absent
        }

        return $this
    }

    <#
        Helper method to check if the file exists and it is file
    #>
    [bool] TestFilePath([string] $location)
    {
        $present = $true

        $item = Get-ChildItem -LiteralPath $location -ea Ignore
        if ($item -eq $null)
        {
            $present = $false
        }
        elseif ($item.PSProvider.Name -ne "FileSystem")
        {
            throw "Path $($location) is not a file path."
        }
        elseif ($item.PSIsContainer)
        {
            throw "Path $($location) is a directory path."
        }

        return $present
    }

    <#
        Helper method to copy file from source to path
    #>
    [void] CopyFile()
    {
        if (-not $this.TestFilePath($this.SourcePath))
        {
            throw "SourcePath $($this.SourcePath) is not found."
        }

        [System.IO.FileInfo] $destFileInfo = new-object System.IO.FileInfo($this.Path)
        if (-not $destFileInfo.Directory.Exists)
        {
            Write-Verbose -Message "Creating directory $($destFileInfo.Directory.FullName)"

            <#
                Use CreateDirectory instead of New-Item to avoid code
                 to handle the non-terminating error
            #>
            [System.IO.Directory]::CreateDirectory($destFileInfo.Directory.FullName)
        }

        if (Test-Path -LiteralPath $this.Path -PathType Container)
        {
            throw "Path $($this.Path) is a directory path"
        }

        Write-Verbose -Message "Copying $($this.SourcePath) to $($this.Path)"

        # DSC engine catches and reports any error that occurs
        Copy-Item -LiteralPath $this.SourcePath -Destination $this.Path -Force
    }
} # This module defines a class for a DSC "FileResource" provider.
```

## Create a manifest

To make a class-based resource available to the DSC engine, you must include a
`DscResourcesToExport` statement in the manifest file that instructs the module to export the
resource. Our manifest looks like this:

```powershell
@{

# Script module or binary module file associated with this manifest.
RootModule = 'MyDscResource.psm1'

DscResourcesToExport = 'FileResource'

# Version number of this module.
ModuleVersion = '1.0'

# ID used to uniquely identify this module
GUID = '81624038-5e71-40f8-8905-b1a87afe22d7'

# Author of this module
Author = 'Microsoft Corporation'

# Company or vendor of this module
CompanyName = 'Microsoft Corporation'

# Copyright statement for this module
Copyright = '(c) 2014 Microsoft. All rights reserved.'

# Description of the functionality provided by this module
# Description = ''

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '5.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''
}
```

## Test the resource

After saving the class and manifest files in the folder structure as described earlier, you can
create a configuration that uses the new resource. For information about how to run a DSC
configuration, see [Enacting configurations](../pull-server/enactingConfigurations.md). The
following configuration will check to see whether the file at `c:\test\test.txt` exists, and, if
not, copies the file from `c:\test.txt` (you should create `c:\test.txt` before you run the
configuration).

```powershell
Configuration Test
{
    Import-DSCResource -module MyDscResource
    FileResource file
    {
        Path = "C:\test\test.txt"
        SourcePath = "c:\test.txt"
        Ensure = "Present"
    }
}
Test
Start-DscConfiguration -Wait -Force Test
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

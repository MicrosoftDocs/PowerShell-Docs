# Allowance for Identical Duplicate Resources in a Configuration

DSC does not allow or handle conflicting resource definitions within a configuration. It does not try to resolve the conflict it simply fails. As configuration reuse becomes more utilized through composite resources, etc. conflicts will occur more often. When conflicting resource definitions are identical, DSC should be smart and allow this. With this release, it does.

**Example**

```PowerShell
Configuration IIS_FrontEnd
{
    WindowsFeature FE_IIS         #Identical resource
    {
        Ensure = 'Present'
        Name = 'Web-Server'
    }

    WindowsFeature FTP
    {
        Ensure = 'Present'
        Name = 'Web-FTP-Server'
    }
}

Configuration IIS_Worker
{
    WindowsFeature Worker_IIS      #Identical resource
    {
        Ensure = 'Present'
        Name = 'Web-Server'
    }

    WindowsFeature ASP
    {
        Ensure = 'Present'
        Name = 'Web-ASP-Net45'
    }
}

Configuration WebApplication
{
    IIS_Frontend Web {}

    IIS_Worker ASP {}
}
```

In previous releases, the result would be a failed compliation due to a conflict between the WindowsFeature FE_IIS and the WindowsFeature Worker_IIS resources trying to ensure the 'Web-Server' role is installed. Notice that **All** of the properties that are being configured are identical in these two configurations. Since **All** of the properties in these two resources are identical, this will result in a successful compiliation now. 

If any of the properties are different between the two resources, they will not be considered identical and compilation will fail.

**Example:**
```PowerShell
Configuration IIS_FrontEnd
{
    WindowsFeature FE_IIS
    {
        Ensure = 'Present'     #Ensure is Present here
        Name = 'Web-Server'
    }

    WindowsFeature FTP
    {
        Ensure = 'Present'
        Name = 'Web-FTP-Server'
    }
}

Configuration IIS_Worker
{
    WindowsFeature Worker_IIS
    {
        Ensure = 'Absent'      #Ensure property is Absent instead of Present
        Name = 'Web-Server'
    }

    WindowsFeature ASP
    {
        Ensure = 'Present'
        Name = 'Web-ASP-Net45'
    }
}

Configuration WebApplication
{
    IIS_Frontend Web {}

    IIS_Worker ASP {}
}
```

This very similar configuration will fail because the WindowsFeature FE_IIS and the WindowsFeature Worker_IIS resources are no longer identical and therefore conflict.
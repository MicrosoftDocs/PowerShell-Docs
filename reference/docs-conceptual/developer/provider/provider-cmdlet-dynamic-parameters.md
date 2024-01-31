---
description: Provider cmdlet dynamic parameters
ms.date: 09/13/2016
ms.topic: reference
title: Provider cmdlet dynamic parameters
---
# Provider cmdlet dynamic parameters

Providers can define dynamic parameters that are added to a provider cmdlet when the user specifies
a certain value for one of the static parameters of the cmdlet. For example, a provider can add
different dynamic parameters based on what path the user specifies when they call the `Get-Item` or
`Set-Item` provider cmdlets.

## Dynamic Parameter Methods

Dynamic parameters are defined by implementing one of the dynamic parameter methods, such as the
[System.Management.Automation.Provider.ItemCmdletProvider.GetItemDynamicParameters*][19] and
[System.Management.Automation.Provider.SetItemDynamicParameters.SetItemDynamicParameters*][21]
methods. These methods return an object that has public properties that are decorated with
attributes similar to those of stand-alone cmdlets. Here is an example of an implementation of the
[System.Management.Automation.Provider.ItemCmdletProvider.GetItemDynamicParameters*][19] method
taken from the Certificate provider:

```csharp
protected override object GetItemDynamicParameters(string path)
{
    return new CertificateProviderDynamicParameters();
}
```

Unlike the static parameters of provider cmdlets, you can specify the characteristics of these
parameters in the same way that parameters are defined in stand-alone cmdlets. Here is an example of
a dynamic parameter class taken from the Certificate provider:

```csharp
internal sealed class CertificateProviderDynamicParameters
{
  /// <summary>
  /// Dynamic parameter the controls whether we only return
  /// code signing certs.
  /// </summary>
  [Parameter()]
  public SwitchParameter CodeSigningCert
  {
    get
    {
      {
        return codeSigningCert;
      }
    }

    set
    {
      {
        codeSigningCert = value;
      }
    }
  }

    private SwitchParameter codeSigningCert = new SwitchParameter();
}
```

## Dynamic Parameters

Here is a list of the static parameters that can be used to add dynamic parameters.

- `Clear-Content` cmdlet - You can define dynamic parameters that are triggered by the `Path`
  parameter of the Clear-Clear cmdlet by implementing the
  [System.Management.Automation.Provider.IContentCmdletProvider.ClearContentDynamicParameters*][09]
  method.
- `Clear-Item` cmdlet - You can define dynamic parameters that are triggered by the `Path` parameter
  of the `Clear-Item` cmdlet by implementing the
  [System.Management.Automation.Provider.ItemCmdletProvider.ClearItemDynamicParameters*][18] method.
- `Clear-ItemProperty` cmdlet - You can define dynamic parameters that are triggered by the `Path`
  parameter of the `Clear-ItemProperty` cmdlet by implementing the
  [System.Management.Automation.Provider.IPropertyCmdletProvider.ClearPropertyDynamicParameters*][15]
  method.
- `Copy-Item` cmdlet - You can define dynamic parameters that are triggered by the `Path`,
  `Destination`, and `Recurse` parameters of the `Copy-Item` cmdlet by implementing the
  [System.Management.Automation.Provider.ContainerCmdletProvider.CopyItemDynamicParameters*][02]
  method.
- `Get-ChildItem` cmdlet - You can define dynamic parameters that are triggered by the `Path` and
  `Recurse` parameters of the `Get-ChildItem` cmdlet by implementing the
  [System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItemsDynamicParameters*][03]
  and
  [System.Management.Automation.Provider.ContainerCmdletProvider.GetChildNamesDynamicParameters*][04]
  methods.
- `Get-Content` cmdlet - You can define dynamic parameters that are triggered by the `Path`
  parameter of the `Get-Content` cmdlet by implementing the
  [System.Management.Automation.Provider.IContentCmdletProvider.GetContentReaderDynamicParameters*][10]
  method.
- `Get-Item` cmdlet - You can define dynamic parameters that are triggered by the `Path` parameter
  of the `Get-Item` cmdlet by implementing the
  [System.Management.Automation.Provider.ItemCmdletProvider.GetItemDynamicParameters*][19] method.
- `Get-ItemProperty` cmdlet - You can define dynamic parameters that are triggered by the `Path` and
  `Name` parameters of the `Get-ItemProperty` cmdlet by implementing the
  [System.Management.Automation.Provider.IPropertyCmdletProvider.GetPropertyDynamicParameters*][16]
  method.
- `Invoke-Item` cmdlet - You can define dynamic parameters that are triggered by the `Path`
  parameter of the `Invoke-Item` cmdlet by implementing the
  [System.Management.Automation.Provider.ItemCmdletProvider.InvokeDefaultActionDynamicParameters*][20]
  method.
- `Move-Item` cmdlet - You can define dynamic parameters that are triggered by the `Path` and
  `Destination` parameters of the `Move-Item` cmdlet by implementing the
  [System.Management.Automation.Provider.NavigationCmdletProvider.MoveItemDynamicParameters*][22]
  method.
- `New-Item` cmdlet - You can define dynamic parameters that are triggered by the `Path`,
  `ItemType`, and `Value` parameters of the `New-Item` cmdlet by implementing the
  [System.Management.Automation.Provider.ContainerCmdletProvider.NewItemDynamicParameters*][05]
  method.
- `New-ItemProperty` cmdlet - You can define dynamic parameters that are triggered by the `Path`,
  `Name`, `PropertyType`, and `Value` parameters of the `New-ItemProperty` cmdlet by implementing
  the
  [System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.NewPropertyDynamicParameters*][12]
  method.
- `New-PSDrive` cmdlet - You can define dynamic parameters that are triggered by the
  [System.Management.Automation.PSDriveInfo][23] object returned by the `New-PSDrive` cmdlet by
  implementing the
  [System.Management.Automation.Provider.DriveCmdletProvider.NewDriveDynamicParameters*][08] method.
- `Remove-Item` cmdlet - You can define dynamic parameters that are triggered by the `Path` and
  `Recurse` parameters of the `Remove-Item` cmdlet by implementing the
  [System.Management.Automation.Provider.Containercmdletprovider.Removeitemdynamicparameters*][06]
  method.
- `Remove-ItemProperty` cmdlet - You can define dynamic parameters that are triggered by the `Path`
  and `Name` parameters of the `Remove-ItemProperty` cmdlet by implementing the
  [System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RemovePropertyDynamicParameters*][13]
  method.
- `Rename-Item` cmdlet - You can define dynamic parameters that are triggered by the `Path` and
  `NewName` parameters of the `Rename-Item` cmdlet by implementing the
  [System.Management.Automation.Provider.Containercmdletprovider.Renameitemdynamicparameters*][07]
  method.
- `Rename-ItemProperty` - You can define dynamic parameters that are triggered by the `Path`,
  `Name`, and `NewName` parameters of the `Rename-ItemProperty` cmdlet by implementing the
  [System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RenamePropertyDynamicParameters*][14]
  method.
- `Set-Content` cmdlet - You can define dynamic parameters that are triggered by the `Path`
  parameter of the `Set-Content` cmdlet by implementing the
  [System.Management.Automation.Provider.IContentCmdletProvider.GetContentWriterDynamicParameters*][11]
  method.
- `Set-Item` cmdlet - You can define dynamic parameters that are triggered by the `Path` and `Value`
  parameters of the `Set-Item` cmdlet by implementing the
  [System.Management.Automation.Provider.ItemCmdletProvider.SetItemDynamicParameters*][21] method.

- `Set-ItemProperty` cmdlet - You can define dynamic parameters that are triggered by the `Path` and
  `Value` parameters of the `Set-Item` cmdlet by implementing the
  [System.Management.Automation.Provider.IPropertyCmdletProvider.SetPropertyDynamicParameters*][17]
  method.
- `Test-Path` cmdlet - You can define dynamic parameters that are triggered by the `Path` parameter
  of the `Test-Path` cmdlet by implementing the
  [System.Management.Automation.Provider.ItemCmdletProvider.InvokeDefaultActionDynamicParameters*][20]
  method.

## See Also

[Writing a Windows PowerShell Provider][01]

<!-- link references -->
[01]: writing-a-windows-powershell-provider.md
[02]: xref:System.Management.Automation.Provider.ContainerCmdletProvider.CopyItemDynamicParameters*
[03]: xref:System.Management.Automation.Provider.ContainerCmdletProvider.GetChildItemsDynamicParameters*
[04]: xref:System.Management.Automation.Provider.ContainerCmdletProvider.GetChildNamesDynamicParameters*
[05]: xref:System.Management.Automation.Provider.ContainerCmdletProvider.NewItemDynamicParameters*
[06]: xref:System.Management.Automation.Provider.ContainerCmdletProvider.RemoveItemDynamicParameters*
[07]: xref:System.Management.Automation.Provider.ContainerCmdletProvider.RenameItemDynamicParameters*
[08]: xref:System.Management.Automation.Provider.DriveCmdletProvider.NewDriveDynamicParameters*
[09]: xref:System.Management.Automation.Provider.IContentCmdletProvider.ClearContentDynamicParameters*
[10]: xref:System.Management.Automation.Provider.IContentCmdletProvider.GetContentReaderDynamicParameters*
[11]: xref:System.Management.Automation.Provider.IContentCmdletProvider.GetContentWriterDynamicParameters*
[12]: xref:System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.NewPropertyDynamicParameters*
[13]: xref:System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RemovePropertyDynamicParameters*
[14]: xref:System.Management.Automation.Provider.IDynamicPropertyCmdletProvider.RenamePropertyDynamicParameters*
[15]: xref:System.Management.Automation.Provider.IPropertyCmdletProvider.ClearPropertyDynamicParameters*
[16]: xref:System.Management.Automation.Provider.IPropertyCmdletProvider.GetPropertyDynamicParameters*
[17]: xref:System.Management.Automation.Provider.IPropertyCmdletProvider.SetPropertyDynamicParameters*
[18]: xref:System.Management.Automation.Provider.ItemCmdletProvider.ClearItemDynamicParameters*
[19]: xref:System.Management.Automation.Provider.ItemCmdletProvider.GetItemDynamicParameters*
[20]: xref:System.Management.Automation.Provider.ItemCmdletProvider.InvokeDefaultActionDynamicParameters*
[21]: xref:System.Management.Automation.Provider.ItemCmdletProvider.SetItemDynamicParameters*
[22]: xref:System.Management.Automation.Provider.NavigationCmdletProvider.MoveItemDynamicParameters*
[23]: xref:System.Management.Automation.PSDriveInfo

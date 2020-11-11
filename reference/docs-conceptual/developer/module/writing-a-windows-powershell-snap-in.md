---
ms.date: 09/13/2016
ms.topic: reference
title: Writing a Windows PowerShell Snap-in
description: Writing a Windows PowerShell Snap-in
---
# Writing a Windows PowerShell Snap-in

This example shows how to write a Windows PowerShell snap-in that can be used to register all the
cmdlets and Windows PowerShell providers in an assembly.

With this type of snap-in, you do not select which cmdlets and providers you want to register. To
write a snap-in that allows you to select what is registered, see
[Writing a Custom Windows PowerShell Snap-in](./writing-a-custom-windows-powershell-snap-in.md).

### Writing a Windows PowerShell Snap-in

1. Add the RunInstallerAttribute attribute.

2. Create a public class that derives from the
   [System.Management.Automation.PSSnapIn](/dotnet/api/System.Management.Automation.PSSnapIn) class.

    In this example, the class name is "GetProcPSSnapIn01".

3. Add a public property for the name of the snap-in (required). When naming snap-ins, do not use
   any of the following characters: `#`, `.`, `,`, `(`, `)`, `{`, `}`, `[`, `]`, `&`, `-`, `/`, `\`,
   `$`, `;`, `:`, `"`, `'`, `<`, `>`, `|`, `?`, `@`, `` ` ``, `*`

    In this example, the name of the snap-in is "GetProcPSSnapIn01".

4. Add a public property for the vendor of the snap-in (required).

    In this example, the vendor is "Microsoft".

5. Add a public property for the vendor resource of the snap-in (optional).

    In this example, the vendor resource is "GetProcPSSnapIn01,Microsoft".

6. Add a public property for the description of the snap-in (required).

    In this example, the description is "This is a Windows PowerShell snap-in that registers the
    get-proc cmdlet".

7. Add a public property for the description resource of the snap-in (optional).

    In this example, the vendor resource is "GetProcPSSnapIn01,This is a Windows PowerShell snap-in
    that registers the get-proc cmdlet".

## Example

This example shows how to write a Windows PowerShell snap-in that can be used to register the
Get-Proc cmdlet in the Windows PowerShell shell. Be aware that in this example, the complete
assembly would contain only the GetProcPSSnapIn01 snap-in class and the `Get-Proc` cmdlet class.

```csharp
[RunInstaller(true)]
public class GetProcPSSnapIn01 : PSSnapIn
{
  /// <summary>
  /// Create an instance of the GetProcPSSnapIn01 class.
  /// </summary>
  public GetProcPSSnapIn01()
         : base()
  {
  }

  /// <summary>
  /// Specify the name of the PowerShell snap-in.
  /// </summary>
  public override string Name
  {
    get
    {
      return "GetProcPSSnapIn01";
    }
  }

  /// <summary>
  /// Specify the vendor for the PowerShell snap-in.
  /// </summary>
  public override string Vendor
  {
    get
    {
      return "Microsoft";
    }
  }

  /// <summary>
  /// Specify the localization resource information for the vendor.
  /// Use the format: resourceBaseName,VendorName.
  /// </summary>
  public override string VendorResource
  {
    get
    {
      return "GetProcPSSnapIn01,Microsoft";
    }
  }

  /// <summary>
  /// Specify a description of the PowerShell snap-in.
  /// </summary>
  public override string Description
  {
    get
    {
      return "This is a PowerShell snap-in that includes the get-proc cmdlet.";
    }
  }

  /// <summary>
  /// Specify the localization resource information for the description.
  /// Use the format: resourceBaseName,Description.
  /// </summary>
  public override string DescriptionResource
  {
    get
    {
      return "GetProcPSSnapIn01,This is a PowerShell snap-in that includes the get-proc cmdlet.";
    }
  }
}
```

## See Also

[How to Register Cmdlets, Providers, and Host Applications](/previous-versions/ms714644(v=vs.85))

[Windows PowerShell Shell SDK](../windows-powershell-reference.md)

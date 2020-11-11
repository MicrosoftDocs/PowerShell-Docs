---
ms.date: 09/13/2016
ms.topic: reference
title: Writing a Custom Windows PowerShell Snap-in
description: Writing a Custom Windows PowerShell Snap-in
---
# Writing a Custom Windows PowerShell Snap-in

This example shows how to write a Windows PowerShell snap-in that registers specific cmdlets.

With this type of snap-in, you specify which cmdlets, providers, types, or formats to register. For
more information about how to write a snap-in that registers all the cmdlets and providers in an
assembly, see [Writing a Windows PowerShell Snap-in](./writing-a-windows-powershell-snap-in.md).

## To write a Windows PowerShell Snap-in that registers specific cmdlets.

1. Add the RunInstallerAttribute attribute.
2. Create a public class that derives from the
   [System.Management.Automation.Custompssnapin](/dotnet/api/System.Management.Automation.CustomPSSnapIn)
   class.

   In this example, the class name is "CustomPSSnapinTest".

3. Add a public property for the name of the snap-in (required). When naming snap-ins, do not use
   any of the following characters: `#`, `.`, `,`, `(`, `)`, `{`, `}`, `[`, `]`, `&`, `-`, `/`, `\`,
   `$`, `;`, `:`, `"`, `'`, `<`, `>`, `|`, `?`, `@`, `` ` ``, `*`

   In this example, the name of the snap-in is "CustomPSSnapInTest".

4. Add a public property for the vendor of the snap-in (required).

   In this example, the vendor is "Microsoft".

5. Add a public property for the vendor resource of the snap-in (optional).

   In this example, the vendor resource is "CustomPSSnapInTest,Microsoft".

6. Add a public property for the description of the snap-in (required).

   In this example, the description is: "This is a custom Windows PowerShell snap-in that includes
   the `Test-HelloWorld` and `Test-CustomSnapinTest` cmdlets".

7. Add a public property for the description resource of the snap-in (optional).

   In this example, the vendor resource is:

   > CustomPSSnapInTest, This is a custom Windows PowerShell snap-in that includes the
   > Test-HelloWorld and Test-CustomSnapinTest cmdlets".

8. Specify the cmdlets that belong to the custom snap-in (optional) using the
   [System.Management.Automation.Runspaces.Cmdletconfigurationentry](/dotnet/api/System.Management.Automation.Runspaces.CmdletConfigurationEntry)
   class. The information added here includes the name of the cmdlet, its .NET type, and the cmdlet
   Help file name (the format of the cmdlet Help file name should be `name.dll-help.xml`).

   This example adds the Test-HelloWorld and TestCustomSnapinTest cmdlets.

9. Specify the providers that belong to the custom snap-in (optional).

   This example does not specify any providers.

10. Specify the types that belong to the custom snap-in (optional).

    This example does not specify any types.

11. Specify the formats that belong to the custom snap-in (optional).

    This example does not specify any formats.

## Example

This example shows how to write a Custom Windows PowerShell snap-in that can be used to register the
`Test-HelloWorld` and `Test-CustomSnapinTest` cmdlets. Be aware that in this example, the complete
assembly could contain other cmdlets and providers that would not be registered by this snap-in.

```csharp
[RunInstaller(true)]
public class CustomPSSnapinTest : CustomPSSnapIn
{
  /// <summary>
  /// Creates an instance of CustomPSSnapInTest class.
  /// </summary>
  public CustomPSSnapinTest()
          : base()
  {
  }

  /// <summary>
  /// Specify the name of the custom PowerShell snap-in.
  /// </summary>
  public override string Name
  {
    get
    {
      return "CustomPSSnapInTest";
    }
  }

  /// <summary>
  /// Specify the vendor for the custom PowerShell snap-in.
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
  /// Use the format: resourceBaseName,resourceName.
  /// </summary>
  public override string VendorResource
  {
    get
    {
        return "CustomPSSnapInTest,Microsoft";
    }
  }

  /// <summary>
  /// Specify a description of the custom PowerShell snap-in.
  /// </summary>
  public override string Description
  {
    get
    {
      return "This is a custom PowerShell snap-in that includes the Test-HelloWorld and Test-CustomSnapinTest cmdlets.";
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
        return "CustomPSSnapInTest,This is a custom PowerShell snap-in that includes the Test-HelloWorld and Test-CustomSnapinTest cmdlets.";
    }
  }

  /// <summary>
  /// Specify the cmdlets that belong to this custom PowerShell snap-in.
  /// </summary>
  private Collection<CmdletConfigurationEntry> _cmdlets;
  public override Collection<CmdletConfigurationEntry> Cmdlets
  {
    get
    {
      if (_cmdlets == null)
      {
        _cmdlets = new Collection<CmdletConfigurationEntry>();
        _cmdlets.Add(new CmdletConfigurationEntry("test-customsnapintest", typeof(TestCustomSnapinTest), "TestCmdletHelp.dll-help.xml"));
        _cmdlets.Add(new CmdletConfigurationEntry("test-helloworld", typeof(TestHelloWorld), "HelloWorldHelp.dll-help.xml"));
      }

      return _cmdlets;
    }
  }

  /// <summary>
  /// Specify the providers that belong to this custom PowerShell snap-in.
  /// </summary>
  private Collection<ProviderConfigurationEntry> _providers;
  public override Collection<ProviderConfigurationEntry> Providers
  {
    get
    {
      if (_providers == null)
      {
        _providers = new Collection<ProviderConfigurationEntry>();
      }

      return _providers;
    }
  }

  /// <summary>
  /// Specify the types that belong to this custom PowerShell snap-in.
  /// </summary>
  private Collection<TypeConfigurationEntry> _types;
  public override Collection<TypeConfigurationEntry> Types
  {
    get
    {
      if (_types == null)
      {
        _types = new Collection<TypeConfigurationEntry>();
      }

      return _types;
    }
  }

  /// <summary>
  /// Specify the formats that belong to this custom PowerShell snap-in.
  /// </summary>
  private Collection<FormatConfigurationEntry> _formats;
  public override Collection<FormatConfigurationEntry> Formats
  {
    get
    {
      if (_formats == null)
      {
        _formats = new Collection<FormatConfigurationEntry>();
      }

      return _formats;
    }
  }
}
```

For more information about registering snap-ins, see
[How to Register Cmdlets, Providers, and Host Applications](/previous-versions/ms714644(v=vs.85))
in the
[Windows PowerShell Programmer's Guide](../prog-guide/windows-powershell-programmer-s-guide.md).

## See Also

[How to Register Cmdlets, Providers, and Host Applications](/previous-versions/ms714644(v=vs.85))

[Windows PowerShell Shell SDK](../windows-powershell-reference.md)

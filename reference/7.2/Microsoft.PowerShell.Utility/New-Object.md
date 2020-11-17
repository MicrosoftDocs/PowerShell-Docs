---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 04/08/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/new-object?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: New-Object
---
# New-Object

## SYNOPSIS
Creates an instance of a Microsoft .NET Framework or COM object.

## SYNTAX

### Net (Default)

```
New-Object [-TypeName] <String> [[-ArgumentList] <Object[]>] [-Property <IDictionary>] [<CommonParameters>]
```

### Com

```
New-Object [-ComObject] <String> [-Strict] [-Property <IDictionary>] [<CommonParameters>]
```

## DESCRIPTION

The `New-Object` cmdlet creates an instance of a .NET Framework or COM object.

You can specify either the type of a .NET Framework class or a ProgID of a COM object. By default,
you type the fully qualified name of a .NET Framework class and the cmdlet returns a reference to an
instance of that class. To create an instance of a COM object, use the **ComObject** parameter and
specify the ProgID of the object as its value.

## EXAMPLES

### Example 1: Create a System.Version object

This example creates a **System.Version** object using the "1.2.3.4" string as the constructor.

```powershell
New-Object -TypeName System.Version -ArgumentList "1.2.3.4"
```

```Output
Major  Minor  Build  Revision
-----  -----  -----  --------
1      2      3      4
```

### Example 2: Create an Internet Explorer COM object

This example creates two instances of the COM object that represents the Internet Explorer
application. The first instance uses the **Property** parameter hash table to call the **Navigate2**
method and set the **Visible** property of the object to `$True` to make the application visible.
The second instance gets the same results with individual commands.

```powershell
$IE1 = New-Object -COMObject InternetExplorer.Application -Property @{Navigate2="www.microsoft.com"; Visible = $True}

# The following command gets the same results as the example above.
$IE2 = New-Object -COMObject InternetExplorer.Application`
$IE2.Navigate2("www.microsoft.com")`
$IE2.Visible = $True`
```

### Example 3: Use the Strict parameter to generate a non-terminating error

This example demonstrates that adding the **Strict** parameter causes the `New-Object` cmdlet to
generate a non-terminating error when the COM object uses an interop assembly.

```powershell
$A = New-Object -COMObject Word.Application -Strict -Property @{Visible = $True}
```

```Output
New-Object : The object written to the pipeline is an instance of the type
"Microsoft.Office.Interop.Word.ApplicationClass" from the component's primary interop assembly. If
this type exposes different members than the IDispatch members, scripts written to work with this
object might not work if the primary interop assembly is not installed.

At line:1 char:14
+ $A = New-Object  <<<< -COM Word.Application -Strict; $a.visible=$true
```

### Example 4: Create a COM object to manage Windows desktop

This example shows how to create and use a COM object to manage your Windows desktop.

The first command uses the **ComObject** parameter of the `New-Object` cmdlet to create a COM object
with the **Shell.Application** ProgID. It stores the resulting object in the `$ObjShell` variable. The
second command pipes the `$ObjShell` variable to the `Get-Member` cmdlet, which displays the
properties and methods of the COM object. Among the methods is the **ToggleDesktop** method. The
third command calls the **ToggleDesktop** method of the object to minimize the open windows on your
desktop.

```powershell
$Objshell = New-Object -COMObject "Shell.Application"
$objshell | Get-Member
$objshell.ToggleDesktop()
```

```Output
   TypeName: System.__ComObject#{866738b9-6cf2-4de8-8767-f794ebe74f4e}

Name                 MemberType Definition
----                 ---------- ----------
AddToRecent          Method     void AddToRecent (Variant, string)
BrowseForFolder      Method     Folder BrowseForFolder (int, string, int, Variant)
CanStartStopService  Method     Variant CanStartStopService (string)
CascadeWindows       Method     void CascadeWindows ()
ControlPanelItem     Method     void ControlPanelItem (string)
EjectPC              Method     void EjectPC ()
Explore              Method     void Explore (Variant)
ExplorerPolicy       Method     Variant ExplorerPolicy (string)
FileRun              Method     void FileRun ()
FindComputer         Method     void FindComputer ()
FindFiles            Method     void FindFiles ()
FindPrinter          Method     void FindPrinter (string, string, string)
GetSetting           Method     bool GetSetting (int)
GetSystemInformation Method     Variant GetSystemInformation (string)
Help                 Method     void Help ()
IsRestricted         Method     int IsRestricted (string, string)
IsServiceRunning     Method     Variant IsServiceRunning (string)
MinimizeAll          Method     void MinimizeAll ()
NameSpace            Method     Folder NameSpace (Variant)
Open                 Method     void Open (Variant)
RefreshMenu          Method     void RefreshMenu ()
ServiceStart         Method     Variant ServiceStart (string, Variant)
ServiceStop          Method     Variant ServiceStop (string, Variant)
SetTime              Method     void SetTime ()
ShellExecute         Method     void ShellExecute (string, Variant, Variant, Variant, Variant)
ShowBrowserBar       Method     Variant ShowBrowserBar (string, Variant)
ShutdownWindows      Method     void ShutdownWindows ()
Suspend              Method     void Suspend ()
TileHorizontally     Method     void TileHorizontally ()
TileVertically       Method     void TileVertically ()
ToggleDesktop        Method     void ToggleDesktop ()
TrayProperties       Method     void TrayProperties ()
UndoMinimizeALL      Method     void UndoMinimizeALL ()
Windows              Method     IDispatch Windows ()
WindowsSecurity      Method     void WindowsSecurity ()
WindowSwitcher       Method     void WindowSwitcher ()
Application          Property   IDispatch Application () {get}
Parent               Property   IDispatch Parent () {get}
```

### Example 5: Pass multiple arguments to a constructor

This example shows how to create an object with a constructor that takes multiple parameters. The
parameters must be put in an array when using **ArgumentList** parameter.

```powershell
$array = @('One', 'Two', 'Three')
$parameters = @{
    TypeName = 'System.Collections.Generic.HashSet[string]'
    ArgumentList = ([string[]]$array, [System.StringComparer]::OrdinalIgnoreCase)
}
$set = New-Object @parameters
```

PowerShell binds each member of the array to a parameter of the constructor.

> [!NOTE]
> This example uses parameter splatting for readability. For more information, see
> [about_Splatting](../Microsoft.PowerShell.Core/About/about_Splatting.md).

### Example 6: Calling a constructor that takes an array as a single parameter

This example shows how to create an object with a constructor that takes a parameter that is an
array or collection. The array parameter must be put in wrapped inside another array.

```powershell
$array = @('One', 'Two', 'Three')
# This command throws an exception.
$set = New-Object -TypeName 'System.Collections.Generic.HashSet[string]' -ArgumentList $array
# This command succeeds.
$set = New-Object -TypeName 'System.Collections.Generic.HashSet[string]' -ArgumentList (,[string[]]$array)
$set
```

```Output
New-Object : Cannot find an overload for "HashSet`1" and the argument count: "3".
At line:1 char:8
+ $set = New-Object -TypeName 'System.Collections.Generic.HashSet[strin ...
+        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo          : InvalidOperation: (:) [New-Object], MethodException
+ FullyQualifiedErrorId : ConstructorInvokedThrowException,Microsoft.PowerShell.Commands.NewObjectCommand

One
Two
Three
```

The first attempt to create the object in this example fails. PowerShell attempted to bind the three
members of `$array` to parameters of the constructor but the constructor does not take three
parameter. Wrapping `$array` in another array prevents PowerShell from attempting to bind the three
members of `$array` to parameters of the constructor.

## PARAMETERS

### -ArgumentList

Specifies an array of arguments to pass to the constructor of the .NET Framework class. If the
constructor takes a single parameter that is an array, you must wrap that parameter inside another
array. For example:

`$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate -ArgumentList (,$bytes)`

For more information about the behavior of **ArgumentList**, see [about_Splatting](../Microsoft.PowerShell.Core/About/about_Splatting.md#splatting-with-arrays).

The alias for **ArgumentList** is **Args**.

```yaml
Type: System.Object[]
Parameter Sets: Net
Aliases: Args

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComObject

Specifies the programmatic identifier (ProgID) of the COM object.

```yaml
Type: System.String
Parameter Sets: Com
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Property

Sets property values and invokes methods of the new object.

Enter a hash table in which the keys are the names of properties or methods and the values are
property values or method arguments. `New-Object` creates the object and sets each property value
and invokes each method in the order that they appear in the hash table.

If the new object is derived from the **PSObject** class, and you specify a property that does not
exist on the object, `New-Object` adds the specified property to the object as a NoteProperty. If
the object is not a **PSObject**, the command generates a non-terminating error.

```yaml
Type: System.Collections.IDictionary
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Strict

Indicates that the cmdlet generates a non-terminating error when a COM object that you attempt to
create uses an interop assembly. This feature distinguishes actual COM objects from .NET Framework
objects with COM-callable wrappers.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Com
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TypeName

Specifies the fully qualified name of the .NET Framework class. You cannot specify both the
**TypeName** parameter and the **ComObject** parameter.

```yaml
Type: System.String
Parameter Sets: Net
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe input to this cmdlet.

## OUTPUTS

### Object

`New-Object` returns the object that is created.

## NOTES

- `New-Object` provides the most commonly-used functionality of the VBScript CreateObject
  function. A statement like `Set objShell = CreateObject("Shell.Application")` in VBScript can be
  translated to `$objShell = New-Object -COMObject "Shell.Application"` in PowerShell.
- `New-Object` expands upon the functionality available in the Windows Script Host environment by
  making it easy to work with .NET Framework objects from the command line and within scripts.

## RELATED LINKS

[about_Object_Creation](../Microsoft.PowerShell.Core/About/about_Object_Creation.md)

[Compare-Object](Compare-Object.md)

[Group-Object](Group-Object.md)

[Measure-Object](Measure-Object.md)

[Select-Object](Select-Object.md)

[Sort-Object](Sort-Object.md)

[Tee-Object](Tee-Object.md)


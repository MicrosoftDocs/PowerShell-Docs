---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293993
schema: 2.0.0
---

# New-Object
## SYNOPSIS
Creates an instance of a Microsoft .NET Framework or COM object.

## SYNTAX

### Net (Default)
```
New-Object [-TypeName] <String> [[-ArgumentList] <Object[]>] [-Property <IDictionary>]
 [-InformationAction <ActionPreference>] [-InformationVariable <String>]
```

### Com
```
New-Object [-ComObject] <String> [-Strict] [-Property <IDictionary>] [-InformationAction <ActionPreference>]
 [-InformationVariable <String>]
```

## DESCRIPTION
The New-Object cmdlet creates an instance of a .NET Framework or COM object.

You can specify either the type of a .NET Framework class or a ProgID of a COM object.
By default, you type the fully qualified name of a .NET Framework class and the cmdlet returns a reference to an instance of that class.
To create an instance of a COM object, use the ComObject parameter and specify the ProgID of the object as its value.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>New-Object -TypeName System.Version -ArgumentList "1.2.3.4"
Major  Minor  Build  Revision

-----  -----  -----  --------

1      2      3      4
```

This command creates a System.Version object.
It uses a "1.2.3.4" string as the constructor.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>$ie = New-Object -COMObject InternetExplorer.Application -Property @{Navigate2="www.microsoft.com"; Visible = $true}
```

This command creates an instance of the COM object that represents the Internet Explorer application.
The value of the Property parameter is a hash table that calls the Navigate2 method and sets the Visible property of the object to $true to make the application visible.

This command is the equivalent of the following:

$ie = New-Object -COMObject InternetExplorer.Application

$ie.Navigate2("www.microsoft.com")

$ie.Visible = $true

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>$a=New-Object -COMObject Word.Application -Strict -Property @{Visible=$true}
New-Object : The object written to the pipeline is an instance of the type
"Microsoft.Office.Interop.Word.ApplicationClass" from the component's primary
interop assembly. If this type exposes different members than the IDispatch
members, scripts written to work with this object might not work if the
primary interop assembly is not installed.

At line:1 char:14
+ $a=New-Object  <<<< -COM Word.Application -Strict; $a.visible=$true
```

This example demonstrates that adding the Strict parameter causes the New-Object cmdlet to generate a non-terminating error when the COM object uses an interop assembly.

### -------------------------- EXAMPLE 4 --------------------------
```
The first command uses the ComObject parameter of the New-Object cmdlet to create a COM object with the "Shell.Application" ProgID. It stores the resulting object in the $objShell variable.
PS C:\>$objshell = New-Object -COMObject "Shell.Application"

The second command pipes the $objShell variable to the Get-Member cmdlet, which displays the properties and methods of the COM object. Among the methods is the ToggleDesktop method.
PS C:\>$objshell | Get-Member
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

The third command calls the ToggleDesktop method of the object to minimize the open windows on your desktop.
PS C:\>$objshell.ToggleDesktop()
```

This example shows how to create and use a COM object to manage your Windows desktop.

## PARAMETERS

### -ArgumentList
Specifies a list of arguments to pass to the constructor of the .NET Framework class.
Separate elements in the list by using commas (,).
The alias for ArgumentList is Args.

```yaml
Type: Object[]
Parameter Sets: Net
Aliases: Args

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComObject
Specifies the programmatic identifier (ProgID) of the COM object.

```yaml
Type: String
Parameter Sets: Com
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationAction
@{Text=}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa
Accepted values: SilentlyContinue, Stop, Continue, Inquire, Ignore, Suspend

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
@{Text=}

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Property
Sets property values and invokes methods of the new object.

Enter a hash table in which the keys are the names of properties or methods and the values are property values or method arguments.
New-Object creates the object and sets each property value and invokes each method in the order that they appear in the hash table.

If the new object is derived from the PSObject class, and you specify a property that does not exist on the object, New-Object adds the specified property to the object as a NoteProperty.
If the object is not a PSObject, the command generates a non-terminating error.

```yaml
Type: IDictionary
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Strict
Generates a non-terminating error when a COM object that you attempt to create uses an interop assembly.
This feature distinguishes actual COM objects from .NET Framework objects with COM-callable wrappers.

```yaml
Type: SwitchParameter
Parameter Sets: Com
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TypeName
Specifies the fully qualified name of the .NET Framework class.
You cannot specify both the TypeName parameter and the ComObject parameter.

```yaml
Type: String
Parameter Sets: Net
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### Object
New-Object returns the object that is created.

## NOTES
New-Object provides the most commonly-used functionality of the VBScript CreateObject function.
A statement like Set objShell = CreateObject("Shell.Application") in VBScript can be translated to $objShell = New-Object -COMObject "Shell.Application" in Windows PowerShell.

New-Object expands upon the functionality available in the Windows Script Host environment by making it easy to work with .NET Framework objects from the command line and within scripts.

## RELATED LINKS

[Compare-Object]()

[ForEach-Object]()

[Group-Object]()

[Measure-Object]()

[Select-Object]()

[Sort-Object]()

[Tee-Object]()

[Where-Object]()


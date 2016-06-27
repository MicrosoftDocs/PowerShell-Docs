---
title: about_Properties
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 32679074-829f-4890-bf71-059f966dc8a1
---
# about_Properties
## TOPIC  
 about\_Properties  
  
## SHORT DESCRIPTION  
 Describes how to use object properties in [!INCLUDE[wps_1]()].  
  
## LONG DESCRIPTION  
 [!INCLUDE[wps_2]()] uses structured collections of information called objects to represent the items in data stores or the state of the computer. Typically, you work with object that are part of the Microsoft .NET Framework, but you can also create custom objects in [!INCLUDE[wps_2]()].  
  
 The association between an item and its object is very close. When you change an object, you usually change the item that it represents. For example, when you get a file in [!INCLUDE[wps_2]()], you do not get the actual file. Instead, you get a FileInfo object that represents the file. When you change the FileInfo object, the file changes too.  
  
 Most objects have properties. Properties are the data that is associated with an object. Different types of object have different properties. For example, a FileInfo object, which represents a file, has an IsReadOnly property that contains $True if the file the read\-only attribute and $False if it does not. A DirectoryInfo object, which represents a file system directory, has a Parent property that contains the path to the parent directory.  
  
### OBJECT PROPERTIES  
 To get the properties of an object, use the Get\-Member cmdlet. For example, to get the properties of a FileInfo object, use the Get\-ChildItem cmdlet to get the FileInfo object that represents a file. Then, use a pipeline operator \(&#124;\) to send the FileInfo object to Get\-Member. The following command gets the PowerShell.exe file and sends it to Get\-Member. The $Pshome automatic variable contains the path of the [!INCLUDE[wps_2]()] installation directory.  
  
```  
Get-ChildItem $pshome\PowerShell.exe | Get-Member  
  
```  
  
 The output of the command lists the members of the FileInfo object. Members include both properties and methods. When you work in [!INCLUDE[wps_2]()], you have access to all the members of the objects.  
  
 To get only the properties of an object and not the methods, use the MemberType parameter of the Get\-Member cmdlet with a value of "property", as shown in the following example.  
  
```  
Get-ChildItem $pshome\PowerShell.exe | Get-Member -MemberType property  
  
   TypeName: System.IO.FileInfo  
  
Name              MemberType Definition  
----              ---------- ----------  
Attributes        Property   System.IO.FileAttributes Attributes {get;set;}  
CreationTime      Property   System.DateTime CreationTime {get;set;}  
CreationTimeUtc   Property   System.DateTime CreationTimeUtc {get;set;}  
Directory         Property   System.IO.DirectoryInfo Directory {get;}  
DirectoryName     Property   System.String DirectoryName {get;}  
Exists            Property   System.Boolean Exists {get;}  
Extension         Property   System.String Extension {get;}  
FullName          Property   System.String FullName {get;}  
IsReadOnly        Property   System.Boolean IsReadOnly {get;set;}  
LastAccessTime    Property   System.DateTime LastAccessTime {get;set;}  
LastAccessTimeUtc Property   System.DateTime LastAccessTimeUtc {get;set;}  
LastWriteTime     Property   System.DateTime LastWriteTime {get;set;}  
LastWriteTimeUtc  Property   System.DateTime LastWriteTimeUtc {get;set;}  
Length            Property   System.Int64 Length {get;}  
Name              Property   System.String Name {get;}  
  
```  
  
 After you find the properties, you can use them in your [!INCLUDE[wps_2]()] commands.  
  
## PROPERTY VALUES  
 Although every object of a specific type has the same properties, the values of those properties describe the particular object. For example, every FileInfo object has a CreationTime property, but the value of that property differs for each file.  
  
 The most common way to get the values of the properties of an object is to use the dot method. Type a reference to the object, such as a variable that contains the object, or a command that gets the object. Then, type a dot \(.\) followed by the property name.  
  
 For example, the following command displays the value of the CreationTime property of the PowerShell.exe file. The Get\-ChildItem command returns a FileInfo object that represents the PowerShell.exe file. The command is enclosed in parentheses to make sure that it is executed before any properties are accessed. The Get\-ChildItem command is followed by a dot and the name of the CreationTime property, as follows:  
  
```  
C:\PS> (Get-ChildItem $pshome\PowerShell.exe).creationtime  
Tuesday, March 18, 2008 12:07:52 AM  
  
```  
  
 You can also save an object in a variable and then get its properties by using the dot method, as shown in the following example:  
  
```  
C:\PS> $a = Get-ChildItem $pshome\PowerShell.exe  
C:\PS> $a.CreationTime  
Tuesday, March 18, 2008 12:07:52 AM  
  
```  
  
 You can also use the Select\-Object and Format\-List cmdlets to display the property values of an object. Select\-Object and Format\-List each have a Property parameter. You can use the Property parameter to specify one or more properties and their values. Or, you can use the wildcard character \(\*\) to represent all the properties.  
  
 For example, the following command displays the values of all the properties of the PowerShell.exe file.  
  
```  
C:\PS> Get-ChildItem $pshome\PowerShell.exe | Format-List -property *  
  
PSPath            : Microsoft.PowerShell.Core\FileSystem::C:\Windows\system32\WindowsPowerShell\v1.0\PowerShell.exe  
PSParentPath      : Microsoft.PowerShell.Core\FileSystem::C:\Windows\system32\WindowsPowerShell\v1.0  
PSChildName       : PowerShell.exe  
PSDrive           : C  
PSProvider        : Microsoft.PowerShell.Core\FileSystem  
PSIsContainer     : False  
VersionInfo       : File:             C:\Windows\system32\WindowsPowerShell\v1.0\PowerShell.exe  
                    InternalName:     POWERSHELL  
                    OriginalFilename: PowerShell.EXE.MUI  
                    File Version:      6.1.6570.1 (fbl_srv_PowerShell(nigels).070711-0102)  
                    FileDescription:  PowerShell.EXE  
                    Product:          Microsoft® Windows® Operating System  
                    ProductVersion:   6.1.6570.1  
                    Debug:            False  
                    Patched:          False  
                    PreRelease:       False  
                    PrivateBuild:     True  
                    SpecialBuild:     False  
                    Language:         English (United States)  
  
BaseName          : PowerShell  
Mode              : -a---  
Name              : PowerShell.exe  
Length            : 160256  
DirectoryName     : C:\Windows\system32\WindowsPowerShell\v1.0  
Directory         : C:\Windows\system32\WindowsPowerShell\v1.0  
IsReadOnly        : False  
Exists            : True  
FullName          : C:\Windows\system32\WindowsPowerShell\v1.0\PowerShell.exe  
Extension         : .exe  
CreationTime      : 3/18/2008 12:07:52 AM  
CreationTimeUtc   : 3/18/2008 7:07:52 AM  
LastAccessTime    : 3/19/2008 8:13:58 AM  
LastAccessTimeUtc : 3/19/2008 3:13:58 PM  
LastWriteTime     : 3/18/2008 12:07:52 AM  
LastWriteTimeUtc  : 3/18/2008 7:07:52 AM  
Attributes        : Archive  
  
```  
  
### STATIC PROPERTIES  
 You can use the static properties of .NET classes in [!INCLUDE[wps_2]()]. Static properties are properties of class, unlike standard properties, which are properties of an object.  
  
 To get the static properties of an class, use the Static parameter of the Get\-Member cmdlet.  
  
 For example, the following command gets the static properties of the System.DateTime class.  
  
```  
Get-Date | Get-Member -MemberType Property -Static  
  
   TypeName: System.DateTime  
  
Name     MemberType Definition  
----     ---------- ----------  
MaxValue Property   static datetime MaxValue {get;}  
MinValue Property   static datetime MinValue {get;}  
Now      Property   datetime Now {get;}  
Today    Property   datetime Today {get;}  
UtcNow   Property   datetime UtcNow {get;}  
  
```  
  
 To get the value of a static property, use the following syntax.  
  
```  
[<ClassName>]::<Property>  
  
```  
  
 For example, the following command gets the value of the UtcNow static property of the System.DateTime class.  
  
```  
[System.DateTime]::UtcNow  
  
```  
  
### PROPERTIES OF SCALAR OBJECTS AND COLLECTIONS  
 The properties of one \("scalar"\) object of a particular type are often different from the properties of a collection of objects of the same type.  
  
 For example, every service has as DisplayName property, but a collection of services does not have a DisplayName property.  Similarly, all collections have a Count property that tells how many objects are in the collection, but individual objects do not have a Count property.  
  
 Beginning in [!INCLUDE[wps_2]()] 3.0, [!INCLUDE[wps_2]()] tries to prevent scripting errors that result from the differing properties of scalar objects and collections.  
  
 \-\-  If you submit a collection, but request a property that exists only on single \("scalar"\) objects, [!INCLUDE[wps_2]()] returns the value of that property for every object in the collection.  
  
 \-\-  If you request the Count or Length property of zero objects or of one object, [!INCLUDE[wps_2]()] returns the correct value.  
  
 If the property exists on the individual objects and on the collection, [!INCLUDE[wps_2]()] does not alter the result.  
  
 This feature also works on methods of scalar objects and collections. For more information, see about\_Methods.  
  
 EXAMPLES  
  
 For example, each service has a DisplayName property. The following command gets the value of the DisplayName property of the Audiosrv service.  
  
```  
PS C:\>(Get-Service Audiosrv).DisplayName  
Windows Audio  
  
```  
  
 However, a collection or array of services does not have a DisplayName. The following command tries to get the DisplayName property of all services in [!INCLUDE[wps_2]()] 2.0.  
  
```  
PS C:\>(Get-Service).DisplayName  
PS C:\>  
  
```  
  
 Beginning in [!INCLUDE[wps_2]()] 3.0, the same command returns the value of the DisplayName property of every service that Get\-Service returns.  
  
```  
PS C:\>(Get-Service).DisplayName  
Application Experience  
Application Layer Gateway Service  
Windows All-User Install Agent  
Application Identity  
Application Information  
...  
  
```  
  
 Conversely, a collection of two or more services has a Count property, which contains the number of objects in the collection.  
  
```  
PS C:\>(Get-Service).Count  
176  
  
```  
  
 Individual services do not have a Count or Length property, as shown in this command in [!INCLUDE[wps_2]()] 2.0.  
  
```  
PS C:\>(Get-Service Audiosrv).Count  
PS C:\>  
  
```  
  
 Beginning in [!INCLUDE[wps_2]()] 3.0, the command returns the correct Count value.  
  
```  
PS C:\>(Get-Service Audiosrv).Count  
1  
  
```  
  
## SEE ALSO  
 about\_Methods  
  
 about\_Objects  
  
 Get\-Member  
  
 Select\-Object  
  
 Format\-List
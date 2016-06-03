---
title: about_Aliases
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 638c1890-4425-4a3e-8432-09015672f234
---
# about_Aliases
```  
TOPIC  
    about_aliases  
  
SHORT DESCRIPTION  
    Describes how to use alternate names for cmdlets and commands in Windows  
    PowerShell.   
  
LONG DESCRIPTION  
    An alias is an alternate name or nickname for a cmdlet or for a command  
    element, such as a function, script, file, or executable file. You  
    can use the alias instead of the command name in any Windows PowerShell  
    commands.  
  
    To create an alias, use the New-Alias cmdlet. For example, the following  
    command creates the "gas" alias for the Get-AuthenticodeSignature cmdlet:  
  
        New-Alias -Name gas -Value Get-AuthenticodeSignature  
  
    After you create the alias for the cmdlet name, you can use the alias   
    instead of the cmdlet name. For example, to get the Authenticode signature  
    for the SqlScript.ps1 file, type:  
  
        Get-AuthenticodeSignature SqlScript.ps1  
  
    Or, type:  
  
        gas SqlScript.ps1  
  
    If you create "word" as the alias for Microsoft Office Word, you can type  
    "word" instead of the following:  
  
        "C:\Program Files\Microsoft Office\Office11\Winword.exe"   
  
BUILT-IN ALIASES  
    Windows PowerShell includes a set of built-in aliases, including "cd" and  
    "chdir" for the Set-Location cmdlet, and "ls" and "dir" for the  
    Get-ChildItem cmdlet.   
  
    To get all the aliases on the computer, including the built-in aliases,  
    type:  
  
        Get-Alias  
  
ALIAS CMDLETS  
    Windows PowerShell includes the following cmdlets, which are designed for  
    working with aliases:   
  
        - Get-Alias. Gets all the aliases in the current session.  
        - New-Alias. Creates a new alias.  
        - Set-Alias. Creates or changes an alias.  
        - Export-Alias. Exports one or more aliases to a file.  
        - Import-Alias. Imports an alias file into Windows PowerShell.   
  
    For detailed information about the cmdlets, type:  
  
Get-Help <cmdlet-Name> -Detailed  
  
    For example, type:  
  
Get-Help Export-Alias -Detailed  
  
CREATING AN ALIAS  
    To create a new alias, use the New-Alias cmdlet. For example, to create the  
    "gh" alias for Get-Help, type:  
  
New-Alias -Name gh -Value Get-Help  
  
    You can use the alias in commands, just as you would use the full cmdlet  
    name, and you can use the alias with parameters.  
  
    For example, to get detailed Help for the Get-WmiObject cmdlet, type:  
  
Get-Help Get-WmiObject -Detailed  
  
    Or, type:  
  
gh Get-WmiObject -Detailed  
  
SAVING ALIASES  
    The aliases that you create are saved only in the current session. To use  
    the aliases in a different session, add the alias to your Windows   
    PowerShell profile. Or, use the Export-Alias cmdlet to save the aliases to  
    a file.   
  
    For more information, type:  
  
        Get-Help about_Profiles  
  
GETTING ALIASES  
    To get all the aliases in the current session, including the built-in  
    aliases, the aliases in your Windows PowerShell profiles, and the aliases  
    that you have created in the current session, type:  
  
Get-Alias  
  
    To get particular aliases, use the Name parameter of the Get-Alias cmdlet.  
    For example, to get aliases that begin with "p", type:  
  
Get-Alias -Name p*  
  
    To get the aliases for a particular item, use the Definition parameter.  
    For example, to get the aliases for the Get-ChildItem cmdlet type:  
  
Get-Alias -Definition Get-ChildItem  
  
 GET-ALIAS OUTPUT  
  
     Get-Alias returns only one type of object, an AliasInfo object   
     (System.Management.Automation.AliasInfo). However, beginning in  
     Windows PowerShell 3.0, the name of aliases that don't include a  
     hyphen, such as "cd" are displayed in the following format:  
  
         <alias> -> <definition>  
  
     For example,  
  
         ac -> Add-Content    
  
     This makes it very quick and easy to get the information that you  
     need.   
  
     The arrow-based alias name format is not used for aliases that  
     include a hyphen. These are likely to be preferred substitute   
     names for cmdlets and functions, instead of typical abbreviations  
     or nicknames, and the author might not want them to be as evident.  
  
ALTERNATE NAMES FOR COMMANDS WITH PARAMETERS  
    You can assign an alias to a cmdlet, script, function, or executable file.  
    However, you cannot assign an alias to a command and its parameters.  
    For example, you can assign an alias to the Get-Eventlog cmdlet, but you  
    cannot assign an alias to the "Get-Eventlog -LogName System" command.  
  
    However, you can create a function that includes the command. To create a  
    function, type the word "function" followed by a name for the function.  
    Type the command, and enclose it in braces ({}).  
  
    For example, the following command creates the syslog function. This  
    function represents the "Get-Eventlog -LogName System" command:  
  
function syslog {Get-Eventlog -LogName System}  
  
    You can now type "syslog" instead of the command. And, you can create  
    aliases for the syslog function.  
  
    For more information about functions, type:  
  
Get-Help about_Functions  
  
ALIAS OBJECTS  
     Windows PowerShell aliases are represented by objects that are instances  
     of the System.Management.Automation.AliasInfo class. For more information  
     about this type of object, see "AliasInfo Class" in the Microsoft   
     Developer Network (MSDN) library at   
     http://go.microsoft.com/fwlink/?LinkId=143644.  
  
     To view the properties and methods of the alias objects, get the  
     aliases. Then, pipe them to the Get-Member cmdlet. For example:  
  
Get-Alias | Get-Member  
  
     To view the values of the properties of a specific alias, such as the   
     "dir" alias, get the alias. Then, pipe it to the Format-List cmdlet. For  
     example, the following command gets the "dir" alias. Next, the command  
     pipes the alias to the Format-List cmdlet. Then, the command uses the   
     Property parameter of Format-List with a wildcard character (*) to display  
     all the properties of the "dir" alias. The following command performs  
     these tasks:  
  
Get-Alias -Name dir | Format-List -Property *  
  
WINDOWS POWERSHELL ALIAS PROVIDER  
    Windows PowerShell includes the Alias provider. The Alias provider lets you  
    view the aliases in Windows PowerShell as though they were on a file system  
    drive.   
  
    The Alias provider exposes the Alias: drive. To go into the Alias: drive,  
    type:  
  
Set-Location Alias:  
  
    To view the contents of the drive, type:  
  
Get-ChildItem  
  
    To view the contents of the drive from another Windows PowerShell drive,  
    begin the path with the drive name. Include the colon (:). For example:  
  
Get-ChildItem -Path Alias:  
  
    To get information about a particular alias, type the drive name and  
    the alias name. Or, type a name pattern. For example, to get all the   
    aliases that begin with "p", type:  
  
Get-ChildItem -Path Alias:p*  
  
    For more information about the Windows PowerShell Alias provider,  
    type:  
  
Get-Help Alias  
  
SEE ALSO  
  
    New-Alias  
    Get-Alias  
    set-alias  
    export-alias  
    import-alias  
    get-psprovider  
    get-psdrive  
    about_functions  
    about_profiles  
    about_providers  
```
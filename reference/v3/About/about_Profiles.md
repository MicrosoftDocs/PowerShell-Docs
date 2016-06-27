---
title: about_Profiles
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e1d9e30a-70cc-4f36-949f-fc7cd96b4054
---
# about_Profiles
```  
TOPIC  
    about_Profiles  
  
SHORT DESCRIPTION  
    Describes how to create and use a Windows PowerShell profile.  
  
LONG DESCRIPTION  
    You can create a Windows PowerShell profile to customize your environment  
    and to add session-specific elements to every Windows PowerShell session  
    that you start.   
  
    A Windows PowerShell profile is a script that runs when Windows PowerShell   
    starts. You can use the profile as a logon script to customize the   
    environment. You can add commands, aliases, functions, variables, snap-ins,   
    modules, and Windows PowerShell drives. You can also add other   
    session-specific elements to your profile so they are available in every  
    session without having to import or re-create them.  
  
    Windows PowerShell supports several profiles for users and host programs.  
    However, it does not create the profiles for you. This topic describes the  
    profiles, and it describes how to create and maintain profiles on your   
    computer.  
  
    It explains how to use the NoProfile parameter of the Windows PowerShell   
    console (PowerShell.exe) to start Windows PowerShell without any profiles.  
    And, it explains the effect of the Windows PowerShell execution policy on  
    profiles.  
  
 THE PROFILE FILES  
  
    Windows PowerShell supports several profile files. Also, Windows PowerShell  
    host programs can support their own host-specific profiles.   
  
    For example, the Windows PowerShell console supports the following basic   
    profile files. The profiles are listed in precedence order. The first   
    profile has the highest precedence.  
  
        Description                Path  
        -----------                ----  
        Current User, Current Host $Home\[My ]Documents\WindowsPowerShell\Profile.ps1  
        Current User, All Hosts    $Home\[My ]Documents\Profile.ps1  
        All Users, Current Host    $PsHome\Microsoft.PowerShell_profile.ps1  
        All Users, All Hosts       $PsHome\Profile.ps1  
  
    The profile paths include the following variables:  
  
        - The $PsHome variable, which stores the installation directory for  
          Windows PowerShell.  
  
        - The $Home variable, which stores the current user's home directory.  
  
    In addition, other programs that host Windows PowerShell can support their  
    own profiles. For example, Windows PowerShell Integrated Scripting   
    Environment (ISE) supports the following host-specific profiles.  
  
        Description                Path  
        -----------                -----  
        Current user, Current Host $Home\[My ]Documents\WindowsPowerShell\Microsoft.PowerShellISE_profile.ps1  
        All users, Current Host    $PsHome\Microsoft.PowerShellISE_profile.ps1  
  
    In Windows PowerShell Help, the "CurrentUser, Current Host" profile is the profile most  
    often referred to as "your Windows PowerShell profile".  
  
 THE $PROFILE VARIABLE  
  
    The $Profile automatic variable stores the paths to the Windows PowerShell  
    profiles that are available in the current session.   
  
    To view a profile path, display the value of the $Profile variable. You can  
    also use the $Profile variable in a command to represent a path.  
  
    The $Profile variable stores the path to the "Current User,   
    Current Host" profile. The other profiles are saved in note properties of  
    the $profile variable.  
  
    For example, the $Profile variable has the following values in the Windows  
    PowerShell console.  
  
        Name                               Description                  
        -----------                        -----------  
        $Profile                           Current User,Current Host    
        $Profile.CurrentUserCurrentHost    Current User,Current Host    
        $Profile.CurrentUserAllHosts       Current User,All Hosts       
        $Profile.AllUsersCurrentHost       All Users, Current Host      
        $Profile.AllUsersAllHosts          All Users, All Hosts  
  
    Because the values of the $Profile variable change for each user and in  
    each host application, ensure that you display the values of the  
    profile variables in each Windows PowerShell host application that you use.  
  
    To see the current values of the $Profile variable, type:  
  
        $profile | get-member -type noteproperty  
  
    You can use the $Profile variable in many commands. For example, the  
    following command opens the "Current User, Current Host" profile in   
    Notepad:  
  
notepad $profile  
  
    The following command determines whether an "All Users, All Hosts" profile  
    has been created on the local computer:  
  
test-path $profile.AllUsersAllHosts  
  
 HOW TO CREATE A PROFILE  
  
    To create a Windows PowerShell profile, use the following command format:  
  
        if (!(test-path <profile-name>))   
           {new-item -type file -path <profile-name> -force}  
  
    For example, to create a profile for the current user in the current   
    Windows PowerShell host application, use the following command:   
  
        if (!(test-path $profile))   
           {new-item -type file -path $profile -force}  
  
    In this command, the If statement prevents you from overwriting an existing  
    profile. Replace the value of the <profile-path> placeholder with the path  
    to the profile file that you want to create.  
  
    Note: To create "All Users" profiles in Windows Vista and later versions   
          of Windows, start Windows PowerShell with the "Run as administrator"   
          option.  
  
 HOW TO EDIT A PROFILE  
  
    You can open any Windows PowerShell profile in a text editor, such as   
    Notepad.   
  
    To open the profile of the current user in the current Windows PowerShell  
    host application in Notepad, type:  
  
        notepad $profile  
  
    To open other profiles, specify the profile name. For example, to open the  
    profile for all the users of all the host applications, type:  
  
        notepad $profile.AllUsersAllHosts  
  
    To apply the changes, save the profile file, and then restart Windows   
    PowerShell.  
  
 HOW TO CHOOSE A PROFILE  
  
    If you use multiple host applications, put the items that you use in all  
    the host applications into your $Profile.CurrentUserAllHosts profile.  
    Put items that are specific to a host application, such as a command that   
    sets the background color for a host application, in a profile that is   
    specific to that host application.  
  
    If you are an administrator who is customizing Windows  
    PowerShell for many users, follow these guidelines:  
  
        -- Store the common items in the $profile.AllUsersAllHosts profile.  
  
        -- Store items that are specific to a host application in  
           $profile.AllUsersCurrentHost profiles that are specific to the host  
           application.  
  
        -- Store items for particular users in the user-specific profiles.  
  
    Be sure to check the host application documentation for any special  
    implementation of Windows PowerShell profiles.  
  
 HOW TO USE A PROFILE  
  
    Many of the items that you create in Windows PowerShell and most commands   
    that you run affect only the current session. When you end the session,   
    the items are deleted.  
  
    The session-specific commands and items include variables, preference   
    variables, aliases, functions, commands (except for Set-ExecutionPolicy),  
    and Windows PowerShell snap-ins that you add to the session.  
  
    To save these items and make them available in all future sessions, add  
    them to a Windows PowerShell profile.   
  
    Another common use for profiles is to save frequently-used functions,   
    aliases, and variables. When you save the items in a profile, you can  
    use them in any applicable session without re-creating them.  
  
 HOW TO START A PROFILE  
  
    When you open the profile file, it is blank. However, you can fill it with  
    the variables, aliases, and commands that you use frequently.  
  
    Here are a few suggestions to get you started.  
  
    -- Add commands that make it easy to open your profile. This is especially  
       useful if you use a profile other than the "Current User, Current Host"   
       profile. For example, add the following command:  
  
           function pro {notepad $profile.CurrentUserAllHosts}  
  
    -- Add a function that opens Windows PowerShell Help in a compiled HTML   
       Help file (.chm).   
  
           function Get-CHM  
            {  
               (invoke-item $env:windir\help\mui\0409\WindowsPowerShellHelp.chm)  
            }  
  
       This function opens the English version of the .chm file. However, you   
       can replace the language code (0409) to open other versions of the .chm  
       file.  
  
    -- Add a function that lists the aliases for any cmdlet.  
  
           function Get-CmdletAlias ($cmdletname)  
           {  
              get-alias | Where {$_.definition -like "*$cmdletname*"} | ft Definition, Name -auto  
           }  
  
    -- Add an Add-PsSnapin command to add any Windows PowerShell snap-ins that   
       you use.  
  
    -- Customize your console.  
  
           function Color-Console   
           {  
        $host.ui.rawui.backgroundcolor = "white"  
        $host.ui.rawui.foregroundcolor = "black"  
                $hosttime = (dir $pshome\PowerShell.exe).creationtime  
                $Host.UI.RawUI.WindowTitle = "Windows PowerShell $hostversion ($hosttime)"  
                clear-host  
           }  
           Color-console  
  
    -- Add a customized Windows PowerShell prompt that includes the computer  
       name and the current path.   
  
           function prompt   
           {  
              $env:computername + "\" + (get-location) + "> "  
           }  
  
       For more information about the Windows PowerShell prompt, see  
       about_Prompts.  
  
 THE NOPROFILE PARAMETER  
  
    To start Windows PowerShell without profiles, use the NoProfile parameter  
    of PowerShell.exe, the program that starts Windows PowerShell.  
  
    To begin, open a program that can start Windows PowerShell, such as Cmd.exe  
    or Windows PowerShell itself. You can also use the Run dialog box in   
    Windows.   
  
    Type:  
  
PowerShell -noprofile  
  
    For a complete list of the parameters of PowerShell.exe,  
    type:  
  
PowerShell -?  
  
 PROFILES AND EXECUTION POLICY  
  
    The Windows PowerShell execution policy determines, in part, whether you  
    can run scripts and load configuration files, including the profiles. The  
    Restricted execution policy is the default. It prevents all scripts from  
    running, including the profiles. If you use the Restricted policy, the  
    profile does not run, and its contents are not applied.  
  
    A Set-ExecutionPolicy command sets and changes your execution policy. It is  
    one of the few commands that applies in all Windows PowerShell sessions  
    because the value is saved in the registry. You do not have to set it when  
    you open the console, and you do not have to store a Set-ExecutionPolicy  
    command in your profile.  
  
 PROFILES AND REMOTE SESSIONS        
  
    Windows PowerShell profiles are not run automatically in remote sessions,  
    so the commands that the profileS add are not present in the remote session.  
    In addition, the $profile automatic variable is not populated in remote sessions.      
  
    To run a profile in a session, use the Invoke-Command cmdlet.  
  
    For example, the following command runs the CurrentUserCurrentHost profile from  
    the local computer in the session in $s.   
  
        invoke-command -session $s -filepath $profile  
  
    The following command runs the CurrentUserCurrentHost profile from the remote  
    computer in the session in $s. Because the $profile variable is not populated,  
    the command uses the explicit path to the profile.  
  
        invoke-command -session $s {invoke-command "$home\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"}  
  
    After running this command, the commands that the profile adds to the session  
    are available in $s.  
  
SEE ALSO  
    about_Automatic_Variables  
    about_Functions  
    about_Prompts  
    about_Execution_Policies  
    about_Signing  
    about_Remote  
    Set-ExecutionPolicy  
  
```
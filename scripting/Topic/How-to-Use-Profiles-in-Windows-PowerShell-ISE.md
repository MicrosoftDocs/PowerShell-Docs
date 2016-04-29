---
title: How to Use Profiles in Windows PowerShell ISE
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0219626a-6da5-4acc-b630-d058e8b29cc6
---
# How to Use Profiles in Windows PowerShell ISE
This topic explains how to use Profiles in [!INCLUDE[ise_1](../Token/ise_1_md.md)]. We recommend that before performing the tasks in this section, you review [about_Profiles [v4]](https://technet.microsoft.com/en-us/library/e1d9e30a-70cc-4f36-949f-fc7cd96b4054), or in the Console Pane, type, “get\-help about\_profiles” and press **ENTER**.

A profile is a [!INCLUDE[ise_2](../Token/ise_2_md.md)] script that runs automatically when you start a new session.  You can create one or more [!INCLUDE[wps_2](../Token/wps_2_md.md)] profiles for [!INCLUDE[ise_2](../Token/ise_2_md.md)] and use them to add the configure the [!INCLUDE[wps_2](../Token/wps_2_md.md)] or [!INCLUDE[ise_2](../Token/ise_2_md.md)] environment, preparing it for your use, with variables, aliases, functions, and color and font preferences that you want available. A profile affects every [!INCLUDE[ise_2](../Token/ise_2_md.md)] session that you start.

> [!NOTE]
> The [!INCLUDE[wps_2](../Token/wps_2_md.md)] execution policy determines whether you can run scripts and load a profile. The default execution policy, “Restricted,” prevents all scripts from running, including profiles. If you use the “Restricted” policy, the profile cannot load. For more information about execution policy, see [about_Execution_Policies [v4]](https://technet.microsoft.com/en-us/library/347708dc-1515-4d74-978b-8334603472e6).

## Selecting a profile to use in the Windows PowerShell ISE
[!INCLUDE[ise_2](../Token/ise_2_md.md)] supports profiles for the current user and all users. It also supports the [!INCLUDE[wps_2](../Token/wps_2_md.md)] profiles that apply to all hosts.

The profile that you use is determined by how you use [!INCLUDE[wps_2](../Token/wps_2_md.md)] and [!INCLUDE[ise_2](../Token/ise_2_md.md)].

-   If you use only [!INCLUDE[ise_2](../Token/ise_2_md.md)] to run Windows PowerShell, then save all your items in one of the ISE\-specific profiles, such as the CurrentUserCurrentHost profile for [!INCLUDE[ise_2](../Token/ise_2_md.md)] or the AllUsersCurrentHost profile for [!INCLUDE[ise_2](../Token/ise_2_md.md)].

-   If you use multiple host programs to run Windows PowerShell, save your functions, aliases, variables, and commands in a profile that affects all host programs, such as the CurrentUserAllHosts or the AllUsersAllHosts profile, and save ISE\-specific features, like color and font customization in the CurrentUserCurrentHost profile for [!INCLUDE[ise_2](../Token/ise_2_md.md)] profile or the AllUsersCurrentHost profile for [!INCLUDE[ise_2](../Token/ise_2_md.md)].

The following are profiles that can be created and used in [!INCLUDE[ise_2](../Token/ise_2_md.md)]. Each profile is saved to its own specific path.

|Profile Type|Profile Path|
|----------------|----------------|
|“Current user, PowerShell ISE”|$profile.CurrentUserCurrentHost, or $profile|
|“All users, PowerShell ISE”|$profile.AllUsersCurrentHost|
|“Current user, All hosts”|$profile.CurrentUserAllHosts|
|“All users, All hosts”|$profile.AllUsersAllHosts|

## To create a new profile
To create a new “Current user, Windows PowerShell ISE” profile, run this command:

```
if (!(test-path $profile )) 
{new-item -type file -path $profile -force}
```

To create a new “All users, Windows PowerShell ISE” profile, run this command:

```
if (!(test-path $profile.AllUsersCurrentHost)) 
{new-item -type file -path $profile.AllUsersCurrentHost -force}
```

To create a new “Current user, All Hosts” profile, run this command:

```
if (!(test-path $profile.CurrentUserAllHosts)) 
{new-item -type file -path $profile.CurrentUserAllHosts -force}
```

To create a new “All users, All Hosts” profile, type:

```
if (!(test-path $profile.AllUsersAllHosts)) 
{new-item -type file -path $profile.AllUsersAllHosts-force}
```

## To edit a profile

1.  To open the profile, run the command psedit with the variable that specifies the profile you want to edit. For example, to open the “Current user, Windows PowerShell ISE” profile, type: `psEdit $profile`

2.  Add some items to your profile. The following are a few examples to get you started:

    -   To change the default background color of the Console Pane to blue, in the profile file type: `$psISE.Options.OutputPaneBackground = 'blue'` . For more information about the $psISE variable, see [Windows PowerShell ISE Object Model Reference](https://technet.microsoft.com/en-us/library/e1a9e7d1-0fd5-47de-8d9b-f1be1ed13b0c).

    -   To change font size to 20, in the profile file type: `$psISE.Options.FontSize =20`

3.  To save your profile file, on the **File** menu, click **Save**. Next time you open the [!INCLUDE[ise_2](../Token/ise_2_md.md)], your customizations are applied.

## See Also
[about_Profiles [v4]](https://technet.microsoft.com/en-us/library/e1d9e30a-70cc-4f36-949f-fc7cd96b4054)
[Using the Windows PowerShell ISE](../Topic/Using-the-Windows-PowerShell-ISE.md)


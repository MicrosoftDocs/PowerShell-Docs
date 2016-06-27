---
title: about_History
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a5d50e27-238c-461f-9dd0-6ea574f18f32
---
# about_History
## TOPIC  
 about\_History  
  
## SHORT DESCRIPTION  
 Describes how to get and run commands in the command history.  
  
## LONG DESCRIPTION  
 When you enter a command at the command prompt, [!INCLUDE[wps_1]()] saves the command in the command history. You can use the commands in the history as a record of your work. And, you can recall and run the commands from the command history.  
  
### HISTORY CMDLETS  
 [!INCLUDE[wps_2]()] has a set of cmdlets that manage the command history.  
  
```  
Cmdlet (Alias)       Description  
-------------------  ------------------------------------------  
Get-History (h)      Gets the command history.  
  
Invoke-History (r)   Runs a command in the command history.  
  
Add-History          Adds a command to the command history.  
  
Clear-History (clh)  Deletes commands from the command history.  
```  
  
### KEYBOARD SHORTCUTS FOR MANAGING HISTORY  
 In the [!INCLUDE[wps_2]()] console, you can use the following shortcuts to manage the command history.  
  
 For other host applications, see the product documentation.  
  
```  
Use this key      To perform this action  
-------------     ----------------------------------------------  
UP ARROW          Displays the previous command.  
  
DOWN ARROW        Displays the next command.  
  
F7                Displays the command history.   
                  To hide the history, press ESC.  
  
F8                Finds a command. Type one or more characters,  
                  and then press F8. For the next instance,   
                  press F8 again.  
  
F9                Find a command by history ID. Type the history  
                  ID, and then press F9. To find the ID, press F7.  
```  
  
### MAXIMUMHISTORYCOUNT  
 The $MaximumHistoryCount preference variable determines the maximum number of commands that [!INCLUDE[wps_2]()] saves in the command history. The default value is 4096, meaning that [!INCLUDE[wps_2]()] saves the 4096 most recent commands, but you can change the value of the variable.  
  
 For example, the following command lowers the $MaximumHistoryCount to 100 commands:  
  
```  
$MaximumHistoryCount = 100  
```  
  
 To apply the setting, restart [!INCLUDE[wps_2]()].  
  
 To save the new variable value for all your [!INCLUDE[wps_2]()] sessions, add the assignment statement to a [!INCLUDE[wps_2]()] profile. For more information about profiles, see about\_Profiles \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=113729\).  
  
 For more information about the $MaximumHistoryCount preference variable, see about\_Preference\_Variables \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=113248\).  
  
 NOTE:  
  
 In [!INCLUDE[wps_2]()] 2.0, the default value of the $MaximumHistoryCount preference variable is 64.  
  
### ORDER OF COMMANDS IN THE HISTORY  
 Commands are added to the history when the command finishes executing, not when the command is entered. If commands take some time to be completed, or if the commands are executing in a nested prompt, the commands might appear to be out of order in the history. \(Commands that are executing in a nested prompt are completed only when you exit the prompt level.\)  
  
## SEE ALSO  
 about\_Line\_Editing  
  
 about\_Preference\_Variables  
  
 about\_Profiles  
  
 about\_Variables
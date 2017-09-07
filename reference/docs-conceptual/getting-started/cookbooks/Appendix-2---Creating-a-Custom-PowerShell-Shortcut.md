---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  Appendix 2 Creating a Custom PowerShell Shortcut
ms.assetid:  5d4fd421-5d43-4ec7-86fd-acfe887b066e
---

# Appendix 2 - Creating a Custom PowerShell Shortcut
The following procedure describes how to create a shortcut to Windows PowerShell that has several convenient options customized.

1. Create a shortcut that points to Powershell.exe.

2. Right-click the shortcut, and then click **Properties**.

3. Click the **Options** tab.

4. In the **Edit Options** section, select the **QuickEdit** check box.

    This setting lets you select text in the Windows PowerShell console window by dragging the left mouse button, and it lets you copy text to the clipboard by pressing ENTER or by right-clicking the mouse.

5. In the **Edit Options** section, select the **Insert Mode** check box. This setting lets you right-click in the console window to automatically paste text from the clipboard.

6. In the **Command History** section, type or select a number between 1 and 999 in the **Buffer Size** box. This sets the number of typed commands that will be kept in the console buffer.

7. In the **Command History** section, select the **Discard Old Duplicates** check box to eliminate repeated commands from the console buffer.

8. Click the **Layout** tab.

9. In the **Screen Buffer** section, type a number between 1 and 9999 in the **Height** box. The height represents the number of lines of output that are buffered. This is the maximum number of lines retained for viewing when you scroll through the console window. If this number is lower than the height shown in the **Window size** section, the window size height will automatically be reduced to the same value.

10. In the **Window Size** section, type a number between 1 and 9999 for the width. This represents the number of characters that are displayed across the console window. The default width is 80, and Windows PowerShell's output formatting is designed for this width.

11. If you want to place the console at a particular point on the desktop when it is opened, clear the **Let system position window** check box in the **Window position** section, and then change the values in the **Left** and **Top** boxes in the **Window position** section.

12. Click **OK**.


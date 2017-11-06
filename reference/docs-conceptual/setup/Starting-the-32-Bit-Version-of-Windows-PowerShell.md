---
ms.date:  2017-06-05
keywords:  powershell,cmdlet
title:  Starting the 32 Bit Version of Windows PowerShell
ms.assetid:  12b31890-2609-4a76-8c24-0ebe78084f50
---

# Starting the 32-Bit Version of Windows PowerShell
When you install Windows PowerShell on a 64-bit computer, **Windows PowerShell (x86)**, a 32-bit version of Windows PowerShell is installed in addition to the 64-bit version. When you run Windows PowerShell, the 64-bit version runs by default.

However, you might occasionally need to run **Windows PowerShell (x86)**, such as when you are using a module that requires the 32-bit version or when you are connecting remotely to a 32-bit computer.

To start a 32-bit version of Windows PowerShell, use any of the following procedures.

#### In Windows Server® 2012 R2

- On the **Start** screen, type **Windows PowerShell (x86)**. Click the **Windows PowerShell x86** tile.

- In **Server Manager**, from the **Tools** menu, select **Windows PowerShell (x86)**.

- On the desktop, move the cursor to the upper right corner, click **Search**, type **PowerShell x86** and then click **Windows PowerShell (x86)**.

- Via command line, enter: `%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe`

#### In Windows Server® 2012

- On the **Start** screen, type **PowerShell** and then click **Windows PowerShell (x86)**.

- In **Server Manager**, from the **Tools** menu, select **Windows PowerShell (x86)**.

- On the desktop, move the cursor to the upper right corner, click **Search**, type **PowerShell** and then click **Windows PowerShell (x86)**.

- Via command line, enter: `%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe`

#### In Windows® 8.1

- On the **Start** screen, type **Windows PowerShell (x86)**. Click the **Windows PowerShell x86** tile.

- If you are running [Remote Server Administration Tools](http://go.microsoft.com/fwlink/?LinkID=304145) for Windows 8.1, you can also open Windows PowerShell x86 from the **Server ManagerTools** menu. Select **Windows PowerShell (x86)**.

- On the desktop, move the cursor to the upper right corner, click **Search**, type **PowerShell x86** and then click **Windows PowerShell (x86)**.
   
- Via command line, enter: `%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe`

#### In Windows® 8

- On the **Start** screen, move the cursor to the upper right corner, click **Settings**, click **Tiles**, and then move the **Show Administrative Tools** slider to Yes. Then, type **PowerShell** and click **Windows PowerShell (x86)**.

- If you are running [Remote Server Administration Tools](http://www.microsoft.com/download/details.aspx?id=28972) for Windows 8, you can also open Windows PowerShell x86 from the **Server ManagerTools** menu. Select **Windows PowerShell (x86)**.

- On the **Start** screen or the desktop, type **PowerShell (x86)** and then click **Windows PowerShell (x86)**.

- Via command line, enter: `%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe`


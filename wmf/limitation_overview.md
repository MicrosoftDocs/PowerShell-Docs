# Known Issues and Limitations

PowerShell Shortcuts are broken when used for the first time
------------------------------------------------------------

**Resolution:** Perform one of the following actions:

1.  Right click on the PowerShell shortcut. Select “Windows PowerShell” to launch in a non-elevated mode.
2.  Right click on the PowerShell shortcut. Right click on “Windows PowerShell” and select “Run As Administrator” to launch in an elevated mode.

Once you have performed either of the above actions, the PowerShell shortcuts will work. These actions need to be performed only once.


PowerShell Modules and DSC Resources report errors about ExecutionPolicy on Windows 7
-------------------------------------------------------------------------------------
On Windows 7, the use of PowerShell modules and DSC resources may result in errors reported about ExecutionPolicy.

**Resolution:** Set the ExecutionPolicy to RemoteSigned by running the following command in an elevated PowerShell session (Run as Administrator):

```powershell
Set-ExecutionPolicy RemoteSigned
```

Connecting to an old remote Exchange endpoint causes a crash
------------------------------------------------------------

The old Exchange endpoint redirects to a new endpoint. There is a bug in the redirection logic that results in a crash.

**Resolution:** Connect directly to the new endpoint.


Software Inventory Logging feature is erroneously stopped after WMF 5.0 installation on Windows Server 2012 R2
-------------------------------------------------------------------------------------------------------------

When installing WMF 5.0 on a Windows Server 2012 R2 that is already running SIL, the Software Inventory Logging feature is erroneously stopped after installation.

**Resolution:** Run the Start-SilLogging cmdlet once after the WMF installation, as the installation process will errantly stop the Software Inventory Logging feature.

Get-ChildItem does not work if -LiteralPath and -Recurse are used together
--------------------------------------------------------------------------

If a directory name contains an invalid wildcard character, then Get-ChildItem will not produce expected results when both
-LiteralPath and -Recurse are used together.

**Resolution:** Not ideal, but current workaround is to implement recursion in the script rather than rely on the cmdlet.


Sysprep fails after WMF 5.0 installation
----------------------------------------

There are two workarounds for this issue depending on which version of Windows Server you are running.

Workaround #1 – steps for systems running Windows Server 2008 R2

  1.	After installing WMF 5.0, open Powershell as an administrator.
  2.	Run the cmdlet Set-SilLogging –TargetUri https://BlankTarget –CertificateThumbprint 0123456789
  3.	Run the cmdlet Publish-SilData.  There will be an error, this is expected.
  4.	Go to \Windows\System32\Logfiles\SIL\ and delete any files in this directory.
  5.	Ensure all available important Windows Updates are installed, and begin Sysyprep operation normally.


Workaround #2 – steps for systems running Windows Server 2012

  1.	After installing WMF 5.0 on the server to be Sysprep’d, login as administrator.
  2.	Copy Generize.xml from directory \Windows\System32\Sysprep\ActionFiles\ to a location outside of the Windows directory, C:\ for example.
  3.	Open your Generalize.xml copy with notepad.
  4.	Find and remove the following text, one instance of each needs to be deleted (they will be near the end of the document).
      - `<sysprepOrder order="0x3200"></sysprepOrder>`
      - `<sysprepOrder order="0x3300"></sysprepOrder>`
  5.	Save the edited copy of Generalize.xml and close the file.
  6.	Open a command prompt as administrator
  7.	Run the following command to take ownership of the Generalize.xml file in system32 folder:
      * Takeown /f C:\Windows\System32\Sysprep\ActionFiles\Generalize.xml 
        * Assumes Windows is installed on the C: drive.
  8.	Run the following command to set appropriate permission on the file:
      * Cacls C:\Windows\System32\ Sysprep\ActionFiles\Generalize.xml /G `<AdministratorUserName>`:F 
      * Answer Yes at the prompt for confirmation. 
        * Note that `<AdministratorUserName>` should be replaced by the username who is administrator on the machine. For example, "Administrator".
  9.	Copy the file you edited and saved over to the Sysprep directory using the following command:
      * Xcopy C:\Generalize.xml C:\Windows\System32\Sysprep\ActionFiles\Generalize.xml 
      * Answer Yes to overwrite (note that if there is no prompt to overwrite double check the path entered).
        * Assumes your edited copy of Generalize.xml was copied to C:\ .
  10.	Generalize.xml is now updated with the workaround. Please run Sysprep with the generalize option enabled.


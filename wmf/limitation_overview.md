# Known Issues and Limitations

Connecting to an old remote Exchange endpoint causes a crash
------------------------------------------------------------

The old Exchange endpoint redirects to a new endpoint. There is a bug in the redirection logic that results in a crash.

Resolution: Connect directly to the new endpoint.


PowerShell Shortcuts are broken when used for the first time
------------------------------------------------------------

Resolution: Perform one of the following actions:

1.  Right click on the PowerShell shortcut. Select “Windows PowerShell” to launch in a non-elevated mode.
2.  Right click on the PowerShell shortcut. Right click on “Windows PowerShell” and select “Run As Administrator” to launch in an elevated mode.

Once you have performed either of the above actions, the PowerShell shortcuts will work. These actions only need to be performed only once.


Software Inventory Logging feature is erroneously stopped after WMF 5 installation on Windows Server 2012 R2
-------------------------------------------------------------------------------------------------------------

When installing WMF 5.0 on a Windows Server 2012 R2 Server that is already running SIL, the Software Inventory Logging feature is erroneously stopped after install.

Resolution: Run the Start-SilLogging cmdlet once after the WMF install, as the installation process will errantly stop the Software Inventory Logging feature.


# Uninstallation Instructions

## Using Command Prompt
1.	Open **Command Prompt.**
2.	Run the following command:
On Windows Server 2012 R2
```powershell
wusa /uninstall /kb:3094174
```
On Windows Server 2012
```powershell
wusa /uninstall /kb:3094175
```
On Windows Server 2008 R2 SP1
```powershell
wusa /uninstall /kb:3094176
```

## Using Control Panel
1.	Open **Control Panel.**
2.	Open **Programs**, then open **Uninstall a program.**
3.	Click **View installed updates.**
4.	Select **Windows Management Framework 5.0** from the list of installed updates. This corresponds to *KB3094174*,*KB3094175*, or *KB3094176*. Click **Uninstall.**

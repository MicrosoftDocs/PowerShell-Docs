---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  Multiple selection List Boxes
description: This article shows how to create a multiple-selection list box control using the .NET Framework form-building features in Windows PowerShell.
---
# Multiple-selection List Boxes

Use Windows PowerShell 3.0 and later releases to create a multiple-selection list box control in a
custom Windows Form.

## Create list box controls that allow multiple selections

Copy and then paste the following into Windows PowerShell ISE, and then save it as a Windows
PowerShell script (.ps1).

```powershell
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Data Entry Form'
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = 'CenterScreen'

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(75,120)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = 'OK'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(150,120)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = 'Cancel'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please make a selection from the list below:'
$form.Controls.Add($label)

$listBox = New-Object System.Windows.Forms.Listbox
$listBox.Location = New-Object System.Drawing.Point(10,40)
$listBox.Size = New-Object System.Drawing.Size(260,20)

$listBox.SelectionMode = 'MultiExtended'

[void] $listBox.Items.Add('Item 1')
[void] $listBox.Items.Add('Item 2')
[void] $listBox.Items.Add('Item 3')
[void] $listBox.Items.Add('Item 4')
[void] $listBox.Items.Add('Item 5')

$listBox.Height = 70
$form.Controls.Add($listBox)
$form.Topmost = $true

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $listBox.SelectedItems
    $x
}
```

The script begins by loading two .NET Framework classes: **System.Drawing** and
**System.Windows.Forms**. You then start a new instance of the .NET Framework class
**System.Windows.Forms.Form**; that provides a blank form or window to which you can start adding
controls.

```powershell
$form = New-Object System.Windows.Forms.Form
```

After you create an instance of the Form class, assign values to three properties of this class.

- **Text.** This becomes the title of the window.

- **Size.** This is the size of the form, in pixels. The preceding script creates a form that's 300
  pixels wide by 200 pixels tall.

- **StartingPosition.** This optional property is set to **CenterScreen** in the preceding script.
  If you don't add this property, Windows selects a location when the form is opened. By setting the
  **StartingPosition** to **CenterScreen**, you're automatically displaying the form in the middle
  of the screen each time it loads.

```powershell
$form.Text = 'Data Entry Form'
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = 'CenterScreen'
```

Next, create an **OK** button for your form. Specify the size and behavior of the **OK** button. In
this example, the button position is 120 pixels from the form's top edge, and 75 pixels from the
left edge. The button height is 23 pixels, while the button length is 75 pixels. The script uses
predefined Windows Forms types to determine the button behaviors.

```powershell
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Size(75,120)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = 'OK'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)
```

Similarly, you create a **Cancel** button. The **Cancel** button is 120 pixels from the top, but 150
pixels from the left edge of the window.

```powershell
$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(150,120)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = 'Cancel'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)
```

Next, provide label text on your window that describes the information you want users to provide.

```powershell
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please make a selection from the list below:'
$form.Controls.Add($label)
```

Add the control (in this case, a list box) that lets users provide the information you've described
in your label text. There are many other controls you can apply besides text boxes; for more
controls, see [System.Windows.Forms Namespace](/dotnet/api/system.windows.forms).

```powershell
$listBox = New-Object System.Windows.Forms.Listbox
$listBox.Location = New-Object System.Drawing.Point(10,40)
$listBox.Size = New-Object System.Drawing.Size(260,20)
```

Here's how you specify that you want to allow users to select multiple values from the list.

```powershell
$listBox.SelectionMode = 'MultiExtended'
```

In the next section, you specify the values you want the list box to display to users.

```powershell
[void] $listBox.Items.Add('Item 1')
[void] $listBox.Items.Add('Item 2')
[void] $listBox.Items.Add('Item 3')
[void] $listBox.Items.Add('Item 4')
[void] $listBox.Items.Add('Item 5')
```

Specify the maximum height of the list box control.

```powershell
$listBox.Height = 70
```

Add the list box control to your form, and instruct Windows to open the form atop other windows and
dialog boxes when it's opened.

```powershell
$form.Controls.Add($listBox)
$form.Topmost = $true
```

Add the following line of code to display the form in Windows.

```powershell
$result = $form.ShowDialog()
```

Finally, the code inside the **If** block instructs Windows what to do with the form after users
select one or more options from the list box, and then click the **OK** button or press the
**Enter** key.

```powershell
if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $listBox.SelectedItems
    $x
}
```

## See Also

- [Weekend Scripter: Fixing PowerShell GUI Examples](https://devblogs.microsoft.com/scripting/weekend-scripter-fixing-powershell-gui-examples/)
- [GitHub: Dave Wyatt's WinFormsExampleUpdates](https://github.com/dlwyatt/WinFormsExampleUpdates)
- [Windows PowerShell Tip of the Week: Multi-Select List Boxes - And More!](/previous-versions/windows/it-pro/windows-powershell-1.0/ff730950(v=technet.10))

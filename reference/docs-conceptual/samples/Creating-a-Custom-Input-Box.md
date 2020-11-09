---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  Creating a Custom Input Box
description: This article shows how to create a custom input box by using the .NET Framework form-building features in Windows PowerShell.
---
# Creating a Custom Input Box

Script a graphical custom input box by using Microsoft .NET Framework form-building features in
Windows PowerShell 3.0 and later releases.

## Create a custom, graphical input box

Copy and then paste the following into Windows PowerShell ISE, and then save it as a Windows
PowerShell script (.ps1).

```powershell
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Data Entry Form'
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,120)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,120)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please enter the information in the space below:'
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,40)
$textBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($textBox)

$form.Topmost = $true

$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $textBox.Text
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
$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,120)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)
```

Similarly, you create a **Cancel** button. The **Cancel** button is 120 pixels from the top, but 150
pixels from the left edge of the window.

```powershell
$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,120)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)
```

Next, provide label text on your window that describes the information you want users to provide.

```powershell
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please enter the information in the space below:'
$form.Controls.Add($label)
```

Add the control (in this case, a text box) that lets users provide the information you've described
in your label text. There are many other controls you can apply besides text boxes; for more
controls, see [System.Windows.Forms Namespace](/dotnet/api/system.windows.forms).

```powershell
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,40)
$textBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($textBox)
```

Set the **Topmost** property to **$true** to force the window to open atop other open windows and
dialog boxes.

```powershell
$form.Topmost = $true
```

Next, add this line of code to activate the form, and set the focus to the text box that you created.

```powershell
$form.Add_Shown({$textBox.Select()})
```

Add the following line of code to display the form in Windows.

```powershell
$result = $form.ShowDialog()
```

Finally, the code inside the **If** block instructs Windows what to do with the form after users
provide text in the text box, and then click the **OK** button or press the **Enter** key.

```powershell
if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $textBox.Text
    $x
}
```

## See Also

- [GitHub: Dave Wyatt's WinFormsExampleUpdates](/previous-versions/windows/it-pro/windows-powershell-1.0/ff730941(v=technet.10))
- [Windows PowerShell Tip of the Week:  Creating a Custom Input Box](https://technet.microsoft.com/library/ff730941.aspx)

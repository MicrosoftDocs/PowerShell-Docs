---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  Creating a Graphical Date Picker
description: This article shows how to create a custom calendar-style control by using the .NET Framework form-building features in Windows PowerShell.
---
# Creating a Graphical Date Picker

Use Windows PowerShell 3.0 and later releases to create a form with a graphical, calendar-style
control that lets users select a day of the month.

## Create a graphical date-picker control

Copy and then paste the following into Windows PowerShell ISE, and then save it as a Windows
PowerShell script (.ps1).

```powershell
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object Windows.Forms.Form -Property @{
    StartPosition = [Windows.Forms.FormStartPosition]::CenterScreen
    Size          = New-Object Drawing.Size 243, 230
    Text          = 'Select a Date'
    Topmost       = $true
}

$calendar = New-Object Windows.Forms.MonthCalendar -Property @{
    ShowTodayCircle   = $false
    MaxSelectionCount = 1
}
$form.Controls.Add($calendar)

$okButton = New-Object Windows.Forms.Button -Property @{
    Location     = New-Object Drawing.Point 38, 165
    Size         = New-Object Drawing.Size 75, 23
    Text         = 'OK'
    DialogResult = [Windows.Forms.DialogResult]::OK
}
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object Windows.Forms.Button -Property @{
    Location     = New-Object Drawing.Point 113, 165
    Size         = New-Object Drawing.Size 75, 23
    Text         = 'Cancel'
    DialogResult = [Windows.Forms.DialogResult]::Cancel
}
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$result = $form.ShowDialog()

if ($result -eq [Windows.Forms.DialogResult]::OK) {
    $date = $calendar.SelectionStart
    Write-Host "Date selected: $($date.ToShortDateString())"
}
```

The script begins by loading two .NET Framework classes: **System.Drawing** and
**System.Windows.Forms**. You then start a new instance of the .NET Framework class
**Windows.Forms.Form**; that provides a blank form or window to which you can start adding controls.

```powershell
$form = New-Object Windows.Forms.Form -Property @{
    StartPosition = [Windows.Forms.FormStartPosition]::CenterScreen
    Size          = New-Object Drawing.Size 243, 230
    Text          = 'Select a Date'
    Topmost       = $true
}
```

This example assigns values to four properties of this class by using the **Property** property and hashtable.

1. **StartPosition**: If you don't add this property, Windows selects a location when the form is
   opened. By setting this property to **CenterScreen**, you're automatically displaying the form in
   the middle of the screen each time it loads.

2. **Size**:
   This is the size of the form, in pixels.
   The preceding script creates a form that's 243 pixels wide by 230 pixels tall.

3. **Text**:
   This becomes the title of the window.

4. **Topmost**: By setting this property to `$true`, you can force the window to open atop other
   open windows and dialog boxes.

Next, create and then add a calendar control in your form.
In this example, the current day is not highlighted or circled.
Users can select only one day on the calendar at one time.

```powershell
$calendar = New-Object Windows.Forms.MonthCalendar -Property @{
    ShowTodayCircle   = $false
    MaxSelectionCount = 1
}
$form.Controls.Add($calendar)
```

Next, create an **OK** button for your form. Specify the size and behavior of the **OK** button. In
this example, the button position is 165 pixels from the form's top edge, and 38 pixels from the
left edge. The button height is 23 pixels, while the button length is 75 pixels. The script uses
predefined Windows Forms types to determine the button behaviors.

```powershell
$okButton = New-Object Windows.Forms.Button -Property @{
    Location     = New-Object Drawing.Point 38, 165
    Size         = New-Object Drawing.Size 75, 23
    Text         = 'OK'
    DialogResult = [Windows.Forms.DialogResult]::OK
}
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)
```

Similarly, you create a **Cancel** button.
The **Cancel** button is 165 pixels from the top, but 113 pixels from the left edge of the window.

```powershell
$cancelButton = New-Object Windows.Forms.Button -Property @{
    Location     = New-Object Drawing.Point 113, 165
    Size         = New-Object Drawing.Size 75, 23
    Text         = 'Cancel'
    DialogResult = [Windows.Forms.DialogResult]::Cancel
}
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)
```

Add the following line of code to display the form in Windows.

```powershell
$result = $form.ShowDialog()
```

Finally, the code inside the `if` block instructs Windows what to do with the form after users
select a day on the calendar, and then click the **OK** button or press the **Enter** key. Windows
PowerShell displays the selected date to users.

```powershell
if ($result -eq [Windows.Forms.DialogResult]::OK) {
    $date = $calendar.SelectionStart
    Write-Host "Date selected: $($date.ToShortDateString())"
}
```

## See Also

- [GitHub: Dave Wyatt's WinFormsExampleUpdates](https://github.com/dlwyatt/WinFormsExampleUpdates)
- [Windows PowerShell Tip of the Week:  Creating a Graphical Date Picker](/previous-versions/windows/it-pro/windows-powershell-1.0/ff730942(v=technet.10))

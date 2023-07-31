$schTaskName = "Hello CTI Firms"

Get-ScheduledTask -TaskName $schTaskName  | Unregister-ScheduledTask -Confirm:$false

$taskname = $schTaskName
$taskdescription = "Report Local Users - run as system"
$action = New-ScheduledTaskAction -Execute 'Powershell.exe' `
  -Argument '-noexit -NoProfile -WindowStyle Hidden -command "&{get-localuser|out-file c:\users.txt -force}'

Register-ScheduledTask -Action $action -Trigger $trigger -TaskName $taskname -Description $taskdescription -Settings $settings -User "System"

Start-Sleep -Seconds 2
Start-ScheduledTask -TaskName $schTaskName
Start-Sleep -Seconds 5

Get-ScheduledTask -TaskName $schTaskName  | Unregister-ScheduledTask -Confirm:$false

# Stop the CrowdStrike service

Stop-Service -Name "CSFalconService" -Force

# Remove the problematic driver file

$driverPath = "C:\Windows\System32\drivers"

$driverFile = Get-ChildItem -Path $driverPath -Filter "C-00000291*.sys"

if ($driverFile) {

Remove-Item -Path $driverFile.FullName -Force

Write-Output "Successfully removed the driver file: $($driverFile.FullName)"

} else {

Write-Output "Driver file not found."

}

# Disable the Csagent service by modifying the registry

$registryPath = "HKLM:\System\CurrentControlSet\Services\Csagent"

Set-ItemProperty -Path $registryPath -Name "Start" -Value 4

# Start the CrowdStrike service

Start-Service -Name "CSFalconService"

Write-Output "CrowdStrike service has been restarted. The problematic driver file has been removed and Csagent service has been disabled."

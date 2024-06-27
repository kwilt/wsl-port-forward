Add-Type -AssemblyName System.Web
$hostPort = 8080
$guestPort = 443

function Get-LoggedInUser($loggedInUser) {
  (Get-WMIObject -class Win32_ComputerSystem | Select-Object -ExpandProperty UserName | Out-String).trim("$env:USERDOMAIN\").trim()
}


function Test-Config {
  $checkPorts = Invoke-Expression "netsh interface portproxy show v4tov4 listenport=$hostPort listenaddress=0.0.0.0"
  # When there is a configuration present, $checkPortsWithSpecialCharacters will return System.Object[]
  # There was no other way I could figure out to test if a config was present because
  # without the HtmlEncode method, $checkPorts was returning an empty string no matter what
  $checkPortsWithSpecialCharacters = [System.Web.HttpUtility]::HtmlEncode($checkPorts)
  if ($checkPortsWithSpecialCharacters -eq "") {
    Write-Host
    Write-Host -ForegroundColor Green "No existing configuration to clear"
    Write-Host
  }
  else {
    Write-Host
    Write-Host -ForegroundColor Yellow "Clearing previous configuration"
    Write-Host
    Invoke-Expression "netsh interface portproxy delete v4tov4 listenport=$hostPort listenaddress=0.0.0.0" >$null
  }
}

function Set-Ports {
  $filePath = $filePath = "C:\Users\$(loggedInUser)\.wslip"
  if (Test-Path $filePath -PathType Leaf) {
    Write-Host -ForegroundColor Green "Found WSL IP: $(Get-Content $filePath)in $filePath"
    Invoke-Expression "netsh interface portproxy add v4tov4 listenport=$hostPort listenaddress=0.0.0.0 connectport=$guestPort connectaddress=$(Get-Content $filePath)" -ErrorVariable SetPortsError
  }
  else {
    Write-Host -ForegroundColor Red "Could not find WSL IP in $filePath."
    Break
  }
    Write-Host
    Write-Host -ForegroundColor Yellow "Your new configuration:"
    Write-Host
    Invoke-Expression "netsh interface portproxy show v4tov4" | Write-Host -ForegroundColor Yellow
    Write-Host
    Write-Host
}

Test-Config

Set-Ports

Read-Host -Prompt "Press Enter to exit"

# thanks to https://vmarena.com/how-to-enable-remote-desktop-rdp-remotely-using-powershell/
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

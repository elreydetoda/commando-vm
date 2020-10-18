$base_gh_url = 'https://raw.githubusercontent.com'

if ( ! ($RepoOwner = $env:RepoOwner) ){
    $RepoOwner = 'fireeye'
}

if ( ! ($Branch = $env:Branch) ){
    $Branch = 'master'
}

$command_base_url = "${base_gh_url}/${RepoOwner}/commando-vm"
$branch_base_url = "${command_base_url}/${Branch}"
$packer_template_folder = "${branch_base_url}/packer"
$packer_build_folder = "${packer_template_folder}/win10_1809"

$setup_script_url = "${packer_build_folder}/floppy/setup.ps1"
$fix_network_script_url = "${packer_build_folder}/floppy/setup.ps1"

Invoke-Expression (new-object system.net.webclient).DownloadString("${setup_script_url}")

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" /v StartupPage /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" /v AllItemsIconView /t REG_DWORD /d 0 /f
# backticks from: https://stackoverflow.com/questions/14130226/error-description-invalid-query#answer-14132476
cmd /C wmic useraccount where name=`"vagrant`" set PasswordExpires=false
cmd.exe /c powershell -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force"
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows Defender" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableOnAccessProtection /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableScanOnRealtimeEnable /t REG_DWORD /d 1 /f

Invoke-Expression (new-object system.net.webclient).DownloadString("${fix_network_script_url}")

# enabling ntp for windows more info here: https://gist.github.com/elreydetoda/d53e11fc0dfc8a017fca549a2347560c
Invoke-Expression (new-object system.net.webclient).DownloadString("https://git.io/JfvET")

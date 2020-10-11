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

Invoke-Expression (new-object system.net.webclient).DownloadString("${setup_script_url}")

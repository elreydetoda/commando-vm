
# CommandoVM & HashiCorp's Packer

Welcome to the packer builder of CommandoVM - a fully automated ( Beta ) installation of the customizable commandvm platform.

## Requirements

* a hypervisor ( below are current hypervisors )
  * [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
* HashiCorp's [packer](https://www.packer.io/downloads)
* [packer provisioner windows update](https://github.com/rgl/packer-provisioner-windows-update)
* 60 GB Hard Drive
* 2 GB RAM

## Recommended

* 80+ GB Hard Drive
* 4+ GB RAM

# Instructions

## Standard install

1. make sure you have all the [pre-reqs](#requirements).
2. Download the zip from [https://github.com/fireeye/commando-vm](https://github.com/fireeye/commando-vm).
3. Decompress the zip and cd into the [win10_1809 folder](/packer/win10_1809/).
4. run the following command: `packer build win10_1809_virtualbox_iso_to_finish.json`.
   > if you don't have packer in you path, then you will have to specify the full path to the packer binary.
  
This will automate the whole process of creating the base vm, doing a windows installation, and then installing all the necessary CommandoVM components.

## Custom install

1. make sure you have all the [pre-reqs](#requirements).
2. Download the zip from [https://github.com/fireeye/commando-vm](https://github.com/fireeye/commando-vm) into your Downloads folder.
3. Decompress the zip and cd into the [win10_1809 folder](/packer/win10_1809/).
4. Modify any of the .json files to your pleasure.
5. run the following command: `packer build win10_1809_virtualbox_iso_to_finish.json`.

### Other resources

* packer documentation: [https://www.packer.io/docs](https://www.packer.io/docs)
* current builder(s):
  * [Virtualbox](https://www.packer.io/docs/builders/virtualbox)
* current provisioner(s):
  * [File](https://www.packer.io/docs/provisioners/file)
  * [Windows Shell](https://www.packer.io/docs/provisioners/windows-shell)
  * [Windows Restart](https://www.packer.io/docs/provisioners/windows-restart)

### Possible Install Type

#### Base Installation

The `win10_1809_virtualbox_iso_to_base.json` build will take an ISO and create a base windows vm, that is prepared for CommandoVM to install. This would be used well with a custom CommandoVM installation, where you would modify your profile to your liking.

#### Snapshot Installation

The `win10_1809_virtualbox_snapshot_to_finish.json` build will take an already existing virtual machine name: `Windows_10_1809_x64_commando` ( rename your vm this or change this in the config if you don't want to use that name ) and a snapshot named: `Snapshot_1` (which you will have to create), and then do the CommandoVM installation for you with the default profile. Also, you will need to pass a parameter of `-var 'profile_file_name=<profile_you_want>'` to understand profiles better go [here](/Profiles/).

**NOTE:** you will need to either have your username and password or a username and password created in order to use this install method with Administrative rights to the vm:

* username: `vagrant`
* password: `vagrant`

**NOTE:** you will need to configure your machine up to the CommandoVM standards (i.e. removing tamper protection, etc...), and also you will have to configure the machine similar to the following commands executed [here](/packer/win10_1809/floppy/Autounattend.xml)


## Vagrantize

### Manualish

* [ ] manually do windows install
* [ ] update completely
  * probably need to create a packer template which handles just the first two bullets
* [ ] run commando prep script

  ```powershell
  $env:RepoOwner = 'elreydetoda'
  $env:Branch = 'helper-scripts'
  iex (new-object system.net.webclient).DownloadString("https://git.io/JTTGX")
  ```

* [ ] manually run commando install script from [master](https://github.com/fireeye/commando-vm/archive/master.zip)

  * because I am lazy, here are the commands:

    ```powershell
    Unblock-File .\install.ps1
    Set-ExecutionPolicy Unrestricted -f
    .\install.ps1 -password vagrant -nochecks 1
    ```

  * there are points in the script ( after reboot ) which currently power windows defender back on, so you will have to disable it during reboots. Haven't figured out why this is yet, but I am will eventually.
    * or do their suggested action of `.\install.ps1 -nochecks 1 <password>` to just start the installer again ( after you disable defender )
* [ ] snapshot with name: vagrant_ready
* [ ] run: packer build win10_1809_virtualbox_snapshot_to_vagrant.json
* [ ] shutdown vm after done building ( auto shutdown isn't working for some silly reason )
* [ ] run test Vagrantfile to make sure it works properly
  * currently for some reason winrm won't stay connected ( at least on linux ) when you execute `vagrant winrm`, but you can rdp into the box
  * the box ( after exported into vagrant format ) was 17Gb

#### Vagrant Cloud

If you want your vagrant box to be auto uploaded to vagrant cloud you can copy the example variables-vagrant_cloud.json.example to variables-vagrant_cloud.json, and fill in your information.  Then you run this command: `packer build -var-file=variables-vagrant_cloud.json win10_1809_virtualbox_snapshot_to_vagrant-cloud.json` instead of running the normal packer build command

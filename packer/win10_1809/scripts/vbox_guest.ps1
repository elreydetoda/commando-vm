# inspiration from: https://github.com/chef/bento/blob/d576c592a900b62224db4ba2bfe39e182924fc58/packer_templates/windows/cookbooks/packer/recipes/vm_tools.rb
# drive is E, because windows ISO is at D
Get-ChildItem E:/cert/ -Filter vbox*.cer | ForEach-Object {
  E:/cert/VBoxCertUtil.exe add-trusted-publisher $_.FullName --root $_.FullName
}
mkdir "C:/Windows/Temp/virtualbox"
Start-Process -FilePath "e:/VBoxWindowsAdditions.exe" -ArgumentList "/S" -WorkingDirectory "C:/Windows/Temp/virtualbox" -Wait
Remove-Item "C:/Windows/Temp/virtualbox" -Recurse -Force

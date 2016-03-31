@echo off
setlocal enabledelayedexpansion
echo ************************************
echo I'll set up monorail server now...
echo ************************************
vagrant up dev
set pxe_count=4
set vbox_manage=c:\Program Files\Oracle\VirtualBox
set PATH=%PATH%;%vbox_manage%
echo ************************************
echo I'll set up pxe clients now...
echo ************************************
FOR /L %%i IN (1 1 %pxe_count%) DO (
   set vmName=pxe-%%i
   set storName=!vmName!.vdi
   VBoxManage createvm --name !vmName! --register
   VBoxManage createhd --filename !vmName! --size 8192
   VBoxManage storagectl !vmName! --name "SATA Controller" --add sata --controller IntelAHCI
   VBoxManage storageattach !vmName! --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium !storName!
   VBoxManage modifyvm !vmName! --ostype Ubuntu --boot1 net --memory 768
   VBoxManage modifyvm !vmName! --nic1 intnet --intnet1 closednet --nicpromisc1 allow-all
   VBoxManage modifyvm !vmName! --nictype1 82540EM --macaddress1 auto

)

set pxe_count=
set vbox_manage=
set vmName=
set storName=


::echo "starting the services"
::echo "The RackHD documentation will be available shortly at http://localhost:9090/docs"
::vagrant ssh dev -c "sudo nf start"


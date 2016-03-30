@echo off
set pxe_count=1
set vbox_manage=c:\Program Files\Oracle\VirtualBox
set PATH=%PATH%;%vbox_manage%
FOR /L %%i IN (1 1 %pxe_count%) DO (
   echo ***
   echo %vbox_manage%
   echo ***
   set vmName=pxe-%%i
   set "storName=%vmName%"
   set "storName=%storName%.vdi"
   VBoxManage createvm --name %vmName% --register
   VBoxManage createhd --filename %vmName% --size 8192
   VBoxManage storagectl %vmName% --name "SATA Controller" --add sata --controller IntelAHCI
   VBoxManage storageattach %vmName% --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium %storName%
   VBoxManage modifyvm %vmName% --ostype Ubuntu --boot1 net --memory 768
   VBoxManage modifyvm %vmName% --nic1 intnet --intnet1 closednet --nicpromisc1 allow-all
   VBoxManage modifyvm %vmName% --nictype1 82540EM --macaddress1 auto

)


:: unset variables below
set pxe_count=
set vbox_manage=
set vmName=
set storName=


::#!/bin/bash
::# monorail_rack
::# script to deploy a development test enviorment.


::##################
::# INCLUDE CONFIG #
::##################
::SCRIPT_DIR=$(cd $(dirname $0) && pwd)
::source $SCRIPT_DIR/../config/monorail_rack.cfg


::############
::# GET OPTS #
::############

::function usage {
::  printf "\nusage: monorail_rack [-h]\n"
::  printf "\t-h display usage\n\n"
::  printf "\t customize deployment variables by editing:\n"
::  printf "\t\t example/config/monorail_rack.cfg\n\n"
::  exit
::}


::while getopts ":h" opt; do
::  case $opt in
::    h)
::      usage
::      ;;
::    \?)
::      echo "Invalid option: -$OPTARG" >&2
::      usage
::      ;;
::  esac
::done


::##########################
::# DEPLOY MONORAIL SERVER #
::##########################

::# TODO: handle if we want to download static files and/or BMCs
::#       For now assumed no downloading of dependicies...

::echo "I'll set up monorail server now..."
::vagrant up dev

::######################
::# DEPLOY PXE CLIENTS #
::######################

::if [ $pxe_count ]
::  then
::    for (( i=1; i <= $pxe_count; i++ ))
::      do
::        vmName="pxe-$i"
::        if [[ ! -e $vmName.vdi ]]; then # check to see if PXE vm already exists
::            echo "deploying pxe: $i"
::            VBoxManage createvm --name $vmName --register;
::            VBoxManage createhd --filename $vmName --size 8192;
::            VBoxManage storagectl $vmName --name "SATA Controller" --add sata --controller IntelAHCI
::            VBoxManage storageattach $vmName --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $vmName.vdi
::            VBoxManage modifyvm $vmName --ostype Ubuntu --boot1 net --memory 768;
::            VBoxManage modifyvm $vmName --nic1 intnet --intnet1 closednet --nicpromisc1 allow-all;
::            VBoxManage modifyvm $vmName --nictype1 82540EM --macaddress1 auto;
::        fi
::      done
::fi

::echo "starting the services"
::echo "The RackHD documentation will be available shortly at http://localhost:9090/docs"
::vagrant ssh dev -c "sudo nf start"

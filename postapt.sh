#!/bin/bash

##################################################################
#
#	Some cool ascii stuff
#
##################################################################
#
#  Post installation script (dynamic version)
#  ===========================================================
#  Menu based bash script that allows for some added flexibiltiy 
#  compared to previous versions.  You will be allowed to choose 
#  to simply update your machine or also deploy different versions
#  to accommodate your environment.
#
#  This version will include:
#  - a lightweight build (this is in turn due to my low-power travel 
#    Asus laptop, love the passive cooling!)
#  - a VM variant to be deployed in VirtualBox
#  - a "full-weight" build that fits my growing skillset as well as
#    tools that I am in the process of learning to use.
#
#  This script continues to serve as a learning tool for my bash
#  scripting as well as being something useful to hopefully more than
#  just myself.
#
#  Cheers!
#    - m0nkeydrag0n
#
##################################################################

#-------------------------------------------
# Set some primary parameters
#-------------------------------------------
EDITO=vim
PASSWD=/etc/passwd
RED='\033[0;41;30m'
STD='\033[0;0;39m'

#-------------------------------------------
# Define user interactive parameters
#-------------------------------------------
pause(){
read -p "Press [Enter] key to continue"
fackEnterKey
}

one(){
# stuff for selection 1
echo "Updating and upgrading packages"
sudo apt-get -y update && sudo apt-get -y upgrade
}

two(){
# Selection 2 will contain all apps in the lighterweight build, these will also 
# be present in the full-weight build
echo "You have selected lightweight build"

# Invoke lightweight build mini script
cd /home/$USER
./lwbuild.sh
}

three(){
# stuff for selection 3
echo "You have chosen the VM build"
cd /home/$USER
}

four(){
# stuff for selection 4
echo "Build with all the tools"
cd /home/$USER
./lwbuild.sh
./fwbuild.sh
}

#-------------------------------------------
# Create the menu to be displayed
#-------------------------------------------
show_menus(){
clear
echo "############################################################"
echo "#                                                          #"
echo "#   m0nkeydrag0n's post install script learnfest           #"
echo "#   ============================================           #"
echo "#                                                          #"
echo "#   Please make your selection below:                      #"
echo "#   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                      #"
echo "#   1. Update                                              #"
echo "#   2. Lightweight build for low power machines            #"
echo "#   3. VM delight, virtualbox guest additions included     #"
echo "#   4. Full build, only the tools I have learned to use    #"
echo "#   5. Exit                                                #"
echo "#                                                          #"
echo "############################################################"
	echo ""
}

#-------------------------------------------
# Receive user input
#-------------------------------------------
read_options(){
local choice
read -p "Enter choice 1-5: " choice
case $choice in
1) one ;;
2) two ;;
3) three ;;
4) four ;;
5) exit 0;;
*) echo -e "${RED}Error...please select again!${STD}" && sleep 2
esac
}

#-------------------------------------------
# Trap CTRL+C, CTRL+Z and quit singles
# Trap CTRL+C, CTRL+Z and quit singles
#-------------------------------------------
trap '' SIGINT SIGQUIT SIGTSTP

#-------------------------------------------
# Loop the menu!
#-------------------------------------------
while true
do
show_menus
read_options
done

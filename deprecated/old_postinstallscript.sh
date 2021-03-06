#!/bin/bash

################################################################################
#               ___        _                  _                  ___           #
#              / _ \      | |                | |                / _ \          #
#    _ __ ___ | | | |_ __ | | _____ _   _  __| |_ __ __ _  __ _| | | |_ __     #
#   | '_ ` _ \| | | | '_ \| |/ / _ \ | | |/ _` | '__/ _` |/ _` | | | | '_ \    #
#   | | | | | | |_| | | | |   <  __/ |_| | (_| | | | (_| | (_| | |_| | | | |   #
#   |_| |_| |_|\___/|_| |_|_|\_\___|\__, |\__,_|_|  \__,_|\__, |\___/|_| |_|   #
#                                    __/ |                 __/ |               #
#                                   |___/                 |___/                #
#                                                                              #
################################################################################
# Post installation script                                                     #
# ================================================                             #
# - update                                                                     #
# - install apps                                                               #
# - upgrade all packages                                                       #
# - remove unnecessary fluff                                                   #
# - success!                                                                   #
################################################################################

# --> Cautiously adding things...
# Remove unnecessary apps
sudo dnf remove rhythmbox libreoffice* cheese shotwell evolution -y

# First update
echo "Performing update..."
echo
sudo dnf update -y && sudo dnf upgrade -y
echo "Updating complete."
echo

# Add repos for applications
echo "Adding repositories..."
echo
cd /etc/yum.repos.d/
sudo wget http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
echo
echo "Another round of updates..."
sudo dnf update -y
echo

echo "Performing application installations..."
# Install vim nmap ettercap keepassx wireshark
sudo dnf install -y vim nmap ettercap keepassx wireshark wireshark-gtk
echo

# Install VirtualBox
cd /home/m0nkeydrag0n/Downloads/ && wget https://www.virtualbox.org/download/oracle_vbox.asc
sudo rpm --import oracle_vbox.asc
cd ..
sudo dnf install binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms -y
sudo dnf install VirtualBox-5.2 -y
sudo usermod -a -G vboxusers m0nkeydrag0n
echo

# Install Metasploit Framework
sudo -i -u root curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  sudo chmod 755 msfinstall && \
  ./msfinstall
echo

# Clean packages
echo "Cleaning up the mess..."
sudo dnf clean all
echo

echo "Post installation procedures completed."
echo "Go forth and learn."
echo

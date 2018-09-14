#!/bin/bash

#####################################################################
# 
# m0nkeydrag0n ascii stuff to go here
#
#####################################################################
#
# Post installation script (apt fork)
# ===================================
# - update install
# - remove fluff
# - install applications
# - reboot and finalize
#
#####################################################################

# Adding to this list slowly
# Remove unnecessary applications

# Update system
echo "Updating..."
echo
sudo apt-get -y update && sudo apt-get -y upgrade
echo "Updating complete."
echo

# Change location to current user's home folder
cd /home/$USER

# Install some useful apps
sudo apt-get install -y vim nmap keepassx wireshark wireshark-gtk wireshark-qt terminix virtualbox virtualbox-ext-pack

# Install VirtualBox Guest Additions
sudo apt-get install -y virtualbox-guest-x11

# Install dependencies for Kismet Wireless
sudo apt-get install -y build-essential git libmicrohttpd-dev pkg-config zlib1g-dev libnl-3-dev libnl-genl-3-dev libcap-dev libpcap-dev libncurses5-dev libnm-dev libdw-dev libsqlite3-dev libprotobuf-dev libprotobuf-c-dev protobuf-compiler protobuf-c-compiler libsensors4-dev python python-setuptools python-protobuf python-sqlite python-requests librtlsdr0 libusb-1.0.0 python-libusb1

# Downlad Kismet
git clone https://www.kismetwireless.net/git/kismet.git
# Begin Kismet configure, compiling and install
cd kismet
./configure
make -j4 # Set compile to four cores
sudo make suidinstall
sudo usermod -a -G kismet $USER # Current user added to kismet group


# Add VTE to bashrc for Tilix
sudo cat << EOF >> ~/.bashrc
# Adding statement to rectify issue regarding GTK+ for Tilix
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	source /etc/profile.d/vte*.sh
fi
EOF

# Clean the place up
echo "Cleaning up the mess..."
sudo apt autoremove
echo

echo "All done here, go forth a do the things!"


#!/bin/bash

####################################################################
#
# This is lightweight portion of the script
#
####################################################################

# Install some apps
sudo apt-get install -y vim nmap keepassx wireshark wireshark-gtk wireshark-qt terminix

# Install dependencies for Kistmet Wireless
sudo apt-get install -y build-essential git libmicrohttpd-dev pkg-config zlib1g-dev \
libnl-3-dev libnl-genl-3-dev libcap-dev libpcap-dev libncurses5-dev libnm-dev libdw-dev \
libsqlite3-dev libprotobuf-dev libprotobuf-c-dev protobuf-compiler protobuf-c-compiler \
libsensors4-dev python python-setuptools python-protobuf python-sqlite python-requests \
librtlsdr0 libusb-1.0.0 python-libusb1

# Downlod Kismet
git clone https://www.kismetwireless.net/git/kismet.git
# Begin Kismet configure, compiling and install
cd kismet
./configure
# Set to max threads
make -j$(nproc)
sudo make suidinstall
sudo usermod -a -G kismet $USER # Current user added to kismet group

# Install Moloch
git clone https://github.com/aol/moloch.git
# Configure and install Moloch
./home/$USER/moloch/easybutton-build.sh --install
# Config setup
sudo /home/$USER/moloch make config

# Add VTE to bashrc for Tilix
# - this fixes an error message that pops up in ubuntu
sudo cat << EOF >> ~/.bashrc
# Adding statement to rectify issue regarding GTK+ for Tilix
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte*.sh
fi
EOF



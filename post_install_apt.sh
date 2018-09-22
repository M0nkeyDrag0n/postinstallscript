#!/bin/bash
#####################################################################
#    ____    __  _____  ____   _  __  __  ______ __    _ 
#   |    \  /  |/     ||    \ | ||  |/ / |   ___|\ \  // 
#   |  |  \/   ||  /  ||  |  \| ||     \ |   ___| \ \//  
#   |__|\__/|__||_____/|__|\____||__|\__\|______| /__/   
#    _____   _____   ____    ______  _____  ____   _     
#   |     \ |  .  | |    \  |   ___|/     ||    \ | |    
#   |  |   \|     \ |     \ |   |  ||  /  ||  |  \| |    
#   |______/|__|\__\|__|\__\|______||_____/|__|\____|    
#                                                        
#####################################################################
#
# Post installation script (apt fork)
# ===================================
# - update Ubuntu
# - remove the fluff..
# - install applications
#	vim		keepassx	wireshark
#	terminix	virtualbux	moloch
#	kismet		nmap		
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
make -j4 # manually set 4 threads
sudo make suidinstall
sudo usermod -a -G kismet $USER # Current user added to kismet group

# Install Moloch
git clone https://github.com/aol/moloch.git
# Configure and install Moloch
./home/$USER/moloch/easybutton-build.sh --install
# Config setup
sudo /home/$USER/moloch/make config

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

echo "All done here, go forth and do the things!"


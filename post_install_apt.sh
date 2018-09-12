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
sudo apt-get y update && sudo apt-get y upgrade
echo "Updating complete."
echo

# Add repos for some good stuffs


# Install some useful apps
sudo apt-get install y vim nmap keepassx wireshark wireshark-gtk wireshark-qt terminix virtualbox virtualbox-ext-pack

# add vte to bashrc for Tilix
sudo cat << EOF >> ~/.bashrc
# adding statement to rectify issue regarding GTK+ for Tilix
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	source /etc/profile.d/vte*.sh
fi
EOF

# prepare to install Metasploit Framework
sudo apt-get install y gpgv2 autoconf bison build-essential curl git-core libapr1 libaprutil1 libcurl4-openssl-dev libgmp3-dev libpcap-dev libpq-dev libreadline6-dev libsqlite3-dev libssl-dev libsvn1 libtool libxml2 libxml2-dev libxslt-dev libyaml-dev locate ncurses-dev openssl postgresql postgresql-contrib wget xsel zlib1g zlib1g-dev

# configure postgres
sudo su postgres
createuser msfuser -S -R -P
createdb msfdb -O msfuser
exit

# Clean the place up
echo "Cleaning up the mess..."
sudo apt autoremove
echo

echo "All done here, go forth a do the things!"


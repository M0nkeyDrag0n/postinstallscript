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
# Post installation script for Fedora                                          #
# ================================================                             #
# - perform initial update                                                     #
# - install apps                                                               #
# - upgrade all packages                                                       #
# - remove unnecessary fluff                                                   #
# - success!                                                                   #
################################################################################

echo "Performing first update..."
echo

# First update
sudo dnf update -y
echo
echo "Updating complete."
echo

# Upgrade OS prior to moving forward
sudo dnf upgrade -y
echo
echo "Upgrade complete."
echo

# Add repos for applications
echo "Adding repositories..."
echo

echo "Performing application installations..."

# Install vim
sudo dnf install -y vim
echo

# Install NMap
sudo dnf install -y nmap
echo

# Install Ettercap
sudo dnf install -y ettercap
echo

# Install KeepassX
sudo dnf install -y keepassx
echo

# Install WireShark
sudo dnf install -y wireshark wireshark-gtk
echo

# Install Metasploit Framework
sudo -i -u root curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  chmod 755 msfinstall && \
  ./msfinstall
echo

# Remove unnecessary apps
# sudo dnf remove

echo "Post installation procedures completed."
echo


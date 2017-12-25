#!/bin/bash

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
sudo dnf update
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

# Install KeepassX
sudo dnf install -y keepassx

# Install WireShark
sudo dnf install -y wireshark wireshark-gtk

# Remove unnecessary apps
sudo dnf remove 

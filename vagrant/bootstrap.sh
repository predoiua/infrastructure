#!/usr/bin/env bash

sudo yum -y update
#install minimal desktop
# CentOS 6
#sudo yum -y groupinstall "Desktop" "Desktop Platform" "X Window System" "Fonts"
# CentOS 7
yum groupinstall "GNOME Desktop" "Graphical Administration Tools"

#install chrome
sudo wget http://chrome.richardlloyd.org.uk/install_chrome.sh
sudo chmod u+x install_chrome.sh
sudo ./install_chrome.sh -f


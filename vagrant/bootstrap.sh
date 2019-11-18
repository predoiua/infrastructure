#!/usr/bin/env bash

sudo yum -y update
#install minimal desktop
# CentOS 6
#sudo yum -y groupinstall "Desktop" "Desktop Platform" "X Window System" "Fonts"
# CentOS 7
sudo yum install -y epel-release
sudo yum update
#sudo yum groupinstall -y "Server with GUI"
sudo yum group install -y "MATE Desktop"
# "Graphical Administration Tools"

#install chrome
sudo yum install -y https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm


#!/bin/bash
sudo yum install -y epel-release
sudo yum update -y
#sudo yum groupinstall -y "Server with GUI"
sudo yum group install -y "X Window system" "MATE Desktop"
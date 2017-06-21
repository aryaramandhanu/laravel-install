#!/bin/bash
# Laravel Setup for Ubuntu 16.04 LTS
# 

# root check
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }

# update the sources
apt update
echo "................updated apt repos"
sleep 2 	

# install zip & git
apt -y install zip git
echo "................installed git"
sleep 2

# install nginx
apt -y install nginx
echo "................installed NGINX"
sleep 2

# install php
apt-get install python-software-properties -y
add-apt-repository ppa:ondrej/php
apt-get update -y
apt-get install -y php5.6
echo "................installed PHP"
sleep 2
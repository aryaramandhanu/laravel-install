#!/bin/bash
# Laravel Setup for Ubuntu 16.04 LTS
# 
######################################

# variable config
NGINX-DIR="${PWD}/config/nginx"
PHP-FPM-DIR="${PWD}/config/php-fpm/"

# root check
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }

# update the sources
apt update
echo "....................................................updated apt repos"
sleep 2 	

# install zip & git
apt -y install zip git
echo "....................................................installed git"
sleep 2
echo ""

# install php
apt-get install python-software-properties -y
add-apt-repository ppa:ondrej/php
apt-get update -y
apt-get -y install  php5.6-mysql php5.6-cli php5.6-curl php5.6-json php5.6-sqlite3 php5.6-mcrypt php5.6-curl php-xdebug php5.6-mbstring  mysql-server-5.7 php5.6-fpm
echo "...................................................installed PHP"
sleep 2
echo ""

# install nginx
apt -y install nginx
echo "....................................................installed NGINX"
sleep 2
echo ""

# nginx config
echo "Setup nginx........"
echo "Move nginx.conf"
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf-bak
cp -rvf $NGINX-DIR/nginx.conf /etc/nginx/
cp -rvf $NGINX-DIR/sites-available/*.conf /etc/nginx/sites-available/*


# symlink config
unlink /etc/nginx/sites-enable/default
ln -s /etc/nginx/sites-available/* /etc/nginx/sites-enable/
echo ""

# check nginx
echo "check nginx.........."
nginx -t

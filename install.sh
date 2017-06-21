#!/bin/bash
# Laravel Setup for Ubuntu 16.04 LTS
# 
######################################

# git apps
frontend="git@bitbucket.org:kanisake/garudabiru-www-frontend.git"
backend="git@bitbucket.org:kanisake/garudabiru-www-backend.git"
api="git@bitbucket.org:kanisake/garudabiru-www-backend.git"
docroot="/usr/share/nginx/"
root="/root/"

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
add-apt-repository ppa:ondrej/php -y
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
echo "...done"
sleep 2

cp -rvf config/nginx/nginx.conf /etc/nginx/
cp -rvf config/nginx/sites-available/*.conf /etc/nginx/sites-available/


# symlink config
unlink /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/* /etc/nginx/sites-enabled/
echo ""

# check nginx
echo "check nginx.........."
nginx -t

# setup application
echo "clone all repo to document root"
echo ""

git clone $frontend $docroot/frontend
echo ""
git clone $backend $docroot/backend
echo ""
git clone $api $docroot/api
echo "clone done...."
sleep 2

# install composer
echo "instaling composer"
cd $root
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
cd $root/laravel-install
echo "Composer install done"
sleep 2

# composer update 
echo "Composer update for all apps"
echo "composer update frontend"
cd $docroot/frontend && composer update
echo "........................................................ composer update frontend done"
echo ""
sleep 2

# setup php-fpm
echo "Setup PHP-FPM"
echo ""
mv /etc/php/5.6/fpm/pool.d/www.conf ~
cp -rvf config/php-fpm/* /etc/php/5.6/fpm/pool.d/
sleep 2

# config php
echo "config php with php-fpm"
sed -i "s/error_reporting = .*/error_reporting = E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED/" /etc/php/5.6/fpm/php.ini
sed -i "s/display_errors = .*/display_errors = Off/" /etc/php/5.6/fpm/php.ini
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/5.6/fpm/php.ini
sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/5.6/fpm/php.ini
sed -i "s/upload_max_filesize = .*/upload_max_filesize = 50M/" /etc/php/5.6/fpm/php.ini
sed -i "s/post_max_size = .*/post_max_size = 50M/" /etc/php/5.6/fpm/php.ini
echo "........................................config php.ini done"
echo ""
sleep 2

# restart service
/etc/init.d/nginx restart
/etc/init.d/php5.6-fpm restart


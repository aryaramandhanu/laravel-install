#!/bin/bash
# Laravel Setup for Ubuntu 16.04 LTS
# 

# update the sources
sudo apt update
echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::updated apt repos"
sleep 2

# install zip & git
sudo apt -y install zip git
echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::installed GIT"
sleep 2

# install nginx
sudo apt -y install nginx
echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::installed NGINX"
sleep 2
#!/bin/bash

# Composer
cd ~/logging/
sudo wget -O composer-setup.php https://getcomposer.org/installer
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
composer require php-amqplib/php-amqplib
composer update
cd ~/

# Setup Central Logging
sudo mkdir -p /var/logCentral/nginx
sudo mkdir -p /var/logCentral/rabbitmq
sudo mkdir -p /var/logCentral/apt
sudo mkdir -p /var/logCentral/mysql

sudo mkdir -p /var/log/nginx
sudo mkdir -p /var/log/rabbitmq
sudo mkdir -p /var/log/mysql

# systemd
pwd=`pwd`'/logging'

# Create serviceAutoLog in systemd
serviceAutoLog="[Unit]
Description=Log File Modifcation Watchdog

[Service]
Type=simple
Restart=always
ExecStart=/usr/bin/php -f $pwd/autoLog.sh

[Install]
WantedBy=milti=user.target"

echo "$serviceAutoLog" > rmq-autoLog.service

sudo cp rmq-autoLog.service /etc/systemd/system/
sudo systemctl start rmq-autoLog
sudo systemctl enable rmq-autoLog

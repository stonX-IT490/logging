#!bin/bash

# Composer
cd ~/logging/
sudo wget -O composer-setup.php https://getcomposer.org/installer
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
composer require php-amqplib/php-amqplib
composer update
cd ~/

# Setup Central Logging
sudo mkdir /var/logCentral
sudo mkdir /var/logCentral/nginx
sudo mkdir /var/logCentral/rabbitmq
sudo mkdir /var/logCentral/apt
sudo mkdir /var/logCentral/mysql

sudo mkdir /var/log/nginx
sudo mkdir /var/log/rabbitmq
sudo mkdir /var/log/mysql

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


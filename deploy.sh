#!/bin/bash

# Composer
sudo wget -O composer-setup.php https://getcomposer.org/installer
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
composer require php-amqplib/php-amqplib
composer update

# Setup Central Logging
sudo mkdir -p /var/logCentral/{nginx,rabbitmq,apt,mysql}
sudo mkdir -p /var/log/{nginx,rabbitmq,mysql}

# systemd
pwd=`pwd`

chmod +x $pwd/autoLog.sh
chmod +x $pwd/failover.sh

# Create serviceAutoLog in systemd
serviceAutoLog="[Unit]
Description=RMQ Logger Service

[Service]
Type=forking
Restart=always
WorkingDirectory=$pwd
ExecStart=/usr/bin/bash -f $pwd/autoLog.sh
User=root
Group=root

[Install]
WantedBy=multi-user.target"

echo "$serviceAutoLog" > rmq-autoLog.service

sudo cp rmq-autoLog.service /etc/systemd/system/
sudo systemctl start rmq-autoLog
sudo systemctl enable rmq-autoLog

# Create service in systemd
failover="[Unit]
Description=RMQ Failover Service

[Service]
Type=simple
Restart=always
WorkingDirectory=$pwd
ExecStart=/usr/bin/bash -f $pwd/failover.sh
User=root
Group=root

[Install]
WantedBy=multi-user.target"

echo "$failover" > rmq-failover.service

sudo cp rmq-failover.service /etc/systemd/system/
sudo systemctl start rmq-failover
sudo systemctl enable rmq-failover
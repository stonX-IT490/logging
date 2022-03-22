#!/bin/bash

# RECEIVE: run php receiveLog for each logfile
sleep 20s
php receiveLog.php ufw.log &>> /var/log/rabbitmq/autoLog.log &
php receiveLog.php messages &>> /var/log/rabbitmq/autoLog.log &
php receiveLog.php syslog &>> /var/log/rabbitmq/autoLog.log &
php receiveLog.php daemon.log &>> /var/log/rabbitmq/autoLog.log &
php receiveLog.php nginx/error.log &>> /var/log/rabbitmq/autoLog.log &
php receiveLog.php apt/term.log &>> /var/log/rabbitmq/autoLog.log &
# php receiveLog.php rabbitmq/rabbit@hippity-hopper.log &>> /var/log/rabbitmq/autoLog.log &
php receiveLog.php rabbitmq/rabbitmq-server.log &>> /var/log/rabbitmq/autoLog.log &
php receiveLog.php rabbitmq/rabbitmq-server.error.log &>> /var/log/rabbitmq/autoLog.log &
php receiveLog.php dpkg.log &>> /var/log/rabbitmq/autoLog.log &
php receiveLog.php alternatives.log &>> /var/log/rabbitmq/autoLog.log &
php receiveLog.php kern.log &>> /var/log/rabbitmq/autoLog.log &
php receiveLog.php mysql/mariadb.err &>> /var/log/rabbitmq/autoLog.log &

php receiveLog.php rabbitmq/autoLog.log &>> /dev/null &

# SEND: watch for modification to logfile then run sendLog()
sleep 1s
./logCentral.sh ufw.log &>> /var/log/rabbitmq/autoLog.log &
./logCentral.sh messages &>> /var/log/rabbitmq/autoLog.log &
./logCentral.sh daemon.log &>> /var/log/rabbitmq/autoLog.log &
./logCentral.sh nginx/error.log &>> /var/log/rabbitmq/autoLog.log &
./logCentral.sh apt/term.log &>> /var/log/rabbitmq/autoLog.log &
# ./logCentral.sh rabbitmq/rabbit@hippity-hopper.log &>> /var/log/rabbitmq/autoLog.log &
./logCentral.sh rabbitmq/rabbitmq-server.log &>> /var/log/rabbitmq/autoLog.log &
./logCentral.sh rabbitmq/rabbitmq-server.error.log &>> /var/log/rabbitmq/autoLog.log &
./logCentral.sh dpkg.log &>> /var/log/rabbitmq/autoLog.log &
./logCentral.sh alternatives.log &>> /var/log/rabbitmq/autoLog.log &
./logCentral.sh kern.log &>> /var/log/rabbitmq/autoLog.log &
./logCentral.sh mysql/mariadb.err &>> /var/log/rabbitmq/autoLog.log &

./logCentral.sh rabbitmq/autoLog.log &> /dev/null &

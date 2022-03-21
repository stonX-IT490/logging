#!/bin/bash

# RECEIVE: run php receiveLog for each logfile
php receiveLog.php ufw.log &>> /var/log/rabbitmq/receiveLog.log &
php receiveLog.php messages &>> /var/log/rabbitmq/receiveLog.log &
php receiveLog.php syslog &>> /var/log/rabbitmq/receiveLog.log &
php receiveLog.php daemon.log &>> /var/log/rabbitmq/receiveLog.log &
php receiveLog.php nginx/error.log &>> /var/log/rabbitmq/receiveLog.log &
php receiveLog.php apt/term.log &>> /var/log/rabbitmq/receiveLog.log &
php receiveLog.php rabbitmq/rabbit@hippity-hopper.log &>> /var/log/rabbitmq/receiveLog.log &
php receiveLog.php rabbitmq/rabbitmq-server.log &>> /var/log/rabbitmq/receiveLog.log &
php receiveLog.php rabbitmq/rabbitmq-server.error.log &>> /var/log/rabbitmq/receiveLog.log &
php receiveLog.php dpkg.log &>> /var/log/rabbitmq/receiveLog.log &
php receiveLog.php alternatives.log &>> /var/log/rabbitmq/receiveLog.log &
php receiveLog.php kern.log &>> /var/log/rabbitmq/receiveLog.log &

php receiveLog.php rabbitmq/receiveLog.log &>> /dev/null &


# SEND: watch for modification to logfile then run sendLog()
./logCentral.sh ufw.log &>> /var/log/rabbitmq/logCentral.log &
./logCentral.sh messages &>> /var/log/rabbitmq/logCentral.log &
./logCentral.sh daemon.log &>> /var/log/rabbitmq/logCentral.log &
./logCentral.sh nginx/error.log &>> /var/log/rabbitmq/logCentral.log &
./logCentral.sh daemon.log &>> /var/log/rabbitmq/logCentral.log &
./logCentral.sh apt/term.log &>> /var/log/rabbitmq/logCentral.log &
./logCentral.sh rabbitmq/rabbit@hippity-hopper.log &>> /var/log/rabbitmq/logCentral.log &
./logCentral.sh rabbitmq/rabbitmq-server.log &>> /var/log/rabbitmq/logCentral.log &
./logCentral.sh rabbitmq/rabbitmq-server.error.log &>> /var/log/rabbitmq/logCentral.log &
./logCentral.sh dpkg.log &>> /var/log/rabbitmq/logCentral.log &
./logCentral.sh alternatives.log &>> /var/log/rabbitmq/logCentral.log &
./logCentral.sh kern.log &>> /var/log/rabbitmq/logCentral.log &

./logCentral.sh daemon.log &> /dev/null &
